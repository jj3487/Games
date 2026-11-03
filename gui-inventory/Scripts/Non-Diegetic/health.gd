extends TextureProgressBar

@onready var controls: Node = get_tree().get_first_node_in_group("controls")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controls.heal.connect(on_heal)
	controls.damaged.connect(on_damaged)
	value = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func on_heal(hp: int) -> void:
	value += hp

func on_damaged(hp: int) -> void:
	value -= hp
