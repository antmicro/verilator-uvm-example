class sig_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(sig_scoreboard)

  uvm_tlm_analysis_fifo #(sig_seq_item) item_collected_source, item_collected_sink;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_source = new("item_collected_source", this);
    item_collected_sink   = new("item_collected_sink", this);
  endfunction : build_phase

  virtual function void check_phase(uvm_phase phase);
    sig_seq_item sent, received;
    if (item_collected_source.size != item_collected_sink.size)
      `uvm_error(get_type_name(), "Received is not equal sent!")
    else
      while (item_collected_source.can_get()) begin
        void'(item_collected_source.try_get(sent));
        void'(item_collected_sink.try_get(received));
        assert (sent.sig_length == received.sig_length)
        else `uvm_error(get_type_name(), $sformatf(
                        "Sent length: %h Received length: %h are different.",
                        sent.sig_length,
                        received.sig_length));
        `uvm_info(get_type_name(), $sformatf(
                  "Sent length: %h Received length: %h are the same.",
                  sent.sig_length,
                  received.sig_length),
                  UVM_MEDIUM);
      end
  endfunction : check_phase

endclass : sig_scoreboard
