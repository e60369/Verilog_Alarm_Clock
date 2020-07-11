//This top level module is what we use for physical validation.
module alarm_clock_pv (input CLK,SW5,SW4,SW3,SW2,SW1,SW0,KEY1,KEY0,
output logic [6:0] SEC_LSB,SEC_MSB,MIN_LSB,MIN_MSB,HR_LSB,HR_MSB,
output logic LED7,LED5,LED4,LED3,LED2,LED1,LED0);
logic clk,reset,clkout,time_set,alarm_set,sethrs1min0,run_clock,activatealarm,alarmreset,runset,alrmA,alrm,clkout1,carry,Maxval,count2,clkt;
logic [7:0]sec,min,hrs,min_alrm,hrs_alrm,secH,secL,minH,minL,hrsH,hrsL,AminH,AminL,AhrsH,AhrsL;
logic [24:0]count_max,count,count_max1,count1;
logic [6:0] HexSeg0,HexSeg1,HexSeg2,HexSeg3,HexSeg4,HexSeg5;

//Here we assign the switches and buttons to their respective variables and the count_max for the freq divider(s).
assign count_max = 25'd25000000;
assign count_max1 = 25'd12500000;
assign clk = CLK;
assign alarmreset = KEY0;
assign runset = KEY1;
assign activatealarm = SW5;
assign run_clock = SW4;
assign sethrs1min0 = SW3;
assign alarm_set = SW2;
assign time_set = SW1;
assign reset = SW0;
assign SEC_LSB = HexSeg0;
assign SEC_MSB = HexSeg1;
assign MIN_LSB = HexSeg2;
assign MIN_MSB = HexSeg3;
assign HR_LSB = HexSeg4;
assign HR_MSB = HexSeg5;
assign Maxval = 1'b1;

//This decides whether or not we are using the 1Hz clock or the 2Hz clock.
always_comb begin
clkt = clkout;
	if (time_set || alarm_set)
	clkt = clkout1;
	else
	clkt = clkout;
