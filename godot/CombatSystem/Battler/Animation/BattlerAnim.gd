# Hold and plays the base animation for battlers.
class_name BattlerAnim
extends Position2D

signal animation_finished(name)
# Emitted by animations when a combat action should apply its next effect, like dealing damage or healing an ally.
signal triggered

var _position_start := Vector2.ZERO

onready var anim_player: AnimationPlayer = $Pivot/AnimationPlayer
onready var tween: Tween = $Tween
onready var anchor: Position2D = $FrontAnchor


func _ready() -> void:
	_position_start = position


func play(anim_name: String) -> void:
	anim_player.play(anim_name)
	anim_player.seek(0.0)


func queue_animation(anim_name: String) -> void:
	anim_player.queue(anim_name)


func get_anchor_global_position() -> Vector2:
	return anchor.global_position


func move_forward() -> void:
	tween.interpolate_property(
		self,
		"position",
		position,
		position + Vector2.LEFT * scale.x * 40.0,
		0.3,
		Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	tween.start()


func move_back() -> void:
	tween.interpolate_property(
		self,
		"position",
		position,
		_position_start,
		0.3,
		Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	tween.start()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("animation_finished", anim_name)
