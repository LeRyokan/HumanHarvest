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
	void main()
	{
		
		//if (mod(floor(${Shader.vTexCoord}.y * ${Shader.uObjectSize}.y), 2.0) == 0.0)
		//{
			//gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
		//}
		//else
		//{
			//gl_FragColor = texture2D(${Shader.uSampler},${Shader.vTexCoord});
		//}
		
		
		if (mod(${Shader.vTexCoord}.y, 2.0) == 0.0)
		{
			gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
		else
		{
			gl_FragColor = texture2D(${Shader.uSampler},${Shader.vTexCoord});
		}
	}
	';
	
	
	//@fragment var fragment = '
	//void main(void)
	//{
		//vec4 color = texture2D(${Shader.uSampler}, ${Shader.vTexCoord});
		////gl_FragColor = vec4(vec3(1.0, 1.0, 1.0) - color.rgb, color.a);
		//gl_FragColor = vec4((1.0 - color.r) * color.a, (1.0 - color.g) * color.a, (1.0 - color.b) * color.a, color.a);
	//}
	//';
	
	//if (mod(floor(vTexCoord.y * uResolution.y / scale), 2.0) == 0.0)
		//{
			//gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
		//}
		//else
		//{
			//gl_FragColor = texture2D(uImage0, vTexCoord);
		//}
	
	
	
	
	//
	//@fragment var fragment = '
	//void main()
	//{
		//vec4 color = texture2D(${Shader.uSampler}, ${Shader.vTexCoord});
		//gl_FragColor = vec4((1.0 - color.r) * color.a, (1.0 - color.g) * color.a, (1.0 - color.b) * color.a, color.a);
	//}
	//';
	//
	
	public function new()
	{
		super();
	}
}