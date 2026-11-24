extends Button

@onready var backgroundSprite: AnimatedSprite2D = $Background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Inventory/player_inventory.tres")
var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui) -> void:
	itemStackGui = isg
	backgroundSprite.play("filled")
	container.add_child(itemStackGui)
	if !itemStackGui.item:
		return
	inventory.insertItem(index,itemStackGui.originIndex , itemStackGui.item, itemStackGui.amount)
	itemStackGui.originIndex = index

func takeItem() -> ItemStackGui:
	if !itemStackGui:
		return null
	var item = itemStackGui
	item.originIndex = index
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroundSprite.play("default")
	return item

func isEmpty():
	return !itemStackGui
