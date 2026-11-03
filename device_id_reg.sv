class device_id_reg extends uvm_reg;

  uvm_reg_field revision;
  uvm_reg_field vendor_id;
  uvm_reg_field product_id;

  `uvm_object_utils(device_id_reg)

  function new(string name = "device_id");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    revision = uvm_reg_field::type_id::create("revision");
    revision.configure(this, 8, 24, "RO", 0, 8'h02, 1, 0, 0);

    vendor_id = uvm_reg_field::type_id::create("vendor_id");
    vendor_id.configure(this, 8, 16, "RO", 0, 8'hA5, 1, 0, 0);

    product_id = uvm_reg_field::type_id::create("product_id");
    product_id.configure(this, 16, 0, "RO", 0, 16'h5357, 1, 0, 0);

  endfunction

endclass