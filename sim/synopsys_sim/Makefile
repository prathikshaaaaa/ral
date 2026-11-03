SHELL := sh
.SHELLFLAGS := -ec
.DEFAULT_GOAL := usage
.NOTPARALLEL:

ifneq ($(notdir $(CURDIR)),synopsys_sim)
$(error Run this makefile with make -C sim/synopsys_sim)
endif

.PHONY: usage help compile simulate all regression check_run coverage_report \
        merge_cov_report compile_war_err simulate_war_err clean_compile \
        clean_simulate clean clean_all

VCS ?= vcs
URG ?= urg
UVM_VERSION ?= uvm-1.2
EXTRA_VCS_FLAGS ?=
EXTRA_SIM_FLAGS ?=

test ?= pkt_regression_test
seed ?= 1
uvm_verbosity ?= UVM_MEDIUM
test_folder ?= $(test)_$(seed)
testlist_name ?= apb_regression.list
coverage ?= 1
CM_METRICS ?= line+cond+tgl+fsm+branch+assert

ROOT_DIR := $(abspath ../..)
FILELIST := $(ROOT_DIR)/apb_compile.f
RUN_MAKE = $(MAKE)
SIMV := $(abspath .build/simv)
COMPILE_COV := $(abspath .build/compile.vdb)
TEST_DIR := $(abspath results/$(test_folder))
TEST_LOG := $(TEST_DIR)/sim.log
TEST_COV := $(TEST_DIR)/coverage.vdb
REGRESSION_COV := $(abspath .build/regression_cov.list)

ifeq ($(coverage),1)
CM_COMPILE_FLAGS = -cm $(CM_METRICS) -cm_dir "$(COMPILE_COV)"
CM_RUN_FLAGS = -cm $(CM_METRICS) -cm_dir "$(TEST_COV)" -cm_name $(test)_$(seed)
else ifeq ($(coverage),0)
CM_COMPILE_FLAGS :=
CM_RUN_FLAGS :=
else
$(error coverage must be 0 or 1)
endif

usage help:
	@echo "APB packet switch - Synopsys VCS"
	@echo "make -C sim/synopsys_sim compile"
	@echo "make -C sim/synopsys_sim simulate test=pkt_regression_test seed=1"
	@echo "make -C sim/synopsys_sim all"
	@echo "make -C sim/synopsys_sim regression"
	@echo "make -C sim/synopsys_sim coverage_report"
	@echo "make -C sim/synopsys_sim clean"

compile:
	@mkdir -p .build logs
	@rm -rf .build/compile.vdb
	@cd "$(ROOT_DIR)" && "$(VCS)" -full64 -sverilog -ntb_opts $(UVM_VERSION) \
		-debug_access+all -timescale=1ns/1ps \
		-f "$(FILELIST)" -top hdl_top -top hvl_top \
		-Mdir="$(abspath .build/csrc)" -o "$(SIMV)" \
		$(CM_COMPILE_FLAGS) $(EXTRA_VCS_FLAGS) \
		-l "$(abspath logs/vcs_compile.log)"
	@$(MAKE) --no-print-directory compile_war_err

check_run:
	@case "$(test_folder)" in ''|*[!A-Za-z0-9_-]*) echo 'test_folder may contain only letters, digits, _ and -.'; exit 2;; esac

simulate: check_run
	@test -x "$(SIMV)" || { echo "ERROR: Run make compile first."; exit 2; }
	@mkdir -p "$(TEST_DIR)"
	@rm -f "$(TEST_LOG)"
ifeq ($(coverage),1)
	@test -d "$(COMPILE_COV)" || { echo "ERROR: Recompile with coverage=1."; exit 2; }
	@rm -rf "$(TEST_COV)"
	@mkdir -p "$(TEST_COV)"
	@cp -R "$(COMPILE_COV)/." "$(TEST_COV)/"
endif
	@echo "Running $(test), seed=$(seed), verbosity=$(uvm_verbosity)"
	@run_status=0; \
		"$(SIMV)" +UVM_TESTNAME=$(test) +UVM_VERBOSITY=$(uvm_verbosity) \
		+ntb_random_seed=$(seed) $(CM_RUN_FLAGS) $(EXTRA_SIM_FLAGS) \
		-l "$(TEST_LOG)" || run_status=$$?; \
		$(MAKE) --no-print-directory simulate_war_err \
			test="$(test)" test_folder="$(test_folder)" || run_status=1; \
		exit $$run_status

