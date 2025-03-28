Shader "Shaun/ReflectiveSurfaces/GardenLevelFloor" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
		_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
		_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
		_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
		_Blur ("Blur", Float) = 0
		_AmbientT ("Ambient color top", Vector) = (0,0,0,1)
		_AmbientB ("Ambient color bott", Vector) = (0,0,0,1)
		_AddColT ("Add color top", Vector) = (0,0,0,1)
		_AddColB ("Add color bott", Vector) = (0,0,0,1)
		_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
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