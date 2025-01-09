Shader "Shaun/3dObjShaders/NoTex/3DObj+Grad_VCols_NoTex" {
	Properties {
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_Gradient1Start ("Grad1 zero strength Y point", Float) = 0
		_Gradient1End ("Grad1 full strength Y point", Float) = 0
		_GradientLightCut ("Grad Light Cut", Float) = 1
		_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
		_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
		_Gradient1SubColor ("Grad1 additive color", Vector) = (0,0,0,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_ShadowSub ("Shadow Additive Color", Vector) = (0,0,0,1)
		_BackLightLimitForFrontFaces ("Backlight limit on front faces", Float) = 0
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
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