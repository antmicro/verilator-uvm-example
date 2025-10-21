module tbench_top;
  import uvm_pkg::*;
  import sig_pkg::*;

  bit clk;
  bit reset;

  always #5 clk = ~clk;

  initial begin
    reset = 1;
    #12 reset = 0;
  end

  sig_if intf (
      clk,
      reset
  );

  initial begin
    uvm_config_db#(virtual sig_if.DRIVER)::set(uvm_root::get(), "*", "vif", intf.DRIVER);
    uvm_config_db#(virtual sig_if.MONITOR)::set(uvm_root::get(), "*", "vif", intf.MONITOR);
  end

  initial begin
    run_test();
  end

endmodule
