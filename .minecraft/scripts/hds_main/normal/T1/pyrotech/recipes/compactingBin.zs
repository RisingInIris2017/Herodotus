#packmode normal
#priority -1

import mods.pyrotech.CompactingBin;
import scripts.hds_main.utils.modloader.isInvalid;

if(!isInvalid){

CompactingBin.addRecipe("coal_block", <minecraft:coal_block>, <minecraft:coal>, 9);
CompactingBin.addRecipe("iron_slag", <pyrotech:generated_pile_slag_iron>, <ore:oreCentrifugedIron>, 9);
}