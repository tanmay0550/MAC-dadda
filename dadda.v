module dadda(
    input [7:0] A,B,
    input [15:0] C,
    output [15:0] mult,
    output cout
);
    reg layer1 [15:0][0:8];
	 reg [15:0] layer1_temp;
    wire [15:0] si1,si2;
	 wire [45:0] carry_f,sum_f;
	 wire [9:0] carry_h,sum_h;
	 wire [31:0] bk_in1,bk_in2,bk_sum;
	 wire bk_cout;
//    assign layer1 [15:0][0] = C;
    integer i,j;
	 integer k;
	 always @(*) begin 
        for(k=0; k<16; k=k+1) begin: M1  
            layer1[k][0]<= C[k];
        end
		  
		  for(j=0; j<8; j=j+1) begin
            for(i = 0; i<8; i=i+1) 
                layer1[i+j][j+1] <= A[i] & B[j];
            end
		  
    end
//	 assign layer1[15:0][0] = layer1_temp;
	 
//    generate 
//        for(j=0; j<8; j=j+1) begin: U1  
//            for(i = 0; i<8; i=i+1) begin: U2
//                and_block g (A[i],B[j],layer1[i+j][j+1]);
//            end
//        end
//    endgenerate
//  assign si1= {C[1] , C[0]};
    half_adder h0 (layer1[5][5],layer1[5][6],sum_h[0],carry_h[0]);
    half_adder h1 (layer1[6][6],layer1[6][7],sum_h[1],carry_h[1]);
    half_adder h2 (layer1[7][7],layer1[7][8],sum_h[2],carry_h[2]);
    half_adder h3 (layer1[8][0],layer1[8][2],sum_h[3],carry_h[3]);

    full_adder f0 (layer1[6][3],layer1[6][4],layer1[6][5],sum_f[0],carry_f[0]);
    full_adder f1 (layer1[7][1],layer1[7][2],layer1[7][3],sum_f[1],carry_f[1]);
    full_adder f2 (layer1[7][4],layer1[7][5],layer1[7][6],sum_f[2],carry_f[2]);
    full_adder f3 (layer1[8][3],layer1[8][4],layer1[8][5],sum_f[3],carry_f[3]);
    full_adder f4 (layer1[8][6],layer1[8][7],layer1[8][8],sum_f[4],carry_f[4]);
    full_adder f5 (layer1[9][3],layer1[9][4],layer1[9][5],sum_f[5],carry_f[5]);
    full_adder f6 (layer1[9][6],layer1[9][7],layer1[9][8],sum_f[6],carry_f[6]);
    full_adder f7 (layer1[10][6],layer1[9][7],layer1[9][8],sum_f[7],carry_f[7]);


//layer2
    half_adder h4 (layer1[3][3],layer1[3][4],sum_h[4],carry_h[4]);
    half_adder h5 (layer1[4][4],layer1[4][5],sum_h[5],carry_h[5]);
    // half_adder h6 (layer1[11][7],layer1[11][8],sum_h[6],carry_h[6]);

    full_adder f8  (layer1[4][1],layer1[4][2],layer1[4][3],sum_f[8],carry_f[8]);
    full_adder f10 (layer1[5][0],layer1[5][1],layer1[5][2],sum_f[9],carry_f[9]);
    full_adder f9 (layer1[5][3],layer1[5][4],sum_h[0],sum_f[10],carry_f[10]);
    full_adder f11 (layer1[6][0],layer1[6][1],layer1[6][2],sum_f[11],carry_f[11]);
    full_adder f12 (sum_f[0],sum_h[1],carry_h[0],sum_f[12],carry_f[12]);
    full_adder f13 (layer1[7][0],sum_f[1],sum_f[2],sum_f[13],carry_f[13]);
    full_adder f14 (sum_h[2],carry_f[0],carry_h[1],sum_f[14],carry_f[14]);
    full_adder f15 (sum_h[3],sum_f[3],sum_f[4],sum_f[15],carry_f[15]);
    full_adder f16 (carry_f[1],carry_f[2],carry_h[2],sum_f[16],carry_f[16]);
    full_adder f17 (layer1[9][0],sum_f[5],sum_f[6],sum_f[17],carry_f[17]);
    full_adder f18 (carry_f[3],carry_f[4],carry_h[3],sum_f[18],carry_f[18]);
    full_adder f19 (layer1[10][0],layer1[10][4],layer1[10][5],sum_f[19],carry_f[19]);
    full_adder f20 (sum_f[7],carry_f[5],carry_f[6],sum_f[20],carry_f[20]);
    full_adder f21 (layer1[11][0],layer1[11][5],layer1[11][6],sum_f[21],carry_f[21]);
    full_adder f22 (layer1[12][6],layer1[12][7],layer1[12][8],sum_f[22],carry_f[22]);
    full_adder h6 (layer1[11][7],layer1[11][8],carry_f[7],sum_h[6],carry_h[6]);


