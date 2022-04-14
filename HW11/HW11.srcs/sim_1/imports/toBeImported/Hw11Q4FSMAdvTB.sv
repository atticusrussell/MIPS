`timescale 1 ns/10 ps // time-unit = 1 ns, precision = 10 ps

module Hw11Q4FSMAdvTB();
	reg [ 1:0 ] w;
	wire z, InIdle;
	// ADD: clk and rst, both assigned in always block
	reg clk, rst;

	
	// ADD: integer for state_cnt and clk-period constant ( 10 ns )
	integer state_cnt; 
	parameter clk_period = 10;

	
	
	
	// ADD: Instantiate Hw11Q4FSM
	Hw11Q4FSM d0 ( .clk(clk),
					.rst(rst),
					.w(w),
					.z(z),
					.InIdle(InIdle)
		);
	
	
	// ADD: intial block to intialize clk and state_cnt
	initial begin
		//initialize clock and state_cnt
		clk = 1'b0;
		state_cnt = 0;
	end
	
	
	always #( clk_period/2 ) clk = ~clk;
	
	//stimuli 
	initial begin 
		rst = 1'b1;
		#clk_period;
		rst = 1'b0;
		@( negedge clk );
		
		while ( state_cnt < 4 ) begin 
			w = $random % 3;
			if ( ( w == 2'b00 ) | ( w == 2'b11 ) ) begin 
				if ( state_cnt != 4 ) state_cnt = state_cnt + 1;
				end else begin 
					state_cnt = 0;
				end 
				
				// ADD: wait for falling edge of clock
				@(negedge clk);
				
				if ( (( state_cnt == 0 ) && ( InIdle != 1'b1 )) | (( state_cnt != 0 ) && 
					( InIdle == 1'b1)) )
					$display ( "InIdle = %b when state_cnt = %d", InIdle, state_cnt );

					// ADD: report if z=0 and state_cnt = 4 or if z = 1 and state_cnt != 4
				if ( (( state_cnt == 4 ) && ( z != 1'b1 )) | (( state_cnt != 4 ) && 
					( z == 1'b1)) )
					$display ( "z = %b when state_cnt = %d", z, state_cnt );
					
					
					
				// slight delay so next change to state_cnt at different time when loop happens
				#( clk_period/4 );
		end 
	end 
endmodule