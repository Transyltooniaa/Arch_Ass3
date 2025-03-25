`timescale 1ns / 1ps

module adder_tb;
    reg clk;
    reg [7:0] a, b;
    wire [7:0] sum;
    wire cout;
    
    adder uut (
        .clk(clk),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        a = 0;
        b = 0;
        
        #10 a = 8'd15; b = 8'd10; 
        #10 a = 8'd200; b = 8'd100; 
        #10 a = 8'd255; b = 8'd1; 
        #10 a = 8'd127; b = 8'd127; 
        
        #20 $finish;
    end
    
    initial begin
        $monitor("Time=%0t | a=%d, b=%d, sum=%d, cout=%b", $time, a, b, sum, cout);
    end
    
endmodule