all:
	@$(MAKE) --no-print-directory compile
	@$(MAKE) --no-print-directory simulate

regression:
	@set -eu; \
		list="$(testlist_name)"; \
		test -f "$$list" || { echo "ERROR: Test list not found: $$list"; exit 2; }; \
		$(RUN_MAKE) --no-print-directory compile; \
		: > "$(REGRESSION_COV)"; \
		passed=0; failed=0; \
		while IFS= read -r line || [ -n "$$line" ]; do \
			test_name=$$(printf '%s' "$$line" | sed 's/#.*//' | tr -d '[:space:]'); \
			[ -n "$$test_name" ] || continue; \
			if $(RUN_MAKE) --no-print-directory simulate test="$$test_name" test_folder="$${test_name}_$(seed)"; then \
				passed=$$((passed + 1)); \
				database="$(abspath results)/$${test_name}_$(seed)/coverage.vdb"; \
				if [ "$(coverage)" = 1 ] && [ -d "$$database" ]; then \
					printf '%s\n' "$$database" >> "$(REGRESSION_COV)"; \
				fi; \
			else \
				failed=$$((failed + 1)); \
				echo "FAILED: $$test_name"; \
			fi; \
		done < "$$list"; \
		echo "Regression summary: $$passed passed, $$failed failed"; \
		[ $$((passed + failed)) -gt 0 ] || { echo "ERROR: Test list is empty."; exit 2; }; \
		[ $$failed -eq 0 ]

coverage_report: check_run
	@test "$(coverage)" = 1 || { echo "ERROR: Coverage is disabled."; exit 2; }
	@test -d "$(TEST_COV)" || { echo "ERROR: No coverage database for $(test_folder)."; exit 2; }
	"$(URG)" -dir "$(TEST_COV)" -format both \
		-report "$(TEST_DIR)/html_cov_report" > "$(TEST_DIR)/urg.log" 2>&1
	@echo "Coverage: $(TEST_DIR)/html_cov_report/dashboard.html"

merge_cov_report:
	@test "$(coverage)" = 1 || { echo "ERROR: Coverage is disabled."; exit 2; }
	@test -s "$(REGRESSION_COV)" || { echo "ERROR: No regression coverage manifest."; exit 2; }
	@mkdir -p logs
	@set -eu; set --; \
		while IFS= read -r database || [ -n "$$database" ]; do \
			[ -n "$$database" ] || continue; \
			test -d "$$database" || { echo "ERROR: Missing coverage database: $$database"; exit 2; }; \
			set -- "$$@" "$$database"; \
		done < "$(REGRESSION_COV)"; \
		[ "$$#" -gt 0 ] || { echo "ERROR: Coverage manifest is empty."; exit 2; }; \
		"$(URG)" -dir "$$@" -format both -report coverage_report > logs/urg.log 2>&1
	@echo "Merged coverage: coverage_report/dashboard.html"

compile_war_err:
	@test -f logs/vcs_compile.log || { echo "ERROR: No compilation log."; exit 2; }
	@echo "Compilation log: logs/vcs_compile.log"
	@grep -E '(Error-|Warning-|\*\* Error|\*\* Warning)' logs/vcs_compile.log | head -n 30 || true

simulate_war_err: check_run
	@echo "Simulation log: $(TEST_LOG)"
	@test -f "$(TEST_LOG)" || { echo "ERROR: No simulation log."; exit 2; }
	@if grep -Eq 'UVM_(ERROR|FATAL)[[:space:]]*:[[:space:]]*[1-9]|Error-|Fatal-' "$(TEST_LOG)"; then \
		echo "Simulation reported errors:"; \
		grep -En 'UVM_(ERROR|FATAL)|Error-|Fatal-' "$(TEST_LOG)"; \
		exit 1; \
	fi
	@echo "Simulation log checks passed."

clean_compile:
	rm -rf .build
	rm -f logs/vcs_compile.log

clean_simulate:
	rm -rf results coverage_report
	rm -f logs/urg.log

clean clean_all:
	@$(MAKE) --no-print-directory clean_compile
	@$(MAKE) --no-print-directory clean_simulate
