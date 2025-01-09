Shader "Shaun/Unlit/UISpotlight" {
	Properties {
		_ColorTop ("Inner Color", Vector) = (1,1,1,1)
		_ColorBottom ("Outer Color", Vector) = (0.5,0.5,0.5,1)
		_Pos_Size_Soft ("Pos, Size, Softness", Vector) = (0.5,0.5,0.5,5)
		_SrcMode ("SrcMode", Float) = 0
		_DstMode ("DstMode", Float) = 0
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