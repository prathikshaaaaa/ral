class version_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field major;
  uvm_reg_field minor;
  uvm_reg_field patch;

  `uvm_object_utils(version_reg)

  function new(string name = "version_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 8, 24, "RO", 0, 8'h00, 1, 0, 0);

    major = uvm_reg_field::type_id::create("major");
    major.configure(this, 8, 16, "RO", 0, 8'h01, 1, 0, 0);

    minor = uvm_reg_field::type_id::create("minor");
    minor.configure(this, 8, 8, "RO", 0, 8'h02, 1, 0, 0);

    patch = uvm_reg_field::type_id::create("patch");
    patch.configure(this, 8, 0, "RO", 0, 8'h00, 1, 0, 0);

  endfunction

endclass