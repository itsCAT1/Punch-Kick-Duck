Shader "Shaun/3dObjShaders/NoTex/3DObj+Grad+FragSpec+VAO_NoTex" {
	Properties {
		_BaseCol ("Base Color", Vector) = (1,1,1,1)
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_Gradient1Start ("Grad1 zero strength Y point", Float) = 0
		_Gradient1End ("Grad1 full strength Y point", Float) = 0
		_GradientLightCut ("Grad Light Cut", Float) = 1
		_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
		_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
		_GradientSpecCut ("Grad Specular Cut", Float) = 1
		_Gradient1SubColor ("Grad1 additive color", Vector) = (0,0,0,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_SpecCol ("Specular Color", Vector) = (0,0,0,1)
		_Shininess ("Shininess", Float) = 0
		_SpecPower ("Specular Brightness", Float) = 1
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
		_RimAmount ("Rim light encroachment", Float) = 0.65
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