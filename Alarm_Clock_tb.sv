`timescale 1ns/1ps
module alarm_clock_tb ();
logic CLK_2Hz,reset,time_set,alarm_set,sethrs1min0,run_clock,activatealarm,alarmreset,runset;
wire alrm;
wire [7:0] sec,min,hrs,min_alrm,hrs_alrm;

initial begin
//We do a general reset here.
CLK_2Hz = 0;
activatealarm =0;
time_set = 0;
run_clock = 0;
alarm_set = 0;
runset = 1;
alarmreset = 1;
sethrs1min0 = 0;
reset = 1; #10; reset = 0; #10;

//This sets the time.
time_set = 1;#5;
sethrs1min0 = 0;#5;
runset = 0; #58; runset =1;#5;//Equivalent to 29mins.
sethrs1min0 =1;#5;
runset = 0; #10; runset =1;#5;//Equivalent to 5mins.
time_set = 0; sethrs1min0 = 0; #10;

//This sets the alarm.
alarm_set = 1;#5;
sethrs1min0 = 0;#5;
runset = 0; #60; runset =1;#5;//Equivalent to 30mins.
sethrs1min0 =1;#5;
runset = 0; #10; runset =1;#5;//Equivalent to 5mins.
alarm_set = 0;#10;

//We activate the alarm.
activatealarm = 1;

//We run the clock.
run_clock = 1;

end
//This is our clock.
   always @ (*) begin
   CLK_2Hz = 1;
	repeat (500)begin
	#1 CLK_2Hz = ~CLK_2Hz;
	end
   end

// If the alarm is triggered we wait a little bit, trigger the alarmreset and then reset the clock.
   always @ (*) begin
	if (alrm == 1)begin
	#10; alarmreset = 0; #10; alarmreset = 1; #10; reset = 1; #10; reset=0;
	end
   end

alarm_clock A1(CLK_2Hz,reset,time_set,alarm_set,sethrs1min0,run_clock,activatealarm,alarmreset,runset,sec,min,hrs,min_alrm,hrs_alrm,alrm);

endmodule