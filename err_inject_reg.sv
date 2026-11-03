class err_inject_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field clear_count;
  uvm_reg_field injected;
  uvm_reg_field length_error;
  uvm_reg_field crc_error;
  uvm_reg_field protocol_error;
  uvm_reg_field undersize;
  uvm_reg_field queue_overflow;
  uvm_reg_field dest_error;
  uvm_reg_field bus_error;

  `uvm_object_utils(err_inject_reg)

  function new(string name = "err_inject_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 23, 8, "WO", 0, 23'h0, 1, 0, 0);

    clear_count = uvm_reg_field::type_id::create("clear_count");
    clear_count.configure(this, 1, 31, "WO", 0, 1'h0, 1, 0, 0);

    injected = uvm_reg_field::type_id::create("injected");
    injected.configure(this, 1, 7, "WO", 0, 1'h0, 1, 0, 0);

    length_error = uvm_reg_field::type_id::create("length_error");
    length_error.configure(this, 1, 6, "WO", 0, 1'h0, 1, 0, 0);

    crc_error = uvm_reg_field::type_id::create("crc_error");
    crc_error.configure(this, 1, 5, "WO", 0, 1'h0, 1, 0, 0);

    protocol_error = uvm_reg_field::type_id::create("protocol_error");
    protocol_error.configure(this, 1, 4, "WO", 0, 1'h0, 1, 0, 0);

    undersize = uvm_reg_field::type_id::create("undersize");
    undersize.configure(this, 1, 3, "WO", 0, 1'h0, 1, 0, 0);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "WO", 0, 1'h0, 1, 0, 0);

    dest_error = uvm_reg_field::type_id::create("dest_error");
    dest_error.configure(this, 1, 1, "WO", 0, 1'h0, 1, 0, 0);

    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this, 1, 0, "WO", 0, 1'h0, 1, 0, 0);

  endfunction
endclass