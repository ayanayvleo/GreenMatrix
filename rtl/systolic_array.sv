`timescale 1ns/1ps

import greenmatrix_pkg::*;

module systolic_array #(
    parameter int N = ARRAY_SIZE
) (
    input logic clk,
    input logic rst,
    input logic clear_acc,
    input logic enable,

    // One A input for each row.
    input data_t a_row_in [0:N-1],

    // One B input for each column.
    input data_t b_col_in [0:N-1],

    // N x N result matrix.
    output acc_t c_out [0:N-1][0:N-1]
);

    // Data traveling horizontally through the array.
    data_t a_pipe [0:N-1][0:N-1];

    // Data traveling vertically through the array.
    data_t b_pipe [0:N-1][0:N-1];

    genvar row;
    genvar col;

    generate
        for (row = 0; row < N; row = row + 1) begin : GEN_ROWS
            for (col = 0; col < N; col = col + 1) begin : GEN_COLS

                data_t pe_a_in;
                data_t pe_b_in;

                // First column receives A from the outside.
                // Remaining columns receive A from the PE on the left.
                if (col == 0) begin : GEN_A_LEFT_EDGE
                    assign pe_a_in = a_row_in[row];
                end
                else begin : GEN_A_INTERNAL
                    assign pe_a_in = a_pipe[row][col-1];
                end

                // First row receives B from the outside.
                // Remaining rows receive B from the PE above.
                if (row == 0) begin : GEN_B_TOP_EDGE
                    assign pe_b_in = b_col_in[col];
                end
                else begin : GEN_B_INTERNAL
                    assign pe_b_in = b_pipe[row-1][col];
                end

                pe u_pe (
                    .clk       (clk),
                    .rst       (rst),
                    .clear_acc (clear_acc),
                    .enable    (enable),

                    .a_in      (pe_a_in),
                    .b_in      (pe_b_in),

                    .a_out     (a_pipe[row][col]),
                    .b_out     (b_pipe[row][col]),
                    .acc_out   (c_out[row][col])
                );

            end
        end
    endgenerate

endmodule
