//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/NoTex/3DObjGrad+VAO_NoTex" {
Properties {
_BaseCol ("Base Color", Color) = (1,1,1,1)
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
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 27767
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BaseCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat16_2.x = u_xlat0.y + (-_GradientStart);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_7.x = u_xlat0.z * u_xlat15 + 0.75;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_12 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_17 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * _BackLightDir.w;
    u_xlat16_12 = (-_GradientStart) + _GradientEnd;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_12;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x * _GradientSubColor.w;
    u_xlat16_3.xy = (-u_xlat16_2.xx) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_8.xyz = u_xlat16_7.xxx * _BackLightCol.xyz;
    u_xlat16_7.x = max(u_xlat16_17, 0.0);
    u_xlat16_12 = (-u_xlat16_17) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * _MainLightDir.w;
    u_xlat16_7.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_4.xyz = u_xlat16_7.xxx * _MainLightCol.xyz;
    u_xlat16_7.x = (-u_xlat16_2.x) * _GradientShadowCut + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_12 = (-in_COLOR0.z) + 1.0;
    u_xlat16_7.x = max(u_xlat16_12, u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * _ShadowSub.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * in_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat16_2.xyz = _GradientSubColor.xyz * u_xlat16_2.xxx + u_xlat16_7.xyz;
    vs_COLOR0.xyz = _BaseCol.xyz * _DiffuseBaseCol.xyz + u_xlat16_2.xyz;
    vs_COLOR0.w = _BaseCol.w;
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	mediump vec4 _BaseCol;
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec3 in_COLOR0;
in mediump vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat16_2.x = u_xlat0.y + (-_GradientStart);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_7.x = u_xlat0.z * u_xlat15 + 0.75;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_12 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_17 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * _BackLightDir.w;
    u_xlat16_12 = (-_GradientStart) + _GradientEnd;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * _GradientSubColor.w;
    u_xlat16_3.xy = (-u_xlat16_2.xx) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_8.xyz = u_xlat16_7.xxx * _BackLightCol.xyz;
    u_xlat16_7.x = max(u_xlat16_17, 0.0);
    u_xlat16_12 = (-u_xlat16_17) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * _MainLightDir.w;
    u_xlat16_7.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_4.xyz = u_xlat16_7.xxx * _MainLightCol.xyz;
    u_xlat16_7.x = (-u_xlat16_2.x) * _GradientShadowCut + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_12 = (-in_COLOR0.z) + 1.0;
    u_xlat16_7.x = max(u_xlat16_12, u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * _ShadowSub.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * in_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat16_2.xyz = _GradientSubColor.xyz * u_xlat16_2.xxx + u_xlat16_7.xyz;
    vs_COLOR0.xyz = _BaseCol.xyz * _DiffuseBaseCol.xyz + u_xlat16_2.xyz;
    vs_COLOR0.w = _BaseCol.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}