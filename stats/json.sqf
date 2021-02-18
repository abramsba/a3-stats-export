
json_fnc_vector3 = {
	params["_x", "_y", "_z"];
	format["{""x"":%1,""y"":%2,""z"":%3}", _x, _y, _z]	
};

json_fnc_vector2 = {
	params["_x", "_y"];
	format["{""x"": %1,""y"": %2}", _x, _y]	
};

json_fnc_message = {
	params["_game_timestamp", ["_data","{}"]];
	format["{""game_timestamp"":%1,""data"":%2}", _game_timestamp, _data]	
};

json_fnc_boolean ={
	if(_this) then { "true" } else { "false" };
};

json_fnc_unit = {
	params[
		"_unit_uuid",
		"_name",
		"_player",
		"_faction",
		"_stance",
		"_position",
		"_asl",
		"_atl",
		"_eye",
		"_aim"
	];
	format["{""man"":{""unit_uuid"": ""%1"",""name"":""%2"",""player"":%3,""faction"":""%4"",""stance"":""%5"",""position"":%6,""asl"":%7,""atl"":%8,""eye"":%9,""aim"":%10}}",
		_unit_uuid,
		_name,
		_player,
		_faction,
		_stance,
		_position,
		_asl,
		_atl,
		_eye,
		_aim
	]
};

json_fnc_vehicle = {
	params[
		"_vehicle_uuid",
		"_vehicle_class",
		"_position",
		"_asl",
		"_atl",
		"_direction"
	];
	format["{""vehicle"":{""vehicle_uuid"":""%1"",""vehicle_class"":""%2"",""position"":%3,""asl"":%4,""atl"":%5,""direction"":%6}}",
		_vehicle_uuid,
		_vehicle_class,
		_position,
		_asl,
		_atl,
		_direction
	];
};

json_fnc_fired = {
	params[
		"_unit",
		"_bullet_uuid",
		"_weapon_class",
		"_magazine_class",
		"_muzzle_class",
		"_bullet_class",
		"_mode",
		"_wind_dir",
		"_wind_str"
	];	
	format["{""unit"":%1,""bullet_uuid"":""%2"",""weapon_class"":""%3"",""magazine_class"":""%4"",""muzzle_class"":""%5"",""bullet_class"":""%6"",""mode"":""%7"",""wind"":{""dir"":%8,""str"":%9}}",
		_unit,
		_bullet_uuid,
		_weapon_class,
		_magazine_class,
		_muzzle_class,
		_bullet_class,
		_mode,
		_wind_dir,
		_wind_str
	]
};

json_fnc_fired_vehicle = {
	params[
		"_unit",
		"_vehicle",
		"_bullet_uuid",
		"_weapon_class",
		"_magazine_class",
		"_muzzle_class",
		"_bullet_class",
		"_mode",
		"_wind_dir",
		"_wind_str"
	];	
	format["{""unit"":%1,""bullet_uuid"":""%2"",""weapon_class"":""%3"",""magazine_class"":""%4"",""muzzle_class"":""%5"",""bullet_class"":""%6"",""mode"":""%7"",""wind"":{""dir"":%8,""str"":%9},""vehicle"":%10}",
		_unit,
		_bullet_uuid,
		_weapon_class,
		_magazine_class,
		_muzzle_class,
		_bullet_class,
		_mode,
		_wind_dir,
		_wind_str,
		_vehicle
	]
};

json_fnc_launched = {
	params[
		"_unit",
		"_bullet_uuid",
		"_weapon_class",
		"_magazine_class",
		"_muzzle_class",
		"_bullet_class",
		"_mode",
		"_wind_dir",
		"_wind_str"
	];	
	format["{""unit"":%1,""rocket_uuid"":""%2"",""weapon_class"":""%3"",""magazine_class"":""%4"",""muzzle_class"":""%5"",""bullet_class"":""%6"",""mode"":""%7"",""wind"":{""dir"":%8,""str"":%9}}",
		_unit,
		_bullet_uuid,
		_weapon_class,
		_magazine_class,
		_muzzle_class,
		_bullet_class,
		_mode,
		_wind_dir,
		_wind_str
	]
};

json_fnc_thrown = {
	params[
		"_unit",
		"_object_uuid",
		"_object_class",
		"_wind_dir",
		"_wind_str"
	];
	format["{""unit"":%1,""object_uuid"":""%2"",""object_class"":""%3"",""wind"":{""dir"":%4,""str"":%5}}",
		_unit,
		_object_uuid,
		_object_class,
		_wind_dir,
		_wind_str
	]
};

json_fnc_hitpart = {
	params[
		"_target",
		"_bullet_uuid",
		"_impact",
		"_impact_asl",
		"_velocity",
		"_direct",
		"_limb"
	];	
	format["{""target"":%1,""bullet_uuid"":""%2"",""impact"":%3,""impact_asl"":%4,""velocity"":%5,""direct"":%6,""limb"":""%7""}",
		_target,
		_bullet_uuid,
		_impact,
		_impact_asl,
		_velocity,
		_direct,
		_limb
	]
};

json_fnc_explosion = {
	params[
		"_target",
		"_owner",
		"_bullet_uuid",
		"_impact",
		"_impact_asl",
		"_limb"
	];	
	format["{""target"":%1,""explosion_uuid"":""%2"",""impact"":%3,""impact_asl"":%4,""owner"":%5,""limb"":""%6""}",
		_target,
		_bullet_uuid,
		_impact,
		_impact_asl,
		_owner,
		_limb
	]
};

json_fnc_vehicleget = {
	params[
		"_unit",
		"_vehicle"
	];
	format["{""unit"":%1,""vehicle"":%2}",
		_unit,
		_vehicle
	]
};

json_fnc_weather = {
	params[
		"_fog",
		"_rain",
		"_overcast",
		"_lightning",
		"_waves"
	];
	format["{""fog"":%1,""rain"":%2,""overcast"":%3,""lightning"":%4,""waves"":%5}",
		_fog,
		_rain,
		_overcast,
		_lightning,
		_waves
	]
};

json_fnc_meta = {
	params[
		"_mission_name",
		"_mission_map",
		"_start_timestamp"
	];
	format["{""mission_name"":""%1"",""mission_map"":""%2"",""mission_start"":""%3""}",
		_mission_name,
		_mission_map,
		_start_timestamp
	]
};
