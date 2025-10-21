class sig_model_env extends uvm_env;
  sig_agent      sig_agnt_d, sig_agnt_m;
  sig_scoreboard sig_scb;

  `uvm_component_utils(sig_model_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sig_agnt_d = sig_agent::type_id::create("sig_agnt_d", this);
    sig_agnt_m = sig_agent::type_id::create("sig_agnt_m", this);
    sig_scb = sig_scoreboard::type_id::create("sig_scb", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    sig_agnt_d.monitor.item_collected_port.connect(sig_scb.item_collected_source.analysis_export);
    sig_agnt_m.monitor.item_collected_port.connect(sig_scb.item_collected_sink.analysis_export);
  endfunction : connect_phase

endclass : sig_model_env
