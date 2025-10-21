class sig_sequence extends uvm_sequence #(sig_seq_item);
  `uvm_object_utils(sig_sequence)

  function new(string name = "sig_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for (int i = 0; i < 10; i++) begin
      req = sig_seq_item::type_id::create("req");
      wait_for_grant();
      void'(req.randomize());
      send_request(req);
      wait_for_item_done();
    end
  endtask

endclass
