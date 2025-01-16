extends CanvasLayer

@onready var player = get_node("/root/Game/player")

func _ready() -> void:
	if player:
		player.connect("score_changed", Callable(self, "_on_score_changed"))
		update_score()

func _on_score_changed(new_score: int) -> void:
	$scoreNumber.text = str(new_score)

func update_score() -> void:
	if player:
		$scoreNumber.text = str(player.player_score)
