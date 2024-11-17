//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/Unlit/UISpotlight" {
Properties {
_ColorTop ("Inner Color", Color) = (1,1,1,1)
_ColorBottom ("Outer Color", Color) = (0.5,0.5,0.5,1)
_Pos_Size_Soft ("Pos, Size, Softness", Vector) = (0.5,0.5,0.5,5)
_SrcMode ("SrcMode", Float) = 0
_DstMode ("DstMode", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  Cull Off
  GpuProgramID 2777
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_3;
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
    u_xlat16_2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = u_xlat16_2.z + u_xlat16_2.x;
    u_xlat16_3.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.z;
    u_xlat16_2.xy = u_xlat16_3.xy / u_xlat0.ww;
    u_xlat16_2.z = 1.0;
    vs_TEXCOORD0.xw = u_xlat16_2.xz;
    u_xlat0.x = _ScreenParams.y / _ScreenParams.x;
    vs_TEXCOORD0.y = u_xlat0.x * u_xlat16_2.y;
    vs_TEXCOORD0.z = u_xlat0.x;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Pos_Size_Soft;
uniform 	mediump vec4 _ColorTop;
uniform 	mediump vec4 _ColorBottom;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
vec2 u_xlat2;
float u_xlat4;
vec2 u_xlat7;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.z * _Pos_Size_Soft.w;
    u_xlat1 = _Pos_Size_Soft.z * 0.5 + u_xlat16_0.x;
    u_xlat4 = _Pos_Size_Soft.z * 0.5 + (-u_xlat16_0.x);
    u_xlat1 = (-u_xlat4) + u_xlat1;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat7.x = vs_TEXCOORD0.z * _Pos_Size_Soft.y;
    u_xlat2.y = (-u_xlat7.x);
    u_xlat2.x = (-_Pos_Size_Soft.x);
    u_xlat7.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat4 = (-u_xlat4) + u_xlat7.x;
    u_xlat1 = u_xlat1 * u_xlat4;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat4 = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat4;
    u_xlat4 = min(vs_TEXCOORD0.z, _ScreenParams.x);
    u_xlat4 = u_xlat7.x / u_xlat4;
    u_xlat4 = max(u_xlat4, u_xlat7.x);
    u_xlat4 = min(u_xlat4, 1.0);
    u_xlat16_0 = (-_ColorTop) + _ColorBottom;
    u_xlat16_0 = vec4(u_xlat4) * u_xlat16_0 + _ColorTop;
    u_xlat1 = u_xlat1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat1);
    SV_Target0.w = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_3;
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
    u_xlat16_2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = u_xlat16_2.z + u_xlat16_2.x;
    u_xlat16_3.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.z;
    u_xlat16_2.xy = u_xlat16_3.xy / u_xlat0.ww;
    u_xlat16_2.z = 1.0;
    vs_TEXCOORD0.xw = u_xlat16_2.xz;
    u_xlat0.x = _ScreenParams.y / _ScreenParams.x;
    vs_TEXCOORD0.y = u_xlat0.x * u_xlat16_2.y;
    vs_TEXCOORD0.z = u_xlat0.x;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Pos_Size_Soft;
uniform 	mediump vec4 _ColorTop;
uniform 	mediump vec4 _ColorBottom;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec2 u_xlat2;
float u_xlat4;
vec2 u_xlat7;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.z * _Pos_Size_Soft.w;
    u_xlat1 = _Pos_Size_Soft.z * 0.5 + u_xlat16_0.x;
    u_xlat4 = _Pos_Size_Soft.z * 0.5 + (-u_xlat16_0.x);
    u_xlat1 = (-u_xlat4) + u_xlat1;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat7.x = vs_TEXCOORD0.z * _Pos_Size_Soft.y;
    u_xlat2.y = (-u_xlat7.x);
    u_xlat2.x = (-_Pos_Size_Soft.x);
    u_xlat7.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat4 = (-u_xlat4) + u_xlat7.x;
    u_xlat1 = u_xlat1 * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat4;
    u_xlat4 = min(vs_TEXCOORD0.z, _ScreenParams.x);
    u_xlat4 = u_xlat7.x / u_xlat4;
    u_xlat4 = max(u_xlat4, u_xlat7.x);
    u_xlat4 = min(u_xlat4, 1.0);
    u_xlat16_0 = (-_ColorTop) + _ColorBottom;
    u_xlat16_0 = vec4(u_xlat4) * u_xlat16_0 + _ColorTop;
    u_xlat1 = u_xlat1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat1);
    SV_Target0.w = u_xlat1;
    return;
}

#endif
"
}
}
}
}
}