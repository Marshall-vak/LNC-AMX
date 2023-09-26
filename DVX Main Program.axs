PROGRAM_NAME='DVX Main Program'

#include 'amx-dvx-control'
#include 'amx-modero-control'
#include 'amx-dxlink-control'
#include 'debug'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

// Master Controller
dvCONSOLE = 0:1:0

//gpio connections
dvIO = 5001:17:0	// GPIO

//relays
dvRELAY = 5001:8:0      //Relays

// RS-232 Connections
dvCOM1 = 5001:1:0	// RS-232 port 1 
dvCOM2 = 5001:2:0	// RS-232 port 2
dvCOM3 = 5001:3:0	// RS-232 port 3 
dvCOM4 = 5001:4:0	// RS-232 port 4
dvCOM3 = 5001:5:0	// RS-232 port 5 
dvCOM4 = 5001:6:0	// RS-232 port 6

//internal switcher connection
dvDVXSW = 5002:1:0	// Switcher
dvSWV = 5002:1:8	// Switcher Video
dvSWA = 5002:1:10	// Switcher Audio

//Video outputs
dvHdmi1 = 5002:1:0	//HDMI Out 1 and DxLink Out 1
dvHdmi2 = 5002:2:0	//HDMI Out 2
dvHdmi3 = 5002:3:0	//HDMI Out 3 and DxLink Out 2
dvHdmi4 = 5002:4:0	//HDMI Out 4

//DxLink DVX in/out ports
dvDvxDxLinkIn1 = 5002:1:0	//DxLink Input 1
dvDvxDxLinkIn2 = 5002:2:0	//DxLink Input 2
dvDvxDxLinkOut1 = 5002:3:0	//DxLink Output 1
dvDvxDxLinkOut2 = 5002:4:0	//DxLink Output 2


//html5 webpannel
vdvSwitcher = 41001:1:0;	// Virtual Device

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Big Start Button on the Welcome Page
INTEGER WelcomePageStartButton[] = { 1 }

//All Welcome Page Buttons
INTEGER WelcomePageMaster[] = { WelcomePageStartButton }


//Output Select Buttons
INTEGER OutputButtons[] = { 11, 12, 13, 14, 15, 16 }

//Input Select Buttons
INTEGER InputButtons[] = { 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 }

//Mic Output Buttons
INTEGER MicOutputButtons[] = { 6, 7, 8, 9 }
//When a mic output button is pressed we can check if its in the inside table and if its not then its outside
//Think of a grid
INTEGER MicInsideButtons[] = { 6, 8 }
//The other sider of the grid
INTEGER MicOnebuttons[] = { 6, 7 }

//Button codes on the Main Page
INTEGER MainPageMaster[] = { OutputButtons, InputButtons, MicButtons }


//Projector Power buttons
INTEGER ProjectorPowerButtons[] = { 101, 102 }
//When a power button is pressed we can check if its in the on table and if its not then its off
//Again think of a grid
INTEGER ProjectorPowerOnbutton[] = { 101 }

//Projector Image Mute button
INTEGER ProjectorImageMuteButtons[] = { 103 }

//all buttons on the Projector Popup page
INTEGER ProjectorPopupMaster[] = { ProjectorPowerButtons, ProjectorImageMuteButtons }


//Audio Popup Power Buttons
INTEGER AudioPowerButtons[] = { 105, 106, 107, 108 }
//When a power button is pressed we can check if its in the on table and if its not then its off
//Again think of a grid (again)
INTEGER AudioPowerOnButtons[] = { 105, 107 }
//The Other Side of the table
INTEGER AudioInsideButtons[] = { 105, 106 }

//All Buttons on the audio popup page
INTEGER AudioPopupMaster[] = { AudioPowerButtons }


//Audio Popup Power Buttons
INTEGER ShutDownButtons[] = { 100 }
//When a shutdown button is pressed we can check if its in the yes table and if its not then its no
//Again think of a grid (again [again])
INTEGER ShutDownYesButtons[] = { 100 }

//All Buttons on the Shutdown System Page
INTEGER ShutdownPopupMaster[] = { ShutDownButtons }



//Group of all touch pannels connected to the master
DEV dvTPMaster[] = { }

//Group of all HDMI outputs on the DVX
DEV dvHdmiMaster[] = { dvHdmi1, dvHdmi2, dvHdmi3, dvHdmi4 }

//Group of all DxLink Inputs on the back of the dvx
DEV dvDvxDxlinkInMaster[] = { dvDvxDxLinkIn1, dvDvxDxLinkIn2 }

