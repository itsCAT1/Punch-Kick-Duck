Shader "FT/Emission" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_Texture ("Texture", 2D) = "black" {}
		_Emission ("Emission", Float) = 1
		[MaterialToggle] _Use_SoftPaticle ("Use_SoftPaticle", Float) = 1
		_SoftParticle_Value ("SoftParticle_Value", Range(0, 1)) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	Fallback "Diffuse"
	//CustomEditor "ShaderForgeMaterialInspector"
}