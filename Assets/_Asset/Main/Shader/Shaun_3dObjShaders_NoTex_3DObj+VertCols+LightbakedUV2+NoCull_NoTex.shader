Shader "Shaun/3dObjShaders/NoTex/3DObj+VertCols+LightbakedUV2+NoCull_NoTex" {
	Properties {
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
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