//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/3DObjGrad+AOtex+BLPos" {
Properties {
_AOTex ("AO Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_GradientStart ("Zero gradient Y point", Float) = 0
_GradientEnd ("Full gradient Y point", Float) = 2
_GradientLightCut ("Grad Light Cut", Float) = 1
_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Additive Color", Vector) = (0,0,0,1)
_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 11431
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _BackLightPos;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_shad0;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat0.xyz) + _BackLightPos.xyz;
    u_xlat16_4.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_4.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _GradientSubColor.w;
    u_xlat16_4.x = (-u_xlat16_3) * _GradientShadowCut + 1.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_9 = u_xlat0.z * u_xlat15 + 0.75;
    u_xlat16_9 = max(u_xlat16_9, 0.0);
    u_xlat16_9 = dot(vec2(u_xlat16_9), vec2(u_xlat16_9));
    u_xlat16_14 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_19 = max(u_xlat16_14, 0.0);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * _MainLightDir.w;
    vs_shad0 = u_xlat16_4.x * u_xlat16_14;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_4.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _BackLightPos.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.00499999989 + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_14);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = u_xlat16_9 * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * _BackLightDir.w;
    u_xlat16_13.xy = (-vec2(u_xlat16_3)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    vs_COLOR2.xyz = _GradientSubColor.xyz * vec3(u_xlat16_3) + _DiffuseBaseCol.xyz;
    u_xlat16_3 = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_13.x * u_xlat16_19;
    u_xlat16_8.xyz = u_xlat16_8.xxx * _MainLightCol.xyz;
    u_xlat16_3 = u_xlat16_4.x * u_xlat16_3;
    u_xlat16_4.xyz = vec3(u_xlat16_3) * _BackLightCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_COLOR0.yyy;
    vs_COLOR0.xyz = u_xlat16_8.xyz * in_COLOR0.xxx + u_xlat16_4.xyz;
    vs_COLOR2.w = 1.0;
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
uniform 	mediump vec3 _ShadowSub;
uniform lowp sampler2D _AOTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_shad0;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR2;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture2D(_AOTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = (-u_xlat10_0) + 1.0;
    u_xlat16_3.xyz = vs_COLOR0.xyz * vec3(u_xlat10_0) + vs_COLOR2.xyz;
    u_xlat16_1 = max(u_xlat16_1, vs_shad0);
    SV_Target0.xyz = _ShadowSub.xyz * vec3(u_xlat16_1) + u_xlat16_3.xyz;
    SV_Target0.w = vs_COLOR2.w;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _BackLightPos;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_shad0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat0.xyz) + _BackLightPos.xyz;
    u_xlat16_4.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * _GradientSubColor.w;
    u_xlat16_4.x = (-u_xlat16_3) * _GradientShadowCut + 1.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_9 = u_xlat0.z * u_xlat15 + 0.75;
    u_xlat16_9 = max(u_xlat16_9, 0.0);
    u_xlat16_9 = dot(vec2(u_xlat16_9), vec2(u_xlat16_9));
    u_xlat16_14 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_19 = max(u_xlat16_14, 0.0);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * _MainLightDir.w;
    vs_shad0 = u_xlat16_4.x * u_xlat16_14;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_4.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _BackLightPos.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.00499999989 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_14);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = u_xlat16_9 * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * _BackLightDir.w;
    u_xlat16_13.xy = (-vec2(u_xlat16_3)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    vs_COLOR2.xyz = _GradientSubColor.xyz * vec3(u_xlat16_3) + _DiffuseBaseCol.xyz;
    u_xlat16_3 = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_13.x * u_xlat16_19;
    u_xlat16_8.xyz = u_xlat16_8.xxx * _MainLightCol.xyz;
    u_xlat16_3 = u_xlat16_4.x * u_xlat16_3;
    u_xlat16_4.xyz = vec3(u_xlat16_3) * _BackLightCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_COLOR0.yyy;
    vs_COLOR0.xyz = u_xlat16_8.xyz * in_COLOR0.xxx + u_xlat16_4.xyz;
    vs_COLOR2.w = 1.0;
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
uniform 	mediump vec3 _ShadowSub;
UNITY_LOCATION(0) uniform mediump sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_shad0;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_AOTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = (-u_xlat16_0) + 1.0;
    u_xlat16_3.xyz = vs_COLOR0.xyz * vec3(u_xlat16_0) + vs_COLOR2.xyz;
    u_xlat16_1 = max(u_xlat16_1, vs_shad0);
    SV_Target0.xyz = _ShadowSub.xyz * vec3(u_xlat16_1) + u_xlat16_3.xyz;
    SV_Target0.w = vs_COLOR2.w;
    return;
}

#endif
"
}
}
}
}
}