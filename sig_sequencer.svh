class sig_sequencer extends uvm_sequencer #(sig_seq_item);
  `uvm_component_utils(sig_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
