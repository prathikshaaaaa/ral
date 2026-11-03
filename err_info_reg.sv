class err_info_reg extends uvm_reg;

  uvm_reg_field tx_snapshot;
  uvm_reg_field reserved;
  uvm_reg_field dest_port;
  uvm_reg_field source;
  uvm_reg_field last_code;

  `uvm_object_utils(err_info_reg)

  function new(string name = "err_info_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    tx_snapshot = uvm_reg_field::type_id::create("tx_snapshot");
    tx_snapshot.configure(this, 12, 20, "RO", 0, 12'h000, 1, 0, 0);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 2, 18, "RO", 0, 2'h0, 1, 0, 0);

    dest_port = uvm_reg_field::type_id::create("dest_port");
    dest_port.configure(this, 2, 16, "RO", 0, 2'h0, 1, 0, 0);

    source = uvm_reg_field::type_id::create("source");
    source.configure(this, 8, 8, "RO", 0, 8'h00, 1, 0, 0);

    last_code = uvm_reg_field::type_id::create("last_code");
    last_code.configure(this, 8, 0, "RO", 0, 8'h00, 1, 0, 0);

  endfunction

endclass