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
dvCOM5 = 5001:5:0	// RS-232 port 5 
dvCOM6 = 5001:6:0	// RS-232 port 6

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

//Touch Panels
dvTp1 = 10:1:0		//Server Room / av room touch panel
dvTp2 = 11:1:0		//Podium / Projector screen touch panel
dvTp3 = 12:1:0		//Dvd player area touch panel
dvTp4 = 13:1:0		//Old Man table touch panel

//projector
vdvOptomaTH1060 = 41001:1:0  // The COMM module should use this as its duet device
// Serial RS-232 Control
dvOptomaTH1060 = 5001:2:0 // This device should be used as the physical device by the COMM module

//html5 webpanel
vdvSwitcher = 41001:1:0;	// Virtual Device

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Big Start Button on the Welcome Page
INTEGER WelcomePageStartButton[] = { 1 }

//All Welcome Page Buttons
INTEGER WelcomePageMaster[] = { 1 } //WelcomePageStartButton }


//Output Select Buttons
INTEGER OutputButtons[] = { 11, 12, 13, 14, 15, 16 }
//Physical Output Numbers (IN ORDER)
INTEGER PhysicalOutputNumbers[] = { 11, 12, 5, 6, 7, 8 }

//Input Select Buttons
INTEGER InputButtons[] = { 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 }
//Physical input Numbers (IN ORDER)
INTEGER PhysicalInputNumbers[] = { 5, 6, 7, 8, 9, 10, 11, 12, 1, 16 }

//Input / Output Master
INTEGER InputOutputMaster[] = { 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 }

//Mic Output Buttons
INTEGER MicOutputButtons[] = { 6, 7, 8, 9 }
//When a mic output button is pressed we can check if its in the inside table and if its not then its outside
//Think of a grid
INTEGER MicInsideButtons[] = { 6, 8 }
//The other sider of the grid
INTEGER MicOnebuttons[] = { 6, 7 }

//Button codes on the Main Page ( All of the above )
INTEGER MainPageMaster[] = { 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 6, 7, 8, 9 }


//Projector Power buttons
INTEGER ProjectorPowerButtons[] = { 101, 102 }
//When a power button is pressed we can check if its in the on table and if its not then its off
//Again think of a grid
INTEGER ProjectorPowerOnbutton[] = { 101 }

//Projector Hour Refresh Button
INTEGER ProjectorHourRefreshbutton[] = { 104 }

//Projector Image Mute button
INTEGER ProjectorImageMuteButtons[] = { 105 }

//Projector Screen Buttons
INTEGER ProjectorScreenButtons[] = { 103, 106 }
//When a power button is pressed we can check if its in the on table and if its not then its off
//Again think of a grid (again)
INTEGER ProjectorScreenUpButtons[] = { 103 }

//all buttons on the Projector Popup page ( All of the above )
INTEGER ProjectorPopupMaster[] = { 101, 102, 103, 104, 105, 106 }


//Audio Popup Power Buttons
INTEGER AudioPowerButtons[] = { 110, 111, 112, 113 }
//When a power button is pressed we can check if its in the on table and if its not then its off
//Again think of a grid (again [again])
INTEGER AudioPowerOnButtons[] = { 110, 112 }
//The Other Side of the table
INTEGER AudioInsideButtons[] = { 110, 111 }

//All Buttons on the audio popup page ( All of the above )
INTEGER AudioPopupMaster[] = { 110, 111, 112, 113 }

//Audio Power Status Channel Codes
//Inside Audio Status Channel Code
INTEGER InsideAudioStatus[] = { 200 }
//Outside Audio Status Channel Code
INTEGER OutsideAudioStatus[] = { 201 }


//Audio Popup Power Buttons
INTEGER ShutDownButtons[] = { 100 }
//When a shutdown button is pressed we can check if its in the yes table and if its not then its no
//Again think of a grid (again [again {again}])
INTEGER ShutDownYesButtons[] = { 100 }

//Shutdown Abort Button
INTEGER ShutdownAbortButton[] = { 120 }

//All Buttons on the Shutdown System Page ( All of the above )
INTEGER ShutdownPopupMaster[] = { 100 }



