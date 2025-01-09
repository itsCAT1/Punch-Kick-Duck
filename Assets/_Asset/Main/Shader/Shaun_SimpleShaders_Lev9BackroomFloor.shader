Shader "Shaun/SimpleShaders/Lev9BackroomFloor" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		_TintMulti1 ("Tint and opac 1", Vector) = (0,0,0,0)
		_TintMulti2 ("Tint and opac 2", Vector) = (0,0,0,0)
		_LerpFactor ("Lerp value due to floor angle", Float) = 0
		_ZDarkCol ("Fog Color", Vector) = (0,0,0,1)
		_ZDarkStart ("Fog start z", Float) = 0
		_ZDarkRange ("Fog range", Float) = 10
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