class sig_driver extends uvm_driver #(sig_seq_item);
  virtual sig_if.DRIVER vif;

  `uvm_component_utils(sig_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual sig_if.DRIVER)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      fork begin
          fork
            begin
              @(posedge vif.reset) vif.driver_cb.sig <= 0;
            end
            begin
              seq_item_port.get_next_item(req);
              drive();
              seq_item_port.item_done();
            end
          join_any
          disable fork;
      end join
    end
  endtask : run_phase

  virtual task drive();
    vif.driver_cb.sig <= 1;
    for (int i = 0; i < req.sig_length; i++) @(posedge vif.clk);
    vif.driver_cb.sig <= 0;
    @(posedge vif.clk);
  endtask : drive

endclass : sig_driver
