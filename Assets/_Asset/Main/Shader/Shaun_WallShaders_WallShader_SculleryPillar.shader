Shader "Shaun/WallShaders/WallShader_SculleryPillar" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		[NoScaleOffset] _ShadTex ("Shadow Tex", 2D) = "white" {}
		_DiffuseBaseTint ("Diffuse base tint", Vector) = (1,1,1,0)
		_LightCol ("Light color", Vector) = (0,0,0,0)
		_LightPos ("Light position", Vector) = (0,0,0,0)
		_BGradStart ("Bott Grad start", Float) = 0
		_BGradEnd ("Bott Grad end", Float) = 2
		_BGradCol ("Bott Grad color", Vector) = (0,0,0,0)
		_TGradStart ("Top Grad start", Float) = 0
		_TGradEnd ("Top Grad end", Float) = 2
		_TGradCol ("Top Grad color", Vector) = (0,0,0,0)
		_ShadPosAndScale ("Shad pos + scale", Vector) = (0.5,0.5,0,0)
		_ShadPower ("Shad strength", Float) = 1
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