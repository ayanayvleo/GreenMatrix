`timescale 1ns/1ps

import greenmatrix_pkg::*;

module mac_unit (
    input  logic clk,
    input  logic rst,
    input  logic clear_acc,
    input  logic enable,

    input  data_t a,
    input  data_t b,

    input  acc_t acc_in,
    output acc_t acc_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            acc_out <= '0;
        else if (clear_acc)
            acc_out <= '0;
        else if (enable)
            acc_out <= acc_in + (a * b);
    end

endmodule
