extends Sprite

enum {DNA_A, DNA_T, DNA_G, DNA_C}

var resolution
var protein
var isLeft

func _ready():
	resolution = Vector2(get_viewport().size.x, get_viewport().size.y)
	

func init(nprotein, nisleft):
	if nprotein > DNA_C:
		print("Error, DNA index invalid for " + str(protein) )
		protein = 0
	
	protein = nprotein
	isLeft = nisleft
	
	match protein:
		DNA_A:
			name = "Adenine"
		DNA_T:
			name = "Thymine"
		DNA_G:
			name = "Guanine"
		DNA_C:
			name = "Cytosine"
		_:
			name = "PROTEIN_UNK"

	
	# set frame # to protein index
	set_frame(protein)
	
	# flip horizontal value if not on the left
	if !isLeft:
		flip_h = true	

func getSpeed():
	return get_node("/root/World").getSpeed()

func _physics_process(delta):
	
	position = Vector2(position.x, position.y + getSpeed())
	
	if position.y > resolution.y + 30:
		#get_parent().remove_child(self)
		queue_free()
		