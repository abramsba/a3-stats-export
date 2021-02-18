
#include "json.sqf"
#include "stats.sqf"

fnc_server_start ={
	call stats_fnc_start_weather_report;
	call stats_fnc_report_meta;
	addMissionEventHandler ["EntityKilled", { _this call stats_fnc_report_killed; }];
	addMissionEventHandler ["EntityRespawned", { _this call stats_fnc_report_respawn; }];
	addMissionEventHandler ["HandleDisconnect", { _this call stats_fnc_report_disconnect; }];
	if(!isdedicated) then {
		call fnc_client_start;
	};
};

fnc_client_start ={
	[] spawn {
		waituntil { alive player };
		call stats_fnc_report_player_join;
	};
};

if(isserver) then {
	call fnc_server_start;
}
else {
	call fnc_client_start;
};