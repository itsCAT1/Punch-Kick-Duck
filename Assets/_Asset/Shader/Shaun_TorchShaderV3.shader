//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/TorchShaderV3" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_NoiseTex ("Noise", 2D) = "white" { }
_InnerCol ("Inner tint", Color) = (1,1,1,1)
_OuterCol ("Outer tint", Color) = (1,1,1,1)
_CenterCol ("Center add col", Vector) = (-0.7,-0.4,6,0)
_NoiseScaler_SmokeThicknessBrightness ("Noise scale:X,Y & Smoke thickness+brightness: ZW", Vector) = (1,1,1,1)
_SpeedAndStrength ("Speed:X,Y & Noise power:Z,W", Vector) = (1,1,1,1)
_SparksXRestriction ("Sparks X constraint", Float) = 0.1
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 21757
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _NoiseScaler_SmokeThicknessBrightness;
uniform 	mediump vec4 _SpeedAndStrength;
uniform 	float _zeroToOneTimeCount_qSpeed;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat0.x = u_xlat0.x * 5.22300005 + _zeroToOneTimeCount_qSpeed;
    u_xlat0.xy = u_xlat0.xx * _SpeedAndStrength.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseScaler_SmokeThicknessBrightness.xy + (-u_xlat0.xy);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.y = in_TEXCOORD0.y + -0.0299999993;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OuterCol;
uniform 	mediump vec4 _InnerCol;
uniform 	mediump vec4 _CenterCol;
uniform 	mediump vec4 _NoiseScaler_SmokeThicknessBrightness;
uniform 	mediump vec4 _SpeedAndStrength;
uniform 	mediump float _SparksXRestriction;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_16;
void main()
{
    u_xlat0 = (-vs_TEXCOORD0.x) + (-_SparksXRestriction);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat5.x = vs_TEXCOORD0.x + (-_SparksXRestriction);
    u_xlat0 = u_xlat0 * u_xlat5.x;
    u_xlat16_1.x = (-_SparksXRestriction) + 0.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat5.x = vs_TEXCOORD0.y * 3.0;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat10_5.xyz = texture2D(_NoiseTex, vs_TEXCOORD1.xy).xyw;
    u_xlat16_1.x = u_xlat10_5.z * u_xlat0;
    u_xlat16_6.xy = u_xlat10_5.xy + vec2(-0.5, -1.0);
    u_xlat5.xy = u_xlat16_6.xy * vs_TEXCOORD0.yy;
    u_xlat5.xy = u_xlat5.xy * _SpeedAndStrength.zw + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat16_3 = u_xlat10_2.yyyy * _InnerCol;
    u_xlat16_3 = u_xlat10_2.xxxx * _OuterCol + u_xlat16_3;
    u_xlat16_3 = u_xlat10_2.zzzz * _CenterCol + u_xlat16_3;
    u_xlat16_1.xyz = _OuterCol.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xy = (-u_xlat10_2.xy) + vec2(1.0, 1.0);
    u_xlat16_16 = u_xlat10_2.w * _NoiseScaler_SmokeThicknessBrightness.z;
    u_xlat5.x = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat10 = u_xlat5.x * _NoiseScaler_SmokeThicknessBrightness.w;
    u_xlat16_16 = u_xlat16_16 * u_xlat5.x + u_xlat16_3.w;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    SV_Target0.w = u_xlat0 * u_xlat10_5.z + u_xlat16_16;
    u_xlat16_4.xyz = vec3(u_xlat10) * _InnerCol.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xzw * u_xlat16_3.yyy + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _NoiseScaler_SmokeThicknessBrightness;
uniform 	mediump vec4 _SpeedAndStrength;
uniform 	float _zeroToOneTimeCount_qSpeed;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat0.x = u_xlat0.x * 5.22300005 + _zeroToOneTimeCount_qSpeed;
    u_xlat0.xy = u_xlat0.xx * _SpeedAndStrength.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseScaler_SmokeThicknessBrightness.xy + (-u_xlat0.xy);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.y = in_TEXCOORD0.y + -0.0299999993;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _OuterCol;
uniform 	mediump vec4 _InnerCol;
uniform 	mediump vec4 _CenterCol;
uniform 	mediump vec4 _NoiseScaler_SmokeThicknessBrightness;
uniform 	mediump vec4 _SpeedAndStrength;
uniform 	mediump float _SparksXRestriction;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_16;
void main()
{
    u_xlat0 = (-vs_TEXCOORD0.x) + (-_SparksXRestriction);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat5.x = vs_TEXCOORD0.x + (-_SparksXRestriction);
    u_xlat0 = u_xlat0 * u_xlat5.x;
    u_xlat16_1.x = (-_SparksXRestriction) + 0.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat5.x = vs_TEXCOORD0.y * 3.0;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat16_5.xyz = texture(_NoiseTex, vs_TEXCOORD1.xy).xyw;
    u_xlat16_1.x = u_xlat16_5.z * u_xlat0;
    u_xlat16_6.xy = u_xlat16_5.xy + vec2(-0.5, -1.0);
    u_xlat5.xy = u_xlat16_6.xy * vs_TEXCOORD0.yy;
    u_xlat5.xy = u_xlat5.xy * _SpeedAndStrength.zw + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_3 = u_xlat16_2.yyyy * _InnerCol;
    u_xlat16_3 = u_xlat16_2.xxxx * _OuterCol + u_xlat16_3;
    u_xlat16_3 = u_xlat16_2.zzzz * _CenterCol + u_xlat16_3;
    u_xlat16_1.xyz = _OuterCol.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_16 = u_xlat16_2.w * _NoiseScaler_SmokeThicknessBrightness.z;
    u_xlat5.x = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat10 = u_xlat5.x * _NoiseScaler_SmokeThicknessBrightness.w;
    u_xlat16_16 = u_xlat16_16 * u_xlat5.x + u_xlat16_3.w;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    SV_Target0.w = u_xlat0 * u_xlat16_5.z + u_xlat16_16;
    u_xlat16_4.xyz = vec3(u_xlat10) * _InnerCol.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xzw * u_xlat16_3.yyy + u_xlat16_1.xyz;
    return;
}

#endif
"
}
}
}
}
}