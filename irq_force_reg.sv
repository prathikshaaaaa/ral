class irq_force_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field force_field;

  `uvm_object_utils(irq_force_reg)

  function new(string name = "irq_force_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "WO", 0, 24'h0, 1, 0, 0);

    force_field = uvm_reg_field::type_id::create("force_field");
    force_field.configure(this, 8, 0, "WO", 0, 8'h00, 1, 0, 0);

  endfunction

endclass