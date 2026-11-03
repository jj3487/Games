extends Resource
class_name Inventory

const MAX_SLOTS: int = 12
@export var free_slot_count: int = 12
@export var items: Array[InventoryItem]
#@export var amounts: Array[int]
signal updated

func add_item(item: InventoryItem, amount: int) -> void:
	# your add logic here
	if free_slot_count < amount:
		amount = free_slot_count
	for i in items.size():
		for j in amount:
			if items[i] == null:
				items[i] = item
	updated.emit()

func delete_item(item: InventoryItem, amount: int) -> void:
	# your delete logic here
	if MAX_SLOTS < amount:
		amount = MAX_SLOTS
	for i in amount:
		if items[i] == item:
			items[i] = null
	
	updated.emit()
