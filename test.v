module main;
	reg[3:0] x1 = 3; 
	reg[2:0] y1 = 3;
	reg[3:0] x2 = 0;
	reg[2:0] y2 = 2;
	reg[3:0] x3 = 1;
	reg[2:0] y3 = 1;
	wire[3:0] x4;
	wire[2:0] y4;

	initial begin
		$function(x1);
		$function(y1);		
		$function(x2);
		$function(y2);		
		$function(x3);
		$function(y3);
		$function(x4);
		$display("x4: %d", x4);
		$function(y4);
		$display("y4: %d", y4);

	end
endmodule