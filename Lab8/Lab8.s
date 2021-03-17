/*
Evan Chou
Lab 8b
November 30, 2020
*/

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global Root1
		.thumb_func

//float Root1(float a, float b, float c)
Root1:
        //assume that S0=a,S1=b,S2=c
        PUSH {R4,R5,LR} //push registers
		VMOV R4,S0 //move a in S0 into R4 to preserve value
		VMOV R5,S1 //move b in S1 into R5 to preserve value
		BL Discriminant //Now we can call the Discriminant function without worrying about losing original values
		VSQRT.F32 S3,S0	//store squareroot of discriminant in S3
		VMOV S0,R4 //move back value: S0=a
		VMOV S1,R5 //move back value: S1=b
		VNEG.F32 S1,S1 //change sign of b to negative, so S1=-b
		VADD.F32 S3,S1,S3 //S3=-b+squareroot of discriminant
		VMOV S1,2.0 //move 2.0 to S1 to multiply by a and to divide later
		VMUL.F32 S0,S0,S1 //multiple a times 2 and store into S0
		VDIV.F32 S0,S3,S0 //divide -squareroot of discriminant by 2a
		POP {R4,R5,PC} //pop back
		
		.global Root2
		.thumb_func

//float Root2(float x, float a, float b, float c)
Root2:
        //assume that S0=a,S1=b,S2=c
		PUSH {R4,R5,LR} //push registers
		VMOV R4,S0 //move a in S0 into R4 to preserve value
		VMOV R5,S1 //move b in S1 into R5 to preserve value
		BL Discriminant //Now we can call the Discriminant function without worrying about losing original values
		VSQRT.F32 S3,S0 //store squareroot of discriminant in S3
		VMOV S0,R4 //move back value: S0=a
		VMOV S1,R5 //move back value: S1=b
		VNEG.F32 S1,S1 //change sign of b to negative, so S1=-b
		VSUB.F32 S3,S1,S3 //S3=-b-squareroot of discriminant
		VMOV S1,2.0 //move 2.0 to S1 to multiply by a and to divide later
        VMUL.F32 S0,S0,S1 //multiple a times 2 and store into S0
		VDIV.F32 S0,S3,S0 //divide -squareroot of discriminant by 2a
        POP {R4,R5,PC} //pop back

        .global Quadratic
        .thumb_func

//float Quadratic(float x, float a, float b, float c)
Quadratic:
        //assume that S0=x,S1=a,S2=b,S3=c
        VMLA.F32 S3,S0,S2 //multiply S0 and S2 and then add to S3 and finally store into S3, so S3=S3+S0*S2 --> c+bx
        VMUL.F32 S0,S0,S0 //multiple x and x, so S0=x^2
        VMUL.F32 S1,S1,S0 //multiple a times x^2, so S1=S1*S0 --> a*x^2
        VADD.F32 S0,S3,S1 //add values stored in S1 with S3, so S0=(c+bx)+(a*x^2)
        BX LR //return

        .global Discriminant
        .thumb_func

//float Discriminant(float a, float b, float c)
Discriminant:
        //assume that S0=a,S1=b,S2=c
        VMUL.F32 S1,S1,S1 //multiple b and b, so S1=b^2
        VMOV S3,4.0 //move 4.0 to S3 to multiply by a and c to subtract later
        VMUL.F32 S0,S0,S3 //multiply 4 and a and store in S0, so S0=4a
        VMLS.F32 S1,S0,S2 //multiply S0 and S2 and then subtract from S1 and finally store in S1, so S1=b^2-4ac
        VMOV S0,S1 //move the equation we just got from S1 to S0 to use for other functions
        BX LR //return

.end
