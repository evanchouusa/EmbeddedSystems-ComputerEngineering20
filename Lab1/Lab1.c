/*
 * Evan Chou
 * Lab 1 
 * Wednesday, October 6, 2020
 */

#include <stdio.h>
#include <string.h>
#include <math.h>

int32_t     Bits2Signed(int8_t bits[8]); //Convert array of bits to signed int			
uint32_t    Bits2Unsigned(int8_t bits[8]); //Convert array of bits to unsigned int
void        Increment(int8_t bits[8]); //Add 1 to value represented by bit pattern
void        Unsigned2Bits(uint32_t n, int8_t bits[8]); //Opposite of Bits2Unsigned

int32_t Bits2Signed(int8_t bits[8]) 
{
    int32_t n=Bits2Unsigned(bits); //set n value from binary to unsigned integer
   
   	if(n>127) 
	{						
		n-=256;
	}
	return n; //return value n				
}

uint32_t Bits2Unsigned(int8_t bits[8]) 
{
	int i; //declare variable
    uint32_t n=0; //set n value to 0 initially		

    for(i=7; i>=0; i--) 
	{				
        n=2*n+bits[i]; //given polynomial equation
    }
    return n; //return value n						   
}

void Increment(int8_t bits[8]) 
{
    int i; //declare variable

    for(i=0; i<8; i++) 
	{						
        if(bits[i]==0) //if bit is 0, then change to 1 
		{						
            bits[i]=1;
            break;				
        }
        if(bits[i]==1) //if bit is 1, then change to 0
		{			
            bits[i]=0;
        }
    }
	return;						
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]) 
{
	//declare variables
    int i=0;
    int j;

    while(i<8) //repeated division for binary 
	{			
        j=n%2;						
        n=n/2;						
        bits[i]=j;					
        i++;			
    }
    return;			
}
