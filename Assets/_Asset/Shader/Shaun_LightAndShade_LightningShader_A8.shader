//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/LightAndShade/LightningShader_A8" {
Properties {
_MainTex ("Tex", 2D) = "white" { }
_Color ("Bolt Col", Vector) = (1,0,0,1)
_UVySpeedAndOffs ("uvY scroll speed & offset", Vector) = (10,0,0,0)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ZWrite Off
  Cull Off
  GpuProgramID 47980
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec2 _UVySpeedAndOffs;
uniform 	float _zeroToOneTimeCount_qSpeed;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.x = _zeroToOneTimeCount_qSpeed * _UVySpeedAndOffs.x + _UVySpeedAndOffs.y;
    u_xlat0.x = u_xlat0.x + in_TEXCOORD0.y;
    vs_TEXCOORD0.y = u_xlat0.x;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.xyz = (-_Color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlatb0 = _Color.w>=0.600000024;
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_2.xyz;
    u_xlat16_11 = (u_xlatb0) ? 1.0 : 0.0;
    vs_TEXCOORD1.xyz = _Color.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    vs_TEXCOORD1.w = u_xlat16_11;
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
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = u_xlat16_0 * vs_TEXCOORD1.w;
    u_xlat16_1.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _Color.www;
    SV_Target0.w = vs_TEXCOORD1.w;
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
uniform 	mediump vec2 _UVySpeedAndOffs;
uniform 	float _zeroToOneTimeCount_qSpeed;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.x = _zeroToOneTimeCount_qSpeed * _UVySpeedAndOffs.x + _UVySpeedAndOffs.y;
    u_xlat0.x = u_xlat0.x + in_TEXCOORD0.y;
    vs_TEXCOORD0.y = u_xlat0.x;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.xyz = (-_Color.xyz) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Color.w>=0.600000024);
#else
    u_xlatb0 = _Color.w>=0.600000024;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_2.xyz;
    u_xlat16_11 = (u_xlatb0) ? 1.0 : 0.0;
    vs_TEXCOORD1.xyz = _Color.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    vs_TEXCOORD1.w = u_xlat16_11;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = u_xlat16_0 * vs_TEXCOORD1.w;
    u_xlat16_1.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _Color.www;
    SV_Target0.w = vs_TEXCOORD1.w;
    return;
}

#endif
"
}
}
}
}
}