class sig_seq_item extends uvm_sequence_item;
  rand bit [3:0] sig_length;

  `uvm_object_utils_begin(sig_seq_item)
  `uvm_field_int(sig_length, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "sig_seq_item");
    super.new(name);
  endfunction

  constraint min_time_c {sig_length > 0;};

endclass
