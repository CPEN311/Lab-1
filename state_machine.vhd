--------------------------------------------------------
--
--  This is the skeleton file for Lab 1 Phase 3.  You should
--  start with this file when you describe your state machine.  
--  
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------------
--
--  This is the entity part of the top level file for Phase 3.
--  The entity part declares the inputs and outputs of the
--  module as well as their types.  For now, a signal of
--  â€œstd_logicâ€ type can take on the value â€˜0â€™ or â€˜1â€™ (it
--  can actually do more than this).  A signal of type
--  std_logic_vector can be thought of as an array of 
--  std_logic, and is used to describe a bus (a parallel 
--  collection of wires).
--
--  Note: you don't have to change the entity part.
--  
----------------------------------------------------------

entity state_machine is
   port (clk : in std_logic;  -- clock input to state machine
         resetb : in std_logic;  -- active-low reset input
         dir : in std_logic;     -- dir input
         hex0 : out std_logic_vector(6 downto 0)  -- output of state machine
            -- Note that in the above, hex0 is a 7-bit wide bus
            -- indexed using indices 6, 5, 4 ... down to 0.  The
            -- most-significant bit is hex(6) and the least significant
            -- bit is hex(0)
   );
end state_machine;

----------------------------------------------------------------
--
-- The following is the architecture part of the state machine.  It 
-- describes the behaviour of the state machine using synthesizable
-- VHDL.  
--
----------------------------------------------------------------- 

architecture behavioural of state_machine is
  signal next_state, current_state: std_logic_vector(6 downto 0);
  constant J : std_logic_vector(6 downto 0) := "1110001";
  constant O : std_logic_vector(6 downto 0) := "1000000";
  constant S : std_logic_vector(6 downto 0) := "0010010"; 
  constant H : std_logic_vector(6 downto 0) := "0001001"; 
  constant U : std_logic_vector(6 downto 0) := "1000001";
  constant A : std_logic_vector(6 downto 0) := "0001000";
  

begin
	
	-- next state process
	process(all)
	  begin
	    case current_state is
	      when J => if (dir = '0') then
	                          next_state <= O;
	                        else
	                          next_state <= A;
	                        end if;
	      when O => if (dir = '0') then
	                          next_state <= S;
	                        else
	                          next_state <= J;
	                        end if;	                        
	      when S => if (dir = '0') then
	                          next_state <= H;
	                        else
	                          next_state <= O;
	                        end if;	 	     
	      when H => if (dir = '0') then
	                          next_state <= U;
	                        else
	                          next_state <= S;
	                        end if;	 	   
	      when U => if (dir = '0') then
	                          next_state <= A;
	                        else
	                          next_state <= H;
	                        end if;	 	  
	      when A => if (dir = '0') then
	                          next_state <= J;
	                        else
	                          next_state <= U;
	                        end if;	 	  	                          
	      when others => next_state <= J;
	    end case;
	    
	    if(resetb = '0') then
	       next_state <= j;
	    end if;
	    
	end process;
	
	-- update led process
	process(all)
	  begin
	  hex0 <= current_state;
	end process;
	
	process(clk)
	  begin
	    if rising_edge(clk) then
	      current_state <= next_state;
	    end if;
	end process;



end behavioural;
