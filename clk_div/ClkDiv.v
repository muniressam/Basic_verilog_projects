
module ClkDiv #(parameter ratio_width = 8)(
 input  wire                   i_ref_clk,             
 input  wire                   i_rst,                 
 input  wire                   i_clk_en,               
 input  wire [ratio_width-1: 0]i_div_ratio, 
 
 output reg                    o_div_clk               
);

wire [ratio_width-2 :0] edge_flip_half ;  
wire [ratio_width-2 :0] edge_flip_full ; 
reg  [ratio_width-2 :0]count ;                                                                       
reg                    div_clk ;
reg                    odd_edge_tog ;               
wire                   is_one ;
wire                   is_zero;
wire                   clk_en;
wire                   is_odd;

always @(posedge i_ref_clk or negedge i_rst)               
 begin 
  if(!i_rst)
   begin
    count <= 0 ;
	div_clk <= 0 ;	
    odd_edge_tog <= 1 ;
   end
    else if(clk_en) 
     begin
      if(!is_odd && (count == edge_flip_half))              
       begin
        count <= 0 ;                                        
        div_clk <= ~div_clk ;                               		
       end
      else if((is_odd && (count == edge_flip_half) && odd_edge_tog ) || (is_odd && (count == edge_flip_full) && !odd_edge_tog ))  // odd edge flip condition
       begin  
        count <= 0 ;                                        
        div_clk <= ~div_clk ;		                        
        odd_edge_tog <= ~odd_edge_tog ;                      
       end
    else
     count <= count + 1'b1 ;
   end
 end

always @(posedge i_ref_clk or negedge i_rst)                
 begin 
  if(!i_rst)
   begin
    o_div_clk <= 0 ;
   end
  else
   begin
    o_div_clk = clk_en ? div_clk : i_ref_clk ;              
   end   
 end

assign is_odd = i_div_ratio[0] ;
assign edge_flip_half = ((i_div_ratio >> 1) - 1 ) ;
assign edge_flip_full = (i_div_ratio >> 1) ;

assign is_zero = ~|i_div_ratio ;                               
assign is_one  = (i_div_ratio == 1'b1) ;                       
assign clk_en = i_clk_en & !is_one & !is_zero;                 


endmodule