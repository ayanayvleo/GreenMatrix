`timescale 1ns/1ps

import greenmatrix_pkg::*;

module pe (
    input  logic clk,
    input  logic rst,
    input  logic clear_acc,
    input  logic enable,

    input  data_t a_in,
    input  data_t b_in,

    output data_t a_out,
    output data_t b_out,
    output acc_t  acc_out
);

    wire acc_t acc_feedback;

    // Pass matrix A values toward the right.
    // Pass matrix B values downward.
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            a_out <= '0;
            b_out <= '0;
        end
        else if (enable) begin
            a_out <= a_in;
            b_out <= b_in;
        end
    end

    // Each PE contains one multiply-accumulate unit.
    mac_unit u_mac (
        .clk       (clk),
        .rst       (rst),
        .clear_acc (clear_acc),
        .enable    (enable),
        .a         (a_in),
        .b         (b_in),
        .acc_in    (acc_feedback),
        .acc_out   (acc_feedback)
    );

    assign acc_out = acc_feedback;

endmodule
