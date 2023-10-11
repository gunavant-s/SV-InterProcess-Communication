/*
Create two tasks each capable of sending a message to Console at a fixed interval.
Assume Task1 sends the message "Task 1 Trigger" at an interval of 20 ns while Task2 sends the message "Task 2 Trigger" at an interval of 40 ns. 
Keep the count of the number of times Task 1 and Task 2 trigger by adding a variable for keeping the track of task execution and incrementing with each trigger.
Execute both tasks in parallel till 200 nsec. Display the number of times Task 1 and Task 2 executed after 200 ns before calling $finish for stopping the simulation.
*/

module tb;
  
  int cnt1=0,cnt2=0;
  event e1,e2;
  
  task first();
    while($time <= 200) begin
      $display("Task 1 Trigger");
      #20;
      cnt1 += 1;
    end
    -> e1;
    
  endtask
  
  task second();
    while($time <= 200) begin
      $display("Task 2 Trigger");
      #40;
      cnt2 += 1;
    end
    -> e2;
    
  endtask
  
  task wait_event();
    wait(e1.triggered);
    wait(e2.triggered);
    $display("Task1 executed : %0d, Task2 executed : %0d",cnt1,cnt2);
    $finish;
  endtask
  
  initial begin
    fork
      first();
      second();
    join
    wait_event();
  end
  
endmodule

/*
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Task 2 Trigger
# KERNEL: Task 1 Trigger
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
*/