//layer3
	half_adder h7 (layer1[2][2],layer1[2][3],sum_h[7],carry_h[7]);
    //half_adder h8 (layer1[13][7],layer1[13][8],sum_h[8],carry_h[8]);
	full_adder f33e (layer1[13][7],layer1[13][8],carry_f[22],sum_h[8],carry_h[8]);


    full_adder f23 (layer1[3][1],layer1[3][2],sum_h[4],sum_f[23],carry_f[23]);
    full_adder f24 (sum_f[8],sum_h[5],carry_h[4],sum_f[24],carry_f[24]);
    full_adder f25 (sum_f[10],carry_f[8],carry_h[5],sum_f[25],carry_f[25]);
    full_adder f26 (sum_f[12],carry_f[9],carry_f[10],sum_f[26],carry_f[26]);
    full_adder f27 (sum_f[14],carry_f[11],carry_f[12],sum_f[27],carry_f[27]);
    full_adder f28 (sum_f[16],carry_f[13],carry_f[14],sum_f[28],carry_f[28]);
    full_adder f29 (sum_f[18],carry_f[15],carry_f[16],sum_f[29],carry_f[29]);
    full_adder f30 (sum_f[20],carry_f[17],carry_f[18],sum_f[30],carry_f[30]);
    full_adder f31 (sum_h[6],carry_f[19],carry_f[20],sum_f[31],carry_f[31]);
    full_adder f32 (sum_f[22],carry_f[21],carry_h[6],sum_f[32],carry_f[32]);


