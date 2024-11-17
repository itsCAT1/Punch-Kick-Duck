//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/LightAndShade/additiveOverlay_AlSq_withInsects" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Orbit1_Radius_MaxOffset_Speed ("Bug1 orbit dist, speed, bug smallness", Vector) = (0.15,1,20,0)
_Orbit2_Radius_MaxOffset_Speed ("Bug1 orbit dist, speed, bug smallness", Vector) = (0.4,1,20,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent+30" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent+30" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 54172
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec3 _Orbit1_Radius_MaxOffset_Speed;
uniform 	mediump vec3 _Orbit2_Radius_MaxOffset_Speed;
uniform 	mediump float _zeroToTwoPiTimeCount_qSpeed;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
mediump vec2 u_xlat16_12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.x = _Orbit1_Radius_MaxOffset_Speed.y * _zeroToTwoPiTimeCount_qSpeed;
    u_xlat16_3 = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat0.x = u_xlat16_2.x * _CosTime.w;
    u_xlat0.y = u_xlat16_3 * _SinTime.z;
    u_xlat16_2.x = _Orbit1_Radius_MaxOffset_Speed.z * _Orbit1_Radius_MaxOffset_Speed.x;
    u_xlat1.xy = u_xlat0.xy * u_xlat16_2.xx;
    u_xlat16_2.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_12.xy = u_xlat16_2.xy * _Orbit1_Radius_MaxOffset_Speed.zz + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Orbit2_Radius_MaxOffset_Speed.zz + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat1.xy + u_xlat16_12.xy;
    u_xlat16_12.xy = _Orbit2_Radius_MaxOffset_Speed.zy * vec2(_Orbit2_Radius_MaxOffset_Speed.x, _zeroToTwoPiTimeCount_qSpeed);
    u_xlat16_3 = sin(u_xlat16_12.y);
    u_xlat16_4 = cos(u_xlat16_12.y);
    u_xlat0.x = u_xlat16_4 * _SinTime.w;
    u_xlat0.y = u_xlat16_3 * _CosTime.z;
    u_xlat10.xy = u_xlat16_12.xx * u_xlat0.xy;
    vs_TEXCOORD0.zw = u_xlat10.xy + u_xlat16_2.xy;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform mediump sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = vs_COLOR0.w + 0.25;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 + 0.25;
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.zw).w;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.w = u_xlat16_1 * u_xlat16_1;
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
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec3 _Orbit1_Radius_MaxOffset_Speed;
uniform 	mediump vec3 _Orbit2_Radius_MaxOffset_Speed;
uniform 	mediump float _zeroToTwoPiTimeCount_qSpeed;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
mediump vec2 u_xlat16_12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.x = _Orbit1_Radius_MaxOffset_Speed.y * _zeroToTwoPiTimeCount_qSpeed;
    u_xlat16_3 = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat0.x = u_xlat16_2.x * _CosTime.w;
    u_xlat0.y = u_xlat16_3 * _SinTime.z;
    u_xlat16_2.x = _Orbit1_Radius_MaxOffset_Speed.z * _Orbit1_Radius_MaxOffset_Speed.x;
    u_xlat1.xy = u_xlat0.xy * u_xlat16_2.xx;
    u_xlat16_2.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_12.xy = u_xlat16_2.xy * _Orbit1_Radius_MaxOffset_Speed.zz + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Orbit2_Radius_MaxOffset_Speed.zz + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat1.xy + u_xlat16_12.xy;
    u_xlat16_12.xy = _Orbit2_Radius_MaxOffset_Speed.zy * vec2(_Orbit2_Radius_MaxOffset_Speed.x, _zeroToTwoPiTimeCount_qSpeed);
    u_xlat16_3 = sin(u_xlat16_12.y);
    u_xlat16_4 = cos(u_xlat16_12.y);
    u_xlat0.x = u_xlat16_4 * _SinTime.w;
    u_xlat0.y = u_xlat16_3 * _CosTime.z;
    u_xlat10.xy = u_xlat16_12.xx * u_xlat0.xy;
    vs_TEXCOORD0.zw = u_xlat10.xy + u_xlat16_2.xy;
    vs_COLOR0 = in_COLOR0 * _Color;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = vs_COLOR0.w + 0.25;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 + 0.25;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.zw).w;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.w = u_xlat16_1 * u_xlat16_1;
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