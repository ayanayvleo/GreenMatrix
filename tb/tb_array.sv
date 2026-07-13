`timescale 1ns/1ps

import greenmatrix_pkg::*;

module tb_array;

    localparam int N = 2;

    logic clk;
    logic rst;
    logic clear_acc;
    logic enable;

    data_t a_row_in [0:N-1];
    data_t b_col_in [0:N-1];

    acc_t c_out [0:N-1][0:N-1];

    systolic_array #(
        .N(N)
    ) dut (
        .clk       (clk),
        .rst       (rst),
        .clear_acc (clear_acc),
        .enable    (enable),
        .a_row_in  (a_row_in),
        .b_col_in  (b_col_in),
        .c_out     (c_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task drive_inputs(
        input integer a0,
        input integer a1,
        input integer b0,
        input integer b1
    );
        begin
            @(negedge clk);

            a_row_in[0] = a0;
            a_row_in[1] = a1;

            b_col_in[0] = b0;
            b_col_in[1] = b1;
        end
    endtask

    initial begin
        $dumpfile("sim/parameterized_array_wave.vcd");
        $dumpvars(0, tb_array);

        rst       = 1;
        clear_acc = 0;
        enable    = 0;

        a_row_in[0] = 0;
        a_row_in[1] = 0;

        b_col_in[0] = 0;
        b_col_in[1] = 0;

        #12;
        rst    = 0;
        enable = 1;

        // Matrix A:
        // 1 2
        // 3 4
        //
        // Matrix B:
        // 5 6
        // 7 8

        drive_inputs(1, 0, 5, 0);
        drive_inputs(2, 3, 7, 6);
        drive_inputs(0, 4, 0, 8);
        drive_inputs(0, 0, 0, 0);

        @(posedge clk);
        #1;

        $display("----------------------------------------");
        $display("Parameterized GreenMatrix Result");
        $display("[ %0d  %0d ]", c_out[0][0], c_out[0][1]);
        $display("[ %0d  %0d ]", c_out[1][0], c_out[1][1]);
        $display("----------------------------------------");

        if (c_out[0][0] !== 19)
            $fatal(1, "C00 FAILED: expected 19, received %0d", c_out[0][0]);

        if (c_out[0][1] !== 22)
            $fatal(1, "C01 FAILED: expected 22, received %0d", c_out[0][1]);

        if (c_out[1][0] !== 43)
            $fatal(1, "C10 FAILED: expected 43, received %0d", c_out[1][0]);

        if (c_out[1][1] !== 50)
            $fatal(1, "C11 FAILED: expected 50, received %0d", c_out[1][1]);

        $display("PARAMETERIZED 2x2 ARRAY TEST PASSED");
        $display("----------------------------------------");

        #10;
        $finish;
    end

endmodule
