`timescale 1ns/1ps

import greenmatrix_pkg::*;

module tb_top;

    localparam int N = 2;

    logic clk;
    logic rst;
    logic start;

    logic busy;
    logic done;

    data_t matrix_a [0:N-1][0:N-1];
    data_t matrix_b [0:N-1][0:N-1];

    acc_t c_out [0:N-1][0:N-1];

    greenmatrix_top #(
        .N(N)
    ) dut (
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .matrix_a (matrix_a),
        .matrix_b (matrix_b),
        .busy     (busy),
        .done     (done),
        .c_out    (c_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/greenmatrix_wave.vcd");
        $dumpvars(0, tb_top);

        rst   = 1;
        start = 0;

        // Matrix A
        // [1 2]
        // [3 4]
        matrix_a[0][0] = 1;
        matrix_a[0][1] = 2;
        matrix_a[1][0] = 3;
        matrix_a[1][1] = 4;

        // Matrix B
        // [5 6]
        // [7 8]
        matrix_b[0][0] = 5;
        matrix_b[0][1] = 6;
        matrix_b[1][0] = 7;
        matrix_b[1][1] = 8;

        #12;
        rst = 0;

        // Start the complete accelerator.
        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        $display("GreenMatrix started.");

        wait(busy === 1'b1);
        $display("GreenMatrix is computing.");

        wait(done === 1'b1);
        #1;

        $display("----------------------------------------");
        $display("Complete GreenMatrix Result");
        $display("[ %0d  %0d ]", c_out[0][0], c_out[0][1]);
        $display("[ %0d  %0d ]", c_out[1][0], c_out[1][1]);
        $display("----------------------------------------");

        if (c_out[0][0] !== 19)
            $fatal(1, "C00 FAILED: expected 19, received %0d",
                   c_out[0][0]);

        if (c_out[0][1] !== 22)
            $fatal(1, "C01 FAILED: expected 22, received %0d",
                   c_out[0][1]);

        if (c_out[1][0] !== 43)
            $fatal(1, "C10 FAILED: expected 43, received %0d",
                   c_out[1][0]);

        if (c_out[1][1] !== 50)
            $fatal(1, "C11 FAILED: expected 50, received %0d",
                   c_out[1][1]);

        $display("COMPLETE GREENMATRIX TEST PASSED");
        $display("----------------------------------------");

        #10;
        $finish;
    end

endmodule
