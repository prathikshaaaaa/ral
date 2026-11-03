class err_enable_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field injected_en;
  uvm_reg_field length_en;
  uvm_reg_field crc_en;
  uvm_reg_field protocol_en;
  uvm_reg_field undersize_en;
  uvm_reg_field overflow_en;
  uvm_reg_field dest_en;
  uvm_reg_field bus_en;

  `uvm_object_utils(err_enable_reg)

  function new(string name = "err_enable_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 24'h0, 1, 0, 0);

    injected_en = uvm_reg_field::type_id::create("injected_en");
    injected_en.configure(this, 1, 7, "RW", 0, 1'h0, 1, 0, 0);

    length_en = uvm_reg_field::type_id::create("length_en");
    length_en.configure(this, 1, 6, "RW", 0, 1'h0, 1, 0, 0);

    crc_en = uvm_reg_field::type_id::create("crc_en");
    crc_en.configure(this, 1, 5, "RW", 0, 1'h0, 1, 0, 0);

    protocol_en = uvm_reg_field::type_id::create("protocol_en");
    protocol_en.configure(this, 1, 4, "RW", 0, 1'h0, 1, 0, 0);

    undersize_en = uvm_reg_field::type_id::create("undersize_en");
    undersize_en.configure(this, 1, 3, "RW", 0, 1'h0, 1, 0, 0);

    overflow_en = uvm_reg_field::type_id::create("overflow_en");
    overflow_en.configure(this, 1, 2, "RW", 0, 1'h0, 1, 0, 0);

    dest_en = uvm_reg_field::type_id::create("dest_en");
    dest_en.configure(this, 1, 1, "RW", 0, 1'h0, 1, 0, 0);

    bus_en = uvm_reg_field::type_id::create("bus_en");
    bus_en.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 0);

  endfunction
endclass