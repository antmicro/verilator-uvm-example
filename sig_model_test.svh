class sig_model_test extends uvm_test;
  `uvm_component_utils(sig_model_test)

  sig_model_env env;
  sig_sequence  seq;

  function new(string name = "sig_model_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = sig_model_env::type_id::create("env", this);
    seq = sig_sequence::type_id::create("seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.sig_agnt_d.sequencer);
    phase.drop_objection(this);
  endtask : run_phase

endclass : sig_model_test
