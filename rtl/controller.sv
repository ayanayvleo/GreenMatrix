`timescale 1ns/1ps

module controller #(
    parameter int COMPUTE_CYCLES = 4
) (
    input  logic clk,
    input  logic rst,
    input  logic start,

    output logic clear_acc,
    output logic enable,
    output logic busy,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        CLEAR,
        COMPUTE,
        DONE
    } state_t;

    state_t current_state;
    state_t next_state;

    localparam int COUNTER_WIDTH =
        (COMPUTE_CYCLES <= 1) ? 1 : $clog2(COMPUTE_CYCLES);

    logic [COUNTER_WIDTH-1:0] cycle_count;

    // State register and compute-cycle counter
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            cycle_count   <= '0;
        end
        else begin
            current_state <= next_state;

            if (current_state == CLEAR)
                cycle_count <= '0;
            else if (current_state == COMPUTE)
                cycle_count <= cycle_count + 1'b1;
            else
                cycle_count <= '0;
        end
    end

    // State transition logic
    always_comb begin
        next_state = current_state;

        case (current_state)

            IDLE: begin
                if (start)
                    next_state = CLEAR;
            end

            CLEAR: begin
                next_state = COMPUTE;
            end

            COMPUTE: begin
                if (cycle_count == COMPUTE_CYCLES - 1)
                    next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end

    // Output control logic
    always_comb begin
        clear_acc = 1'b0;
        enable    = 1'b0;
        busy      = 1'b0;
        done      = 1'b0;

        case (current_state)

            IDLE: begin
                busy = 1'b0;
            end

            CLEAR: begin
                clear_acc = 1'b1;
                busy      = 1'b1;
            end

            COMPUTE: begin
                enable = 1'b1;
                busy   = 1'b1;
            end

            DONE: begin
                done = 1'b1;
            end

            default: begin
                clear_acc = 1'b0;
                enable    = 1'b0;
                busy      = 1'b0;
                done      = 1'b0;
            end

        endcase
    end

endmodule
