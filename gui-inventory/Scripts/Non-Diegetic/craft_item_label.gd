extends Node

@onready var craftSlots = $"../NinePatchRect/TabContainer/Crafting/VBoxContainer/Crafted/GridContainer2".get_children()
@onready var recipeBook: RecipeBook = preload("res://Inventory/Crafting/recipe_book.tres")
var tooltip: PanelContainer
var tooltipTitle: Label
var tooltipBody: Label

func createTooltip() -> void:
	tooltip = PanelContainer.new()
	var style = StyleBoxFlat.new()
	style.bg_color = Color("96683e")
	style.border_color = Color("42281c")
	style.set_border_width_all(2)
	style.set_content_margin_all(8)
	tooltip.add_theme_stylebox_override("panel", style)

	var box = VBoxContainer.new()
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tooltipTitle = Label.new()
	tooltipTitle.add_theme_font_size_override("font_size", 12)
	tooltipTitle.add_theme_color_override("font_color", Color("ecd2a0"))
	tooltipBody = Label.new()
	tooltipBody.add_theme_font_size_override("font_size", 10)
	tooltipBody.add_theme_color_override("font_color", Color("ecd2a0"))
	box.add_child(tooltipTitle)
	box.add_child(tooltipBody)
	tooltip.add_child(box)

	tooltip.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tooltip.z_index = 100
	tooltip.visible = false
	add_child(tooltip)

func connectCraftHover() -> void:
	for i in range(craftSlots.size()):
		craftSlots[i].mouse_entered.connect(showRecipeTooltip.bind(i))
		craftSlots[i].mouse_exited.connect(hideRecipeTooltip)

func showRecipeTooltip(index: int) -> void:
	if index >= recipeBook.recipes.size():
		return
	var recipe: Recipe = recipeBook.recipes[index]
	tooltipTitle.text = str(recipe.result.name) + " x" + str(recipe.result_amount)
	var text = ""
	for i in range(recipe.ingredients.size()):
		text += str(recipe.ingredients[i].name) + " x" + str(recipe.ingredient_amounts[i]) + "\n"
	tooltipBody.text = text.strip_edges()
	tooltip.reset_size()
	tooltip.visible = true
	tooltip.global_position = get_viewport().get_mouse_position() + Vector2(12, 12)

func hideRecipeTooltip() -> void:
	tooltip.visible = false
