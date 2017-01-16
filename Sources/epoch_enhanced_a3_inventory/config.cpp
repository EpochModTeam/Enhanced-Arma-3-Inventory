/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Epoch Enhanced Armor Stats for Arma 3

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Enhanced-Arma3-Inventory
*/
class CfgPatches {
	class A3_epoch_enhanced_a3_inventory {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Ui_F"};
	};
};

class CfgMods
{
	class epoch_enhanced_a3_inventory
	{
		dir = "@EEA3I";
		name = "Epoch Enhanced Arma 3 Inventory";
		picture = "\epoch_enhanced_a3_inventory\epoch_ca.paa";
		hidePicture = 0;
		hideName = 0;
		action = "http://www.epochmod.com";
		version = "1.1";
		ArmAVersion = 166;
		overview = "Enhanced Inventory for Arma 3";
	};
};

// custom UI stuff for armor stats
class RscProgress;
class RscCustomProgress : RscProgress
{
	texture = "";
	textureExt = "";
	colorBar[] = { 0.9, 0.9, 0.9, 0.9 };
	colorExtBar[] = { 1, 1, 1, 1 };
	colorFrame[] = { 1, 1, 1, 1 };
	x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	y = "16 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	colorBackground[] = { 1, 1, 1, 0.75 };
};
class RscTotalArmorProgress : RscProgress
{
    texture = "";
    textureExt = "";
    colorBar[] = { 0.9, 0.9, 0.9, 0.9 };
    colorExtBar[] = { 1, 1, 1, 1 };
    colorFrame[] = { 1, 1, 1, 1 };
    x = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
    y = "22.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    w = "11 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
    h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

// code
class CfgFunctions {
	class epoch_enhanced_a3_inventory {
		tag = "EPOCH";
		project = "epoch";
		class GUI
		{
			file = "epoch_enhanced_a3_inventory\scripts";
			class armorCalc{};
            class subMenu{};
            class ammoRepack{};
            class armorInit
            {
                postInit = 1;
            };
		};
	};
};

/* example custom sub menu config
 The condition and button action code have the following special variables available.
     _thisItem = contains the classname of the item
     _thisItemType = contains the type numbers:
          type=256 magazine
          type=801 uniform
          etc.

 interactActions Format:
     0 = Text Name of Action
     1 = Code to execute when button is pressed.
     2 = (optional) Condition evaluates string as code, code needs to return a BOOL.
class CfgItemInteractions {
    class ItemMap
    {
        interactActions[] = {
            {"Open Map","hintSilent 'Testing: Open Map Action';"}
        };
    };
    class ItemRadio
    {
        interactActions[] = {
            {"Open Radio","hintSilent 'Testing: Open Radio Action';"}
        };
    };
    class ItemCompass
    {
        interactActions[] = {
            {"Open Compass","hintSilent 'Testing: Open Compass Action';"}
        };
    };
    class ItemGPS
    {
        interactActions[] = {
            {"Open GPS","hintSilent 'Testing: Open GPS Action';"}
        };
    };
    class ItemWatch
    {
        interactActions[] = {
            {"Open Watch","hintSilent 'Testing: Open Watch Action';"},
            {"Open Notebook","hintSilent 'Testing: Open Notebook Action';"}
        };
    };
};
