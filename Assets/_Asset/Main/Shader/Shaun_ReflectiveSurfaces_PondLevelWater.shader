Shader "Shaun/ReflectiveSurfaces/PondLevelWater" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset] _SurfaceTex ("DistortionTex", 2D) = "white" {}
		_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
		_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
		_AmbientT ("Ambient color top", Vector) = (0,0,0,1)
		_AmbientB ("Ambient color bott", Vector) = (0,0,0,1)
		_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
		_RipplePosXY_EndAndStartSize ("Ripple pos, endsize, startsize", Vector) = (0.5,0.5,0,0)
		_CurrRippleScales ("Curr ripple scales", Vector) = (0,0,0,1)
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