Shader "Shaun/3dObjShaders/BannerShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,0)
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,0)
		_ShaderVec4 ("Wave pos, freq, power", Vector) = (0,10,1,1)
		_YShiftAndEndYShift ("Y shift due to Z, Y shift at end", Vector) = (0.3,0.9,0,0)
		_ShaderVec4Alt ("Foldiness, end X contract, billow", Vector) = (1.5,2.1,0.35,0)
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