//Group of all DxLink Outputs on the back of the dvx
DEV dvDvxDxLinkOutMaster[] = { dvDvxDxLinkOut1, dvDvxDxLinkOut2 }

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//Inside Audio Current Power State
// 1 is on 0 is off
INTEGER InsideAudioState = 0 // Default to off state

//Outside Audio Current Power State
// 1 is on 0 is off
INTEGER OutsideAudioState = 0 // Default to off state

//The State of Mic number 1
// 0 is inside 1 is outside
INTEGER MicOneState = 0 // Default to inside state

//The State of Mic number 2
// 0 is inside 1 is outside
INTEGER MicTwoState = 1 // Default to outside state

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

//Function for turning on or off the Inside audio
DEFINE_FUNCTION fnSetInsideAudioPower(INTEGER State){
    
    //set the global state to the current state
    InsideAudioState = State
    
    //if the state is 1 (aka on) turn on relay 1 and stop the rest of the function from running
    IF (State = 1) RETURN ON[dvRELAY, 1]
    
    //turn off relay 1
    OFF[dvRELAY, 1]
    
}

//Repeat for outside
//Function for turning on or off the Outside audio
DEFINE_FUNCTION fnSetOutsideAudioPower(INTEGER State){
    
    //set the global state to the current state
    OutsideAudioState = State
    
    //if the state is 1 (aka on) turn on relay 2 and stop the rest of the function from running
    IF (State = 1) RETURN ON[dvRELAY, 2]
    
    //turn off relay 2
    OFF[dvRELAY, 2]
    
}

