class gen_interval_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field interval;

  `uvm_object_utils(gen_interval_reg)

  function new(string name = "gen_interval_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 16'h0, 1, 0, 0);

    interval = uvm_reg_field::type_id::create("interval");
    interval.configure(this, 16, 0, "RW", 0, 16'h0002, 1, 0, 0);

  endfunction
endclass