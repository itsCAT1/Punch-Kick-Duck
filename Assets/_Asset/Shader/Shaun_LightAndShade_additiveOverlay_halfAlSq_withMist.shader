//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/LightAndShade/additiveOverlay_halfAlSq_withMist" {
Properties {
_NoiseTex ("Mist Tex", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_NoisePosAndScale ("Mist pos + scale", Vector) = (0,0.5,0,0)
_NoiseStrength ("Mist strength", Float) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 12567
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _NoisePosAndScale;
uniform 	float _zeroToOneTimeCount_oneFiftiethSpeed;
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
bool u_xlatb3;
mediump vec2 u_xlat16_5;
void main()
{
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = _zeroToOneTimeCount_oneFiftiethSpeed * 3.0;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat16_5.x = float(1.0) / _NoisePosAndScale.z;
    u_xlat0.x = (-u_xlat0.x) * u_xlat16_5.x;
    u_xlat16_5.xy = u_xlat0.xx * _NoisePosAndScale.zw;
    u_xlat16_2 = u_xlat16_2 * _NoisePosAndScale.z + (-u_xlat16_5.x);
    vs_TEXCOORD0.x = u_xlat16_2 + 0.5;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 * _NoisePosAndScale.w + u_xlat16_5.y;
    vs_TEXCOORD0.y = u_xlat16_2 + 0.5;
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
uniform 	mediump float _NoiseStrength;
uniform mediump sampler2D _NoiseTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_2 = vs_COLOR0.w * 0.25;
    u_xlat16_0 = u_xlat16_0 * 0.75 + u_xlat16_2;
    u_xlat16_1 = texture2D(_NoiseTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2 = u_xlat16_1 * _NoiseStrength;
    SV_Target0.w = u_xlat16_2 * u_xlat16_0;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _NoisePosAndScale;
uniform 	float _zeroToOneTimeCount_oneFiftiethSpeed;
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
bool u_xlatb3;
mediump vec2 u_xlat16_5;
void main()
{
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = _zeroToOneTimeCount_oneFiftiethSpeed * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat16_5.x = float(1.0) / _NoisePosAndScale.z;
    u_xlat0.x = (-u_xlat0.x) * u_xlat16_5.x;
    u_xlat16_5.xy = u_xlat0.xx * _NoisePosAndScale.zw;
    u_xlat16_2 = u_xlat16_2 * _NoisePosAndScale.z + (-u_xlat16_5.x);
    vs_TEXCOORD0.x = u_xlat16_2 + 0.5;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 * _NoisePosAndScale.w + u_xlat16_5.y;
    vs_TEXCOORD0.y = u_xlat16_2 + 0.5;
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
uniform 	mediump float _NoiseStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_2 = vs_COLOR0.w * 0.25;
    u_xlat16_0 = u_xlat16_0 * 0.75 + u_xlat16_2;
    u_xlat16_1 = texture(_NoiseTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2 = u_xlat16_1 * _NoiseStrength;
    SV_Target0.w = u_xlat16_2 * u_xlat16_0;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}