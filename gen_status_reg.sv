class gen_status_reg extends uvm_reg;

  uvm_reg_field reserved_31_24;
  uvm_reg_field remaining;
  uvm_reg_field reserved_7_4;
  uvm_reg_field fsm;
  uvm_reg_field done;
  uvm_reg_field running;

  `uvm_object_utils(gen_status_reg)

  function new(string name = "gen_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved_31_24 = uvm_reg_field::type_id::create("reserved_31_24");
    reserved_31_24.configure(this, 8, 24, "RO", 0, 8'h00, 1, 0, 0);

    remaining = uvm_reg_field::type_id::create("remaining");
    remaining.configure(this, 16, 8, "RO", 0, 16'h0000, 1, 0, 0);

    reserved_7_4 = uvm_reg_field::type_id::create("reserved_7_4");
    reserved_7_4.configure(this, 4, 4, "RO", 0, 4'h0, 1, 0, 0);

    fsm = uvm_reg_field::type_id::create("fsm");
    fsm.configure(this, 2, 2, "RO", 0, 2'h0, 1, 0, 0);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this, 1, 1, "RO", 0, 1'h0, 1, 0, 0);

    running = uvm_reg_field::type_id::create("running");
    running.configure(this, 1, 0, "RO", 0, 1'h0, 1, 0, 0);

  endfunction

endclass