/*
Evan Chou
Lab5d
November 3rd, 2020
*/
        
		.syntax     unified
        .cpu        cortex-m4
        .text

        .global     Hanoi
        .thumb_func
        .align

/*void Hanoi(int num, int fm, int to, int aux);
	{
	if(num>1) Hanoi(num-1, fm, aux, to);
	Move1Disk(fm,to);
	if(num>1) Hanoi(num-1, aux, to, fm);
	}
*/

Hanoi:  PUSH        {R4, R5, R6, R7, LR} //push out to preserve values
        MOV         R4, R0 //move num to R4 to preserve value
        MOV         R5, R1 //move fm to R5 to preserve value
        MOV         R6, R2 //move to to R6 to preserve value
        MOV         R7, R3 //move aux to R7 to preserve value
        CMP         R0, 1 //we are comparing num to 1
        BLE         Move //If num is less than or equal to 1, we go to move because we cannot move on with criteria >1.
Then:   SUB         R0, R0, 1 //this is if greater than 1, then we subtract 1 from num
        MOV         R2, R7 //We now move aux to R2 if num is greater than 1
        MOV         R3, R6 //We also move to to R3 if num is greater than 1
        BL          Hanoi //calling recursive function Hanoi
        
Move:   MOV         R0, R5 //This is if num is less than or equal to 1. We now move rm to R0 to call parameters for Move1Disk
        MOV         R1, R6 //We also move to to R1 for same previous reasons
        BL          Move1Disk //Now we can call Move1Disk with the right parameters
        MOV         R0, R4 //Mov num to R4 to preserve value
        CMP         R0, 1 //we are comparing num to 1
        BLE         Done //If num is less than or equal to 1, we are done
        SUB         R0, R0, 1 //If num is greater than 1, we can store num-1 to R0
        MOV         R1, R7 //We then move aux to R1 position
        MOV         R2, R6 //Move to to R2 position
        MOV         R3, R5 //Finally move fm to R3 position
        BL          Hanoi //calling recursive function Hanoi

Done:   POP         {R4, R5, R6, R7, PC} //Done with function, pop back values
       
        .end

