class irq_status_reg extends uvm_reg;

  uvm_reg_field reserved;
  uvm_reg_field sw_event;
  uvm_reg_field start_ack;
  uvm_reg_field queue_almost_full;
  uvm_reg_field packet_forwarded;
  uvm_reg_field packet_dropped;
  uvm_reg_field queue_overflow;
  uvm_reg_field error;
  uvm_reg_field gen_done;

  `uvm_object_utils(irq_status_reg)

  function new(string name = "irq_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 24'h0, 1, 0, 0);

    sw_event = uvm_reg_field::type_id::create("sw_event");
    sw_event.configure(this, 1, 7, "W1C", 0, 1'h0, 1, 0, 0);

    start_ack = uvm_reg_field::type_id::create("start_ack");
    start_ack.configure(this, 1, 6, "W1C", 0, 1'h0, 1, 0, 0);

    queue_almost_full = uvm_reg_field::type_id::create("queue_almost_full");
    queue_almost_full.configure(this, 1, 5, "W1C", 0, 1'h0, 1, 0, 0);

    packet_forwarded = uvm_reg_field::type_id::create("packet_forwarded");
    packet_forwarded.configure(this, 1, 4, "W1C", 0, 1'h0, 1, 0, 0);

    packet_dropped = uvm_reg_field::type_id::create("packet_dropped");
    packet_dropped.configure(this, 1, 3, "W1C", 0, 1'h0, 1, 0, 0);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "W1C", 0, 1'h0, 1, 0, 0);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this, 1, 1, "W1C", 0, 1'h0, 1, 0, 0);

    gen_done = uvm_reg_field::type_id::create("gen_done");
    gen_done.configure(this, 1, 0, "W1C", 0, 1'h0, 1, 0, 0);

  endfunction
endclass