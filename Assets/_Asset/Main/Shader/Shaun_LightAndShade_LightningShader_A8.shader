Shader "Shaun/LightAndShade/LightningShader_A8" {
	Properties {
		[NoScaleOffset] _MainTex ("Tex", 2D) = "white" {}
		_Color ("Bolt Col", Vector) = (1,0,0,1)
		_UVySpeedAndOffs ("uvY scroll speed & offset", Vector) = (10,0,0,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}