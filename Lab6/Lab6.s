/*
Evan Chou
Lab 6d
November 10, 2020
*/

	    .syntax     unified
   		.cpu        cortex-m4
    	.text       

    	.global     PutNibble
    	.thumb_func
    	.align

//Note that this function is PutNibble(void *nibbles, uint32_t which, uint32_t value). Specifically, this function stores individual nibbles.
PutNibble: 
		//Assuming R0 is *nibbles, R1 is which, R2 is value
        PUSH {R4} //push R4 to preserver value
        LSR R4,R1,1 //shift 'which' in R1 to right by 1 and put into R4. This allows us to select a byte in the nibbles array.
        LDRB R3,[R0,R4] //[R0,R4] is 8-bit byte containing one of two nibbles. We then load this into R3.
        AND R1,R1,1 //We are doing an AND here to select the specific 4-bit nibble, storing it in R1
        CMP R1,1 //We are comparing that nibble we just selected to 1 in order to determine whether it is even or odd
        ITE EQ //If true, not true --> Equal          
        BFIEQ R3,R2,4,4 //If equal, means R1 is odd, so using bit field clear to put value into R3 
        BFINE R3,R2,0,4 //If not equal, means R1 is even, so we do the same thing and put desired correct value into R3
        STRB R3,[R0,R4] //Now that we have what we want in R3, we can store the value we just got into R3
        POP {R4} //pop R4 back
        BX LR //return

    	.global     GetNibble
    	.thumb_func
    	.align

//Note that this function is GetNibble(void *nibbles, uint32_t which). Specifically, this function retrieves individual nibbles within the array.
GetNibble:
        LSR R2,R1,1 //shift 'which' in R1 to right by 1 and put into R2. This allows us to select a byte in the nibbles array. 
        LDRB R2,[R0,R2] //We want to load the value in the updated address we just got into R0 
        AND R1,R1,1 //We are doing an AND here to select the specific 4-bit nibble, storing it in R1
        CMP R1,1 //We are comparing that nibble we just selected to 1 in order to determine whether it is even or odd
        ITE EQ //If true, not true --> Equal        
        UBFXEQ R0,R2,4,4 //If equal, means R1 is odd, so using unsigned bit field extract to get the value from second half of nibble and putting it into R0
        UBFXNE R0,R2,0,4 //If not equal, menas R1 is even, so using unsigned bit field extract to get the value of first half of nibble and putting it into R0
        BX LR //return

        .end
