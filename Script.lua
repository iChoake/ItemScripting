local Require, Export = Addon('ItemScripting')

-----------------------------------------------------------
--       KEEP A COPY OF THIS FILE TO SAVE YOUR CODE       
-----------------------------------------------------------

Export('Pickup', function (Item)

  if Item:IsType('Trash') 
  then return Item:Junk() end

  if Item:IsType('Poison','Potion') 
  and not Item:IsCrafted() 
  and not Item:IsQuickslotted()
  then return Item:Junk() end

end)

Export('Banking', function (Bank, Backpack)

  for Item in Backpack:Items() do

    if Item:IsName('Soul Gem','Lockpick')
    and Item:MaxStack() > Item:Stack()
    and Item:MaxStack() < Item:InBackpack()
    then Item:Transfer() end

    if Item:IsFilterType('Materials')
    then Item:Transfer() end

  end

  for Item in Bank:Items() do

    if Item:IsName('Soul Gem','Lockpick') 
    then Item:TransferFill() end

  end

end)