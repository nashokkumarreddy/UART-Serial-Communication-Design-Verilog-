module baud_rate_gen (
    input wire clk,       // System Clock (e.g., 50MHz)
    input wire rst,       // Reset
    output reg tick       // 16x Oversampling Tick
);
    // Formula: Clock / (Baud Rate * 16)
    // Example: 50MHz / (9600 * 16) = ~325
    parameter DIVISOR = 325; 
    
    reg [10:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            tick <= 0;
        end else begin
            if (counter == DIVISOR - 1) begin
                counter <= 0;
                tick <= 1;
            end else begin
                counter <= counter + 1;
                tick <= 0;
            end
        end
    end
endmodule
