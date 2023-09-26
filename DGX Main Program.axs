PROGRAM_NAME='DGX Main Program'

#include 'amx-dgx-control'
#include 'amx-dxlink-control'
#include 'debug'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
// Master Controller
dvCONSOLE = 1:1:0

//DxLink DVX in/out ports
//dvDvxDxLinkIn1 = 5002:1:0
//dvDvxDxLinkIn2 = 5002:2:0
//dvDvxDxLinkOut1 = 5002:3:0
//dvDvxDxLinkOut2 = 5002:4:0

//DxLink TX Boxes
dvDxLinkTx1 = 20001:1:0
dvDxLinkTx2 = 20002:1:0
dvDxLinkTx3 = 20003:1:0
dvDxLinkTx4 = 20004:1:0
dvDxLinkTx5 = 20005:1:0
dvDxLinkTx6 = 20006:1:0
dvDxLinkTx7 = 20007:1:0
dvDxLinkTx8 = 20008:1:0

//DxLink RX Boxes
dvDxLinkRx1 = 20501:1:0
dvDxLinkRx2 = 20502:1:0
dvDxLinkRx3 = 20503:1:0
dvDxLinkRx4 = 20504:1:0
dvDxLinkRx5 = 20505:1:0
dvDxLinkRx6 = 20506:1:0
dvDxLinkRx7 = 20507:1:0
dvDxLinkRx8 = 20508:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Device Groups
//Group of all DxLink Tx Link boxes
DEV dvDxLinkTxMaster[] = { dvDxLinkTx1, dvDxLinkTx2, dvDxLinkTx3, dvDxLinkTx4, dvDxLinkTx5, dvDxLinkTx6, dvDxLinkTx7, dvDxLinkTx8 }

//Group of all DxLink Rx Link boxes
DEV dvDxLinkRxMaster[] = { dvDxLinkRx1, dvDxLinkRx2, dvDxLinkRx3, dvDxLinkRx4, dvDxLinkRx5, dvDxLinkRx6, dvDxLinkRx7, dvDxLinkRx8 }

//Group of all DxLink Link boxes
DEV dvDxLinkMaster[] = { dvDxLinkTxMaster, dvDxLinkRxMaster }

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*              Function DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_FUNCTION INTEGER fnGetIndex(INTEGER nArray[], INTEGER nValue){

   INTEGER x
   
    FOR (x=1; x<=LENGTH_ARRAY(nArray); x++) {
	IF (nArray[x] = nValue) RETURN x
    }

   RETURN 0

}

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//yay
print("'Starting LNC AMX DGX!'", false);

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_MODULE 


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//DxLink
DATA_EVENT[dvDxLinkTxMaster]
{
    online: {
	SEND_STRING dvCONSOLE, "'A DxLink TX Box Came online: ', devToString(Data.Device)"
    }
}

//DxLink
DATA_EVENT[dvDxLinkRxMaster]
{
    online: {
	SEND_STRING dvCONSOLE, "'A DxLink RX Box Came online: ', devToString(Data.Device)"
    }
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


