`default_nettype none

module tt_um_decodificador (
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,   // Dedicated outputs
  input  wire [7:0] uio_in,   // IOs: Input path
  output wire [7:0] uio_out,  // IOs: Output path
  output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // always 1 when the design is powered, so you can ignore it
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);

  reg [6:0] segmentos;

  always @(*) begin
    case (ui_in[3:0])
      4'd0: segmentos = 7'b1111110;
      4'd1: segmentos = 7'b0110000;
      4'd2: segmentos = 7'b1101101;
      4'd3: segmentos = 7'b1111001;
      4'd4: segmentos = 7'b0110011;
      4'd5: segmentos = 7'b1011011;
      4'd6: segmentos = 7'b1011111;
      4'd7: segmentos = 7'b1110000;
      4'd8: segmentos = 7'b1111111;
      4'd9: segmentos = 7'b1111011;
      default: segmentos = 7'b0000000;
    endcase
  end

  assign uo_out  = {1'b0, segmentos};
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, ui_in[7:4], 1'b0};

endmodule
