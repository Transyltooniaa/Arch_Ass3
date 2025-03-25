module adder (
    input clk,
    input [7:0] a, b,
    output reg [7:0] sum,
    output reg cout
);
    reg [7:0] t1,t2;
    reg cin;
    always@(posedge clk) begin
        t1 <= a;
        t2 <= b;
        cin <= 0;
    end
    always @(posedge clk) begin
        {cout, sum} <= t1 + t2 + cin;
    end
endmodule
