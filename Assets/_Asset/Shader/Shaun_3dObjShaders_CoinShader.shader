//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/CoinShader" {
Properties {
_MainTex ("Normal Map Tex", 2D) = "white" { }
_SurfCol ("Coin Color", Color) = (1,1,1,1)
_DiffuseBaseCol ("Diffuse Material Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_EmbossStr ("Emboss strength", Float) = 1
_SpecCol ("Specular Color", Color) = (0,0,0,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" "Replacement" = "CharBody" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" "Replacement" = "CharBody" }
  Cull Off
  GpuProgramID 14830
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec3 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD1.xyz = u_xlat16_0.xyw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_2.y = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.xy = u_xlat16_2.xy * _MainLightDir.ww;
    u_xlat16_2.xzw = u_xlat16_2.xxx * _ShadowSub.xyz;
    vs_COLOR1.xyz = _MainLightCol.xyz * u_xlat16_2.yyy + u_xlat16_2.xzw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _SurfCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump float _EmbossStr;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec3 vs_COLOR1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_13 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_13)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_5.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.x = (-u_xlat16_0.z) + 1.0;
    u_xlat0.x = u_xlat0.x * _EmbossStr;
    u_xlat0.x = u_xlat0.x * _EmbossStr;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_EmbossStr, _EmbossStr));
    u_xlat16_2.x = dot(u_xlat16_2.xy, vs_TEXCOORD1.xy);
    u_xlat16_6 = u_xlat16_2.x * _MainLightDir.w;
    u_xlat0.x = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = (-u_xlat16_2.x) * _MainLightDir.w + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _ShadowSub.xyz;
    u_xlat16_2.xyz = _MainLightCol.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_3.xyz = _SurfCol.xyz * _DiffuseBaseCol.xyz + vs_COLOR1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = _SurfCol.w;
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
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD1.xyz = u_xlat16_0.xyw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_2.y = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.xy = u_xlat16_2.xy * _MainLightDir.ww;
    u_xlat16_2.xzw = u_xlat16_2.xxx * _ShadowSub.xyz;
    vs_COLOR1.xyz = _MainLightCol.xyz * u_xlat16_2.yyy + u_xlat16_2.xzw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _SurfCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump float _EmbossStr;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_13 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_13)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_5.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.x = (-u_xlat16_0.z) + 1.0;
    u_xlat0.x = u_xlat0.x * _EmbossStr;
    u_xlat0.x = u_xlat0.x * _EmbossStr;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_EmbossStr, _EmbossStr));
    u_xlat16_2.x = dot(u_xlat16_2.xy, vs_TEXCOORD1.xy);
    u_xlat16_6 = u_xlat16_2.x * _MainLightDir.w;
    u_xlat0.x = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = (-u_xlat16_2.x) * _MainLightDir.w + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _ShadowSub.xyz;
    u_xlat16_2.xyz = _MainLightCol.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_3.xyz = _SurfCol.xyz * _DiffuseBaseCol.xyz + vs_COLOR1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = _SurfCol.w;
    return;
}

#endif
"
}
}
}
}
}