Shader "Shaun/CharShaders/EyeballShaderAlt" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		_DiffuseBaseCol ("Diffuse Material Color", Vector) = (1,1,1,1)
		_PupilCol ("Pupil Color", Vector) = (0,0,0,1)
		_PupilOffsetAndSize ("Pupil Offset & size", Vector) = (0,0,0,1)
		_Lids ("Lid Encroachment", Vector) = (0,0,0,0)
		_UpperLidTint ("Upper Lid Edge Tint", Vector) = (0,0,0,1)
		_LowerLidTint ("Lower Lid Edge Tint", Vector) = (0,0,0,1)
		_LidThickness ("Lid thicknesses", Vector) = (0,0,0,0)
		_LidEdgeBlur ("Lid Edge Softness", Float) = 30
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