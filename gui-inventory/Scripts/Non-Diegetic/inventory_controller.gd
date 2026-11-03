extends Node


@export var inventory: Inventory
@onready var controls: Node2D = $"../Controls"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controls.add.connect(_on_item_added)
	controls.delete.connect(_on_item_deleted)
	pass # Replace with function body.

func _on_item_added(item: InventoryItem, amount:int) -> void:
	print("added")
	inventory.add_item(item, amount)
	pass

func _on_item_deleted(item: InventoryItem, amount:int) -> void:
	print("deleted")
	inventory.delete_item(item, amount)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
