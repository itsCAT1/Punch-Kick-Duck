Shader "Shaun/SpriteShaders/UI_TimerBorder" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_GradCol ("Grad Additive Col", Vector) = (0,0,0,0)
		_GradientStart ("Zero gradient Y point", Float) = 0
		_GradientEnd ("Full gradient Y point", Float) = 2
		_TimerValue ("0-1 Timer Value", Float) = 1
		_Color ("Secondary Color", Vector) = (1,0,0,1)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}