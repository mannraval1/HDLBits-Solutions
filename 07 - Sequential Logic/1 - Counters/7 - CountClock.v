module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
    //assign pm = ((hh == 8'h11) && (mm == 8'h60) && (ss == 8'h60));
  	always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // Starts at 12
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;  // 0 for AM
        end 
        else if (ena) begin
            // --- SECONDS ---
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // --- MINUTES ---
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // --- HOURS ---
                    if (hh == 8'h12) hh <= 8'h01;
                    else if (hh == 8'h09) hh <= 8'h10;
                    else hh <= hh + 1;

                    // --- PM TOGGLE ---
                    if (hh == 8'h11) pm <= ~pm;
                end 
                else begin
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        mm[7:4] <= mm[7:4] + 1;
                    end else mm[3:0] <= mm[3:0] + 1;
                end
            end 
            else begin
                if (ss[3:0] == 4'h9) begin
                    ss[3:0] <= 4'h0;
                    ss[7:4] <= ss[7:4] + 1;
                end else ss[3:0] <= ss[3:0] + 1;
            end
        end
    end
endmodule
