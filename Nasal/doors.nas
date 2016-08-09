## Bombardier C series
## Nasal door system
###########################

var Door =
{
	new: func(name, transit_time)
	{
		return aircraft.door.new("sim/model/door-positions/" ~ name, transit_time);
	}
};
var doors =
{
	pax_left: Door.new("pax-left", 3),
	pax_right: Door.new("pax-right", 3),
	rear_left: Door.new("rear-left", 3),
	rear_right: Door.new("rear-right", 3),
	flight_deck: Door.new("flight-deck", 1),
	cargo: Door.new("cargo", 2),
	cargoR: Door.new("cargoR", 2)
};
