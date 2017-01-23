/*
    Epoch Enhanced Arma3 Inventory - Dynamic inventory (Double-Click) sub menu.

    Author: Aaron Clark - EpochMod.com

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Enhanced-Arma3-Inventory

    Example:
    _this call EPOCH_fnc_subMenu;

    Parameter(s):
		_this select 0: STRING - switch
        _this select 1: STRING - payload

	Returns:
	NUMBER
*/
//[[[cog import generate_private_arrays ]]]
private ["_activeControl","_bg","_btn_arr","_buffer","_button_gen","_cfgItemInteractions","_config","_control","_thisItem","_display","_interactActions","_interactedItem","_magCount","_missionconfig","_pos","_start_idc","_thisItemType","_y2d"];
//[[[end]]]

_interactActions = [];
_magCount = 1;
_thisItemType = 0;

// remove any previous array
_activeControl = uiNamespace getVariable ["EPOCH_active_button_control", controlNull];
if (!isNull _activeControl) then {
    _activeControl ctrlShow false;
    ctrlDelete _activeControl;
};

params ["_main_control","_idc"];

// find selected item
['selectItem',_main_control,_idc] call EPOCH_fnc_armorCalc;

_interactedItem = uiNamespace getVariable ["EPOCH_InteractedItem",[]];
if !(_interactedItem isEqualTo []) then {
    _thisItem = _interactedItem select 1;

    // load action configs
    _cfgItemInteractions = (configfile >> "CfgItemInteractions" >> _thisItem);
    _missionconfig = (missionConfigFile >> "CfgItemInteractions" >> _thisItem);
    if (isClass _missionconfig) then{
        _cfgItemInteractions = _missionconfig;
    };

    _config = (configfile >> "CfgWeapons" >> _thisItem);

    if (isClass (_config)) then {
        _thisItemType = getNumber(_config >> "type");
    } else {
        _config = (configfile >> "CfgMagazines" >> _thisItem);
        _thisItemType = getNumber(_config >> "type");
        _magCount = getNumber(_config >> "count");
    };

    _interactActions = getArray(_cfgItemInteractions >> "interactActions");

    // ammo repack
    if (_magCount > 1) then {
        _interactActions pushBack ["REPACK","call EPOCH_fnc_ammoRepack;"];
    };

    // build menu
    if !(_interactActions isEqualTo []) then {
        _display = ctrlParent (_main_control select 0);
        _pos = getMousePosition;

        _control = _display ctrlCreate ["RscControlsGroupNoScrollbars", 5678910];
        uiNamespace setVariable ["EPOCH_active_button_control", _control];

        _control ctrlSetPosition [(_pos select 0)-0.03,(_pos select 1)-0.03,1,1];
        _control ctrlCommit 0;

        _bg = _display ctrlCreate ["RscButtonTextOnly", 12349,_control];
        _bg ctrlSetPosition [0,0,1,1];
        _bg ctrlCommit 0;
        _bg ctrlAddEventHandler ["MouseEnter",{
            _activeControl = uiNamespace getVariable ["EPOCH_active_button_control", controlNull];
            if !(isNull _activeControl) then {
                _activeControl ctrlShow false;
            };
        }];

        _buffer = _display ctrlCreate ["RscButtonTextOnly", 12345,_control];
        _buffer ctrlSetPosition [0.02,0.02,0.25,0.0625 + (0.0625 * (count _interactActions))];
        _buffer ctrlAddEventHandler ["ButtonClick",{
            _activeControl = uiNamespace getVariable ["EPOCH_active_button_control", controlNull];
            if !(isNull _activeControl) then {
                _activeControl ctrlShow false;
            };
        }];

        _buffer ctrlCommit 0;

        _y2d = 0.06;
        _btn_arr = [];
        _start_idc = 12346;
        {
            _x params [["_btn_text",""],["_btn_code",""],["_btn_condition","true"],["_btn_mode",0],["_btn_fail_code",""]];
            _logicCheck  = !(call compile _btn_condition);
            // mode 0 = do not show button if condition is not met.
            // mode 1 = show button but execute alternate code when clicked.
            switch (_btn_mode) do {
                case 1: {
                    _button_gen = _display ctrlCreate ["RscButtonMenu", _start_idc,_control];
                    _start_idc = _start_idc + 1;
                    _button_gen ctrlSetPosition [0.06,_y2d,0.20,0.06];
                    _button_gen ctrlSetText _btn_text;
                    _button_gen ctrlCommit 0;
                    if (_logicCheck) then {
                        _button_gen ctrlAddEventHandler ["ButtonClick",format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_fail_code];
                    } else {
                        _button_gen ctrlAddEventHandler ["ButtonClick",format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_code];
                    };
                    _button_gen ctrlAddEventHandler ["ButtonClick","(uiNamespace getVariable ['EPOCH_active_button_control', controlNull]) ctrlShow false;"];
                    _y2d = _y2d + 0.0625;
                    _btn_arr pushBack _button_gen;
                };
                default {
                    if (_logicCheck) then {
                        _button_gen = _display ctrlCreate ["RscButtonMenu", _start_idc,_control];
                        _start_idc = _start_idc + 1;
                        _button_gen ctrlSetPosition [0.06,_y2d,0.20,0.06];
                        _button_gen ctrlSetText _btn_text;
                        _button_gen ctrlCommit 0;
                        _button_gen ctrlAddEventHandler ["ButtonClick",format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_code];
                        _button_gen ctrlAddEventHandler ["ButtonClick","(uiNamespace getVariable ['EPOCH_active_button_control', controlNull]) ctrlShow false;"];
                        _y2d = _y2d + 0.0625;
                        _btn_arr pushBack _button_gen;
                    };
                };
            };
        } forEach _interactActions;

        reverse _btn_arr;
        uiNamespace setVariable ["EPOCH_active_controls", ([_control,_bg,_buffer] + _btn_arr) ];
        {ctrlSetFocus _x} forEach (uiNamespace getVariable ["EPOCH_active_controls", []]);
    };
};