//Group of all touch panels connected to the master
DEV dvTPMaster[] = { dvTp1, dvTp2, dvTp3, dvTp4 }

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

//Global Projector Screen State Variable
INTEGER ProjectorScreenState = 0

//console command for use in dvCom1 commands to the dgx
ComCommand[40] = ''

(***********************************************************)
(*              Function DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_FUNCTION INTEGER fnGetIndex(INTEGER nArray[], INTEGER nValue)
{

    //for use in for loops
    INTEGER x
   
    FOR (x=1; x<=LENGTH_ARRAY(nArray); x++) {
	IF (nArray[x] = nValue) RETURN x
    }

   RETURN 0

}

DEFINE_FUNCTION INTEGER channelGet(dev device, integer chan)
{

    return [device, chan]
    
}

DEFINE_FUNCTION INTEGER fnHasOutputFeedback(dev dvTP)
{

    //for use in for loops
    INTEGER x
    
    for (x=1; x<=LENGTH_ARRAY(OutputButtons); x++) {
	if (channelGet(dvTP, OutputButtons[x]) == 1) return 1
    }
    
    return 0
    
}

DEFINE_FUNCTION INTEGER fnHasInputFeedback(dev dvTP)
{
    
    //for use in for loops
    INTEGER x
    
    for (x=1; x<=LENGTH_ARRAY(InputButtons); x++) {
	if (channelGet(dvTP, InputButtons[x]) == 1) return 1
    }
    
    return 0
    
}

DEFINE_FUNCTION fnResetOutputFeedback(dev dvTP)
{

    //for use in for loops
    INTEGER x
    
    //for every input disable the feedback
    for (x=1; x<=LENGTH_ARRAY(OutputButtons); x++) {
	moderoDisableButtonFeedback(dvTP, OutputButtons[x])
    }
    
}

DEFINE_FUNCTION fnResetInputFeedback(dev dvTP)
{
    
    //for use in for loops
    INTEGER x
    
    //for every input disable the feedback
    for (x=1; x<=LENGTH_ARRAY(InputButtons); x++) {
	moderoDisableButtonFeedback(dvTP, InputButtons[x])
    }
}

//INTEGER AudioPopupMaster[] = { 110, 111, 112, 113 }

// Function for turning on or off the Inside audio
DEFINE_FUNCTION fnSetInsideAudioPower(INTEGER State)
{

    //for use in for loops
    INTEGER x
    
    // set the global state to the current state
    InsideAudioState = State
    
    // if the state is 1 (aka on) turn on relay 1 and stop the rest of the function from running
    IF (State = 1) {
	ON[dvRELAY, 1]
    } else {
	// turn off relay 1
	OFF[dvRELAY, 1]
    }
    
    //update panel fedback
    fnUpdateAudioPowerStatus()
    
}

// Repeat for outside
// Function for turning on or off the Outside audio
DEFINE_FUNCTION fnSetOutsideAudioPower(INTEGER State)
{

    //for use in for loops
    INTEGER x
    
    // set the global state to the current state
    OutsideAudioState = State
    
    // if the state is 1 (aka on) turn on relay 2 and stop the rest of the function from running
    IF (State = 1) {
	ON[dvRELAY, 2]
    } else {
	// turn off relay 1
	OFF[dvRELAY, 2]
    }
    
    //update panel fedback
    fnUpdateAudioPowerStatus()
    
}

DEFINE_FUNCTION fnUpdateMicButtonStatus()
{

    //for use in for loops
    INTEGER x
    
    //turn the status light off on every touch pannel
    for (x=1; x<=LENGTH_ARRAY(dvTPMaster); x++) {
	if (MicOneState == 1){
	    //inside button feedback
	    moderoDisableButtonFeedback(dvTPMaster[x], MicOutputButtons[1])
		
	    //outside button feedback
	    moderoEnableButtonFeedback(dvTPMaster[x], MicOutputButtons[2])
	} else {
	    //outside button feedback
	    moderoDisableButtonFeedback(dvTPMaster[x], MicOutputButtons[2])
		
	    //inside button feedback
	    moderoEnableButtonFeedback(dvTPMaster[x], MicOutputButtons[1])
	}
	
	if (MicTwoState == 1){
	    //inside button feedback
	    moderoDisableButtonFeedback(dvTPMaster[x], MicOutputButtons[3])
		
	    //outside button feedback
	    moderoEnableButtonFeedback(dvTPMaster[x], MicOutputButtons[4])
	    } else {
	    //outside button feedback
	    moderoDisableButtonFeedback(dvTPMaster[x], MicOutputButtons[4])
		
	    //inside button feedback
	    moderoEnableButtonFeedback(dvTPMaster[x], MicOutputButtons[3])
	}
    }
}

DEFINE_FUNCTION fnUpdateAudioPowerStatus()
{

    //for use in for loops
    INTEGER x
    
    //turn the status light off on every touch pannel
    for (x=1; x<=LENGTH_ARRAY(dvTPMaster); x++) {
	//set the panel states to current controller states
	if (InsideAudioState == 1){
	    //status light
	    moderoEnableButtonFeedback(Data.Device, InsideAudioStatus[1])
	    
	    //popup off button
	    moderoDisableButtonFeedback(Data.Device, AudioPopupMaster[2])
	    
	    //popup on button
	    moderoEnableButtonFeedback(Data.Device, AudioPopupMaster[1])
	} else {
	    //status light
	    moderoDisableButtonFeedback(Data.Device, InsideAudioStatus[1])
	    
	    //popup off button
	    moderoDisableButtonFeedback(Data.Device, AudioPopupMaster[1])
	    
	    //popup on button
	    moderoEnableButtonFeedback(Data.Device, AudioPopupMaster[2])
	}
	
	if (OutsideAudioState == 1){
	    //status light
	    moderoEnableButtonFeedback(Data.Device, OutsideAudioStatus[1])
	    
	    //popup off button
	    moderoDisableButtonFeedback(Data.Device, AudioPopupMaster[4])
	    
	    //popup on button
	    moderoEnableButtonFeedback(Data.Device, AudioPopupMaster[3])
	} else {
	    //status light
	    moderoDisableButtonFeedback(Data.Device, OutsideAudioStatus[1])
	    
	    //popup off button
	    moderoDisableButtonFeedback(Data.Device, AudioPopupMaster[3])
	    
	    //popup on button
	    moderoEnableButtonFeedback(Data.Device, AudioPopupMaster[4])
	}
    }
}

/*
 * Function:    dvxSetAudioOutputMixLevel
 *
 * Arguments:   dev dvxAudioOutputPort - audio output port on the DVX
 *              sinteger snMixLevel - mix level (-100 to 0)
 *              integer input - input port
 *                      Values:
 *                          DVX_MIX_INPUT_LINE
 *                          DVX_MIX_INPUT_MIC1
 *                          DVX_MIX_INPUT_MIC2
 *              integer input - input port
 *                      Values:
 *                          DVX_MIX_OUTPUT_1_AMP
 *                          DVX_MIX_OUTPUT_2_LINE
 *                          DVX_MIX_OUTPUT_3_LINE
 *                          DVX_MIX_OUTPUT_4_LINE
 *
 * Description: Sets the mix level contribution of the specified audio
 *              input to the audio output port's mixer.
 */
//define_function dvxSetAudioOutputMixLevel (dev dvxAudioOutputPort, sinteger mixLevel, integer input, integer output)

// State 0 is inside and State 1 is outside
DEFINE_FUNCTION fnSetMicState(INTEGER MicNumber, INTEGER State)
{
    if (MicNumber == 1){
	MicOneState = State
	
	if (State == 1){
	    //Switch Mic one to outside audio device here
	    
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 2, 2)
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 2, 3)
	    dvxSetAudioOutputMixLevel(dvSWA, 100, 2, 4)
	    
	    print("'a'", false);
	} else {
	    //Switch Mic one to inside audio device here
	    
	    dvxSetAudioOutputMixLevel(dvSWA, 100, 2, 2)
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 2, 3)
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 2, 4)
	    
	    print("'b'", false);
	}
	
    } else {
	MicTwoState = State
	
	if (State == 1){
	    //Switch Mic two to outside audio device here
	    
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 3, 2)
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 3, 3)
	    dvxSetAudioOutputMixLevel(dvSWA, 100, 3, 4)
	    
	    print("'c'", false);
	} else {
	    //Switch Mic two to inside audio device here
	    
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 3, 2)
	    dvxSetAudioOutputMixLevel(dvSWA, 100, 3, 3)
	    dvxSetAudioOutputMixLevel(dvSWA, 0, 3, 4)
	    
	    print("'d'", false);
	}
    }
    
    //update the panel button status
    fnUpdateMicButtonStatus()
}

