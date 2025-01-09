Shader "Shaun/WallShaders/WallShader_BakedLight_AmbShadOnly" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		[NoScaleOffset] _ShadTex ("Shadow Tex", 2D) = "white" {}
		_DiffuseBaseTint ("Diffuse base tint", Vector) = (1,1,1,0)
		_AmbPosAndScale ("Amb pos + scale", Vector) = (0.5,0.5,0,0)
		_AmbCol ("Amb color", Vector) = (0,0,0,0)
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