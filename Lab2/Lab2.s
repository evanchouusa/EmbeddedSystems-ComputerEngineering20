/*
Evan Chou
Lab 2
Wednesday, October 14, 2020
*/

		.syntax		unified
		.cpu		cortex-m4
		.text

		//int32_t Add(int32_t a, int32_t b)		
		.global		Add
		.thumb_func

Add:	
		//Add a and b and then return
		ADD 	R0,R0,R1
		BX		LR

		//int32_t Less1(int32_t a)
		.global		Less1
		.thumb_func
		
Less1:
		//Subtract 1 from a and then return
		SUB		R0,1
		BX 		LR
		
		//int32_t Square2x(int32_t x)
		.global 	Square2x
		.thumb_func
		
Square2x:

		PUSH {LR} //Adding LR to top of stack
		ADD R0,R0,R0 //Adding x+x or multiply R0 by two
		BL Square //call Square function
		POP {PC} //return
		
		//int32_t Last(int32_t x)
		.global 	Last
		.thumb_func
		
Last:

		PUSH {R4,LR} //Adding R4 and LR to top of stack 
		MOV R4,R0 //copy data from R0 to R4 in order to preserve value
		BL SquareRoot //call SquareRoot function
		ADD R0,R0,R4 //Adding R0 and R4, or R0 <-- R0+R4
		POP {R4,PC} //POP R4 back and return 
	
		.end
