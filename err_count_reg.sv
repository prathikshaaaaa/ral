class err_count_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field count;

  `uvm_object_utils(err_count_reg)

  function new(string name = "err_count_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 16'h0, 1, 0, 0);

    count = uvm_reg_field::type_id::create("count");
    count.configure(this, 16, 0, "RO", 0, 16'h0, 1, 0, 0);

  endfunction

endclass