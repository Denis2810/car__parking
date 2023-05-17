`timescale 1ns / 1ps

module FSM
    (
    input clk, sensor_entrance, sensor_exit, reset_n,
    input [1:0] pass1, pass2,
    output reg green_led, red_led,
    output reg [6:0] HEX_1, HEX_2
    );
    
    wire entrance_valid, exit_valid;
    reg [3:0] state_reg, state_next;
    reg enable;
    wire overflow;
    
    localparam IDLE = 0;
    localparam WAIT_PASSWORD = 1;
    localparam RIGHT_PASS = 2;
    localparam WRONG_PASS = 3;
    localparam STOP = 4;
    
    
    counter #(.BITS(3), .N(5)) entrance(clk, reset_n, sensor_entrance, entrance_valid);
    counter #(.BITS(3), .N(7)) exit(clk, reset_n, sensor_exit, exit_valid);
    counter #(.BITS(5), .N(30)) waiting(clk, reset_n, enable, overflow);
    
    
    
     always@(posedge clk or negedge reset_n) 
     begin
     if(~reset_n)
    begin
        state_reg <= IDLE;
    end
    else
        state_reg <= state_next;
    end
    
    always @ (*)
    begin
        state_next = state_reg;
        case(state_reg)
            IDLE: begin
                  enable=0;
                  if(entrance_valid==1)   
                    state_next = WAIT_PASSWORD;
                  else state_next = IDLE;
                  end
            WAIT_PASSWORD:  begin
                            enable=1;
                            if(pass1==1&&pass2==2) state_next = RIGHT_PASS;
                            else if(overflow)
                            begin
                            if(pass1==1&&pass2==2) state_next = RIGHT_PASS;
                            else state_next = WRONG_PASS;
                            end
                            else state_next = WAIT_PASSWORD;
                            end
            RIGHT_PASS: begin
                        enable=0;
                        if(entrance_valid==1 && exit_valid==1) state_next = STOP;
                        else if (exit_valid==1) state_next = IDLE;  
                        else state_next = RIGHT_PASS;  
                        end
            WRONG_PASS: begin
                        enable=0;
                        if(pass1==1&&pass2==2) state_next = RIGHT_PASS;
                        else state_next= WRONG_PASS;
                        end
            STOP:       begin
                        enable=0;
                        if(pass1==1&&pass2==2) state_next = RIGHT_PASS;
                        else state_next= STOP;
                        end
             default: begin 
                      state_next = IDLE;
                      enable=0;
                      end
        endcase
    end
    
    always @ (posedge clk)
    begin
        state_next = state_reg;
        case(state_reg)
            IDLE: begin
                  green_led=0;
                  red_led=0;
                  HEX_1 = 7'b1111111; 
                  HEX_2 = 7'b1111111;
                  end
            WAIT_PASSWORD: begin
                  green_led=0;
                  red_led=0;
                  HEX_1 = 7'b0000110; 
                  HEX_2 = 7'b0101011;
                           end
            RIGHT_PASS: begin
                        green_led=1;
                        red_led=0;
                        HEX_1 = 7'b0000010; 
                        HEX_2 = 7'b1000000;  
                        end
            WRONG_PASS: begin
                        green_led=0;
                        red_led=1;
                        HEX_1 = 7'b0000110; 
                        HEX_2 = 7'b0000110;
                        end
            STOP:       begin
                        green_led=0;
                        red_led=1;
                        HEX_1 = 7'b0010010; 
                        HEX_2 = 7'b0001100;
                        end
             default: state_next = IDLE;
        endcase
    end
    
endmodule
