extends Panel

@onready var backgroundSprite: AnimatedSprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item
@onready var itemLabel: Label = $CenterContainer/Panel/Label

func update(item: InventoryItem, amount: int) -> void:
	if !item:
		itemSprite.visible = false
		backgroundSprite.play("default")
		itemLabel.text = ""
	else:
		itemSprite.visible = true
		itemSprite.texture = item.texture
		itemLabel.text = str(amount)
		backgroundSprite.play("filled")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
