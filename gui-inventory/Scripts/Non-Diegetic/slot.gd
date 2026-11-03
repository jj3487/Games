extends Panel

@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

func update(item: InventoryItem) -> void:
	if !item:
		itemSprite.visible = false
	else:
		itemSprite.visible = true
		itemSprite.texture = item.texture



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
