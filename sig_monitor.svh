class sig_monitor extends uvm_monitor;
  virtual sig_if.MONITOR vif;
  uvm_analysis_port #(sig_seq_item) item_collected_port;
  sig_seq_item trans_collected;

  `uvm_component_utils(sig_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = null;
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual sig_if.MONITOR)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      if (vif.reset && trans_collected != null) begin
        item_collected_port.write(trans_collected);
        trans_collected = null;
        phase.drop_objection(this);
      end else if (!vif.reset && vif.monitor_cb.sig) begin
        if (trans_collected == null) begin
          phase.raise_objection(this);
          trans_collected = new();
          trans_collected.sig_length = 0;
        end
        trans_collected.sig_length++;
      end else if (!vif.reset && !vif.monitor_cb.sig) begin
        if (trans_collected != null) begin
          item_collected_port.write(trans_collected);
          trans_collected = null;
          phase.drop_objection(this);
        end
      end
    end
  endtask : run_phase

endclass : sig_monitor
