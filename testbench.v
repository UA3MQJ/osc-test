`timescale 1ns/1ps
module testbench();

reg clk;
reg [24:0] cnt;

reg sec1, wss1;
reg sec2, wss2;
reg sec4, wss4;
reg sec8, wss8;

wire ws1;
wire ws2;
wire ws4;
wire ws8;

wire ps1, pr1;
wire ps2, pr2;
wire ps4, pr4;
wire ps8, pr8;

wire [3:0] sub_cnt;
assign sub_cnt = cnt[3:0];

wire sub_cnt_m;
assign sub_cnt_m = clk_d10 + ((wss1 && pr8)||(wss2 && pr4)||(wss4 && pr2)||(wss8 && pr1));

wire clk_d10;
assign clk_d10 = cnt[3];

assign ps1 = cnt[24]==1;
assign ps2 = cnt[23]==1;
assign ps4 = cnt[22]==1;
assign ps8 = cnt[21]==1;

assign pr1 = (sub_cnt == 13);
assign pr2 = (sub_cnt == 10);
assign pr4 = (sub_cnt == 5);
assign pr8 = (sub_cnt == 2);

assign ws1 = sec1 != ps1;
assign ws2 = sec2 != ps2;
assign ws4 = sec4 != ps4;
assign ws8 = sec8 != ps8;

initial
begin
    $dumpfile("bench.vcd");
    $dumpvars(0,testbench);

    $display("starting testbench!!!!");
	
	clk <= 0;
    cnt <= 0;
    sec1 <= 0;
    sec2 <= 0;
    sec4 <= 0;
    sec8 <= 0;

    wss1 <=0;wss2 <=0;wss4 <=0;wss8 <=0;

	repeat (16777216+32) begin // 1s 16 MHz
		#33;
		clk <= 1;
		#33;
		clk <= 0; 
	end
	
    $display("finished OK!");
    //$finish;
end

initial
begin

end

always @(posedge clk) begin
    cnt <= cnt + 1;

    sec1 <= ps1;
    sec2 <= ps2;
    sec4 <= ps4;
    sec8 <= ps8;

    if (ws1==1) wss1 <= 1;
    if (ws2==1) wss2 <= 1;
    if (ws4==1) wss4 <= 1;
    if (ws8==1) wss8 <= 1;

    if (sub_cnt==15) begin
        wss1 <= 0;
        wss2 <= 0;
        wss4 <= 0;
        wss8 <= 0;
    end
end
	
endmodule
