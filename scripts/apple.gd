extends Area2D

func _on_area_entered(area):
	queue_free()
	GlobalSignals.apple_eaten.emit()
