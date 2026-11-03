class soft_reset_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field pulse;

  `uvm_object_utils(soft_reset_reg)

  function new(string name = "soft_reset_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 31, 1, "WO", 0, 31'h0, 1, 0, 0);

    pulse = uvm_reg_field::type_id::create("pulse");
    pulse.configure(this, 1, 0, "WO", 0, 1'h0, 1, 0, 0);

  endfunction
endclass