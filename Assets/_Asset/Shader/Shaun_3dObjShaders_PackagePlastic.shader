//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/PackagePlastic" {
Properties {
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_SpecCol ("Specular Color", Color) = (0,0,0,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 31508
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat16_2.x = u_xlat0.z * u_xlat9 + 0.649999976;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_5 = dot(u_xlat0.xyz, _BackLightDir.xyz);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_11 = dot(u_xlat0.xyz, _MainLightDir.xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_11 = u_xlat16_11 * _MainLightDir.w;
    vs_COLOR0.xyz = _MainLightCol.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec4 _MainLightDir;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_10 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_10 = u_xlat16_10 + u_xlat16_10;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_10)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _Shininess;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4.x + 0.150000006;
    SV_Target0.xyz = u_xlat16_2.xyz + _DiffuseBaseCol.xyz;
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
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat16_2.x = u_xlat0.z * u_xlat9 + 0.649999976;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_5 = dot(u_xlat0.xyz, _BackLightDir.xyz);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_11 = dot(u_xlat0.xyz, _MainLightDir.xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_11 = u_xlat16_11 * _MainLightDir.w;
    vs_COLOR0.xyz = _MainLightCol.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec4 _MainLightDir;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_10 = dot((-_MainLightDir.xyz), u_xlat16_1.xyz);
    u_xlat16_10 = u_xlat16_10 + u_xlat16_10;
    u_xlat16_2.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_10)) + (-_MainLightDir.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, _MainLightDir.xyz);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _Shininess;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4.x + 0.150000006;
    SV_Target0.xyz = u_xlat16_2.xyz + _DiffuseBaseCol.xyz;
    return;
}

#endif
"
}
}
}
}
}