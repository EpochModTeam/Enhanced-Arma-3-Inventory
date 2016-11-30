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
		dir = "@epoch_enhanced_a3_inventory";
		name = "Epoch Enhanced Arma 3 Inventory";
		picture = "\epoch_enhanced_a3_inventory\epoch_ca.paa";
		hidePicture = 0;
		hideName = 0;
		action = "http://www.epochmod.com";
		version = "1.0";
		ArmAVersion = 158;
		overview = "Enhanced Inventory for Arma 3";
	};
};

//
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

// example custom sub menu config
/*
class CfgItemInteractions {
    class ItemMap
    {
        interactActions[] = {
            {"Open Map","showMap true;"}
        };
    };
    class ItemRadio
    {
        interactActions[] = {
            {"Open Radio","showRadio true;"}
        };
    };
    class ItemCompass
    {
        interactActions[] = {
            {"Open Compass","showCompass true;"}
        };
    };
    class ItemGPS
    {
        interactActions[] = {
            {"Open GPS","showGPS true;"}
        };
    };
    class ItemWatch
    {
        interactActions[] = {
            {"Open Watch","showWatch true;"},
            {"Open Notebook","showPad true;"}
        };
    };
};
*/
