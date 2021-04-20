#priority 2000
#loader contenttweaker

import mods.zenutils.cotx.Block;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.player.IFoodStats;
import crafttweaker.item.IItemStack;
import crafttweaker.block.IBlockState;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.MutableItemStack;

val altar as Block = VanillaFactory.createExpandBlock("altar", <blockmaterial:iron>);
altar.onBlockActivated = function(world, pos, state, player, hand, facing, blockHit) {
    if (!world.remote) {
        var ore as IOreDictEntry = null;
        var time as long = world.time % 24000;
        if (time > 5500 && time < 6500) {
            ore = <ore:ingotCopper>;
        }
        if (time > 17500 && time < 18500) {
            ore = <ore:ingotIron>;
        }
        if (!isNull(player.currentItem)) {
            // convert ingot or copper to gold
            val item as MutableItemStack = player.getHeldItem(hand);
            print(item.commandString);
            if (!isNull(item) && !isNull(ore) && ore.matches(item)) {
                val amount as int = world.getRandom().nextInt(8) + 1;
                val foodStats as IFoodStats = player.foodStats;
                if (foodStats.saturationLevel >= 2.0f) {
                    foodStats.saturationLevel -= 2.0f;
                } else if (foodStats.foodLevel >= 2) {
                    foodStats.foodLevel -= 2;
                } else return false;
                player.attackEntityFrom(<damageSource:MAGIC>, 2.0f);
                item.shrink(1);
                player.give(<ore:nuggetGold>.materialPart * amount);
                return true;
            }
            // convert some blocks via starlight storage
            // FIXME: could not work properly
            if (<item:hdsutils:tiny_starlight_storage:1>.matches(item)) {
                val state as IBlockState = world.getBlockState(pos.getOffset("up", 1));
                val blockItem as IItemStack = state.block.getItem(world, pos, state);
                print(blockItem.commandString);
                var blockToConvert as IBlockState = null;
                if (<item:contenttweaker:starlight_frame>.matches(blockItem)) {
                    blockToConvert = <item:contenttweaker:starlight_frame>.asBlock().definition.defaultState;
                } else if (<ore:oreGlass>.matches(blockItem)) {
                    blockToConvert = <item:astralsorcery:blockcustomore>.asBlock().definition.getStateFromMeta(1);
                }
                if (!isNull(blockToConvert)) {
                    player.setItemToSlot(hand, <item:hdsutils:tiny_starlight_storage>);
                    world.setBlockState(blockToConvert, pos.getOffset("up", 1));
                    player.attackEntityFrom(<damageSource:MAGIC>, 4.0f);
                    return true;
                }
            }
        }
        return false;
    } else {
        return true;
    }
};
altar.register();
