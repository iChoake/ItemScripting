local Require, Export = LibAddon('ItemScripting')

-----------------------------------------------------------
--                   EXAMPLE SCRIPT       
-----------------------------------------------------------

Export('Pickup', function (Item)

  -- Junk Treasure, Trash, Raw Traits
  if Item:IsType(56, 48, 68)
  then return Item:Junk() end

  -- Destroy Style, Armor/Weapon Traits
  if Item:IsType(17, 44, 45, 46)
  then return Item:Destroy() end

  -- Destroy Unused Crown Consumables
  if Item:IsType(7, 30, 4, 12)
  and Item:IsBound()
  and not Item:IsQuickslotted()
  then return Item:Destroy() end

  -- Junk Unused Potions, Posions & Food
  if Item:IsType(7, 30, 4, 12)
  and not Item:IsQuickslotted()
  then return Item:Junk() end

  -- Junk Trash Glyphs
  if Item:IsType(20, 21, 26)
  and not Item:IsCrafted()
  and Item:Quality() < 5
  then return Item:Junk() end

  -- Junk Collected Gear & Gear With No Set
  if Item:IsType(1, 2) 
  and (Item:IsCollected() or not Item:HasSet())
  and Item:Quality() < 5
  then return Item:Junk() end

  -- Junk Extra Materials
  if Item:IsFilterType(4)
  and Item:Quality() < 5
  and Item:InBank() >= Item:MaxStack()
  then return Item:Junk() end

  -- Junk Extra Lockpicks
  if Item:IsName('Lockpick')
  and Item:InBackpack() >= Item:MaxStack()
  and Item:Stack() < Item:MaxStack()
  then return Item:Junk() end

  -- Junk Lower Level Crafting Materials
  if Item:IsType(37, 38, 35, 36, 39, 40, 51)
  and Item:CraftRank() < 10
  then return Item:Junk() end

  -- Junk Lower Level Alchemy Materials
  if Item:IsType(33, 58)
  and Item:CraftRank() < 8 
  then return Item:Junk() end

  -- Junk Lower Level Jewelry Materials
  if Item:IsType(64)
  and Item:CraftRank() < 5
  then return Item:Junk() end

  -- Junk Lower Level Raw Jewelry Materials
  if Item:IsType(63)
  and Item:ID() ~= 135145
  then return Item:Junk() end

  -- Junk Lower Quality Upgrade Materials
  if Item:IsType(42, 41, 43, 65, 67, 52)
  and Item:Quality() < 4
  then return Item:Junk() end

  -- Junk Basic Known Recipes
  if Item:IsType(29)
  and Item:IsKnown() 
  and Item:Quality() < 4
  then return Item:Junk() end

end)

Export('Banking', function (Bank, Backpack)

  for Item in Backpack:Items() do

    -- Bank Materials
    if Item:IsFilterType(4)
    then Item:TransferFill() end

    -- Bank Fish Bait
    if Item:IsType(16)
    then Item:Transfer() end

    -- Bank Extra Soul Gems
    if Item:IsType(19)
    and Item:MaxStack() < Item:InBackpack()
    and Item:MaxStack() > Item:Stack()
    then Item:Transfer() end

  end

  for Item in Bank:Items() do

    -- Fill Soul Gem Stacks From Bank
    if Item:IsType(19)
    then Item:TransferFill() end

  end

end)