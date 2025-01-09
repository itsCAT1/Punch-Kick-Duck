Shader "Shaun/3dObjShaders/NoTex/3DObj+VBakedLight+VertAO_NoTex" {
	Properties {
		_ObjectCol ("Object base Color", Vector) = (1,1,1,1)
		_DiffuseBaseCol ("Diffuse base Color", Vector) = (1,1,1,1)
		_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
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