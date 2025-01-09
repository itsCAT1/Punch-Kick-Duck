Shader "KriptoFX/RFX4/Portal/PortalMask" {
	Properties {
		_TurbulenceMask ("Turbulence Mask", 2D) = "white" {}
		_NoiseScale ("Noize Scale (XYZ) Height (W)", Vector) = (1,1,1,0.2)
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