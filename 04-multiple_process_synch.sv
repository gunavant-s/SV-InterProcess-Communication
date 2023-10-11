//Race around condition may occur while using multiple initial block statements. This can be avoided by using "fork join". 
// Perfect synchronization between process is also achieved.
//Schedules multiple process in parallel.

module tb;
  
  
  bit [7:0] data1,data2;
  event done,next;
  
  int i = 0;
  
  //generator
  task generator();
    for(i=0;i<10;i++) begin
      data1 = $urandom(); // 32 bit signed integer
      $display("Data sent : %0d",data1);
      #10;
      wait(next.triggered);
    end
    ->done; // after the sending of all values event is triggered
  endtask
  
  
  //driver
   task reciever();
    forever begin // runs till end of simulation
      #10;
      data2 = data1;
      $display("Data recieved : %0d",data2);
      ->next;
    end
   endtask
  
  //independent task which waits till end of process
  task wait_event();
    wait(done.triggered);
    $display("Finished sending all stimulus");
    $finish();
  endtask
  
  initial begin
    fork
      generator();
      reciever();
      wait_event();
    join
    
  end
    //Code in fork join executes and then the code outside will execute. More like blocking statement.
    
  
endmodule

/*
# KERNEL: Data sent : 167
# KERNEL: Data recieved : 167
# KERNEL: Data sent : 220
# KERNEL: Data recieved : 220
# KERNEL: Data sent : 248
# KERNEL: Data recieved : 248
# KERNEL: Data sent : 81
# KERNEL: Data recieved : 81
# KERNEL: Data sent : 94
# KERNEL: Data recieved : 94
# KERNEL: Data sent : 101
# KERNEL: Data recieved : 101
# KERNEL: Data sent : 180
# KERNEL: Data recieved : 180
# KERNEL: Data sent : 205
# KERNEL: Data recieved : 205
# KERNEL: Data sent : 227
# KERNEL: Data recieved : 227
# KERNEL: Data sent : 151
# KERNEL: Data recieved : 151
# KERNEL: Finished sending all stimulus
*/
