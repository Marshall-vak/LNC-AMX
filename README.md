# LNC-AMX
 
Warning The following code was made by a self-taught dingus that bought really expensive distribution equipment on eBay for really cheap
If you have any questions feel free to ask!

The core of this system is an amx dvx with rs232 port 1 plugged into an amx dgx 16 it is set up like this so even if there are network issues it will work unlike m2m (master to master)
In this case we are really treating the amx dgx 16 as an expansion of the amx dgx all-in-one controller

The dvx has its dxlink outputs plugged into the inputs of the dgx as the dvx can generate logos
The DGX handles audio and video distribution for the displays around the building.
There are two wireless mics wired into the amx dvx as well as the secondary output of the xair (soundboard)
audio output 2 and 3 of the dvx are wired into the input of the xair (soundboard) so they can have dedicated mic sliders insite
audio output 4 of the dvx is wired into an amp that powers speakers outside
relay 1 of the dvx handles the inside audio amp power 
relay 2 of the dvx handles the outside audio amp power
the primary output of the xair (soundboard) is wired directly into the inside audio amps
Every tv and input gets a dxlink box that is wired into the amx dgx
The output side audio card of the amx dgx is set to extract on all channels that have things connected and has their outputs wired into the xair (soundboard)
There is a Razzberry Pi connected to hdmi 1 of the amx dgx that runs there generic video loop

I will include a photo of the rack setup at some point
