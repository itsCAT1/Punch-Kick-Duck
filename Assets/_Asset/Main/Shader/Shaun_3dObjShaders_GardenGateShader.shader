Shader "Shaun/3dObjShaders/GardenGateShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Diffuse Tex", 2D) = "white" {}
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_MetalCol ("Metal Col", Vector) = (1,1,1,1)
		_BodyCol ("Body Col", Vector) = (1,1,1,1)
		_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
		_BackLightLimitForFrontFaces ("Backlight limit on front faces", Float) = 0.25
		_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
		_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
		_UV2ShadowYAdj ("UV2 Shadow Y offset", Float) = 0
		_TexAOStr ("Texture AO strength", Float) = 0
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