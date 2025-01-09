Shader "Shaun/SpriteShaders/UI_BevelledSprites" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_MainLightCol ("Light Tint", Vector) = (1,1,1,1)
		_ShadowSub ("Shadow Tint", Vector) = (0,0,0,0)
		_Color ("Grad Additive Col", Vector) = (0,0,0,0)
		_GradientStart ("Zero gradient Y point", Float) = 0
		_GradientEnd ("Full gradient Y point", Float) = 2
		_EdgeDarken ("Darken towards screen edges strength", Float) = 3
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