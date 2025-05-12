extends Node

@onready var label: Label = %Label

var collected = false

func collect_point():
	collected = true
	print(collected)
