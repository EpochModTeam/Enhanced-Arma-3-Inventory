/*
    Epoch Enhanced Arma3 Inventory - Init

    Author: Aaron Clark - EpochMod.com

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Enhanced-Arma3-Inventory
*/
player addEventHandler ["InventoryOpened", {
    ["init",_this] spawn EPOCH_fnc_armorCalc;
}];
player addEventHandler ["Put",{
    ["refresh"] call EPOCH_fnc_armorCalc;
}];
player addEventHandler ["Take",{
    ["refresh"] call EPOCH_fnc_armorCalc;
}];
