Shader "Shaun/SimpleShaders/GradColorGradOpac" {
	Properties {
		_ColorTop ("Top Color", Vector) = (1,1,1,1)
		_ColorBottom ("Bottom Color", Vector) = (1,1,1,1)
		_GradOpac ("Gradient Opacity", Vector) = (1,1,1,1)
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _DstMode ("DstMode", Float) = 10
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