//CL0I16O5 6 7T
//CLI(INPUT)16O(Output)5 6 7T(Take)
//CL0I + input number + O + output numbers + T
DEFINE_FUNCTION INTEGER fnCalculateComCommand(dev dvTP)
{
    
    //for use in for loops
    INTEGER x
    
    //Start With Change Input
    ComCommand = 'CL0I'
    
    //add the input
    for (x=1; x<=LENGTH_ARRAY(InputButtons); x++) {
	if (channelGet(dvTP, InputButtons[x])){
	    ComCommand = "ComCommand, ITOA(PhysicalInputNumbers[x])"
	}
    }
    
    //Add O for outputs
    ComCommand = "ComCommand, 'O'"
    
    //Add the outputs
    for (x=1; x<=LENGTH_ARRAY(OutputButtons); x++) {
	if (channelGet(dvTP, OutputButtons[x])){
	    if (ComCommand[LENGTH_ARRAY(ComCommand)] == 'O'){
		ComCommand = "ComCommand, ITOA(PhysicalOutputNumbers[x])"
	    } else {
		ComCommand = "ComCommand, ' ', ITOA(PhysicalOutputNumbers[x])"
	    }
	}
    }
    
    //add T to the end of the command for Take
    ComCommand = "ComCommand, 'T'"
    
    //debug log
    print("'Calculated ComCommand: ', ComCommand", false);
    
    //if there is nothing passed there is an error stop the program
    if (ComCommand == 'CL0IOT') return 0
    
    //no error... Continue!
    return 1
}

