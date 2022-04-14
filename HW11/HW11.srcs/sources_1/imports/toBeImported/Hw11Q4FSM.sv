module Hw11Q4FSM ( clk, rst, w, z, InIdle );
	//ADDED:  inputs for rst and w 
	input clk, rst;
	input [1:0] w;

	//reg because z and InIdle assigned in always block
	//ADDED: output for InIdle
	output reg z, InIdle;
	
	
	//State encodings, one hot
	
	parameter [ 4:0 ]
		idle =  5'b00001,
	//ADDED: Create parameters for s1, s2 and s3
		s1 	= 	5'b00010,
		s2 	= 	5'b00100,
		s3 	= 	5'b01000,
		s4 	= 	5'b10000;
	reg [ 4:0 ] state, next_state;
	
	//state clocked block
	//ADDED: Always block to assign state

	always @( posedge clk ) begin 
		if ( rst ) begin 
			state <= idle;
		end else begin 
			state <= next_state;
		end 
	end

	always @( w, state ) begin 
		case ( state ) 
				idle : 
					if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
						next_state = s1;
					end else begin 
						next_state = idle;
					end 
					//ADDED: conditions for s1, s2, s3 & s4
				s1 : 
					if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
						next_state = s2;
					end else begin 
						next_state = idle;
					end 
				s2 : 
					if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
						next_state = s3;
					end else begin 
						next_state = idle;
					end 
				s3 : 
					if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
						next_state = s4;
					end else begin 
						next_state = idle;
					end 
				s4 : 
					if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
						next_state = s4;
					end else begin 
						next_state = idle;
					end 
	
					default :
						next_state = idle;
				endcase
			end
		
		//InIdle clocked block
		always @( posedge clk ) begin 
			case ( next_state ) 
				idle	: InIdle <= 1'b1;
				default	: InIdle <= 1'b0;
			endcase
		end
		
		//z clocked block
		//ADD: always block to assign z
		always @( posedge clk ) begin 
			case ( state ) 
				s4	: z <= 1'b1;
				default	: z <= 1'b0;
			endcase
		end
endmodule