end
//This displays the sec LSB
always_comb begin
	HexSeg0 = 0;
	if (alarm_set == 1)
		HexSeg0 [6] = 1;
	 else if (secL == 8'b0)begin
		HexSeg0[6] = 1;
		end
	else if (secL == 8'd1)begin
		HexSeg0[0] = 1; HexSeg0[3] = 1; HexSeg0[4] = 1; HexSeg0[5] = 1; HexSeg0[6] = 1;
		end
	else if (secL == 8'd2)begin
		HexSeg0[2] = 1; HexSeg0[5] = 1;
		end
	else if (secL == 8'd3)begin
		HexSeg0[4] = 1; HexSeg0[5] = 1;
		end
	else if (secL == 8'd4)begin
		HexSeg0[0] = 1; HexSeg0[3] = 1; HexSeg0[4] = 1;
		end
	else if (secL == 8'd5)begin
		HexSeg0[1] = 1; HexSeg0[4] = 1;
		end
	else if (secL == 8'd6)begin
		HexSeg0[1] = 1;
		end
	else if (secL == 8'd7)begin
		HexSeg0[3] = 1; HexSeg0[4] = 1; HexSeg0[5] = 1; HexSeg0[6] = 1;
		end
	else if (secL == 8'd8)begin
		
		end
	else if (secL == 8'd9)begin
		HexSeg0[4] = 1;
		end
   end
//This displays the sec MSB
always_comb begin
	HexSeg1 = 0;
	if (alarm_set == 1)
		HexSeg1[6] = 1;
	else if (secH == 8'b0)begin
		HexSeg1[6] = 1;
		end
	else if (secH == 8'd1)begin
		HexSeg1[0] = 1; HexSeg1[3] = 1; HexSeg1[4] = 1; HexSeg1[5] = 1; HexSeg1[6] = 1;
		end
	else if (secH == 8'd2)begin
		HexSeg1[2] = 1; HexSeg1[5] = 1;
		end
	else if (secH == 8'd3)begin
		HexSeg1[4] = 1; HexSeg1[5] = 1;
		end
	else if (secH == 8'd4)begin
		HexSeg1[0] = 1; HexSeg1[3] = 1; HexSeg1[4] = 1;
		end
	else if (secH == 8'd5)begin
		HexSeg1[1] = 1; HexSeg1[4] = 1;
		end
	else if (secH == 8'd6)begin
		HexSeg1[1] = 1;
		end
	else if (secH == 8'd7)begin
		HexSeg1[3] = 1; HexSeg1[4] = 1; HexSeg1[5] = 1; HexSeg1[6] = 1;
		end
	else if (secH == 8'd8)begin
		
		end
	else if (secH == 8'd9)begin
		HexSeg1[4] = 1;
		end
   end
//This displays the mins LSB
always_comb begin
	HexSeg2 = 0;
	     if (alarm_set == 1 && AminL == 8'b0)begin
		HexSeg2[6] = 1;
		end
	else if (alarm_set == 0 && minL == 8'b0)begin
		HexSeg2[6] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd1)begin
		HexSeg2[0] = 1; HexSeg2[3] = 1; HexSeg2[4] = 1; HexSeg2[5] = 1; HexSeg2[6] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd1)begin
		HexSeg2[0] = 1; HexSeg2[3] = 1; HexSeg2[4] = 1; HexSeg2[5] = 1; HexSeg2[6] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd2)begin
		HexSeg2[2] = 1; HexSeg2[5] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd2)begin
		HexSeg2[2] = 1; HexSeg2[5] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd3)begin
		HexSeg2[4] = 1; HexSeg2[5] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd3)begin
		HexSeg2[4] = 1; HexSeg2[5] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd4)begin
		HexSeg2[0] = 1; HexSeg2[3] = 1; HexSeg2[4] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd4)begin
		HexSeg2[0] = 1; HexSeg2[3] = 1; HexSeg2[4] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd5)begin
		HexSeg2[1] = 1; HexSeg2[4] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd5)begin
		HexSeg2[1] = 1; HexSeg2[4] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd6)begin
		HexSeg2[1] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd6)begin
		HexSeg2[1] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd7)begin
		HexSeg2[3] = 1; HexSeg2[4] = 1; HexSeg2[5] = 1; HexSeg2[6] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd7)begin
		HexSeg2[3] = 1; HexSeg2[4] = 1; HexSeg2[5] = 1; HexSeg2[6] = 1;
		end
	else if (alarm_set == 1 && AminL == 8'd8)begin
		
		end
	else if (alarm_set == 0 && minL == 8'd8)begin
		
		end
	else if (alarm_set == 1 && AminL == 8'd9)begin
		HexSeg2[4] = 1;
		end
	else if (alarm_set == 0 && minL == 8'd9)begin
		HexSeg2[4] = 1;
		end
   end
//This displays the mins MSB
always_comb begin
	HexSeg3 = 0;
	     if (alarm_set == 1 && AminH == 8'b0)begin
		HexSeg3[6] = 1;
		end
	else if (alarm_set == 0 && minH == 8'b0)begin
		HexSeg3[6] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd1)begin
		HexSeg3[0] = 1; HexSeg3[3] = 1; HexSeg3[4] = 1; HexSeg3[5] = 1; HexSeg3[6] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd1)begin
		HexSeg3[0] = 1; HexSeg3[3] = 1; HexSeg3[4] = 1; HexSeg3[5] = 1; HexSeg3[6] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd2)begin
		HexSeg3[2] = 1; HexSeg3[5] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd2)begin
		HexSeg3[2] = 1; HexSeg3[5] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd3)begin
		HexSeg3[4] = 1; HexSeg3[5] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd3)begin
		HexSeg3[4] = 1; HexSeg3[5] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd4)begin
		HexSeg3[0] = 1; HexSeg3[3] = 1; HexSeg3[4] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd4)begin
		HexSeg3[0] = 1; HexSeg3[3] = 1; HexSeg3[4] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd5)begin
		HexSeg3[1] = 1; HexSeg3[4] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd5)begin
		HexSeg3[1] = 1; HexSeg3[4] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd6)begin
		HexSeg3[1] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd6)begin
		HexSeg3[1] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd7)begin
		HexSeg3[3] = 1; HexSeg3[4] = 1; HexSeg3[5] = 1; HexSeg3[6] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd7)begin
		HexSeg3[3] = 1; HexSeg3[4] = 1; HexSeg3[5] = 1; HexSeg3[6] = 1;
		end
	else if (alarm_set == 1 && AminH == 8'd8)begin
		
		end
	else if (alarm_set == 0 && minH == 8'd8)begin
		
		end
	else if (alarm_set == 1 && AminH == 8'd9)begin
		HexSeg3[4] = 1;
		end
	else if (alarm_set == 0 && minH == 8'd9)begin
		HexSeg3[4] = 1;
		end
   end
//This displays the hrs LSB
always_comb begin
	HexSeg4 = 0;
	     if (alarm_set == 1 && AhrsL == 8'b0)begin
		HexSeg4[6] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'b0)begin
		HexSeg4[6] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd1)begin
		HexSeg4[0] = 1; HexSeg4[3] = 1; HexSeg4[4] = 1; HexSeg4[5] = 1; HexSeg4[6] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd1)begin
		HexSeg4[0] = 1; HexSeg4[3] = 1; HexSeg4[4] = 1; HexSeg4[5] = 1; HexSeg4[6] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd2)begin
		HexSeg4[2] = 1; HexSeg4[5] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd2)begin
		HexSeg4[2] = 1; HexSeg4[5] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd3)begin
		HexSeg4[4] = 1; HexSeg4[5] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd3)begin
		HexSeg4[4] = 1; HexSeg4[5] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd4)begin
		HexSeg4[0] = 1; HexSeg4[3] = 1; HexSeg4[4] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd4)begin
		HexSeg4[0] = 1; HexSeg4[3] = 1; HexSeg4[4] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd5)begin
		HexSeg4[1] = 1; HexSeg4[4] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd5)begin
		HexSeg4[1] = 1; HexSeg4[4] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd6)begin
		HexSeg4[1] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd6)begin
		HexSeg4[1] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd7)begin
		HexSeg4[3] = 1; HexSeg4[4] = 1; HexSeg4[5] = 1; HexSeg4[6] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd7)begin
		HexSeg4[3] = 1; HexSeg4[4] = 1; HexSeg4[5] = 1; HexSeg4[6] = 1;
		end
	else if (alarm_set == 1 && AhrsL == 8'd8)begin
		
		end
	else if (alarm_set == 0 && hrsL == 8'd8)begin
		
		end
	else if (alarm_set == 1 && AhrsL == 8'd9)begin
		HexSeg4[4] = 1;
		end
	else if (alarm_set == 0 && hrsL == 8'd9)begin
		HexSeg4[4] = 1;
		end
   end
//This displays the hrs MSB
always_comb begin
	HexSeg5 = 0;
	     if (alarm_set == 1 && AhrsH == 8'b0) begin
		HexSeg5[6] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'b0)begin
		HexSeg5[6] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd1)begin
		HexSeg5[0] = 1; HexSeg5[3] = 1; HexSeg5[4] = 1; HexSeg5[5] = 1; HexSeg5[6] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd1)begin
		HexSeg5[0] = 1; HexSeg5[3] = 1; HexSeg5[4] = 1; HexSeg5[5] = 1; HexSeg5[6] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd2)begin
		HexSeg5[2] = 1; HexSeg5[5] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd2)begin
		HexSeg5[2] = 1; HexSeg5[5] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd3)begin
		HexSeg5[4] = 1; HexSeg5[5] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd3)begin
		HexSeg5[4] = 1; HexSeg5[5] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd4)begin
		HexSeg5[0] = 1; HexSeg5[3] = 1; HexSeg5[4] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd4)begin
		HexSeg5[0] = 1; HexSeg5[3] = 1; HexSeg5[4] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd5)begin
		HexSeg5[1] = 1; HexSeg5[4] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd5)begin
		HexSeg5[1] = 1; HexSeg5[4] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd6)begin
		HexSeg5[1] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd6)begin
		HexSeg5[1] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd7)begin
		HexSeg5[3] = 1; HexSeg5[4] = 1; HexSeg5[5] = 1; HexSeg5[6] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd7)begin
		HexSeg5[3] = 1; HexSeg5[4] = 1; HexSeg5[5] = 1; HexSeg5[6] = 1;
		end
	else if (alarm_set == 1 && AhrsH == 8'd8)begin
		
		end
	else if (alarm_set == 0 && hrsH == 8'd8)begin
		
		end
	else if (alarm_set == 1 && AhrsH == 8'd9)begin
		HexSeg5[4] = 1;
		end
	else if (alarm_set == 0 && hrsH == 8'd9)begin
		HexSeg5[4] = 1;
		end
end

//This controls the LEDs based on the switch positions.
always_comb begin
	LED0 = 0;LED1 = 0; LED2 =0; LED3 = 0; LED4 = 0; LED5 = 0;
	if (SW5)
	LED5 = 1;
	if (SW4)
	LED4 = 1;
	if (SW3)
	LED3 = 1;
	if (SW2)
	LED2 = 1;
	if (SW1)
	LED1 = 1;
	if (SW0)
	LED0 = 1;
   end

//This flashes LED7 at 2Hz if the alarm has been triggered.
always_ff @ (posedge clkout1) begin
	LED7 = 0;
	if (alrm == 1)
		LED7 = count2;
	else
		LED7 = 0;
   end

//Here we instantiate all the other modules that we will need in order to make our clock work.
alarm_clock A1 (clkt,reset,time_set,alarm_set,sethrs1min0,run_clock,activatealarm,alarmreset,runset,sec,min,hrs,min_alrm,hrs_alrm,alrm);
FreqDiv #(25) F1 (clk, reset, count_max, count, clkout);
FreqDiv #(25) F2 (clk, reset, count_max1, count1, clkout1);
mlsb_finder s1 (sec,secH,secL);
mlsb_finder m1 (min,minH,minL);
mlsb_finder h1 (hrs,hrsH,hrsL);
mlsb_finder Am1 (min_alrm,AminH,AminL);
mlsb_finder Ah1 (hrs_alrm,AhrsH,AhrsL);
clocktime c1(clkout1,alrm, reset,Maxval,count2,carry);
endmodule

//This is the main alarm_clock parent module.
module alarm_clock(input CLK_2Hz,reset,time_set,alarm_set,sethrs1min0,run_clock,activatealarm,alarmreset,runset,
output logic [7:0] sec,min,hrs,min_alrm,hrs_alrm,
output logic alrm);
logic carry_scl_1,carry_mcl_1,carry_hcl_1,carry_scl_2,carry_mcl_2,carry_hcl_2,minset,hrset,minsetA,hrsetA,runset_A;
logic [7:0] sec2;
	// This is how we set the clock.
	always_comb begin
	minset = 0; hrset =0;
		if (sethrs1min0 == 1 && time_set == 1 && runset == 0)begin
			minset = 0;
			hrset  = 1;
			end
		if (sethrs1min0 == 0 && time_set == 1 && runset == 0)begin
			minset = 1;
			hrset = 0;
			end
		end
	//This is how we set the alarm.
	always_comb begin
	minsetA = 0; hrsetA = 0;
		if (sethrs1min0 == 1 && alarm_set == 1 && runset == 0)begin
			minsetA = 0;
			hrsetA  = 1;
			end
		if (sethrs1min0 == 0 && alarm_set == 1 && runset == 0)begin
			minsetA = 1;
			hrsetA  = 0;
			end
		end
	//This is where handle the alarm and it's reset.
	always_comb 
		begin
		alrm <= 0;
		if (run_clock == 1 && activatealarm == 1 && alarmreset == 1 && hrs_alrm == hrs && min_alrm == min && hrs != 0 && min != 0)begin
			alrm <= 1;
			end
		else if (run_clock == 1 && alarmreset == 0)begin
			alrm <= 0;
			end
		end
//We instantiate two instances of the timer, one to run the clock the other for setting the alarm.
timer t1 (CLK_2Hz,run_clock,reset,time_set,minset,hrset,sec,min,hrs,carry_scl_1,carry_mcl_1,carry_hcl_1);
timer a1 (CLK_2Hz,!runset,reset|!alarmreset,alarm_set,minsetA,hrsetA,sec2,min_alrm,hrs_alrm,carry_scl_2,carry_mcl_2,carry_hcl_2);
endmodule

//This is the timer module which we will call to run both our clock and the alarm clock.
module timer (input clk_sec, freerun_t, reset_t, set, minset, hrset, output logic [7:0] seconds,minutes,hours, output carry_scl_1, carry_mcl_1, carry_hcl_1);
localparam fiftynine = 8'd59, twentythree = 8'd23;
logic set_min_t,set_hr_t,carry_scl, carry_mcl, carry_scl_, carry_mcl_;
assign set_min_t = minset;
assign set_hr_t = hrset;
	//This sets the minutes.
	always_comb begin
		if (set&&minset)
		carry_scl_ = clk_sec;
		else
		carry_scl_ = carry_scl;
		end
	//This sets the hours.
	always_comb begin
		if (set&&hrset)
		carry_mcl_ = clk_sec;
		else
		carry_mcl_ = carry_mcl;
		end
//We instantiate three instances of clocktime, one each for sec, mins and hours.
clocktime SecClock (clk_sec, freerun_t, reset_t, fiftynine, seconds, carry_scl);
clocktime MinClock (carry_scl_, freerun_t|set_min_t,reset_t, fiftynine, minutes, carry_mcl);
clocktime HrClock (carry_mcl_, freerun_t|set_hr_t,reset_t,twentythree, hours, carry_hcl);
endmodule

//This is a counter module which counts to a set value and then resets to 0.
module clocktime (input clk, freerun, reset, input [7:0] Maxval, output logic [7:0] count, output logic carry);

   always_ff @ (posedge clk or posedge reset)begin
	if (reset) begin
	   count <= 0;
	   carry <= 0;
	   end
	else
	   if (freerun)
		if (count < Maxval) begin
		   count <= count + 8'd1;
		   carry <= 0;
		   end
		else begin
		    count <=0;
		    carry <=1;
		    end
	end
endmodule

//This module is our frequency divider which will divide down the 50Mhz clock to 2Hz and 1Hz.
module FreqDiv #(parameter Size = 5)(input clk, reset, input [Size-1:0] count_max, output logic [Size-1:0] count, output logic clkout);
always_ff @ (posedge clk or posedge reset)begin
	if (reset) begin
		count <= {Size{1'b0}};
		clkout <= 1'b0;
		end
	else if(count < count_max)
		count <= count + {{(Size-1){1'b0}},1'b1};
	else 	begin 
		count <= {Size{1'b0}};
		clkout <= ~clkout;
		end
	end
endmodule

//This moodule seperates out higher and lower order bits.
module mlsb_finder (input [7:0] num, output logic [7:0] numH, numL);
function [7:0] msblsb;
input [7:0] A;
integer i;
msblsb = 0;
for (i=0;i<=9;i=i+1)
	if (A>(msblsb*8'd10+8'd9))
	   msblsb = msblsb+8'd1;
endfunction
always_comb begin
	numH = msblsb(num);
	numL = num-numH*10;
end
endmodule


