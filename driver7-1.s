// ---------------------------------------------------------------------
// Aspen Cristobal
// CS3b - lab7-1
// 3/14/2026
// ---------------------------------------------------------------------
// 	PURPOSE:
// LOREM
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// LOREM
// ---------------------------------------------------------------------
.global _start	// Provide program starting address 

// functions
.extern getstring

_start:
	// CONSTANTS FOR SYSTEM FILE 
	.EQU STDIN, 		0		// input
	.EQU STDOUT, 		1		// output
	.EQU STDERR,		2		// error output
	.EQU AT_FDCWD,		-100	// file in current directory

	// CONSTANTS FOR SYSTEM COMMANDS
	.EQU SYS_openat, 	56		// 
	.EQU SYS_close,		57		//
	.EQU SYS_read,		63		//
	.EQU SYS_write,		64		//
	.EQU SYS_exit,  	93		// exit() supervisor call code

	// CONSTANTS FOR FILE DESCRIPTORS
	.EQU _O_RDONLY,		0		//
	.EQU A_C_RW,		02102	//
	.EQU T_RW,			01002	//

	// CONSTANTS FOR FILE MODE
	.EQU R__R__R__,		440		//
	.EQU RW_RW_RW_,		660		// 

	// GENERAL CONSTANTS FOR PROGRAM
	.EQU EM_LEN,		39		// error message length
	.EQU PM_LEN,		29		// output prompt message length
	.EQU IN_LEN,		64		// input file name length
	.EQU B_LEN,			16		// buffer (read file) length 

	// -----------------------------------------------------------------
	// GET USER INPUT - INPUT (szBuff, sPMess)
	//	szBuff	- buffer where input will be saved at
	//	sPMess	- prompt message
	// -----------------------------------------------------------------
	.MACRO 	INPUT szBuff, sPMess
			LDR X0, =\szBuff	// buffer to save fileName to
			MOV	X1, IN_LEN		// length of file name
			LDR X2,	=\sPMess		// prompt message
			MOV X3, PM_LEN		// prompt message length 
			BL  getstring		// call function getstring

			// IF INPUT NOT VALID TERMINATE
			CMP  X0, XZR		// if X0 < 0, termiate program
			B.LT end
	.ENDM

	// -----------------------------------------------------------------
	// READ FILE:
	// -----------------------------------------------------------------
	// .MACRO

	// .ENDM

	// -----------------------------------------------------------------
	// READ FILE
	// -----------------------------------------------------------------
	// .MACRO

	// .ENDM
    
	.text  // code section
	
	// -----------------------------------------------------------------
	// GET FIRST INPUT FILE NAME
	//	MACRO: INPUT (szBuff, sPMess)
	// -----------------------------------------------------------------
	INPUT szFileName1, sMFirst

	// -----------------------------------------------------------------
	// GET SECOND INPUT FILE NAME
	//	MACRO: INPUT (szBuff, sPMess)
	// -----------------------------------------------------------------
	INPUT szFileName2, sMSec

	// -----------------------------------------------------------------
	// GET OUTPUT FILE NAME
	//	MACRO: INPUT (szBuff, sPMess)
	// -----------------------------------------------------------------
	INPUT szFileOut, sMOut

	// -----------------------------------------------------------------
	// GET IF WE APPEND OR NOT
	//	MACRO: INPUT (szBuff, sPMess)
	// -----------------------------------------------------------------
	INPUT szApp, sMApp

	// -----------------------------------------------------------------
	// PROCESS INPUT TO SEE IF WE APPEND OR NOT
	//	X0: number of characters we read
	//	X1: azApp, string of intput we got to see if we append
	//	X2: counter, keeps track of what index we are on
	//	X3: file permissions
	//	X4: current character
	// -----------------------------------------------------------------
	// INITALIZE
	LDR X1, =azApp		// append string input
	MOV X2, #0 			// counter = 0
	MOV X3, T___RW 		// file permission, default no / truncate

	// CHECK IF USER INPUT Y
whileProApp:	// while (counter < length && W4 != Y)
	CMP  X2, X0			// counter >= stringLength, exit
	B.GE noApp

	STRB W4, [X1, X2]	// W4 = X1[X2], currentChar = string[counter]
	CMP  W4, #'Y'		// W4 == 'Y'
	B.EQ yesApp

	ADD X2, X2, #1		// counter++
	B whileProApp

	// USER ENTER Y - APPEND
yesApp:
	MOV X3, A_C_RW 		// set file permission to yes / append

	// EXIT PROGRAM - USER DID NOT ENTER Y - NO APPEND
noApp:
	// -----------------------------------------------------------------
	// TERMINATE PROGRAM
	// -----------------------------------------------------------------
end: 
	MOV X0, #0			// set return code to 0, all good 
	MOV X8, #SYS_exit	// set exit() supervisor call code 
	SVC 0				// call Linux to exit 

	.data	// data section
// PROMPT MESSAGES
sMFirst:	.ascii "Enter first input file name :"
sMSec: 		.ascii "Enter second input file name:"
sMOut: 		.ascii "Enter output file name      :"
sMApp: 		.ascii "Append to the output? [Y/N] :"

// ERROR MESSAGES
sEIN:		.ascii "Fatal error: failed to open input file"
sEOut:		.ascii "Fatal error: failed to open output file"

// BUFFERS
szFileName1: 	.skip	IN_LEN
szFileName2: 	.skip	IN_LEN
szFileOut: 		.skip	IN_LEN
szApp: 			.skip	IN_LEN
szBuffer:	 	.skip	B_LEN

.end	// end of program, optional but good practice 
