`timescale 1ns / 1ps



module tb_1();

reg clk, sensor_entrance, sensor_exit, reset_n;
reg [1:0] pass1, pass2;
wire green_led, red_led;
wire [6:0] HEX_1, HEX_2;

FSM dut(clk, sensor_entrance, sensor_exit, reset_n , pass1, pass2, green_led, red_led, HEX_1, HEX_2);

initial begin
    clk=0;
    forever #3 clk=~clk;
end

initial begin
    sensor_entrance=1;
    #33 sensor_entrance=0;
end

initial begin
    reset_n=0;
    #2 reset_n=1;
end

initial begin
    pass1=0;
    pass2=0;
    #235 
    pass1=1;
    pass2=2;
    #5
    sensor_exit=1;
    #15
    sensor_entrance=1;
    #50 
    sensor_exit=0;
    sensor_entrance=0;
end

//IDLE -> WAIT -> WRONG_PASS -> RIGHT_PASS -> STOP -> RIGHT_PASS



initial begin
    #400 $stop();
end


endmodule
