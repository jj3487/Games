extends Node

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/TabContainer/Items/GridContainer.get_children()
@onready var ItemStackGuiClass= preload("res://Scenes/Non-Diegetic/item_stack_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connectSlots()
	inventory.updated.connect(update)
	update()

func connectSlots() -> void:
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update() -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		var item = inventory.items[i]
		var amount = inventory.amounts[i]
		
		if !item: continue
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui: 
			itemStackGui =ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		itemStackGui.item = item
		itemStackGui.amount = amount
		itemStackGui.update()
		
		#slots[i].update(inventory.items[i], inventory.amounts[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onSlotClicked(slot) -> void:
	pass
