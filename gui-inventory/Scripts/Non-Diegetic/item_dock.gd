extends GridContainer

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://Scenes/Non-Diegetic/item_stack_gui.tscn")
@onready var slots: Array = get_children()

func _ready() -> void:
	inventory.updated.connect(update)
	update()

func update() -> void:
	for i in range(slots.size()):
		var slot = slots[i]
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
