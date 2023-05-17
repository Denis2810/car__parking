`timescale 1ns / 1ps

module counter
    #(parameter BITS=5, N=30)
    (
    input clk, reset_n, enable,
    output reg overflow
    );
    
    reg [BITS-1:0] count;
    initial count=0;
    
    always @ (posedge clk or negedge reset_n)
    begin
        if(~reset_n)
            begin
            count<=0;
            overflow<=0;
            end
            
        else if(enable)
        begin
        count<=count+1;
        overflow<=0;
        end
        
        else if(~enable)
        count<=0;
        
        else 
        begin
        count<=count;
        overflow<=overflow;
        end
        
        if(count==N)
        begin
            overflow<=1;
            count<=0;
        end
    end
        
        always @ (posedge clk)
        begin
            if(overflow)
            overflow<=0;
        end
    
    
        
    
endmodule