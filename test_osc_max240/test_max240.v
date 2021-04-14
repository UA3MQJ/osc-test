module test_max240(clk50M, led, wo1, wo2, wo3, wo4);

input wire clk50M;
output wire led;
output wire wo1, wo2, wo3, wo4;

reg [1:0] clkdiv;
reg rled;

initial clkdiv <= 2'd0;
initial rled <= 0;

//assign led = rled;

wire clk8M;

assign clk8M = rled;

always @(posedge clk50M) begin
	clkdiv <= (clkdiv == 2'd2) ? 2'd0 : clkdiv + 1;
	rled <= (clkdiv == 2'd2) ? ~rled : rled;	
end

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

assign led = sub_cnt_m;

wire clk_d10;
assign clk_d10 = cnt[3];

//assign ps1 = cnt[23]==1; // 1 раз в секунду
//assign ps2 = cnt[22]==1; // 2
//assign ps4 = cnt[21]==1; // 4
//assign ps8 = cnt[20]==1; // 8

//assign ps1 = cnt[19]==1; // 16 раз в секунду
//assign ps2 = cnt[18]==1; // 32
//assign ps4 = cnt[17]==1; // 64
//assign ps8 = cnt[16]==1; // 128

//assign ps1 = cnt[15]==1; // 256 раз в секунду
//assign ps2 = cnt[14]==1; // 512
//assign ps4 = cnt[13]==1; // 1024
//assign ps8 = cnt[12]==1; // 2048

assign ps1 = cnt[11]==1; // 4096 раз в секунду
assign ps2 = cnt[10]==1; // 8192
assign ps4 = cnt[9]==1; // 16384
assign ps8 = cnt[8]==1; // 32768



assign pr1 = (sub_cnt == 13);
assign pr2 = (sub_cnt == 10);
assign pr4 = (sub_cnt == 5);
assign pr8 = (sub_cnt == 2);

assign ws1 = sec1 != ps1;
assign ws2 = sec2 != ps2;
assign ws4 = sec4 != ps4;
assign ws8 = sec8 != ps8;

assign wo1 = wss1;
assign wo2 = wss2;
assign wo3 = wss4;
assign wo4 = wss8;

always @(posedge clk8M) begin
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
