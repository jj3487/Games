extends Control

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/TabContainer/Items/GridContainer.get_children()
@onready var ItemStackGuiClass= preload("res://Scenes/Non-Diegetic/item_stack_gui.tscn")

var itemInHand: ItemStackGui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connectSlots()
	connectItemSlots()
	connectCraftSlots()
	inventory.updated.connect(update)
	update()

func connectSlots() -> void:
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update() -> void:
	refreshSlots(slots)
	refreshSlots(itemSlots)
	updateCraftSlots()

func refreshSlots(slotArray: Array) -> void:
	for i in range(slotArray.size()):
		var slot = slotArray[i]
		var item = inventory.items[i] if i < inventory.items.size() else null

		if !item:
			if slot.itemStackGui:
				slot.takeItem().queue_free()
			continue

		var gui: ItemStackGui = slot.itemStackGui
		if !gui:
			gui = ItemStackGuiClass.instantiate()
			slot.insert(gui)
		gui.item = item
		gui.amount = inventory.amounts[i]
		gui.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onSlotClicked(slot) -> void:
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
	if !itemInHand:
		takeItemFromSlot(slot)
	if slot.itemStackGui and slot.itemStackGui.item == itemInHand.item:
		stackItemInSlot(slot)

func stackItemInSlot(slot) -> void:
	var total = slot.itemStackGui.amount + itemInHand.amount
	if total > inventory.MAX_STACK:
		return
	inventory.insertItem(slot.index, itemInHand.originIndex, itemInHand.item, itemInHand.amount)
	itemInHand.queue_free()
	itemInHand = null

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)

func updateItemInHand() -> void:
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2

func _input(event) -> void:
	updateItemInHand()
	
##Crafting part

@onready var itemSlots: Array = $NinePatchRect/TabContainer/Crafting/VBoxContainer/Items/GridContainer.get_children()
@onready var craftSlots: Array = $NinePatchRect/TabContainer/Crafting/VBoxContainer/Crafted/GridContainer2.get_children()
@onready var recipeBook: RecipeBook = preload("res://Inventory/Crafting/recipe_book.tres")

func connectCraftSlots() -> void:
	for i in range(craftSlots.size()):
		var slot = craftSlots[i]
		slot.pressed.connect(craftRecipe.bind(i))

func connectItemSlots() -> void:
	for i in range(itemSlots.size()):
		var slot = itemSlots[i]
		slot.index = i
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func updateCraftSlots() -> void:
	for i in range(craftSlots.size()):
		var slot = craftSlots[i]
		if i >= recipeBook.recipes.size():
			continue
		var recipe: Recipe = recipeBook.recipes[i]

		var gui: ItemStackGui = slot.itemStackGui
		if !gui:
			gui = ItemStackGuiClass.instantiate()
			slot.insert(gui)
		gui.item = recipe.result
		gui.amount = recipe.result_amount
		gui.update()
		# grey out when you can't craft it
		gui.modulate = Color.WHITE if canCraft(recipe) else Color(1, 1, 1, 0.4)

func countItem(item) -> int:
	var total = 0
	for i in range(inventory.items.size()):
		if inventory.items[i] == item:
			total += inventory.amounts[i]
	return total

func canCraft(recipe: Recipe) -> bool:
	for i in range(recipe.ingredients.size()):
		if countItem(recipe.ingredients[i]) < recipe.ingredient_amounts[i]:
			return false
	return true

func removeItems(item, amount: int) -> void:
	for i in range(inventory.items.size()):
		if inventory.items[i] != item:
			continue
		var take = min(amount, inventory.amounts[i])
		inventory.amounts[i] -= take
		amount -= take
		if inventory.amounts[i] <= 0:
			inventory.items[i] = null
			inventory.amounts[i] = 0
		if amount <= 0:
			return

func addItems(item, amount: int) -> void:
	# fill existing stacks first
	for i in range(inventory.items.size()):
		if amount <= 0: return
		if inventory.items[i] == item:
			var add = min(amount, inventory.MAX_STACK - inventory.amounts[i])
			inventory.amounts[i] += add
			amount -= add
	# then use empty slots
	for i in range(inventory.items.size()):
		if amount <= 0: return
		if !inventory.items[i]:
			var add = min(amount, inventory.MAX_STACK)
			inventory.items[i] = item
			inventory.amounts[i] = add
			amount -= add

func craftRecipe(index: int) -> void:
	if index >= recipeBook.recipes.size():
		return
	var recipe: Recipe = recipeBook.recipes[index]
	if !canCraft(recipe):
		return
	for i in range(recipe.ingredients.size()):
		removeItems(recipe.ingredients[i], recipe.ingredient_amounts[i])
	addItems(recipe.result, recipe.result_amount)
	inventory.updated.emit()
