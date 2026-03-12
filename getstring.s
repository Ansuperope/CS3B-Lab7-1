// ---------------------------------------------------------------------
// getstring.s - reminder remove the for loop 
// ---------------------------------------------------------------------
// 	PURPOSE:
// Will read a string of characters up to a specified length from the 
// console and save it in a specified buffer as a C-String (i.e. null
// terminated).
// ---------------------------------------------------------------------
//	VARAIBLES:
// X0: buffer to save file name 
// X1: length of file name
// X2: prompt message
// X3: prompt message length 
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// 1. Get variables from main and save them
// 2. Get input from user
// 3. Process input
//	a. make sure input isnt over max length
//	b. make last letter \0
//  c. replace null with \0
// 4. Output input
// 5. Return to main
// ---------------------------------------------------------------------
.global getstring	// Provide program starting address 

getstring: 
	.EQU STDIN,		0	// starndard input
	.EQU STDOUT,	1	// standard output
	.EQU SYS_read,	63	// Linux read()
	.EQU SYS_write, 64	// Linux write()
	.EQU SYS_exit,  93	// exit() supervisor call code 

	.text  // code section
	// -----------------------------------------------------------------
	// SAVE VARIABLES FROM MAIN
	//  X0 -> X4: buffer to save file name 
    //  X1 -> X5: length of file name
    //  X2 -> X6: prompt message
    //  X3      : prompt message length 
	// -----------------------------------------------------------------
    MOV X4, X0          // X4 = X0, variable to store string
	MOV X5, X1			// X5 = X1, MAX_LENGTH
	MOV X6, X2			// X6 = X2, prompt message

    // -----------------------------------------------------------------
	// OUTPUT - PROMPT USER MESSAGE
    //  X6: prompt message
    //  X3: prompt message length
	// -----------------------------------------------------------------
	MOV X0, STDOUT		// tells program we will output
	MOV X1, X6			// string to output
	MOV X2, X3			// number of characters to output
	MOV X8, SYS_write	// Linux write() sys call
	SVC 0				// call Linux to execute commands

	// -----------------------------------------------------------------
	// GET USER INPUT - INPUT FILE NAME
    //  X4: buffer to save file name 
    //  X5: length of file name
	// -----------------------------------------------------------------
	MOV X0, STDIN  		// file descriptor for stdin (keyboard) 
	MOV X1, X4			// read() needs buffer pointer in X1 
	MOV X2, X5		 	// max amount of characters to read
	MOV X8, SYS_read 	// Linux read() system call number 
	SVC 0				// call Linux to execute commands

    // terminate program
done:
	RET     // return to main

.end	// end of program, optional but good practice 