package greenmatrix_pkg;

    // Global project parameters
    parameter int DATA_WIDTH = 8;
    parameter int ACC_WIDTH  = 32;
    parameter int ARRAY_SIZE = 2;

    // Reusable signed data types
    typedef logic signed [DATA_WIDTH-1:0] data_t;
    typedef logic signed [ACC_WIDTH-1:0]  acc_t;

endpackage
