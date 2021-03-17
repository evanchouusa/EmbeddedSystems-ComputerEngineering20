/*
Evan Chou
Lab 4
Wednesday, October 28, 2020
*/

 		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Discriminant
		.thumb_func

//Discriminant(a,b,c) = b^2 - 4ac
Discriminant:
		MUL R1,R1,R1 //we multiply b by b and store the result in R1
		LSL R0,R0,2	//we multiply a, originally stored in R0, by 4, and then store the new value into R0
		MLS R0,R0,R2,R1	//MLS gives us the equation R1 - R0*R2, and then we store this value into R0
		BX LR //return
		
		.global		Root1
		.thumb_func
//Root1(a,b,c) = -b+SquareRoot(Discriminant(a,b,c))/2a
//Note: this is the positive root
Root1:							
		PUSH {R4,R5,LR} //push these registers to preserve original value
		NEG R5,R1 //store and preserve -b in R1	
		LSL R4,R0,1 //logical shift value
		BL Discriminant	//call Discriminant function
		BL SquareRoot //call SquareRoot function
		ADD R0,R5,R0 //we add the -b which was stored in R5 to the SquareRoot(Discriminant(a,b,c)) stored in R0 and store the new value into R0
		SDIV R0,R0,R4 //divide the R0 value we just got by 2a
		POP {R4,R5,PC} //pop back original values and return
		
		.global		Root2
		.thumb_func
//Root2(a,b,c) = -b-SquareRoote(Discriminant(a,b,c))/2a
//Note: this is the negative root
Root2:						
		PUSH {R4,R5,LR} //push these registers to preserve original value
		NEG R5,R1 //store and preserve -b in R1
		LSL R4,R0,1 //logical shift value
		BL Discriminant //call Discriminant function
		BL SquareRoot //call SquareRoot function
		SUB R0,R5,R0 //we subtract -b which was stored in R5 by SquareRoot(Discriminant(a,b,c)) stored in R0 and store the new value into R0
		SDIV R0,R0,R4 //divide the R0 value we just got by 2a
		POP {R4,R5,PC} //pop back original values and return
		
		.global 	Quadratic
		.thumb_func	
//Quadratic(x,a,b,c) = ax^2 + bx + c
Quadratic:					
		PUSH {R4} //push R4 to preserve original value
		MOV R4,R0 //move R4 into R0, so both have value of x
		MUL R0,R4,R4 //multiply x in R4 by x in R0 and store that value into R0
		MLA R0,R1,R0,R3	 //multiply the value we just got in R0 by a, which is stored in R1, and then add the value stored in R3, which is c. Store this value into R0
		MLA R0,R4,R2,R0	//multiply b, which is stored in R2, by x, which is stored in R4, and then add that to the value we just got in R0. Store this value into R0
		POP {R4} //pop back original value
		BX LR //return

		.end
