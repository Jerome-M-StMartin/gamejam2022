extends Node2D

func on_body_entered(body):
	if body.name == "Pidgeon":
		if body.have_bottle:
			var story = .get_parent().get_node("Story")
			story.next_message()
			body.have_bottle = false
			body.bottle = null
			body.get_node("BottleSprite").visible = false
