extends Button

@onready var backgroundSprite: AnimatedSprite2D = $Background
@onready var container: CenterContainer = $CenterContainer
var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui) -> void:
	itemStackGui = isg
	backgroundSprite.play("filled")
	container.add_child(itemStackGui)

func takeItem() -> ItemStackGui:
	var item = itemStackGui
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroundSprite.play("default")
	return item

func isEmpty():
	return !itemStackGui
