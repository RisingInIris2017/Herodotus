#packmode normal
#priority -1

import mods.prodigytech.atomicreshaper;
import scripts.hds_main.utils.modloader.isInvalid;

if (!isInvalid){

atomicreshaper.removeAll();

atomicreshaper.addRecipe(<minecraft:cauldron>, <botania:altar>, 200);
atomicreshaper.addRecipe(<contenttweaker:raw_iron_block>, <ore:dustTinyIron>.materialPart * 64, 30, 750);
}