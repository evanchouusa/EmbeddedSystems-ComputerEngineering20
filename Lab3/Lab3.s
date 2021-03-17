/*
Evan Chou
Lab 2
Wednesday, October 14, 2020
*/

		.syntax		unified
		.cpu		cortex-m4
		.text

		
		.global		UseLDRB
		.thumb_func

//Function copies 1 byte at a time using LDRB and STRB and updates the address using the post-indexed addressing mode to optimize the execution time
UseLDRB: 
        .rept 512 //initialize 512 bytes of data
        LDRB R2,[R1],1 //We increment by 1 byte into the loaded register
        STRB R2,[R0],1 //Once again, we store the content into the value of R0 and increment the value by 1 byte
        .endr 

        BX LR //return


        .global     UseLDRH
        .thumb_func
//Function copies 2 bytes at a time using LDRH and STRH and updates the address using the post-indexed addressing mode to optimize the execution time
UseLDRH:
        .rept 256 //initialize 256 byes of data 
        LDRH R2,[R1],2 //We increment by 2 bytes into the loaded register
        STRH R2,[R0],2 //Once again, we store the content into the value of R0 and increment the value by 2 bytes
        .endr

        BX LR //return


        .global     UseLDR
        .thumb_func
//Function copies 4 bytes at a time using LDR and STR and updates the address using the post-indexed addressing mode to optimize the execution time
UseLDR:
        .rept 128 //initialize 128 bytes of data
        LDR R2,[R1],4 //We increment by 4 bytes into the loaded register
        STR R2,[R0],4 //Once again, we store the content into the value of R0 and increment the value by 4 bytes
        .endr

        BX LR //return


        .global     UseLDRD
        .thumb_func
//Function copies 8 bytes at a time using LDRD and STRD and updates the address using the post-indexed addressing mode to optimize the execution time
UseLDRD:
        .rept 64 //initialize 64 bytes of data
        LDRD R2,R3,[R1],8 //We increment by 8 bytes into the loaded register
        STRD R2,R3,[R0],8 //Once again, we store the content into the value of R0 and increment the value by 8 bytes
        .endr

        BX LR //return


        .global     UseLDM
        .thumb_func
//Function copies 32 bytes at a time using LDMIA and STMIA and updates the address using the write-back flag to optimize the execution time
UseLDM:
        PUSH {R4-R9} //We are going to use registers R4-R9 as placeholders because R1-R3 can be taken within the function
        .rept 16 //initialize 16 bytes of data
        LDMIA R1!,{R2-R9} //Load content in register 1 to R2-R9
        STMIA R0!,{R2-R9} //Store content of R2-R9, which held content of R1 into R0
        .endr

        POP {R4-R9} //Pop back original contents of R4-R9
		BX LR //return

        .end
