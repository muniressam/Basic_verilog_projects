
module ClkDiv_tb () ; 
 parameter ratio_width_tb = 8  ;
 reg         			   i_ref_clk_tb ;              
 reg         			   i_rst_tb  ;                 
 reg         			   i_clk_en_tb ;               
 reg  [ratio_width_tb-1:0] i_div_ratio_tb ;            
 wire        			   o_div_clk_tb  ;             

 always #5  i_ref_clk_tb = ~i_ref_clk_tb ; 
 
initial
 begin    
      $dumpfile("ClkDiv.vcd") ;
      $dumpvars;

      i_ref_clk_tb = 1'b0 ;
      i_rst_tb = 1'b1 ;
      i_clk_en_tb = 1'b1 ;
      i_div_ratio_tb = 'd7 ;
      #4
      i_rst_tb = 1'b0 ;
      #4
      i_rst_tb = 1'b1 ;
   
      #200
      $stop ;
      
 end 
             
ClkDiv #(.ratio_width(ratio_width_tb)) DUT 
(
.i_ref_clk(i_ref_clk_tb) ,             
.i_rst(i_rst_tb) ,                 
.i_clk_en(i_clk_en_tb) ,    
.i_div_ratio(i_div_ratio_tb),          
.o_div_clk(o_div_clk_tb)               
);
endmodule  
