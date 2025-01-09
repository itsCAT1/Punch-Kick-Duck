Shader "Shaun/3dObjShaders/SurfaceAO" {
	Properties {
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_AOColor ("AO Color (Alpha = strength)", Vector) = (0,0,0,1)
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