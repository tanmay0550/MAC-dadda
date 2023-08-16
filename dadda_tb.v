module dadda_tb;
	reg [7:0] a, b; 
	reg [15:0] x;
	
	wire [15:0] mult_out;
	wire cout;

	dadda inst (a,b,x,mult_out,cout);
	
	initial
	begin
		$dumpvars();
	end
	
	
	//initial begin
		//x = 16'h1111;
		//#1000
		//x = 16'h00ff;
		//#2000
		//x = 16'hff00;
		//#1000
		//x = 16'h2222;
		//#1000
		//x = 16'hffff;
	//end
	
	initial begin
		a = 8'd70; b =8'd20;x = 16'h1111;
		#1000 a = 8'd79; b =8'd69;x = 16'h00ff;
		#1000 a = 8'd215; b =8'd200;x = 16'hff00;
		#1000 a = 8'd74; b =8'd113;x = 16'h2222;
		#1000 a = 8'd93; b =8'd7;x = 16'hffff;
		#1000 a = 8'd117; b =8'd120;x = 16'hffff;
		#1000 a = 8'd79; b =8'd29;x = 16'hffff;
		#1000 a = 8'd73; b =8'd120;x = 16'hffff;
		#1000 a = 8'hff; b =8'hff;x = 16'hffff;
	end
	
	
	
	initial begin
	#11000;$finish;
	end
	
	
endmodule




