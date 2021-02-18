
stats_fnc_unit ={
	private _unit_player        = isplayer _this;
	private _unit_asl_position  = getposasl _this;
	private _unit_atl_position  = getposatl _this;
	private _unit_eye_direction = eyedirection _this;
	private _unit_aim_direction = _this weapondirection (currentweapon _this);
	private _unit_uuid = "";
	if(_unit_player) then { _unit_uuid = getplayeruid _this; } else { _unit_uuid = _this call BIS_fnc_netId; };
	private _ret = [
		_unit_uuid,
		name _this,
		_unit_player,
		side (group _this),
		stance _this,
		[_unit_asl_position select 0, _unit_asl_position select 1] call json_fnc_vector2,
		_unit_asl_position select 2,
		_unit_atl_position select 2,
		_unit_eye_direction call json_fnc_vector3,
		_unit_aim_direction call json_fnc_vector3
	] call json_fnc_unit;
	_ret
};

stats_fnc_vehicle ={
	private _asl = getposasl _this;
	private _atl = getposatl _this;
	private _dir = getdir _this;
	private _class = typeof _this;
	_netid = _this call bis_fnc_netid;
	private _ret = [
		_netid,
		_class,
		[_asl select 0, _asl select 1] call json_fnc_vector2,
		_asl select 2,
		_atl select 2,
		_dir
	] call json_fnc_vehicle;
	_ret
};

stats_fnc_config_check ={
    params["_cfg", "_class", "_parent"];
    _configParents = [(configFile >> _cfg >> _class), true] call BIS_fnc_returnParents;
    _parent in _configParents
};

