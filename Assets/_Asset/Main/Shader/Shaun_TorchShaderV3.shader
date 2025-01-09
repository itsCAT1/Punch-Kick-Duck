Shader "Shaun/TorchShaderV3" {
	Properties {
		[NoScaleOffset] _MainTex ("Base (RGB)", 2D) = "white" {}
		[NoScaleOffset] _NoiseTex ("Noise", 2D) = "white" {}
		_InnerCol ("Inner tint", Vector) = (1,1,1,1)
		_OuterCol ("Outer tint", Vector) = (1,1,1,1)
		_CenterCol ("Center add col", Vector) = (-0.7,-0.4,6,0)
		_NoiseScaler_SmokeThicknessBrightness ("Noise scale:X,Y & Smoke thickness+brightness: ZW", Vector) = (1,1,1,1)
		_SpeedAndStrength ("Speed:X,Y & Noise power:Z,W", Vector) = (1,1,1,1)
		_SparksXRestriction ("Sparks X constraint", Float) = 0.1
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