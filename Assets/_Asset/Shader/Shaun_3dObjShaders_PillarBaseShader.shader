//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/PillarBaseShader" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 63136
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat12;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.xy = u_xlat0.zz * vec2(u_xlat12) + vec2(-0.25, 0.449999988);
    u_xlat16_10 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat1.z = u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.y, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_6 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyw = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_3 = max(u_xlat16_10, 0.0);
    u_xlat16_10 = (-u_xlat16_10) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _MainLightDir.w;
    vs_COLOR0.xyz = _MainLightCol.xyz * vec3(u_xlat16_3) + u_xlat16_2.xyw;
    u_xlat16_2.x = u_xlat16_10 * _MainLightDir.w;
    vs_COLOR1.xyz = u_xlat16_2.xxx * _ShadowSub.xyz;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR0.xyz * u_xlat10_0.www + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat12;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.xy = u_xlat0.zz * vec2(u_xlat12) + vec2(-0.25, 0.449999988);
    u_xlat16_10 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat1.z = u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.y, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_6 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyw = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_3 = max(u_xlat16_10, 0.0);
    u_xlat16_10 = (-u_xlat16_10) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _MainLightDir.w;
    vs_COLOR0.xyz = _MainLightCol.xyz * vec3(u_xlat16_3) + u_xlat16_2.xyw;
    u_xlat16_2.x = u_xlat16_10 * _MainLightDir.w;
    vs_COLOR1.xyz = u_xlat16_2.xxx * _ShadowSub.xyz;
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
uniform 	mediump vec3 _DiffuseBaseCol;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR0.xyz * u_xlat16_0.www + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
}
}
}
}