/*
Evan Chou
Lab 7b
November 17, 2020
*/

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Bills
		.thumb_func
		.align

//void Bills(uint32_t dollars, BILLS *paper);
Bills:
		//This is for 20 dollar bills
		LDR R2,=214748365 //This is from (2^32)/20, constant since we are starting from 20 dollar bills, calculated to be 214748365 and store this in R2
		UMULL R2,R3,R0,R2 //Unsigned multiply where R3 is the quotient. We're multiplying two 32-bit numbers together. Note that we can also do SMMUL R2,R0,R2 and then store R2 into R1.
		STR R3,[R1] //Here we are storing R3 into the 20s
		LSL R12,R3,4 //Multiplying R3 by 16 and to store into R12
		ADD R2,R12,R3,LSL 2 //We can now multiple our original value R3 by 4 and add that to our R12 value to store into R2 to get the amount of 20s needed.
		SUB R2,R0,R2 //By subtracting here, we can find the remainder, which is the remainder for 10 dollar bills
 
TenFiveOne:
		//Ten Bills or Cents
		LDR R3,=429496730 //This is from (2^32)/10, constant with 10 dollar bills now, and store this into R3.
		UMULL R12,R3,R3,R2 //Unsigned multiply where R3 is the quotient
		STR R3,[R1,4] //Here we are storing R3 into the 10s
		LSL R12,R3,3 //Multiplying R3 by 8 and to store into R12
		ADD R12,R12,R3,LSL 1 //We are multiplying our R3 value by 2 and the adding it to the value we just stored into R12 to store into R12.
		SUB R2,R2,R12 //By substracting here, we can find the remainder, which is the remainder for 5 dollar bills
		
		//Five Bills or Cents
		LDR R3,=858993460 //This is from (2^32)/5, constant with 5 dollar bills now, and store this into R3
		UMULL R12,R3,R3,R2 //Unsigned multiply where R3 is the quotient
		STR R3,[R1,8] //Here we are storing R3 into the 5s
		ADD R12,R3,R3,LSL 2 //We are only adding R3+R12, multiplying R3 first by 4 and then adding it to R3
		SUB R2,R2,R12 //By subtracting here, we can find the remainder, which is the reaminder for 1 dollar bills
		STR R2,[R1,12] //Finally we can store R2 into R1 as remainder dollars for 1s
		BX LR //return

		.global 	Coins
		.thumb_func
		.align

//void Coins(uint32_t cents, COINS *coins);
Coins:
        //Quarters
		LDR R2,=171798692 //This is from (2^32)/25, with 25 cents being the largest value of cents
		UMULL R2,R3,R0,R2 //Unsigned multiply where R3 is the quotient
		STR R3,[R1] //Here we are storing R3 into the 25 cents
		ADD R3,R3,R3,LSL 2 //We are multiplying R3 by 4 and the adding it to R3 and storing this in R12
		ADD R2,R3,R3,LSL 2 //We are multiplying R3 by 4 and then adding that to R3's value we got previously and storing this into R2, giving us 25
		SUB R2,R0,R2 //Subtract to find remainders
		B TenFiveOne //calling TenFiveOne function
		
		.end