// DVX Relay 3 - Projector Screen Contacts (UP)
// DVX Relay 4 - Projector Screen Contacts (DOWN)

// States:
// 00 - Startup
// 01 - Projector Screen Up
// 02 - Projector Screen Down
// 10 - Rejected Screen Locked
// 11 - Locked Up (Wall Switch Up)
// 12 - Locked Down (Wall Switch Down)
// 20 - Reserved
// 21 - Projector Screen Rising
// 22 - Projector Screen Lowering

DEFINE_FUNCTION fnSetProjectorScreenState(INTEGER State)
{
    if (State >= 10){
	//return 10
    }

    if (State < 10){
	ProjectorScreenState = State
    }


}

// System Reset Function
DEFINE_FUNCTION fnResetSystem()
{
    //for use in for loops
    INTEGER x

    print("'Resetting All Systems'", false);
    
    // 1 is on 0 is off
    fnSetInsideAudioPower(0)
    fnSetOutsideAudioPower(0)
    
    // State 0 is inside and State 1 is outside
    // fnSetMicState(INTEGER MicNumber, INTEGER State)
    fnSetMicState(1, 0)
    fnSetMicState(2, 1)
    
    //update the panel status
    fnUpdateMicButtonStatus()
    
    //update audio power status
    fnUpdateAudioPowerStatus()

    //for every touch panel in the table
    for (x=1; x<=LENGTH_ARRAY(dvTPMaster); x++) {
	//reset input and output button feedback
	fnResetInputFeedback(dvTPMaster[x])
	fnResetOutputFeedback(dvTPMaster[x])
	
	//disable all popups
	moderoDisableAllPopups(dvTPMaster[x])
	
	//set the page to the welcome page
	moderoSetPage(dvTPMaster[x], 'Welcome')
	
	//beep the touch panel
	moderoBeepDouble(dvTPMaster[x])
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

fnResetSystem()

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************) 

//html 5 web panel
DEFINE_MODULE 'DvxSwitcherDashboard_dr1_0_0' DvxSwitcherDashboard_dr1_0_0(vdvSwitcher, dvDVXSW);

// Define your communications module here like so:
DEFINE_MODULE 'Optoma_TH1060_Comm_dr1_0_0' comm(vdvOptomaTH1060, dvOptomaTH1060);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvCOM1]
{
    online: {
	SEND_COMMAND dvCOM1,'SET BAUD 9600,N,8,1'
	SEND_COMMAND dvCOM1, 'HSOFF'
    }
    
    STRING: {
	STACK_VAR CHAR msg[16]
	
	SEND_STRING dvCONSOLE, "'dvCOM1 returned:', msg"
    }
}

