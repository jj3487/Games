extends Button

@onready var backgroundSprite: AnimatedSprite2D = $Background
@onready var container: CenterContainer = $CenterContainer
var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui) -> void:
	itemStackGui = isg
	backgroundSprite.play("filled")
	container.add_child(itemStackGui)

#func update(item: InventoryItem, amount: int) -> void:
	#if !item:
		#itemSprite.visible = false
		#backgroundSprite.play("default")
		#itemLabel.text = ""
	#else:
		#itemSprite.visible = true
		#itemSprite.texture = item.texture
		#itemLabel.text = str(amount)
		#backgroundSprite.play("filled")
