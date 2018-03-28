shader_type canvas_item;
render_mode unshaded;

uniform sampler2D displace : hint_albedo;
uniform float dispAmtX : hint_range(0,0.1);
uniform float dispAmtY : hint_range(0,0.1);
uniform float abberationAmt : hint_range(0,0.1);
uniform float dispSize : hint_range(0.1,2.0);

void fragment()
{
	// displace effect
	vec4 disp = texture(displace, SCREEN_UV * dispSize);
	vec2 newUV;
	//vec2 newUV = SCREEN_UV + disp.x * dispAmtX;
	newUV.x = SCREEN_UV.x + disp.x * dispAmtX;
	newUV.y = SCREEN_UV.y + disp.y * dispAmtY;

	COLOR.r = texture(SCREEN_TEXTURE, newUV - dispAmtX*0.5).r;
	COLOR.g = texture(SCREEN_TEXTURE, newUV).g;
	COLOR.b = texture(SCREEN_TEXTURE, newUV).b;
	COLOR.a = texture(SCREEN_TEXTURE, newUV).a;
}