// Set IO To detect a pull to low as active (low as in io pin to GND)
//DATA_EVENT[dvIO]
//{
    //send_command dvIO, 'SET INPUT 1 LOW' // DVX IO 1 - Projector Screen Wall Switch Pos 1 (UP)
    //send_command dvIO, 'SET INPUT 2 LOW' // DVX IO 2 - Projector Screen Wall Switch Pos 2 (DOWN)
//}

// Detect Pulls (Changes) on the io pin 1 (Projector Screen Wall Switch [UP])
CHANNEL_EVENT[dvIO, 1]
{
    ON:
    {
	print("'dvIO 1 Pulled Low (ON)'", false);
	
	// Set the projector screen state to 11 - Locked Up (Wall Switch Up)
	fnSetProjectorScreenState(11)
    }
    
    OFF:
    {
	print("'dvIO 1 Pulled High (OFF)'", false);
	
	// Set the current state to the current state - 10 aka unlocking the screen state
	fnSetProjectorScreenState(ProjectorScreenState - 10)
    }
}

// Detect Pulls (Changes) on the io pin 2 (Projector Screen Wall Switch [DOWN])
CHANNEL_EVENT[dvIO, 2]
{
    ON:
    {
	print("'dvIO 2 Pulled Low (ON)'", false);
	
	// Set the projector screen state to 12 - Locked Down (Wall Switch Down)
	fnSetProjectorScreenState(12)
    }
    
    OFF:
    {
	print("'dvIO 2 Pulled High (OFF)'", false);
	
	// Set the current state to the current state - 10 aka unlocking the screen state
	fnSetProjectorScreenState(ProjectorScreenState - 10)
    }
}

