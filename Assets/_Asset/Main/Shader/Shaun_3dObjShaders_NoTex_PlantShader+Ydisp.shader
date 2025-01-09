Shader "Shaun/3dObjShaders/NoTex/PlantShader+Ydisp" {
	Properties {
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
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