//layer4
	half_adder h9 (layer1[1][1],layer1[1][2],sum_h[9],carry_h[9]);
	
	full_adder f33 (layer1[2][0],layer1[2][1],sum_h[7],sum_f[33],carry_f[33]);
    full_adder f34 (layer1[3][0],sum_f[23],carry_h[7],sum_f[34],carry_f[34]);
    full_adder f35 (layer1[4][0],sum_f[24],carry_f[23],sum_f[35],carry_f[35]);
    full_adder f36 (sum_f[9],sum_f[25],carry_f[24],sum_f[36],carry_f[36]);
    full_adder f37 (sum_f[11],sum_f[26],carry_f[25],sum_f[37],carry_f[37]);
    full_adder f38 (sum_f[13],sum_f[27],carry_f[26],sum_f[38],carry_f[38]);
    full_adder f39 (sum_f[15],sum_f[28],carry_f[27],sum_f[39],carry_f[39]);
    full_adder f40 (sum_f[17],sum_f[29],carry_f[28],sum_f[40],carry_f[40]);
    full_adder f41 (sum_f[19],sum_f[30],carry_f[29],sum_f[41],carry_f[41]);
    full_adder f42 (sum_f[21],sum_f[31],carry_f[30],sum_f[42],carry_f[42]);
	full_adder f43 (layer1[12][0],sum_f[32],carry_f[31],sum_f[43],carry_f[43]);
    full_adder f44 (layer1[13][0],sum_h[8],carry_f[32],sum_f[44],carry_f[44]);
    full_adder f45 (layer1[14][0],layer1[14][8],carry_h[8],sum_f[45],carry_f[45]);

    assign si1= {C[15],sum_f[45],sum_f[44],sum_f[43],sum_f[42],sum_f[41],sum_f[40],sum_f[39],sum_f[38],sum_f[37],sum_f[36],sum_f[35],sum_f[34],sum_f[33], C[1] , C[0]};
    assign si2= {carry_f[45],carry_f[44],carry_f[43],carry_f[42],carry_f[41],carry_f[40],carry_f[39],carry_f[38],carry_f[37],carry_f[36],carry_f[35],carry_f[34],carry_f[33],carry_h[9],sum_h[9],layer1[0][1]} ;
	 
	 assign bk_in1 = {16'b0,si1};
	 assign bk_in2 = {16'b0,si2};
	 
	 brent_kung bk (bk_in1,bk_in2,1'b0,bk_cout,bk_sum);
	 assign mult = bk_sum[15:0];
	 assign cout = bk_sum[16];

endmodule

module brent_kung (
    input [31 : 0] a,b,
    input cin,
    output cout,
    output [31 : 0] sum
);
    wire [31:0] G_0,P_0;
    wire [15:0] G_1,P_1;
    wire [7:0] G_2,P_2;
    wire [3:0] G_3,P_3;
    wire [1:0] G_4,P_4;
    wire G_5,P_5;
    wire [5:0] temp;
    wire [31:0] carry; 

    //assigning first carry for different stages

    assign carry[0] = cin;
    assign carry[1] = G_0[0];
    assign carry[2] = G_1[0];
    assign carry[4] = G_2[0];
    assign carry[8] = G_3[0];
    assign carry[16] = G_4[0];
    assign cout = G_5;

    genvar i;
    generate
        for(i=1;i<32;i=i+1) begin: B1
          xor_block P1 (a[i],b[i],P_0[i]);
          and_block P2 (a[i],b[i],G_0[i]);
        end
    endgenerate
    xor_block PR1(a[0],b[0],P_0[0]);
    and_block PR2 (a[0],b[0],temp[0]);
    gen PR3 (temp[0],P_0[0],cin, G_0[0]);



//second stage



    generate
        for(i=1;i<16;i=i+1) begin: B2 
          gen P3 (G_0[2*i+1], P_0[2*i+1], G_0[2*i], G_1[i]);
          and_block P4 (P_0[2*i+1], P_0[2*i], P_1[i]);
        end
    endgenerate
    gen PR4 (G_0[1], P_0[1], G_0[0], temp[1]);
    and_block PR5 (P_0[1], P_0[0], P_1[0]);
    gen PR6 (temp[1], P_1[0], cin, G_1[0]);
    

//third stage

    generate
            for(i=1;i<8;i=i+1) begin: B3
            gen P5 (G_1[2*i+1], P_1[2*i+1], G_1[2*i], G_2[i]);
            and_block P6 (P_1[2*i+1], P_1[2*i], P_2[i]);
            end
    endgenerate
    gen PR7 (G_1[1], P_1[1], G_1[0], temp[2]);
    and_block PR8 (P_1[1], P_1[0], P_2[0]);
    gen PR9 (temp[2], P_2[0], cin, G_2[0]);

//Fourth stage

    generate
            for(i=1;i<4;i=i+1) begin: B4
            gen P7 (G_2[2*i+1], P_2[2*i+1], G_2[2*i], G_3[i]);
            and_block P8 (P_2[2*i+1], P_2[2*i], P_3[i]);
            end
    endgenerate
    gen PR10 (G_2[1], P_2[1], G_2[0], temp[3]);
    and_block PR11 (P_2[1], P_2[0], P_3[0]);
    gen PR12 (temp[3], P_3[0], cin, G_3[0]);

//Fifth stage

    gen PR13 (G_3[1], P_3[1], G_3[0], temp[4]);
    and_block PR14 (P_3[1], P_3[0], P_4[0]);
    gen PR15 (temp[4], P_4[0], cin, G_4[0]);

    gen P9 (G_3[3], P_3[3], G_3[2], G_4[1]);
    and_block P10 (P_3[3], P_3[2], P_4[1]);

//Final stage

    gen P11 (G_4[1], P_4[1], G_4[0], temp[5]);
    and_block P12 (P_4[1], P_4[0], P_5);
    gen P13 (temp[5], P_5, cin, G_5);

//Codd
generate
            for(i=1;i<16;i=i+1) begin: B5
            gen P14 (G_0[2*i], P_0[2*i], carry[2*i], carry[2*i+1]);
            end
endgenerate

//C6,10,14,18,22,26,30
generate
            for(i=1;i<8;i=i+1) begin: B6
            gen P15 (G_1[2*i], P_1[2*i], carry[4*i], carry[4*i+2]);
            end
endgenerate

//C12,20,28
generate
            for(i=1;i<4;i=i+1) begin: B7
            gen P16 (G_2[2*i], P_2[2*i], carry[8*i], carry[(8*i)+4]);
            end
endgenerate


//C24
gen P17 (G_3[2], P_3[2], carry[16], carry[24]);

//sum
generate
            for(i=0;i<32;i=i+1) begin: B8
            xor_block S (P_0[i], carry[i], sum[i]);
            end
endgenerate		
endmodule


module gen(
    input a,b,c,
    output z

);
     assign #10 z = (a | ( b & c));

endmodule

module and_block(
    input a,b,
    output o

);
     assign #10 o =  ( b & a );

endmodule

module xor_block(
    input a,b,
    output o

);
     assign #10 o =  ( b ^ a );

endmodule

module half_adder (input a, input b, output sum, output cout);
	xor_block xor0 (a,b,sum);
	and_block and0 (a,b,cout);

endmodule

module full_adder (input a, input b, input cin, output sum, output cout);
	wire sum0,cout0,cout1,cout2;
	
	xor_block xor1 (a,b,sum0);
	xor_block xor2 (sum0,cin,sum);
	
	and_block and1 (a,b,cout0);
	and_block and2 (a,cin,cout1);
	and_block and3 (cin,b,cout2);
	
	assign  cout = ( cout0 | cout1 | cout2 );
endmodule