// Touch Panel Startup Program
DATA_EVENT[dvTPMaster]
{
    ONLINE:
    {
	//setup touch panel
	moderoDisableAllPopups(Data.Device)
	
	//set panel passwords
	moderoSetPageFlipPassword(Data.Device, '1', '1950')
	//Debug Menu PAssword
	moderoSetPageFlipPassword(Data.Device, '2', '1998')
	moderoSetPageFlipPassword(Data.Device, '3', '1988')
	moderoSetPageFlipPassword(Data.Device, '4', '1988')
	//pannel admin password
	moderoSetPageFlipPassword(Data.Device, '5', '1988')
	
	//reset input and output feedback for this panel
	fnResetInputFeedback(Data.Device)
	fnResetOutputFeedback(Data.Device)
	
	//update panel mic status
	fnUpdateMicButtonStatus()
	
	//update audio power status
	fnUpdateAudioPowerStatus()
	
	//enable touch panel
	moderoSetPage(Data.Device, 'Welcome')
	moderoBeepDouble(Data.Device)
	moderoEnablePopup(Data.Device, 'Online')
	
	SEND_STRING dvCONSOLE, "'a TP came Online:', devToString(Data.Device)"
    }
}

 BUTTON_EVENT[dvTPMaster, 0]
 {
    PUSH:
    {
	//Log what button was pressed on what panel
	print("'Button pushed on dvTP: ', devToString(BUTTON.INPUT.DEVICE), ' BUTTON.INPUT.CHANNEL: ', ITOA(BUTTON.INPUT.CHANNEL)", false)
	
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
	    }
	    
	    if (fnGetIndex(InputOutputMaster, BUTTON.INPUT.CHANNEL) != 0){
		if (fnGetIndex(OutputButtons, BUTTON.INPUT.CHANNEL) != 0){
		    print("'Button Pressed Adressing Output Selection: '", false);
		    
		    //turn on the button feedback for the button that was pressed
		    moderoToggleButtonFeedback(BUTTON.INPUT.DEVICE, BUTTON.INPUT.CHANNEL)
		    
		    //channelGet(dev TP, INTIGER Channel)
		    //fnHasOutputFeedback(dev TP)
		    //fnHasInputFeedback(dev TP)
		    
		    //if an output button is pressed and an input button is already pressed
		    if (fnHasInputFeedback(BUTTON.INPUT.DEVICE)){
			//calculate the com command and if its a sucess run the command
			if(fnCalculateComCommand(BUTTON.INPUT.DEVICE)) SEND_STRING dvCOM1, ComCommand
			
			//reset the button feedback
			fnResetOutputFeedback(BUTTON.INPUT.DEVICE)
			fnResetInputFeedback(BUTTON.INPUT.DEVICE)
		    }
		} else {
		    print("'Button Pressed Adressing Input Selection'", false);
		    
		    //turn on the button feedback for the button that was pressed
		    moderoToggleButtonFeedback(BUTTON.INPUT.DEVICE, BUTTON.INPUT.CHANNEL)
		    
		    //only input button can be pressed at once
		    if (fnHasInputFeedback(BUTTON.INPUT.DEVICE)){
			//Disable all input buttons
			fnResetInputFeedback(BUTTON.INPUT.DEVICE)
			
			//ReEnable the button that was just pressed
			moderoEnableButtonFeedback(BUTTON.INPUT.DEVICE, BUTTON.INPUT.CHANNEL)
		    }
		    
		    //if an input button is pressed and an output button is already pressed
		    if (fnHasOutputFeedback(BUTTON.INPUT.DEVICE)){
			if(fnCalculateComCommand(BUTTON.INPUT.DEVICE)) SEND_STRING dvCOM1, ComCommand
			
			fnResetOutputFeedback(BUTTON.INPUT.DEVICE)
			fnResetInputFeedback(BUTTON.INPUT.DEVICE)
		    }
		}
	    }
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
	    
	    //if the button is a hour refresh button continue
	    if (fnGetIndex(ProjectorHourRefreshbutton, BUTTON.INPUT.CHANNEL) != 0){
		print("'Projector Hour Refresh Button Pressed'", false);
		
		//for future implementation
		print("'==================[ implement me ]=================='", false);
	    }
	    
	    //if the button is a Screen Button button continue
	    if (fnGetIndex(ProjectorScreenButtons, BUTTON.INPUT.CHANNEL) != 0){
		print("'Projector Screen Button Pressed'", false);
	    
		if (fnGetIndex(ProjectorScreenUpButtons, BUTTON.INPUT.CHANNEL) != 0){
		    //if the button is an up button
		    print("'Sending The Projector Screen Up'", false);
		    
		    //send the projector screen up
		    ON[dvRELAY, 3]
		    
		} else {
		    //if the button not a up button then its a down button
		    print("'Sending The Projector Screen Down'", false);
		    
		    //send the projector screen down
		    ON[dvRELAY, 4]
		}
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
		// Call System reset
		
		fnResetSystem()
	    } else {
		//else then it was a no
		print("'Aborting System Reset!'", false);
		
		print("'==================[ implement me ]=================='", false);
	    }
	}
    }
 
    RELEASE:
    {
	//Log what button was released on what panel
	print("'Button released on dvTP: ', devToString(BUTTON.INPUT.DEVICE), ' BUTTON.INPUT.CHANNEL: ', ITOA(BUTTON.INPUT.CHANNEL)", false)
	
	//if the button is a Screen Button button continue
	if (fnGetIndex(ProjectorScreenButtons, BUTTON.INPUT.CHANNEL) != 0){
	    print("'Projector Screen Button Released'", false);
	    
	    if (fnGetIndex(ProjectorScreenUpButtons, BUTTON.INPUT.CHANNEL) != 0){
		//if the button is an up button
		print("'Stopping Sending The Projector Screen Up'", false);
		    
		//Stop Sending the projector screen up
		OFF[dvRELAY, 3]
		
	    } else {
		//if the button not a up button then its a down button
		print("'Stopping Sending The Projector Screen Down'", false);
		    
		//Stop Sending the projector screen down
		OFF[dvRELAY, 4]
	    }
	}
    }
 }

//html5 webpanel
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
(* See Differences in DEFINE_PROGRAM Program Execution section   *)
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
