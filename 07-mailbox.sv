class generator;
  
  int data = 902;
  
  mailbox mbx;
  
  function new(mailbox mbx); // custom constructor
    this.mbx = mbx;
  endfunction
  
  task run();
    mbx.put(data);
    $display("[GEN] : Sent data : %0d",data);
  endtask
  
endclass


class driver;
  
  int datac = 0;
  mailbox mbx;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    mbx.get(datac);
    $display("[DRV] : Sent recieved : %0d",datac);
  endtask
  
endclass


module tb;
  
  generator g;
  driver d;
  mailbox mbx;
  
  initial begin
    mbx = new();

    g = new(mbx);
    d = new(mbx);
//     g.mbx = mbx;
//     d.mbx = mbx;

    g.run();
    d.run();
  end
  
endmodule

// # KERNEL: [GEN] : Sent data : 902
// # KERNEL: [DRV] : Sent recieved : 902
// # KERNEL: Simulation has finished. There are no more test vectors to simulate.
