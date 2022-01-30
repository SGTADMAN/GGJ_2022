extends Node

var theme
var interface

func change_theme_colour(colour):
	#print(theme.get_theme_item_types(4))
	#print(theme.get_type_list("test"))
	theme.set_color("default_color","RichTextLabel", colour)#Color(1.0,1.0,1.0))
	Theme
