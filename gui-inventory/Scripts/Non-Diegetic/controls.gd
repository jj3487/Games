extends Node2D

signal damaged(hp: int)
signal heal(hp: int)
signal add(item: InventoryItem, amount: int)
signal delete(item: InventoryItem, amount: int)
var selected_item: InventoryItem
var amount: int

const WHEAT: InventoryItem = preload("res://Inventory/Items/wheat.tres")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_item = WHEAT
	amount = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_damage_pressed() -> void:
	damaged.emit(10)

func _on_button_heal_pressed() -> void:
	heal.emit(20)

func _on_item_selected(index: int) -> void:
	match index:
		0:
			selected_item = WHEAT
			
			
			

func _on_item_count_changed(value: float) -> void:
	amount = int(value)


func _on_button_add_pressed() -> void:
	add.emit(selected_item, amount)
	print("add: " ,selected_item.name , amount)
	pass # Replace with function body.
	


func _on_button_delete_pressed() -> void:
	delete.emit(selected_item, amount)
	print("delete: " ,selected_item.name , amount)
	pass # Replace with function body.
