//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/NoTex/3DObj+Grad+FragSpec+VAO_NoTex" {
Properties {
_BaseCol ("Base Color", Color) = (1,1,1,1)
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_Gradient1Start ("Grad1 zero strength Y point", Float) = 0
_Gradient1End ("Grad1 full strength Y point", Float) = 0
_GradientLightCut ("Grad Light Cut", Float) = 1
_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
_GradientSpecCut ("Grad Specular Cut", Float) = 1
_Gradient1SubColor ("Grad1 additive color", Vector) = (0,0,0,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_SpecCol ("Specular Color", Color) = (0,0,0,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
_RimAmount ("Rim light encroachment", Float) = 0.65
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 55449
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _BaseCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _Gradient1SubColor;
uniform 	mediump float _Gradient1Start;
uniform 	mediump float _Gradient1End;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _GradientSpecCut;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _RimAmount;
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying mediump vec3 vs_COLOR2;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_3.x = u_xlat1.z * u_xlat21 + _RimAmount;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * _BackLightDir.w;
    u_xlat16_10 = u_xlat0.y + (-_Gradient1Start);
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_17.x = (-_Gradient1Start) + _Gradient1End;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_17.x;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_10 = u_xlat16_10 * _Gradient1SubColor.w;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_17.xy = (-vec2(u_xlat16_10)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_3.x = u_xlat16_17.y * u_xlat16_3.x;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_24 = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * _MainLightDir.w;
    u_xlat16_17.x = u_xlat16_17.x * u_xlat16_24;
    u_xlat16_5.xyz = u_xlat16_17.xxx * _MainLightCol.xyz;
    u_xlat16_17.x = (-in_COLOR0.z) + 1.0;
    u_xlat16_3.x = max(u_xlat16_17.x, u_xlat16_3.x);
    u_xlat16_17.xy = (-vec2(u_xlat16_10)) * vec2(_GradientShadowCut, _GradientSpecCut) + vec2(1.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_10) * _Gradient1SubColor.xyz;
    u_xlat16_6.xyz = _BaseCol.xyz * _DiffuseBaseCol.xyz + u_xlat16_6.xyz;
    u_xlat16_3.x = u_xlat16_17.x * u_xlat16_3.x;
    u_xlat16_10 = max(u_xlat16_17.y, 0.0);
    vs_TEXCOORD0.w = u_xlat16_10 * _SpecPower;
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_3.xyz = u_xlat16_5.xyz * in_COLOR0.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * in_COLOR0.yyy + u_xlat16_3.xyz;
    vs_COLOR2.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
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
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _MainLightDir;
varying mediump vec3 vs_COLOR2;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_10 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_10 = u_xlat16_10 + u_xlat16_10;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_10)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD0.w;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _Shininess;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_COLOR2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec3 _BaseCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _Gradient1SubColor;
uniform 	mediump float _Gradient1Start;
uniform 	mediump float _Gradient1End;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _GradientSpecCut;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _RimAmount;
in mediump vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out mediump vec3 vs_COLOR2;
out mediump vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_3.x = u_xlat1.z * u_xlat21 + _RimAmount;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * _BackLightDir.w;
    u_xlat16_10 = u_xlat0.y + (-_Gradient1Start);
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_17.x = (-_Gradient1Start) + _Gradient1End;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_17.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_10 * _Gradient1SubColor.w;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_17.xy = (-vec2(u_xlat16_10)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_3.x = u_xlat16_17.y * u_xlat16_3.x;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_24 = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * _MainLightDir.w;
    u_xlat16_17.x = u_xlat16_17.x * u_xlat16_24;
    u_xlat16_5.xyz = u_xlat16_17.xxx * _MainLightCol.xyz;
    u_xlat16_17.x = (-in_COLOR0.z) + 1.0;
    u_xlat16_3.x = max(u_xlat16_17.x, u_xlat16_3.x);
    u_xlat16_17.xy = (-vec2(u_xlat16_10)) * vec2(_GradientShadowCut, _GradientSpecCut) + vec2(1.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_10) * _Gradient1SubColor.xyz;
    u_xlat16_6.xyz = _BaseCol.xyz * _DiffuseBaseCol.xyz + u_xlat16_6.xyz;
    u_xlat16_3.x = u_xlat16_17.x * u_xlat16_3.x;
    u_xlat16_10 = max(u_xlat16_17.y, 0.0);
    vs_TEXCOORD0.w = u_xlat16_10 * _SpecPower;
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_3.xyz = u_xlat16_5.xyz * in_COLOR0.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * in_COLOR0.yyy + u_xlat16_3.xyz;
    vs_COLOR2.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
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
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _MainLightDir;
in mediump vec3 vs_COLOR2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_10 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_10 = u_xlat16_10 + u_xlat16_10;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_10)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD0.w;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _Shininess;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_COLOR2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}