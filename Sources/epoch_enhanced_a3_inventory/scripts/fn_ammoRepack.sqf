/*
	Epoch Enhanced Arma3 Inventory - Simple Ammo repack

    Author: Aaron Clark - EpochMod.com

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Enhanced-Arma3-Inventory

    Example:
    call EPOCH_fnc_ammoRepack;
*/
//[[[cog import generate_private_arrays ]]]
private ["_interactedItem","_item","_magazineSize","_magazineSizeMax","_magazinesAmmoFull"];
//[[[end]]]
_item = "";
_interactedItem = uiNamespace getVariable ["EPOCH_InteractedItem",[]];
if !(_interactedItem isEqualTo []) then {
    _item = _interactedItem select 1;
};
_magazineSizeMax = getNumber (configfile >> "CfgMagazines" >> _item >> "count");
// allow repack for all magazines with greater than 1 bullet
if (_magazineSizeMax > 1) then {
    _magazineSize = 0;
    _magazinesAmmoFull = magazinesAmmoFull player;
    {
        if (_item isEqualTo (_x select 0)) then {
            if (!(_x select 2)) then {
                _magazineSize = _magazineSize + (_x select 1);
            };
        };
    } forEach _magazinesAmmoFull;

    // remove all
    player removeMagazines _item;

    // Add full magazines back to player
    for "_i" from 1 to floor (_magazineSize / _magazineSizeMax) do
    {
        player addMagazine [_item, _magazineSizeMax];
    };
    // Add last non full magazine
    if ((_magazineSize % _magazineSizeMax) > 0) then {
        player addMagazine [_item, floor (_magazineSize % _magazineSizeMax)];
    };
    hint "Ammo Repacked";
};
