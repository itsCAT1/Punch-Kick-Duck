Shader "Shaun/CharShaders/CharShader_NoAlpha" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		[NoScaleOffset] _NormalMapTex ("Normal Map Tex", 2D) = "white" {}
		_DiffuseBaseCol ("Diffuse Material Color", Vector) = (1,1,1,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
		_BackLightLimiter ("Back Light Limiter", Float) = 0
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