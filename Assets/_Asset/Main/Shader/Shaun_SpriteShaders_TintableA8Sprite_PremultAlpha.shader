Shader "Shaun/SpriteShaders/TintableA8Sprite_PremultAlpha" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _DstMode ("DstMode", Float) = 10
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 4
		[Enum(Off,0,On,1)] _ZWrite ("ZWrite", Float) = 1
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