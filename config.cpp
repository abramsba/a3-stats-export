
class cfgpatches {
	class a3stats {
		units[] = {
		};
		weapons[] = {
		};
		requiredversion = 1.72;
		requiredaddons[] = { "A3_Modules_F" };
		author = "_bryan";
		authorurl = "";
	};
};

class Extended_GetInMan_Eventhandlers {
  class CAManBase {
    class GetInMan_eh {
      GetInMan = "_this call stats_fnc_report_getin;";
    };
  };
};

class Extended_GetOutMan_Eventhandlers {
  class CAManBase {
    class GetOutMan_eh {
      GetOutMan = "_this call stats_fnc_report_getout";
    };
  };
};

class Extended_FiredBIS_Eventhandlers {
  class CAManBase {
  	class FiredBIS_eh {
  	  FiredBIS = "_this call stats_fnc_report_fired";
    };
  };
  class LandVehicle {
    class FiredBIS_eh {
      FiredBIS = "_this call stats_fnc_report_fired_vehicle";
    };
  };  
};

class Extended_Hitpart_EventHandlers {
  class CAManBase {
    class Hitpart_eh {
      Hitpart = "_this call stats_event_man_hitpart;";
    };
  };
  class LandVehicle {
    class Hitpart_eh {
      Hitpart = "_this call stats_event_vehicle_hitpart;";
    };
  };   
};
