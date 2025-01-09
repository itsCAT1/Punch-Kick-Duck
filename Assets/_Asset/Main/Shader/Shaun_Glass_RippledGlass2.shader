Shader "Shaun/Glass/RippledGlass2" {
	Properties {
		_BGTex ("BG1 Texture", 2D) = "white" {}
		_NoiseTex ("Ripple Texture", 2D) = "white" {}
		_BGDistStr ("BG distortion strenght", Float) = 1
		_LeadLinesTex ("Lead tex", 2D) = "white" {}
		_GlassColTex ("Glass Colors", 2D) = "white" {}
		_GlassColPower ("Overall additional glass col", Float) = 0
		_GlassColFromDist ("Additional glass col due to distortion", Float) = 1
		_YOffsetDueToWorldX ("Y offset due to world X", Float) = 0
		_BGTexXOffset ("BG tex x offset", Float) = 0
		_WorldColTintFromDist ("Dist driven world col multi", Float) = 1
		_LeadlinesBrightness ("Leadlines brightness", Float) = 0
		_SkyCol ("Sky Color", Vector) = (1,1,1,1)
		_BGTint ("BG tint multi", Vector) = (1,1,1,1)
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