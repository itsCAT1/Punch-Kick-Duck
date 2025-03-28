Shader "Shaun/3dObjShaders/CoinShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Normal Map Tex", 2D) = "white" {}
		_SurfCol ("Coin Color", Vector) = (1,1,1,1)
		_DiffuseBaseCol ("Diffuse Material Color", Vector) = (1,1,1,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_EmbossStr ("Emboss strength", Float) = 1
		_SpecCol ("Specular Color", Vector) = (0,0,0,1)
		_Shininess ("Shininess", Float) = 0
		_SpecPower ("Specular Brightness", Float) = 1
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