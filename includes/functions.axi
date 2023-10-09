program_name='debug'

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Include: debug
// 
// Description:
//
//    - This include file provides useful fuctions for debugging a NetLinx program.
//
// Implementation:
//
//    - Any NetLinx program utilising the debug include file must use either the INCLUDE or #INCLUDE keywords to 
//      include the debug include file within the program. While the INCLUDE and #INCLUDE keywords are both 
//      functionally equivalent the #INCLUDE keyword is recommended only because it is the NetLinx keyword (the INCLUDE
//      keyword is from the earlier Axcess programming language and is included within the NetLinx programming language 
//      for backwards compatibility).
//
//      Note: The NetLinx language is not case-sensitive when it comes to keywords. The convention used in this project
//      is for keywords to be written in lower case (e.g., include instead of INCLUDE).
//
//      E.g:
//
//          define_program 'Debugging Demo'
//
//          #include 'functions'
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#if_not_defined __FUNCTIONS__
#define __FUNCTIONS__


DEFINE_FUNCTION INTEGER fnGetIndex(INTEGER nArray[], INTEGER nValue){

	INTEGER x
	
	 FOR (x=1; x<=LENGTH_ARRAY(nArray); x++) {
	 IF (nArray[x] = nValue) RETURN x
	 }
 
	RETURN 0
 
}