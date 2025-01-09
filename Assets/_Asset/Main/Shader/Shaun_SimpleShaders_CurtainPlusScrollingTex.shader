Shader "Shaun/SimpleShaders/CurtainPlusScrollingTex" {
	Properties {
		[NoScaleOffset] _PatternTex ("Pattern Tex", 2D) = "white" {}
		_TexScale ("Pattern scale", Vector) = (0.0017,0.0025,0,0)
		_PatternCol ("Pattern col", Vector) = (1,1,1,1)
		_ColorTop ("Top Color", Vector) = (1,1,1,1)
		_ColorBottom ("Bottom Color", Vector) = (1,1,1,1)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = 1;
		}
		ENDCG
	}
}