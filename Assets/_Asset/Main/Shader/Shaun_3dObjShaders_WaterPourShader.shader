Shader "Shaun/3dObjShaders/WaterPourShader" {
	Properties {
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
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