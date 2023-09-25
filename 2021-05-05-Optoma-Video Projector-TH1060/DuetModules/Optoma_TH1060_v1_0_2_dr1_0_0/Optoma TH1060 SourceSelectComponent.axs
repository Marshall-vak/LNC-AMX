(*********************************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2006 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2007                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
MODULE_NAME = 'Optoma TH1060 SourceSelectComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 8/13/2008 3:52:03 PM                    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

#include 'ComponentInclude.axi'

#include 'SNAPI.axi'

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

// Channels
BTN_GET_INPUT_SELECT            = 1875  // Button: getInputSelect

// Levels

// Variable Text Addresses

// G4 CHANNELS
BTN_SOURCE_CYCLE                = 196   // Button: Cycle Input

#IF_NOT_DEFINED BTN_INPUT_SOURCE
INTEGER BTN_INPUT_SOURCE[]      =       // Button: Input
{
  281,  282,  283,  284,  285,
  286,  287,  288,  289,  290,
  291,  292,  293,  294,  295,
  296,  297,  298,  299,  300
}
#END_IF // BTN_INPUT_SOURCE

// G4 VARIABLE TEXT ADDRESSES

#IF_NOT_DEFINED TXT_INPUT_SOURCE_GROUP
INTEGER TXT_INPUT_SOURCE_GROUP[]=       // Text: Input Group Name
{
  301,  302,  303,  304,  305,
  306,  307,  308,  309,  310,
  311,  312,  313,  314,  315,
  316,  317,  318,  319,  320
}
#END_IF // TXT_INPUT_SOURCE_GROUP


#IF_NOT_DEFINED TXT_INPUT_SOURCE
INTEGER TXT_INPUT_SOURCE[]      =       // Text: Input Name
{
  281,  282,  283,  284,  285,
  286,  287,  288,  289,  290,
  291,  292,  293,  294,  295,
  296,  297,  298,  299,  300
}
#END_IF // TXT_INPUT_SOURCE

TXT_SOURCE_INPUT                = 15    // Text: Input


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER MAX_INPUTS = 20
INTEGER MAX_INPUT_BUTTONS = 20


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


#IF_NOT_DEFINED _uInputProp
STRUCTURE _uInputProp
{
    INTEGER    nGroup
    CHAR       sSignal[20]
    CHAR       sLabel[20]
    CHAR       sDisplay[20]
}
#END_IF


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


VOLATILE _uInputProp InputProps[MAX_ZONE][MAX_INPUTS]
VOLATILE INTEGER InputGroups[MAX_ZONE][MAX_INPUTS]
VOLATILE INTEGER nPropertyCount = 0 		// Number of properties received since the touchpanel came online
VOLATILE INTEGER nInputsUsed[MAX_ZONE];
VOLATILE INTEGER nGroupCount = 0;


//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnDeviceChanged
//
// PURPOSE:          This function is used by the device selection BUTTON_EVENT
//                   to notify the module that a device change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnDeviceChanged()
{

    println ("'OnDeviceChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnPageChanged
//
// PURPOSE:          This function is used by the page selection BUTTON_EVENT
//                   to notify the module that a component change may have occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnPageChanged()
{
    SEND_COMMAND vdvDev[nCurrentZone], '?INPUTPROPERTIES'
    SEND_COMMAND vdvDev[nCurrentZone], '?INPUTSELECT'
    println ("'OnPageChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnZoneChange
//
// PURPOSE:          This function is used by the zone selection BUTTON_EVENT
//                   to notify the module that a zone change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnZoneChange()
{
	displayGroups(nCurrentZone);
	SEND_COMMAND vdvDev[nCurrentZone], '?INPUTSELECT'

    println ("'OnZoneChange'")
}



//*********************************************************************
// Function : initialize
// Purpose  : initialize any variables to default values
// Params   : none
// Return   : none
//*********************************************************************
DEFINE_FUNCTION initialize()
{
    stack_var integer nLoop
    stack_var integer x
    
	nGroupCount = 0;
	send_string 0,"'nGroupCount initialized to 0!!'"

	nPropertyCount = 0;
    for (nLoop = 1; nLoop <= MAX_ZONE; nLoop++)
    {
		nInputsUsed[nLoop] = 0;
		for (x = 1; x <= MAX_INPUTS; x++)
		{
			InputProps[nLoop][x].nGroup = 0
			InputProps[nLoop][x].sSignal = ''
			InputProps[nLoop][x].sLabel = ''
			InputProps[nLoop][x].sDisplay = ''
			InputGroups[nLoop][x] = 0;
		}
    }
	
	// Clear the page
	for (nLoop = 1; nLoop <= MAX_INPUT_BUTTONS; nLoop++)
	{
		send_command dvTP, "'^TXT-',itoa(TXT_INPUT_SOURCE[nLoop]),',0,',''"
		send_command dvTP, "'^SHO-',itoa(TXT_INPUT_SOURCE[nLoop]),',0'"
	}
	send_command dvTP, "'^TXT-',itoa(TXT_SOURCE_INPUT),',0,',''"
}
//*********************************************************************
// Function : parseProperties
// Purpose  : Parse property groups from a list of property groups and
//            puts the group into a property structure
// Params   : props - list of property groups
//            nZone - zone which the list came from
// Return   : INTEGER - number of property groups in list
//*********************************************************************
DEFINE_FUNCTION parseProperties(CHAR props[], INTEGER nZone)
{
    STACK_VAR CHAR sSource[20]
    
    WHILE(LENGTH_STRING(props) > 0)
    {
		STACK_VAR CHAR property[100]
		STACK_VAR INTEGER index
		STACK_VAR INTEGER x
		
		index = 0
		property = DuetParseCmdParam(props)
		
		// separate each property from the property group
		index = ATOI(DuetParseCmdParam(property))
		
		if (nInputsUsed[nZone] < index)
			nInputsUsed[nZone] = index;
		
		if (index > 0 && index <= MAX_INPUTS)
		{
			// This is the only way we can tell the list needs to be reset.
			if (index == 1)
			{
				nPropertyCount = 0;
				nGroupCount = 0;
			    for (x = 1; x <= MAX_INPUTS; x++)
			    {
				InputGroups[nZone][x] = 0;
			    }
			}
			
			nPropertyCount++;
			InputProps[nZone][index].nGroup = ATOI(DuetParseCmdParam(property))
			InputProps[nZone][index].sSignal = DuetParseCmdParam(property)
			InputProps[nZone][index].sLabel = DuetParseCmdParam(property)
			InputProps[nZone][index].sDisplay = DuetParseCmdParam(property)
			
			if (addGroupNumber(InputProps[nZone][index].nGroup, nZone) == TRUE)
			{
				displayGroups(nZone);
			}
		}
    }
}
//*********************************************************************
// Function : findProperty
// Purpose  : Finds the property that matches the passed in index
// Params   : index - matches the INPUTPROPERTY <index> value
//            nZone - zone which the list came from
// Return   : INTEGER - array position of the matching property
//*********************************************************************
DEFINE_FUNCTION INTEGER findProperty(INTEGER index, INTEGER nZone)
{
    stack_var integer nLoop
    
	if (index > 0 && index <= MAX_INPUTS)
	{
		for (nLoop = 1; nLoop <= MAX_INPUTS; nLoop++)
		{
			IF (InputProps[nZone][index].nGroup > 0)
			{
				RETURN TRUE;
			}
		}
	}
    
    RETURN FALSE;
}
//*********************************************************************
// Function : getPropertyIndexByGroup
// Purpose  : Get the property index that matches the passed in 
//            groupNumber.
// Params   : groupNumber - matches the INPUTPROPERTY <group> value
//            nZone - zone which the list came from
// Return   : INTEGER - array position of the matching property
//*********************************************************************
DEFINE_FUNCTION INTEGER getPropertyIndexByGroup(INTEGER groupNumber, INTEGER nZone)
{
    stack_var integer nLoop
    
    for (nLoop = 1; nLoop <= MAX_INPUTS; nLoop++)
    {
		IF (InputProps[nZone][nLoop].nGroup == groupNumber)
		{
			RETURN nLoop
		}
    }
    
    RETURN 0
}
//*********************************************************************
// Function : isGroupUsed
// Purpose  : Check to see if the group number passed in is already in
//            use.
// Params   : groupNumber - matches the INPUTPROPERTY <group> value
//            nZone - zone which the list came from
// Return   : INTEGER - TRUE if used; FALSE otherwise.
//*********************************************************************
DEFINE_FUNCTION INTEGER isGroupUsed(INTEGER groupNumber, INTEGER nZone)
{
    stack_var integer nLoop
    
    for (nLoop = 1; nLoop <= MAX_INPUTS; nLoop++)
	{
		IF (InputGroups[nZone][nLoop] == groupNumber)
		{
			RETURN TRUE;
		}
	}
	
    RETURN FALSE;
}
//*********************************************************************
// Function : sortGroupNumbers
// Purpose  : Sorts the group number array from least to greatest using
//            an insertion sort.
// Params   : nZone - zone which the list came from
// Return   : none
//*********************************************************************
DEFINE_FUNCTION sortGroupNumbers(INTEGER nZone)
{
    stack_var integer i
    stack_var integer j
    stack_var integer index
	
	// initialize sort values to 1
	i = 1;
	j = 1;
	index = 1;
	
	// loop through the entire array
	// 
	// Note: we start with 2 so that we can 
	// subtract the previous in this case
    for (i = 2; i <= nGroupCount; i++)
	{
		// get the next value we wish to swap
		index = InputGroups[nZone][i]
		
		// this will cause a gradual increase in sorted side size
		j = i;
		
		// loop through all of the remaining items
		// and compare each neighbor until the previous
		// item is smaller or equal
		while ((j > 1) && (InputGroups[nZone][j-1] > index))
		{
			// move the current position to the next
			InputGroups[nZone][j] = InputGroups[nZone][j-1];
			j--;
		}
		
		// insert into the correct order
		InputGroups[nZone][j] = index;
	}
}
//*********************************************************************
// Function : addGroupNumber
// Purpose  : Adds a group number to the group number array in the 
//            appropriate sort order.
// Params   : groupNumber - matches the INPUTPROPERTY <group> value
//            nZone - zone which the list came from
// Return   : INTEGER - TRUE if added successfuly; FALSE otherwise.
//*********************************************************************
DEFINE_FUNCTION INTEGER addGroupNumber(INTEGER groupNumber, INTEGER nZone)
{
	if (isGroupUsed(groupNumber, nZone) == FALSE)
	{
		nGroupCount++;

		InputGroups[nZone][nGroupCount] = groupNumber;
		sortGroupNumbers(nZone);
		RETURN TRUE;
	}
	RETURN FALSE;
}
//*********************************************************************
// Function : getGroupIndex
// Purpose  : Get the index of the group number in the group number 
//            array.
// Params   : groupNumber - matches the INPUTPROPERTY <group> value
//            nZone - zone which the list came from
// Return   : INTEGER - array position of the matching property
//*********************************************************************
DEFINE_FUNCTION INTEGER getGroupIndex(INTEGER groupNumber, INTEGER nZone)
{
    stack_var integer nLoop
    
    for (nLoop = 1; nLoop <= nGroupCount; nLoop++)
	{
		IF (InputGroups[nZone][nLoop] == groupNumber)
		{
			RETURN nLoop;
		}
	}
	
    RETURN 0;
}
//*********************************************************************
// Function : displayGroups
// Purpose  : Display each input in group order.
// Params   : nZone - zone which the list came from
// Return   : none
//*********************************************************************
DEFINE_FUNCTION displayGroups(INTEGER nZone)
{
	stack_var integer nCount
	stack_var integer nIndex
	
	send_command dvTP, "'^TXT-',itoa(TXT_SOURCE_INPUT),',0,',''"
	// Loop through the group list and show the first item in the input properties that matches the group
	for (nCount = 1; nCount <= MAX_INPUT_BUTTONS; nCount++)
	{
		if (nCount <= nGroupCount)
		{
			// Get the property index by group number
			nIndex = getPropertyIndexByGroup(InputGroups[nCurrentZone][nCount], nCurrentZone);
			if (nIndex > 0)
			{
				send_command dvTP, "'^TXT-',itoa(TXT_INPUT_SOURCE[nCount]),',0,',InputProps[nCurrentZone][nIndex].sDisplay"
				if( nCount <= nInputsUsed[nCurrentZone] )
				{
					send_command dvTP, "'^SHO-',itoa(TXT_INPUT_SOURCE[nCount]),',1'"
				} 
			}
		}
		else
		{
			send_command dvTP, "'^SHO-',itoa(TXT_INPUT_SOURCE[nCount]),',0'"
		}
	}
}


DEFINE_MUTUALLY_EXCLUSIVE
([dvTp,BTN_INPUT_SOURCE[1]]..[dvTp,BTN_INPUT_SOURCE[LENGTH_ARRAY(BTN_INPUT_SOURCE)]])


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'SourceSelectComponent'

initialize()


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


(***********************************************************)
(*             TOUCHPANEL EVENTS GO BELOW                  *)
(***********************************************************)
DATA_EVENT [dvTP]
{

    ONLINE:
    {
        stack_var integer nLoop
		
		bActiveComponent = FALSE
        nActiveDevice = 1
        nActivePage = 0
        nActiveDeviceID = nNavigationBtns[1]
        nActivePageID = 0
        nCurrentZone = 1
        bNoLevelReset = 0

		// reset all property values
		initialize()
		
		// query for new properties
		for (nLoop = 1; nLoop <= length_array(vdvDev); nLoop++)
		{
			SEND_COMMAND vdvDev[nLoop], '?INPUTPROPERTIES'
			SEND_COMMAND vdvDev[nLoop], '?INPUTSELECT'
		}

    }
    OFFLINE:
    {
        bNoLevelReset = 1
    }

}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for vdvDev
//                   SourceSelectComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the SourceSelectComponent.
//
// LOCAL VARIABLES:  cHeader     :  SNAPI command header
//                   cParameter  :  SNAPI command parameter
//                   nParameter  :  SNAPI command parameter value
//                   cCmd        :  received SNAPI command
//
//---------------------------------------------------------------------------------
DATA_EVENT[vdvDev]
{
    COMMAND :
    {
        // local variables
        STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
        STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
        STACK_VAR CHAR    cParameter[DUET_MAX_PARAM_LEN]
        STACK_VAR INTEGER nParameter
        STACK_VAR CHAR    cTrash[20]
        STACK_VAR INTEGER nZone
        
        nZone = getFeedbackZone(data.device)
        
        // get received SNAPI command
        cCmd = DATA.TEXT
        
        // parse command header
        cHeader = DuetParseCmdHeader(cCmd)
        SWITCH (cHeader)
        {
            
            //----------------------------------------------------------
            // CODE-BLOCK For SourceSelectComponent
            //
            // The following case statements are used in conjunction
            // with the SourceSelectComponent code-block.
            //----------------------------------------------------------
            

            // SNAPI::INPUTSELECT-<index>
            CASE 'INPUTSELECT' :
            {
				stack_var integer bFound
				stack_var integer nGroupIndex
				
				// get parameter value from SNAPI command and set feeback on user interface
				nParameter = ATOI(DuetParseCmdParam(cCmd))
				if (nZone == nCurrentZone)
				{
					OFF [dvTP,BTN_INPUT_SOURCE]
					IF (nParameter > 0 && nParameter <= MAX_INPUTS)
					{
						nGroupIndex = getGroupIndex(InputProps[nZone][nParameter].nGroup, nZone);
								
						bFound = findProperty(nParameter, nZone)
						if (bFound == TRUE)
						{
							ON[dvTP,BTN_INPUT_SOURCE[InputProps[nZone][nParameter].nGroup]]
							send_command dvTP, "'^TXT-',itoa(TXT_SOURCE_INPUT),',0,',InputProps[nZone][nParameter].sDisplay"
						}
					}
				}
			}
			// SNAPI::INPUTPROPERTIES-<index>,<inputGroup>,<deviceLabel>,<signalType>,<AVType>[;<index>,<inputGroup>,<deviceLabel>,<signalType>,<AVType>;...]
			CASE 'INPUTPROPERTIES' :
			{
				// get parameter value from SNAPI command and set feeback on user interface
				parseProperties(cCmd, nZone)
            }
			// SNAPI::INPUTCOUNT-<count>
			CASE 'INPUTCOUNT' :
			{
				nParameter = ATOI(DuetParseCmdParam(cCmd))
				if (nParameter == 0)
				{
					initialize();
				}
			}
			// SNAPI::INPUT-<sourceSelect>,<inputNumber>
			CASE 'INPUT' :
			{
				stack_var integer nIndex
				
				cParameter = DuetParseCmdParam(cCmd)
				nParameter = ATOI(DuetParseCmdParam(cCmd))
				
				if (nZone == nCurrentZone)
				{
//					nIndex = getPropertyIndex(nParameter, cParameter, nZone)
//					if (nIndex > 0)
//						send_command dvTP, "'^TXT-',itoa(TXT_SOURCE_INPUT),',0,',InputProps[nZone][nIndex].sDisplay"
				}
			}
            // SNAPI::DEBUG-<state>
            CASE 'DEBUG' :
            {
                // This will toggle debug printing
                nDbg = ATOI(DuetParseCmdParam(cCmd))
            }

        }
    }
}


//----------------------------------------------------------
// CHANNEL_EVENTs For SourceSelectComponent
//
// The following channel events are used in conjunction
// with the SourceSelectComponent code-block.
//----------------------------------------------------------

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   SourceSelectComponent: channel button - command
//                   on BTN_GET_INPUT_SELECT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the SourceSelectComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_INPUT_SELECT]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], '?INPUTSELECT'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?INPUTSELECT',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   SourceSelectComponent: momentary button - momentary channel
//                   on BTN_SOURCE_CYCLE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the SourceSelectComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_SOURCE_CYCLE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], SOURCE_CYCLE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(SOURCE_CYCLE),']'")
        }
    }
}

//----------------------------------------------------------
// EXTENDED EVENTS For SourceSelectComponent
//
// The following events are used in conjunction
// with the SourceSelectComponent code-block.
//----------------------------------------------------------



//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   SourceSelectComponent: channel range button - command
//                   on BTN_INPUT_SOURCE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_INPUT_SOURCE]
{
    push:
    {
        if (bActiveComponent)
		{
			stack_var integer btn
			stack_var integer index
			
			btn = get_last(BTN_INPUT_SOURCE)
			index = getPropertyIndexByGroup(InputGroups[nCurrentZone][btn], nCurrentZone);
			if (index > 0)
			{
				send_command vdvDev[nCurrentZone], "'INPUTSELECT-',itoa(index)"
				println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'INPUTSELECT-',itoa(index),39")
			}
		}
    }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

