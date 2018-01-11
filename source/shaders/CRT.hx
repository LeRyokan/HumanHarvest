package shaders;

import openfl.display.Shader;
//import openfl.display.Shader.GLShaderPrecision;

/**
 * ...
 * @author ElRyoGrande
 */
class CRT extends Shader 
{
	

	
	@fragment var fragment = '
	
	uniform float time; 
	
	float grad = 0.12;
	float timeScale = 10;
	//float moduloOffset = 7;
	float moduloOffset = 8;
	float fragCoordOffset = 0.5;
	
	void main()
	{
	
		if (mod(gl_FragCoord.y + fragCoordOffset + moduloOffset + (time * timeScale), 9) <= 4.0)
		{
			vec4 yolo = texture2D(${Shader.uSampler}, ${Shader.vTexCoord});
			if (yolo.a != 0.0)
			{
				gl_FragColor = vec4(yolo.r-grad,yolo.g-grad,yolo.b-grad, 1.0);
			}
			else
			{
				gl_FragColor = texture2D(${Shader.uSampler},${Shader.vTexCoord});
			}
		}
		else
		{
			gl_FragColor = texture2D(${Shader.uSampler},${Shader.vTexCoord});
		}
	}
	';
	
	
	
	
	public function new()
	{
		super();
	}
}