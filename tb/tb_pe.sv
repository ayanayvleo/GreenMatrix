`timescale 1ns/1ps

import greenmatrix_pkg::*;

module tb_pe;

    logic clk;
    logic rst;
    logic clear_acc;
    logic enable;

    data_t a_in;
    data_t b_in;

    data_t a_out;
    data_t b_out;
    acc_t  acc_out;

    pe dut (
        .clk       (clk),
        .rst       (rst),
        .clear_acc (clear_acc),
        .enable    (enable),
        .a_in      (a_in),
        .b_in      (b_in),
        .a_out     (a_out),
        .b_out     (b_out),
        .acc_out   (acc_out)
    );

    // 100 MHz clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/pe_wave.vcd");
        $dumpvars(0, tb_pe);

        rst       = 1;
        clear_acc = 0;
        enable    = 0;
        a_in      = 0;
        b_in      = 0;

        // Reset the PE
        #12;
        rst = 0;

        // First MAC operation: 2 x 3 = 6
        @(negedge clk);
        enable = 1;
        a_in   = 2;
        b_in   = 3;

        @(posedge clk);
        #1;
        if (acc_out !== 6)
            $fatal(1, "TEST 1 FAILED: expected 6, received %0d", acc_out);
        else
            $display("TEST 1 PASSED: 2 x 3 = %0d", acc_out);

        if ((a_out !== 2) || (b_out !== 3))
            $fatal(1, "DATA PASS FAILED: a_out=%0d b_out=%0d", a_out, b_out);
        else
            $display("DATA PASS PASSED: a_out=%0d b_out=%0d", a_out, b_out);

        // Second MAC operation: 6 + (4 x 5) = 26
        @(negedge clk);
        a_in = 4;
        b_in = 5;

        @(posedge clk);
        #1;
        if (acc_out !== 26)
            $fatal(1, "TEST 2 FAILED: expected 26, received %0d", acc_out);
        else
            $display("TEST 2 PASSED: 6 + (4 x 5) = %0d", acc_out);

        // Disable should hold the accumulator and outputs
        @(negedge clk);
        enable = 0;
        a_in   = 7;
        b_in   = 7;

        @(posedge clk);
        #1;
        if (acc_out !== 26)
            $fatal(1, "ENABLE TEST FAILED: expected 26, received %0d", acc_out);
        else
            $display("ENABLE TEST PASSED: accumulator held at %0d", acc_out);

        // Clear the accumulator
        @(negedge clk);
        clear_acc = 1;

        @(posedge clk);
        #1;
        if (acc_out !== 0)
            $fatal(1, "CLEAR TEST FAILED: expected 0, received %0d", acc_out);
        else
            $display("CLEAR TEST PASSED: accumulator reset to %0d", acc_out);

        clear_acc = 0;

        $display("----------------------------------------");
        $display("ALL PROCESSING ELEMENT TESTS PASSED");
        $display("----------------------------------------");

        #10;
        $finish;
    end

endmodule
