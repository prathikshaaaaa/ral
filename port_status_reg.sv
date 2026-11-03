class port_status_reg extends uvm_reg;

  uvm_reg_field port3_level;
  uvm_reg_field port2_level;
  uvm_reg_field port1_level;
  uvm_reg_field port0_level;

  `uvm_object_utils(port_status_reg)

  function new(string name = "port_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    port3_level = uvm_reg_field::type_id::create("port3_level");
    port3_level.configure(this, 8, 24, "RO", 0, 8'h00, 1, 0, 0);

    port2_level = uvm_reg_field::type_id::create("port2_level");
    port2_level.configure(this, 8, 16, "RO", 0, 8'h00, 1, 0, 0);

    port1_level = uvm_reg_field::type_id::create("port1_level");
    port1_level.configure(this, 8, 8, "RO", 0, 8'h00, 1, 0, 0);

    port0_level = uvm_reg_field::type_id::create("port0_level");
    port0_level.configure(this, 8, 0, "RO", 0, 8'h00, 1, 0, 0);

  endfunction

endclass