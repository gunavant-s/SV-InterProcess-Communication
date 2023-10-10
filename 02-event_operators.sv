module tb;
 event a1,a2;
  
  initial begin
    ->a1;
    ->a2;
  end
  
  initial begin
    wait(a1.triggered);
    $display("Event A1 Trigger"); // if our event is triggered it will execute next statement. Non blocking
    wait(a2.triggered);
    $display("Event A2 Trigger");
  end

endmodule

/*
# KERNEL: Event A1 Trigger
# KERNEL: Event A2 Trigger
*/

module tb;
 event a1,a2;
  
  initial begin
    ->a1;
    ->a2;
  end
  
  initial begin
    @(a1.triggered);
    $display("Event A1 Trigger"); //blocking statement so the next statement wont execute until a1 is triggered. If a2 triggered first then both stmts wont execute
    @(a2.triggered);
    $display("Event A2 Trigger");
  end

endmodule
/*
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4665 kB (elbread=427 elab2=4103 kernel=134 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
*/
    
