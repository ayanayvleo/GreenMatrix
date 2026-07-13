`timescale 1ns/1ps

import greenmatrix_pkg::*;

module matrix_loader #(
    parameter int N = ARRAY_SIZE
) (
    input logic clk,
    input logic rst,
    input logic clear_acc,
    input logic enable,

    input data_t matrix_a [0:N-1][0:N-1],
    input data_t matrix_b [0:N-1][0:N-1],

    output data_t a_row_out [0:N-1],
    output data_t b_col_out [0:N-1]
);

    localparam int STREAM_CYCLES = (2 * N) - 1;
    localparam int COUNTER_WIDTH =
        (STREAM_CYCLES <= 1) ? 1 : $clog2(STREAM_CYCLES + 1);

    logic [COUNTER_WIDTH-1:0] stream_cycle;

    integer row;
    integer col;
    integer a_index;
    integer b_index;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            stream_cycle <= '0;
        else if (clear_acc)
            stream_cycle <= '0;
        else if (enable)
            stream_cycle <= stream_cycle + 1'b1;
    end

    always_comb begin
        for (row = 0; row < N; row = row + 1)
            a_row_out[row] = '0;

        for (col = 0; col < N; col = col + 1)
            b_col_out[col] = '0;

        if (enable) begin

            // Matrix A is skewed by row.
            for (row = 0; row < N; row = row + 1) begin
                a_index = stream_cycle - row;

                if ((stream_cycle >= row) &&
                    (a_index >= 0) &&
                    (a_index < N))
                    a_row_out[row] = matrix_a[row][a_index];
            end

            // Matrix B is skewed by column.
            for (col = 0; col < N; col = col + 1) begin
                b_index = stream_cycle - col;

                if ((stream_cycle >= col) &&
                    (b_index >= 0) &&
                    (b_index < N))
                    b_col_out[col] = matrix_b[b_index][col];
            end

        end
    end

endmodule
