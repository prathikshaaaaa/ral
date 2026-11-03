class lock_reg extends uvm_reg;

  uvm_reg_field key;
  uvm_reg_field locked;

  `uvm_object_utils(lock_reg)

  function new(string name = "lock_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    key = uvm_reg_field::type_id::create("key");
    key.configure(this, 31, 1, "WO", 0, 31'h0, 1, 0, 0);

    locked = uvm_reg_field::type_id::create("locked");
    locked.configure(this, 1, 0, "RO", 1, 1'h1, 1, 0, 0);

  endfunction
endclass