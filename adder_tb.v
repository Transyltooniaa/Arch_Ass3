`timescale 1ns/1ps

module adder_tb;
    // Inputs
    reg clk;
    reg [7:0] a, b;
    
    // Outputs
    wire [7:0] sum;
    wire cout;
    
    // Expected results
    reg [8:0] expected_result;  // 9-bit to account for cout
    
    // Instantiate the Unit Under Test (UUT)
    adder uut (
        .clk(clk),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5 ns (10 ns period)
    end
    
    // Test cases
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        
        // Wait for global reset
        #10;
        
        // Test case 1: Simple addition without carry
        a = 8'd10;
        b = 8'd20;
        expected_result = a + b;
        #10;  // Wait for registers to update
        #10;  // Wait for addition result
        check_result("Test 1");
        
        // Test case 2: Addition with large numbers
        a = 8'd100;
        b = 8'd100;
        expected_result = a + b;
        #10;
        #10;
        check_result("Test 2");
        
        // Test case 3: Addition with carry out
        a = 8'd255;
        b = 8'd1;
        expected_result = a + b;
        #10;
        #10;
        check_result("Test 3");
        
        // Test case 4: Maximum values
        a = 8'd255;
        b = 8'd255;
        expected_result = a + b;
        #10;
        #10;
        check_result("Test 4");
        
        // Test case 5: Random values
        a = $random;
        b = $random;
        expected_result = a + b;
        #10;
        #10;
        check_result("Test 5");
        
        // Finish simulation
        #10 $finish;
    end
    
    // Task to check if result matches expected
    task check_result;
        input [8*10:1] test_name;  // ASCII string for test name
        reg [8:0] actual_result;
        begin
            actual_result = {cout, sum};  
            
            $display("%s: %d + %d = {cout=%b, sum=%d}", test_name, a, b, cout, sum);
            
            if (actual_result === expected_result) begin
                $display("  [PASS] Expected: {cout=%b, sum=%d}", expected_result[8], expected_result[7:0]);
            end
            else begin
                $display("  [FAIL] Expected: {cout=%b, sum=%d}, Got: {cout=%b, sum=%d}",
                         expected_result[8], expected_result[7:0], cout, sum);
            end
        end
    endtask
    
    initial begin
        $monitor("At time %t: a=%d, b=%d, sum=%d, cout=%b",
                 $time, a, b, sum, cout);
    end
endmodule
