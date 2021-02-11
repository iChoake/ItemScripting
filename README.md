# Item Scripting

Item Scripting is an [Elder Scrolls Online](https://www.elderscrollsonline.com) addon that enables you to script and automate many inventory management tasks: **mark items as junk, destroy items, move items in and out of your bank, and more**. Unlike similar addons, Item Scripting gives you complete control by letting you write your own code. Item Scripting provides an easy to use API for clean and readable scripts.

## Examples

As you pick up items in the game, you can mark them as junk based on criteria of your choosing. This code will mark potions and poisons that are not crafted or in a quick slot as junk:

```lua
if Item:IsType('Potion','Poison')
and not Item:IsCrafted()
and not Item:IsQuickslotted()
then return Item:Junk() end
```

You can also automate the transfer of items in and out of your bank. This code goes through every item in your inventory and transfers any crafting material item to your bank:

```lua
for Item in Backpack:Items() do

  if Item:IsFilterType('Materials')
  then Item:Transfer() end

end
```

## Getting Started

1. Install *Item Scripting* using [Minion](https://minion.mmoui.com), or manually download and place the `ItemScripting` folder in `Documents/Elder Scrolls Online/live/Addons`.

2. Open `Documents/Elder Scrolls Online/live/Addons/ItemScripting/Script.lua` in your favourite text editor. `Script.lua` is where all your custom code will reside.

3. Look at the [Wiki](https://github.com/m7andrew/ItemScripting/wiki) for documentation, and [Example.lua](https://github.com/m7andrew/ItemScripting/blob/main/Example.lua) for an example script.

4. Use the in-game chat commands `/reloadui` to load changes you make to `Script.lua` and `/filterall` to reevaluate every item in your inventory.

5. Backup your `Script.lua` file to a safe location. Updating with Minion will overwrite this file so keep a copy to save your changes between updates.