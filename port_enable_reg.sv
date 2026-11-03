class port_enable_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field port3_en;
  uvm_reg_field port2_en;
  uvm_reg_field port1_en;
  uvm_reg_field port0_en;

  `uvm_object_utils(port_enable_reg)

  function new(string name = "port_enable_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 28, 4, "RO", 0, 28'h0, 1, 0, 0);

    port3_en = uvm_reg_field::type_id::create("port3_en");
    port3_en.configure(this, 1, 3, "RW", 0, 1'h1, 1, 0, 0);

    port2_en = uvm_reg_field::type_id::create("port2_en");
    port2_en.configure(this, 1, 2, "RW", 0, 1'h1, 1, 0, 0);

    port1_en = uvm_reg_field::type_id::create("port1_en");
    port1_en.configure(this, 1, 1, "RW", 0, 1'h1, 1, 0, 0);

    port0_en = uvm_reg_field::type_id::create("port0_en");
    port0_en.configure(this, 1, 0, "RW", 0, 1'h1, 1, 0, 0);

  endfunction

endclass