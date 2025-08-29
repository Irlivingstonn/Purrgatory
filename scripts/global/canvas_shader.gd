# RadialVignette.gd  (Godot 4)

extends ColorRect


@export_range(0.0, 1.0, 0.01) var alpha: float = 1.0      : set = set_alpha
@export_range(0.0, 1.0, 0.01) var inner_radius: float = 0.0 : set = set_inner_radius
@export_range(0.0, 2.0, 0.01) var outer_radius: float = 1.0 : set = set_outer_radius

var _mat: ShaderMaterial

func _ready() -> void:
	# make sure it covers the screen and doesn’t block UI
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	var code := """
		shader_type canvas_item;

		uniform float alpha = 1.0;
		uniform float inner_radius = 0.0;
		uniform float outer_radius = 1.0;

		void fragment() {
			float x = UV.r - 0.5 * 2.0;
			float y = UV.r - 0.5 * 2.0;
			float q = 1.0 - (1.0 - sqrt(x * x + y * y) / outer_radius) / (1.0 - inner_radius);
			COLOR = vec4(0.0, 0.0, 0.0, q * alpha);
		}
	""";

	var shader := Shader.new()
	shader.code = code
	_mat = ShaderMaterial.new()
	_mat.shader = shader
	material = _mat

	_apply_all()

func _apply_all() -> void:
	if _mat == null: return
	_mat.set_shader_parameter("alpha", alpha)
	_mat.set_shader_parameter("inner_radius", inner_radius)
	_mat.set_shader_parameter("outer_radius", outer_radius)

# ---- setters so Inspector changes update live (no notifications needed)
func set_alpha(v: float) -> void:
	alpha = clamp(v, 0.0, 1.0)
	if _mat: _mat.set_shader_parameter("alpha", alpha)

func set_inner_radius(v: float) -> void:
	inner_radius = clamp(v, 0.0, 0.9999) # avoid division by zero
	if _mat: _mat.set_shader_parameter("inner_radius", inner_radius)

func set_outer_radius(v: float) -> void:
	outer_radius = max(v, 0.0001)
	if _mat: _mat.set_shader_parameter("outer_radius", outer_radius)
