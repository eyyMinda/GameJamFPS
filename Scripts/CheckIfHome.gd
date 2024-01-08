extends Node
@onready var CharacterBody = $"../CharacterBody3D"
var PlayerinBase = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if !PlayerinBase and CharacterBody.position.x>-6:
		PlayerinBase=true
		get_tree().call_group("Timer", "PlayerisHomeUpdate", PlayerinBase)
	elif PlayerinBase and CharacterBody.position.x<-6:
		PlayerinBase=false
		get_tree().call_group("Timer", "PlayerisHomeUpdate", PlayerinBase)
	pass