// State 0 is inside and State 1 is outside
DEFINE_FUNCTION fnSetMicState(INTEGER MicNumber, INTEGER State){
    
    if (MicNumber == 1){
	INTEGER MicOneState = State
	
	if (State == 1){
	    //Switch Mic one to outside audio device here
	    
	    print("'==================[ implement me ]=================='", false);
	} else {
	    //Switch Mic one to inside audio device here
	    
	    print("'==================[ implement me ]=================='", false);
	}
	
	RETURN
    }
    
    
    INTEGER MicTwoState = State
	
    if (State == 1){
	//Switch Mic two to outside audio device here
	
	print("'==================[ implement me ]=================='", false);
    } else {
	//Switch Mic two to inside audio device here
	
	print("'==================[ implement me ]=================='", false);
    }
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
print("'Starting LNC AMX DVX!'", false);

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_MODULE 

'DvxSwitcherDashboard_dr1_0_0' DvxSwitcherDashboard_dr1_0_0(vdvSwitcher, dvDVXSW);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

// Touch Pannel Startup Program
DATA_EVENT[dvTPMaster]
{
    ONLINE:
    {
	//setup touch pannel
	moderoDisableAllPopups(Data.Device)
	
	//set pannel passwords
	//moderoSetPageFlipPassword(Data.Device, itoa(0), itoa(1988))
	//moderoSetPageFlipPassword(Data.Device, itoa(1), itoa(1988))
	//moderoSetPageFlipPassword(Data.Device, itoa(2), itoa(1950))
	
	
	//enable touch pannel
	moderoSetPage('Welcome')
	moderoBeepDouble(Data.Device)
	moderoEnablePopup(Data.Device, 'Online')
	
	SEND_STRING dvCONSOLE, "'a TP came Online:', devToString(Data.Device)"
    }
}

 BUTTON_EVENT[dvTPMaster, 0]
 {
    PUSH:
    {
	// if the pressed button is in the WelcomePageMaster group (table) then run the code
	if (fnGetIndex(WelcomePageMaster, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Button Pressed On The Welcome Page'", false);
	    
	    if (fnGetIndex(WelcomePageStartButton, BUTTON.INPUT.CHANNEL) != 0){
		print("'Start Button Pressed'", false);
	    }
	}
	
	// if the pressed button is in the MainPageMaster group (table) then run the code
	if (fnGetIndex(MainPageMaster, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Button Pressed On The Main Page'", false);
	    
	    //if its a mic related button continue
	    if (fnGetIndex(MicOutputButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Mic Output Button Pressed'", false);
		
		if (fnGetIndex(MicOnebuttons, BUTTON.INPUT.CHANNEL) != 0){
		    print("'Adressing Mic One'", false);
		    
		    // State 0 is inside and State 1 is outside
		    // fnSetMicState(INTEGER MicNumber, INTEGER State)
		    
		    if (fnGetIndex(MicInsideButtons, BUTTON.INPUT.CHANNEL) != 0){
			//if the mic is in the inside grop its inside
			print("'Setting Mic One To Inside'", false);
			
			fnSetMicState(1, 0)
		    } else {
			//if its not then set it outside
			print("'Setting Mic One To Outside'", false);
			
			fnSetMicState(1, 1)
		    }

		} else {
		    print("'Adressing Mic Two'", false);
		    
		    if (fnGetIndex(MicInsideButtons, BUTTON.INPUT.CHANNEL) != 0){
			//if the mic is in the inside grop its inside
			print("'Setting Mic Two To Inside'", false);
			
			fnSetMicState(2, 0)
		    } else {
			//if its not then set it outside
			print("'Setting Mic Two To Outside'", false);
			
			fnSetMicState(2, 1)
		    }
		}
	    
		//return if its a mic related button so we dont continue
		//we do this cause the input output system needs to be unique
		RETURN
	    }
	    
	    print("'Button Pressed Adressing Input Selection'", false);
	    
	    print("'==================[ implement me ]=================='", false);
	    
	}
	
	// if the pressed button is in the ProjectorPopupMaster group (table) then run the code
	if (fnGetIndex(ProjectorPopupMaster, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Button Pressed On The Projector Popup'", false);
	    
	    //if the button is a power button continue
	    if (fnGetIndex(ProjectorPowerButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Projector Power Button Pressed'", false);
	    
		if (fnGetIndex(ProjectorPowerOnbutton, BUTTON.INPUT.CHANNEL) != 0){
		    //if the button is an on button
		    print("'Turning on the projector'", false);
		    
		    //for future implementation
		    print("'==================[ implement me ]=================='", false);
		} else {
		    //if the button not an on button then its an off button
		    print("'Turning off the projector'", false);
		    
		    //for future implementation
		    print("'==================[ implement me ]=================='", false);
		}
	    }
	    
	    //if the button is a power button continue
	    if (fnGetIndex(ProjectorImageMuteButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Projector Image Mute Button Pressed'", false);
		
		//for future implementation
		print("'==================[ implement me ]=================='", false);
	    }
	}
	
	// if the pressed button is in the AudioPopupMaster group (table) then run the code
	if (fnGetIndex(AudioPopupMaster, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Button Pressed On The Audio Popup'", false);
	    
	    // if the pressed button is a audio power button then continue
	    if (fnGetIndex(AudioPowerButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Button Pressed On The Audio Popup'", false);
		
		if (fnGetIndex(AudioInsideButtons, BUTTON.INPUT.CHANNEL) != 0){
		    //if the button is inside it will be here
		    print("'Adressing Inside Amps'", false);
		    
		    if (fnGetIndex(AudioPowerOnButtons, BUTTON.INPUT.CHANNEL) != 0){
			//if its in the AudioPowerOnButtons then its on
			print("'Turning Inside Amps on'", false);
			
			fnSetInsideAudioPower(1)
		    } else {
			//if not then its off
			print("'Turning Inside Amps off'", false);
			
			fnSetInsideAudioPower(0)
		    }
		} else {
		    //if the button is not inside (aka outside) it will be here
		    print("'Adressing Outside Amps'", false);
		    
		    if (fnGetIndex(AudioPowerOnButtons, BUTTON.INPUT.CHANNEL) != 0){
			//if its in the AudioPowerOnButtons then its on
			print("'Turning Outside Amps on'", false);
			
			fnSetOutsideAudioPower(1)
		    } else {
			//if not then its off
			print("'Turning Outside Amps off'", false);
			
			fnSetOutsideAudioPower(0)
		    }
		}
	    }
	}
	
	// if the pressed button is in the ShutdownPopupMaster group (table) then run the code
	if (fnGetIndex(ShutdownPopupMaster, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Button Pressed On The Shutdown Popup'", false);
	    
	    // if the button is in the table then its a yes
	    if (fnGetIndex(ShutDownYesButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Resetting All Systems'", false);
		
		//1 is on 0 is off
		fnSetInsideAudioPower(0)
		fnSetOutsideAudioPower(0)
		
		// State 0 is inside and State 1 is outside
		// fnSetMicState(INTEGER MicNumber, INTEGER State)
		fnSetMicState(1, 0)
		fnSetMicState(2, 1)
	    } else {
		//else then it was a no
		print("'Aborting System Reset!'", false);
		
	    }
	}
    }
 
    RELEASE:
    {
    
    }
 }

//html5 webpannel
data_event[vdvSwitcher]
{
    online: 
    {
	send_command data.device,'DEBUG-1';
	
	(***********************************************************)
	(*                UI customization options                 *)
	(***********************************************************)
	// Override reported DVX matrix size
	// send_command data.device,'PROPERTY-INPUT.COUNT,4';
	// send_command data.device,'PROPERTY-OUTPUT.COUNT,2';
	// Remove reported DVX Components
	// send_command data.device,'PROPERTY-Has-microphones,false';
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


**************************)


