Shader "Shaun/3dObjShaders/NoTex/3DObjGrad+2BLpos+VAO_NoTex" {
	Properties {
		_ObjectCol ("Object base Color", Vector) = (1,1,1,1)
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_GradientStart ("Gradient none point", Float) = 0
		_GradientEnd ("Gradient full point", Float) = 2
		_GradientLightCut ("Grad Light Cut", Float) = 1
		_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
		_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
		_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_BackLight2Col ("Back Light 2 Color", Vector) = (0,0,0,1)
		_ShadowSub ("Shadow Additive Color", Vector) = (0,0,0,1)
		_BackLightLimitForFrontFaces ("Backlight limit on front faces", Float) = 0.25
		_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
		_BackLight2Pos ("Backlight 2 Pos", Vector) = (0,0,0,1)
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
		_BackLight2Dir ("Back Light 2 Direction", Vector) = (0,0,0,0)
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