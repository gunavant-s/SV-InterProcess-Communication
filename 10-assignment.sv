/*
Code for transaction class is mentioned in the Instruction tab. Write a code to send transaction data between generator and driver. 
Also, verify the data by printing the value of data members of Generator and Driver
class transaction;
 
bit [7:0] addr = 7'h12;
bit [3:0] data = 4'h4;
bit we = 1'b1;
bit rst = 1'b0;
 
endclass
*/

class transaction;
 
  bit [7:0] addr = 7'h12;
  bit [3:0] data = 4'h4;
  bit we = 1'b1;
  bit rst = 1'b0;
 
endclass

class generator;
  
  transaction t;
  mailbox #(transaction) mbx;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    mbx.put(t);
    $display("GEN : %b %b %b %b",t.addr,t.data,t.we,t.rst);
  endtask
  
endclass

class driver;
  
  transaction t;
  mailbox #(transaction) mbx;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    mbx.get(t);
    $display("DRV : %b %b %b %b",t.addr,t.data,t.we,t.rst);
  endtask
  
endclass

module tb;
  mailbox #(transaction)  mbx;
  generator gen;
  driver drv;
  
  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);

    gen.run();
    drv.run();
  end
    
endmodule

/*
# KERNEL: GEN : 00010010 0100 1 0
# KERNEL: DRV : 00010010 0100 1 0
*/
