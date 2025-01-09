Shader "Shaun/3dObjShaders/FishShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		_Radians_Speed_Curve ("Rads, speed, & curve", Vector) = (0,0,0,1)
		_UVOffset ("UV Offset", Vector) = (0,0,0,1)
		_AFloatVal ("Near Z Limit", Float) = -5.5
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_GradientStart ("Gradient start", Float) = 0
		_GradientEnd ("Gradient end", Float) = 2
		_GradientLightCut ("Grad Light Cut", Float) = 1
		_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
		_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
		_GradientSpecCut ("Grad Specular Cut", Float) = 1
		_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_SpecCol ("Specular Color", Vector) = (0,0,0,1)
		_Shininess ("Shininess", Float) = 0
		_SpecPower ("Specular Brightness", Float) = 1
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
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