extends Resource
class_name Inventory

const MAX_SLOTS: int = 12
const MAX_STACK: int = 20
@export var items: Array[InventoryItem]
@export var amounts: Array[int]
signal updated

func add_item(item: InventoryItem, amount: int) -> void:
	if item == null or amount <= 0:
		return
	amount = check_stack(item, amount)
	for i in items.size():
		if amount == 0:
			break
		if items[i] == null:
			var moved := mini(MAX_STACK, amount)
			items[i] = item
			amounts[i] = moved
			amount -= moved
	updated.emit()

func check_stack(item: InventoryItem, amount: int) -> int:
	for i in items.size():
		if amount == 0:
			break
		if items[i] == item and amounts[i] < MAX_STACK:
			var moved := mini(MAX_STACK - amounts[i], amount)
			amounts[i] += moved
			amount -= moved
	return amount


func delete_item(item: InventoryItem, amount: int) -> void:
	if item == null or amount <= 0:
		return
	var left := amount
	for i in range(MAX_SLOTS - 1, -1, -1):
		if left == 0:
			break
		if items[i] == item:
			var taken := mini(amounts[i], left)
			amounts[i] -= taken
			left -= taken
			if amounts[i] == 0:
				items[i] = null
	updated.emit()
