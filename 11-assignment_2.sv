/*
Code for transaction class is mentioned in the Instruction tab. Write a code to send transaction data between generator and driver. 
Also, verify the data by printing the value of data members of Generator and Driver in each transaction. Execute the code for 10 random transactions.
class transaction;

rand bit [7:0] a;

rand bit [7:0] b;

rand bit wr;

endclass
*/

class transaction;
 
  rand bit [7:0] a;
  rand bit [7:0] b;
  rand bit wr;
 
endclass

class generator;
  
  transaction t;
  mailbox #(transaction) mbx;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    t.randomize();
    mbx.put(t);
    $display("GEN : %d %d",t.a,t.b);
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
    $display("DRV : %d %d",t.a,t.b);
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
	
    for(int i=1;i<=10;i++) begin
      $display("Iteration : %d",i);
      gen.run();
      drv.run();
    end
    
  end
    
endmodule