stats_fnc_report_fired ={
	params[
		"_unit",
		"_weapon",
		"_muzzle",
		"_mode",
		"_ammo",
		"_magazine",
		"_projectile",
		"_vehicle"
	];
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};

	// If grenade, report thrown
	if(["CfgMagazines", _magazine, "HandGrenade"] call stats_fnc_config_check) exitwith {
		_this call stats_fnc_report_thrown;
	};
	if(["CfgWeapons", _weapon, "Launcher_Base_F"] call stats_fnc_config_check) exitwith {
		_this call stats_fnc_report_launch;
	};

	private _unit_json = _unit call stats_fnc_unit;
	private _fired_json = [
		_unit_json,
		(str _projectile),
		_weapon,
		_magazine,
		_muzzle,
		(typeof _projectile),
		_mode,
		winddir,
		windstr
	] call json_fnc_fired;
	private _message_json = [
		servertime,
		_fired_json
	] call json_fnc_message;
	_message = format["fired %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_fired_vehicle ={
	params[
		"_unit",
		"_weapon",
		"_muzzle",
		"_mode",
		"_ammo",
		"_magazine",
		"_projectile",
		"_vehicle"
	];
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};
	private _unit_json = _unit call stats_fnc_unit;
	private _vehicle_json = (vehicle _unit) call stats_fnc_vehicle;
	private _fired_json = [
		_unit_json,
		_vehicle_json,
		(str _projectile),
		_weapon,
		_magazine,
		_muzzle,
		(typeof _projectile),
		_mode,
		winddir,
		windstr
	] call json_fnc_fired_vehicle;
	private _message_json = [
		servertime,
		_fired_json
	] call json_fnc_message;
	_message = format["vehicle_fired %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_launch ={
	params[
		"_unit",
		"_weapon",
		"_muzzle",
		"_mode",
		"_ammo",
		"_magazine",
		"_projectile",
		"_vehicle"
	];
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};
	private _unit_json = _unit call stats_fnc_unit;
	private _fired_json = [
		_unit_json,
		(str _projectile),
		_weapon,
		_magazine,
		_muzzle,
		(typeof _projectile),
		_mode,
		winddir,
		windstr
	] call json_fnc_launched;
	private _message_json = [
		servertime,
		_fired_json
	] call json_fnc_message;
	_message = format["launched %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_thrown ={
	params[
		"_unit",
		"_weapon",
		"_muzzle",
		"_mode",
		"_ammo",
		"_magazine",
		"_projectile",
		"_vehicle"
	];	
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};
	private _unit_json = _unit call stats_fnc_unit;
	private _thrown_json = [
		_unit_json,
		(str _projectile),
		(typeof _projectile),
		winddir,
		windstr
	] call json_fnc_thrown;
	private _message_json = [
		servertime,
		_thrown_json
	] call json_fnc_message;
	_message = format["thrown %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_hitpart ={
	params[
		"_target",
		"_shooter",
		"_bullet",
		"_impact",
		"_velocity",
		"_selection",
		"_ammo",
		"_direction",
		"_radius",
		"_surface",
		"_direct"
	];
	// If server and player shot, let player forward teh messages
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};

	if(!alive _target) exitwith {};
	private _target_json = _target call stats_fnc_unit;
	private _hitpart_json = [
		_target_json,
		(str _bullet),
		[_impact select 0, _impact select 1] call json_fnc_vector2,
		_impact select 2,
		_velocity call json_fnc_vector3,
		_direct call json_fnc_boolean,
		(_selection select 0)
	] call json_fnc_hitpart;

	private _message_json = [
		servertime,
		_hitpart_json
	] call json_fnc_message;
	_message = format["hitpart %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_explosion ={
	params[
		"_target",
		"_shooter",
		"_bullet",
		"_impact",
		"_velocity",
		"_selection",
		"_ammo",
		"_direction",
		"_radius",
		"_surface",
		"_direct"
	];
	if(isserver && (isplayer _unit && isdedicated)) exitwith {};
	if(!alive _target) exitwith {};
	private _target_json = _target call stats_fnc_unit;
	private _owner_json = _shooter call stats_fnc_unit;
	private _hitpart_json = [
		_target_json,
		_owner_json,
		_bullet,
		[_impact select 0, _impact select 1] call json_fnc_vector2,
		_impact select 2,
		(_selection select 0)
	] call json_fnc_explosion;
	private _message_json = [
		servertime,
		_hitpart_json
	] call json_fnc_message;
	_message = format["explosion %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_vehicle_hitpart ={
	params[
		"_target",
		"_shooter",
		"_bullet",
		"_impact",
		"_velocity",
		"_selection",
		"_ammo",
		"_direction",
		"_radius",
		"_surface",
		"_direct"
	];
	if(!alive _target) exitwith {};
	private _vehicle_json = _target call stats_fnc_vehicle;
	private _hitpart_json = [
		_vehicle_json,
		(str _bullet),
		[_impact select 0, _impact select 1] call json_fnc_vector2,
		_impact select 2,
		_velocity call json_fnc_vector3,
		_direct call json_fnc_boolean,
		(_selection select 0)
	] call json_fnc_hitpart;
	private _message_json = [
		servertime,
		_hitpart_json
	] call json_fnc_message;
	_message = format["hitpart %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_vehicle_explosion ={
	params[
		"_target",
		"_shooter",
		"_bullet",
		"_impact",
		"_velocity",
		"_selection",
		"_ammo",
		"_direction",
		"_radius",
		"_surface",
		"_direct"
	];
	if(!alive _target) exitwith {};
	private _target_json = _target call stats_fnc_vehicle;
	private _owner_json = _shooter call stats_fnc_unit;
	private _hitpart_json = [
		_target_json,
		_owner_json,
		_bullet,
		[_impact select 0, _impact select 1] call json_fnc_vector2,
		_impact select 2,
		(_selection select 0)
	] call json_fnc_explosion;
	private _message_json = [
		servertime,
		_hitpart_json
	] call json_fnc_message;
	_message = format["explosion %1", _message_json];
	if(isserver) then { diag_log _message; } else { _message remoteexec ["diag_log", 2]; };
};

stats_fnc_report_getin ={
	params[
		"_unit",
		"_position",
		"_vehicle",
		"_turret"
	];
	private _unit_j = _unit call stats_fnc_unit;
	private _vehicle_j = _vehicle call stats_fnc_vehicle;
	private _vu_j = [_unit_j, _vehicle_j] call json_fnc_vehicleget;
	private _message_json = [
		servertime,
		_vu_j
	] call json_fnc_message;
	diag_log format["getin %1", _message_json];
};

stats_fnc_report_getout ={
	params[
		"_unit",
		"_position",
		"_vehicle",
		"_turret"
	];
	private _unit_j = _unit call stats_fnc_unit;
	private _vehicle_j = _vehicle call stats_fnc_vehicle;
	private _vu_j = [_unit_j, _vehicle_j] call json_fnc_vehicleget;
	private _message_json = [
		servertime,
		_vu_j
	] call json_fnc_message;
	diag_log format["getout %1", _message_json];
};

stats_fnc_start_weather_report ={
	[] spawn {
		while{true} do {
			call stats_fnc_report_weather;
			sleep 15;
		};
	};
};

stats_fnc_report_meta ={
	private _meta_json = [
	 missionname, 
	 worldname, 
	 format["%1.%2.%3|%4.%5",
      date select 0,
      date select 1,
      date select 2,
      date select 3,
      date select 4
	 ]
	] call json_fnc_meta;
	private _message_json = [
		servertime,
		_meta_json
	] call json_fnc_message;
	diag_log format["meta %1", _message_json];
};

stats_fnc_report_weather ={
	private _fog       = fog;
	private _lightning = lightnings;
	private _overcast  = overcast;
	private _waves     = waves;
	private _rain      = rain;	
	private _weather_json = [
		_fog,
		_rain,
		_overcast,
		_lightning,
		_waves
	] call json_fnc_weather;
	private _message_json = [
		servertime,
		_weather_json
	] call json_fnc_message;
	diag_log format["weather %1", _message_json];
};

stats_fnc_report_killed ={
	params["_killed", "_killer", "_instigator"];
	if(["CfgVehicles", (typeof _killed), "CAManBase"] call stats_fnc_config_check) exitwith {
		private _killed_j = _killed call stats_fnc_unit;
		private _message_json = [
			servertime,
			_killed_j
		] call json_fnc_message;
		diag_log format["killed %1", _message_json];	
	};
	if(["CfgVehicles", (typeof _killed), "LandVehicle"] call stats_fnc_config_check) then {
		private _killed_j = _killed call stats_fnc_vehicle;
		private _message_json = [
			servertime,
			_killed_j
		] call json_fnc_message;
		diag_log format["killed %1", _message_json];	
	};
};

stats_fnc_report_player_join ={
    if(isserver && !isdedicated) then {
    	player call stats_fnc_report_player_join_server;
    }
	else { 
    	player remoteexec ["stats_fnc_report_player_join_server", 2];
    };
};

stats_fnc_report_player_join_server ={
	private _player_j = _this call stats_fnc_unit;
	private _message_json = [
		servertime,
		_player_j
	] call json_fnc_message;
	diag_log format["joined %1", _message_json];
};

stats_fnc_report_respawn = {
	params["_new", "_old"];
	private _player_j = _new call stats_fnc_unit;
	private _message_json = [
		servertime,
		_player_j
	] call json_fnc_message;
	diag_log format["respawn %1", _message_json];
};

stats_fnc_report_disconnect = {
	params["_unit", "_id", "_uid", "_name"];
	private _player_j = _unit call stats_fnc_unit;
	private _message_json = [
		servertime,
		_player_j
	] call json_fnc_message;
	diag_log format["disconnect %1", _message_json];
};

stats_event_man_hitpart ={

	_is_explosion = false;
	_expl_id = [32, "epl:"] call f_random_string;
	{
		_x params["_target", "_shooter", "_bullet", "_impact", "_velocity", "_selection", "_ammo", "_direction", "_radius", "_surface", "_direct"];
		if(isnull _bullet) then {
			_x set [2, _expl_id];
			_is_explosion = true; 
		};
	} foreach _this;

	if(!_is_explosion) then {
		{
			_x call stats_fnc_report_hitpart;
		} foreach _this;
	}
	else {
		{
			_x call stats_fnc_report_explosion;
		} foreach _this;
	};
};

stats_event_vehicle_hitpart ={

	_is_explosion = false;
	_expl_id = [32, "epl:"] call f_random_string;
	{
		_x params["_target", "_shooter", "_bullet", "_impact", "_velocity", "_selection", "_ammo", "_direction", "_radius", "_surface", "_direct"];
		if(isnull _bullet) then {
			_x set [2, _expl_id];
			_is_explosion = true; 
		};
	} foreach _this;

	if(!_is_explosion) then {
		{
			_x call stats_fnc_report_vehicle_hitpart;
		} foreach _this;
	}
	else {
		{
			_x call stats_fnc_report_vehicle_explosion;
		} foreach _this;
	};
};


