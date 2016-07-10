###############################################################################
##
##  Nasal for CSeries - main
##
###############################################################################

############################################
# Global loop function
# If you need to run nasal as loop, add it in this function
############################################
global_system = func{

#function for APU knob
if(getprop("/engines/apu/running")){
setprop("/controls/APU/knob", getprop("/controls/APU/off-on") );
setprop("/controls/APU/knob2", 0);
}else{
setprop("/controls/APU/knob2", getprop("/controls/APU/off-on"));
setprop("/controls/APU/knob", 0);
};
#set bleed automatically
#if(getprop("/controls/electric/engine/generator")){
#setprop("/controls/pneumatic/bleed-air", 1);
#}else if(getprop("/controls/electric/APU-generator")){
#setprop("/controls/pneumatic/bleed-air", 2);
#}else if(getprop("/controls/electric/engine[1]/generator")){
#setprop("/controls/pneumatic/bleed-air", 3);
#}
#external power
if(getprop("/controls/ext-avail") == 1){
setprop("/controls/ext-run", getprop("/controls/electric/external-power"));
}else{
setprop("/controls/ext-run", 0);
}



  settimer(global_system, 0);

}



##########################################
# SetListerner must be at the end of this file
##########################################
var nasalInit = setlistener("/sim/signals/fdm-initialized", func{

  settimer(global_system, 2);
 # settimer(tyresmoke, 2);
  removelistener(nasalInit);
});
