#var RAD2DEG = 57.3;

var fuel_dump = {
	init : func {
		me.UPDATE_INTERVAL = 0.1;
	me.loopid = 0;
	
	me.ice_time = 0;
	
	
	# Fuel Dump
	
	setprop("/services/fuel-dump/enable", 0);
	setprop("/services/fuel-dump/connect", 0);
	setprop("/services/fuel-dump/transfer", 0);
	setprop("/services/fuel-dump/clean", 0);
	setprop("/services/fuel-dump/request-lbs", 0);
	
	
	# Set to 0 if the aircraft is stationary
	
#	if (getprop("/velocities/groundspeed-kt") < 100) {
#		setprop("/services/fuel-dump/enable", 0);
#	}

	me.reset();
	},
	update : func {
	
	
		# Fuel Dump Controls
		

#		if ((getprop("services/fuel-dump/enable") == 1) and (getprop("services/fuel-dump/connect") == 1)) {
	
			
			
			if (getprop("/services/fuel-dump/clean")) {
			
				if (getprop("consumables/fuel/total-fuel-lbs") > 90) {
				
					setprop("/consumables/fuel/tank/level-lbs", getprop("/consumables/fuel/tank/level-lbs") - 80);
					setprop("/consumables/fuel/tank[1]/level-lbs", getprop("/consumables/fuel/tank[1]/level-lbs") - 80);
					setprop("/consumables/fuel/tank[2]/level-lbs", getprop("/consumables/fuel/tank[2]/level-lbs") - 80);
				
				} else {
					setprop("/services/fuel-dump/clean", 0);
					screen.log.write("Finished draining the fuel tanks...", 1, 1, 1);
				}	
			
			}
		


			
#		} else {	
#			setprop("/services/fuel-dump/transfer", 0);
#			setprop("/services/fuel-dump/clean", 0);


#		}
		

		
		
	me.ice_time += 1;
	
	},
	reset : func {
		me.loopid += 1;
		me._loop_(me.loopid);
	},
	_loop_ : func(id) {
		id == me.loopid or return;
		me.update();
		settimer(func { me._loop_(id); }, me.UPDATE_INTERVAL);
	}
};

#var toggle_parkingbrakes = func {
#
#	if (getprop("/controls/parking-brake") == 1)
#		setprop("/controls/parking-brake", 0);
#	else	
#		setprop("/controls/parking-brake", 1);	
#
#}

setlistener("sim/signals/fdm-initialized", func {
	fuel_dump.init();
	print("Dump Service ..... Initialized");
});
