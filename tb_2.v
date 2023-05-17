`timescale 1ns / 1ps



module tb_2();

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
    reset_n=0;
    #2 reset_n=1;
end

initial begin
    sensor_entrance=1;
    sensor_exit=1;
    #22 sensor_entrance=0;
    #9 sensor_entrance=1;
    sensor_exit=0;
    #27 sensor_entrance=0;
end

initial begin
    #300 $stop();
end

initial begin
    #80
    pass1=1;
    #20 pass2=2;
    #10 pass1=1;
    pass2=2;
    #10 sensor_exit=1;
    pass2=0;
    #10 sensor_entrance=1;
    #30 sensor_entrance=0;
    sensor_exit=0;
    pass2=2;
    #10 sensor_exit=1;
    #40 sensor_exit=0;
end

//IDLE -> WAIT_PASSWORD -> RIGHT_PASS -> STOP -> RIGHT_PASS -> IDLE

endmodule
