extends Node

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/TabContainer/Items/GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.updated.connect(update)
	update()

func update() -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i], inventory.amounts[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
