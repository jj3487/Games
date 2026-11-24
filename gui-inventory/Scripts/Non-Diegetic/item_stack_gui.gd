extends Panel

class_name ItemStackGui

@onready var itemSprite: Sprite2D = $Item
@onready var itemLabel: Label = $Label

var originIndex: int = -1
var item: InventoryItem
var amount: int

func update()->void:
	if !item: return
	
	itemSprite.visible = true
	itemSprite.texture = item.texture
	
	if amount > 1:
		itemLabel.visible = true
		itemLabel.text = str(amount)
	else:
		itemLabel.visible = false
