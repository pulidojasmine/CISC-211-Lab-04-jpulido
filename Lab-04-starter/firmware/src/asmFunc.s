/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    

    /* setting everything other than "balance" to 0, every time asmFunc runs */
	
    /* copying r0 to transaction - r0 is where the input is located */
    LDR
    STR R0, [transaction]
    
    /* compare the transaction amount, is amount greater than 1000 */
    LDR R0, =transaction
    LDR R1, [R0]
    
    CMP R1, 1000
    BGT out_of_bounds
    
    CMP R1, -1000
    BLT out_of_bounds
    
    /* what happens when value is in bounds = calc tempBalance */
    LDR R0, =balance
    LDR R0, [R0]
    ADD R2, R0, R1
    
    CMP R2, R0
    BNE out_of_bounds
    
    /* copying what's in R2 into balance */
    STR R2, [balance]
    
    /* if balance is less than zero, branch to less_than_zero -> stay_in */
    CMP R2, 0
    BLT less_than_zero
    
    /* if balance is greater than zero, they eat out */
    LDR R0, =eat_out
    MOV R1, 1
    STR R1, [R0]
    
    /* this sets R0 = balance */
    LDR R0, =balance
    LDR R0, [R0]
    B done
    
    /* branch to if balance is zero */
    CMP R2, 0
    BEQ execute_ice_cream
    
    
    out_of_bounds:
    STR R0, [transaction]
    LDR R0, =we_have_a_problem
    MOV R1, 1
    STR R1, [R0]
    LDR R0, =balance
    LDR R1, [R0]
    
    /* creates a branch to "done" in order to complete the program */
    B done
    
    less_than_zero:
    /* if balance is less than zero, they stay in */
    LDR R0, =stay_in
    MOV R1, [R0]
    
    LDR R0, =balance
    LDR R0, [R0]
    B done
    
    
    execute_ice_cream:
    LDR R0, =eat_ice_cream
    MOV R1, 1
    STR R1, [R0]
    
    LDR R0, =balance
    LDR R0, [R0]
    B done
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




