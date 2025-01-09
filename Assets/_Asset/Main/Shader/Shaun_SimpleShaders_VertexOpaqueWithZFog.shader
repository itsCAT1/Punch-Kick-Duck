Shader "Shaun/SimpleShaders/VertexOpaqueWithZFog" {
	Properties {
		_ZDarkCol ("Fog Color", Vector) = (0,0,0,1)
		_ZDarkStart ("Fog start z", Float) = 0
		_ZDarkRange ("Fog range", Float) = 10
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