`timescale 1ns/1ps

module tb_controller;

    logic clk;
    logic rst;
    logic start;

    logic clear_acc;
    logic enable;
    logic busy;
    logic done;

    controller #(
        .COMPUTE_CYCLES(4)
    ) dut (
        .clk       (clk),
        .rst       (rst),
        .start     (start),
        .clear_acc (clear_acc),
        .enable    (enable),
        .busy      (busy),
        .done      (done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/controller_wave.vcd");
        $dumpvars(0, tb_controller);

        rst   = 1;
        start = 0;

        #12;
        rst = 0;

        // Confirm IDLE state
        @(posedge clk);
        #1;

        if (busy !== 0 || done !== 0)
            $fatal(1, "IDLE TEST FAILED");
        else
            $display("IDLE TEST PASSED");

        // Send one-clock start pulse
        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        // Controller should enter CLEAR
        if (clear_acc !== 1 || busy !== 1)
            $fatal(1, "CLEAR STATE FAILED");
        else
            $display("CLEAR STATE PASSED");

        // Controller should enter COMPUTE
        @(negedge clk);

        if (enable !== 1 || busy !== 1)
            $fatal(1, "COMPUTE STATE FAILED");
        else
            $display("COMPUTE STATE STARTED");

        // Wait for computation to finish
        wait(done === 1'b1);

        #1;

        if (enable !== 0 || busy !== 0)
            $fatal(1, "DONE STATE CONTROL FAILED");

        $display("DONE STATE PASSED");
        $display("----------------------------------------");
        $display("ALL CONTROLLER FSM TESTS PASSED");
        $display("----------------------------------------");

        @(posedge clk);
        #10;
        $finish;
    end

endmodule
