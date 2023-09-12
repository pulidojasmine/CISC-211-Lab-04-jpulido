/*** asmFunc.s   ***/

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* initialize a global variable that C can access to print the nameStr */
.global deposit,withdrawal,balance,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type deposit,%gnu_unique_object
.type withdrawal,%gnu_unique_object
.type balance,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

deposit:           .word     0
withdrawal:        .word     0
balance:           .word     0
eat_out:           .word     0
stay_in:           .word     0
eat_ice_cream:     .word     0
we_have_a_problem: .word     0
/* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ( input1, input2 )
     
where:
     input1:  an integer value passed in from the C program
     input2:  an integer value passed in from the C program
     output: the integer value returned to the C function
     
     function description: The C call passes in the two values to be summed
                           in registers 0 and 1 (r0 and r1).
                           asmFunc adds the two integer values together
                           and places the result in r0.
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
    
    /* Lets study these lines in class. Can we predict the values of APSR
     * and the general purpose registers???    */
    subs r0,r0,r0  /* What will r0 be? How about the APSR? */
    movs r0,0b10110100 
    mov  r1,0
    movs r1,1
    rsbs r2,r1,0

     /* Start of Lab 3 Quiz Section */
    subs r0,r0,r0  /* STUDENTS! Set a breakpoint at this line! */
    subs r2,r2,r2
    adds r1, r0, 5
    rsbs r2,r1,0
    mov  r2, 0
    movs r2, 0
    movs r3, 0x80000000
    adds r4, r3, r3  
       
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




