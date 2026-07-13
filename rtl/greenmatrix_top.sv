`timescale 1ns/1ps

import greenmatrix_pkg::*;

module greenmatrix_top #(
    parameter int N = ARRAY_SIZE,
    parameter int COMPUTE_CYCLES = (3 * N) - 2
) (
    input logic clk,
    input logic rst,
    input logic start,

    input data_t matrix_a [0:N-1][0:N-1],
    input data_t matrix_b [0:N-1][0:N-1],

    output logic busy,
    output logic done,

    output acc_t c_out [0:N-1][0:N-1]
);

    logic clear_acc;
    logic enable;

    data_t a_row_stream [0:N-1];
    data_t b_col_stream [0:N-1];

    controller #(
        .COMPUTE_CYCLES(COMPUTE_CYCLES)
    ) controller_inst (
        .clk       (clk),
        .rst       (rst),
        .start     (start),
        .clear_acc (clear_acc),
        .enable    (enable),
        .busy      (busy),
        .done      (done)
    );

    matrix_loader #(
        .N(N)
    ) loader_inst (
        .clk       (clk),
        .rst       (rst),
        .clear_acc (clear_acc),
        .enable    (enable),
        .matrix_a  (matrix_a),
        .matrix_b  (matrix_b),
        .a_row_out (a_row_stream),
        .b_col_out (b_col_stream)
    );

    systolic_array #(
        .N(N)
    ) array_inst (
        .clk       (clk),
        .rst       (rst),
        .clear_acc (clear_acc),
        .enable    (enable),
        .a_row_in  (a_row_stream),
        .b_col_in  (b_col_stream),
        .c_out     (c_out)
    );

endmodule
