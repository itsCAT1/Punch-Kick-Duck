//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/3DObjGrad+2BLightPos+VAO" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_GradientStart ("Gradient none point", Float) = 0
_GradientEnd ("Gradient full point", Float) = 2
_GradientLightCut ("Grad Light Cut", Float) = 1
_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_BackLight2Col ("Back Light 2 Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Additive Color", Vector) = (0,0,0,1)
_BackLightLimitForFrontFaces ("Backlight limit on front faces", Float) = 0.25
_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
_BackLight2Pos ("Backlight 2 Pos", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
_BackLight2Dir ("Back Light 2 Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 21572
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _BackLight2Col;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _BackLightLimitForFrontFaces;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _BackLightPos;
uniform 	mediump vec4 _BackLight2Pos;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump vec4 _BackLight2Dir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_13;
mediump vec2 u_xlat16_19;
float u_xlat24;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xzw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat16_11.xyz = (-u_xlat0.xzw) + _BackLightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat0.xzw) + _BackLight2Pos.xyz;
    u_xlat16_28 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_5 = inversesqrt(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _BackLightPos.w;
    u_xlat16_28 = (-u_xlat16_28) * 0.00499999989 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_5);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_5 = u_xlat0.z * u_xlat24 + 0.800000012;
    u_xlat16_5 = max(u_xlat16_5, _BackLightLimitForFrontFaces);
    u_xlat16_5 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_11.x = dot(u_xlat1.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = u_xlat16_5 * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_11.x * _BackLightDir.w;
    u_xlat16_19.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_19.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _GradientSubColor.w;
    u_xlat16_19.xy = (-vec2(u_xlat16_3)) * vec2(_GradientBackLightCut, _GradientShadowCut) + vec2(1.0, 1.0);
    u_xlat16_11.x = u_xlat16_19.x * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_28 * u_xlat16_11.x;
    u_xlat16_13.xyz = u_xlat16_11.xxx * _BackLightCol.xyz;
    u_xlat16_11.x = (-u_xlat16_3) * _GradientLightCut + 1.0;
    u_xlat16_28 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_6.x = max(u_xlat16_28, 0.0);
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * _MainLightDir.w;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_11.xxx * _MainLightCol.xyz;
    u_xlat16_11.x = u_xlat16_19.y * u_xlat16_28;
    u_xlat16_27 = (-in_COLOR0.z) + 1.0;
    u_xlat16_11.x = max(u_xlat16_27, u_xlat16_11.x);
    u_xlat16_7.xyz = u_xlat16_11.xxx * _ShadowSub.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz * in_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat16_11.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _BackLight2Pos.w;
    u_xlat16_11.x = (-u_xlat16_11.x) * 0.00499999989 + 1.0;
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_4.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_27 = dot(u_xlat1.xyz, u_xlat16_4.xyz);
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_27 = u_xlat16_5 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * _BackLight2Dir.w;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_27;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_19.x;
    u_xlat16_11.xyz = u_xlat16_11.xxx * _BackLight2Col.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * in_COLOR0.yyy + u_xlat16_13.xyz;
    vs_COLOR0.xyz = _GradientSubColor.xyz * vec3(u_xlat16_3) + u_xlat16_11.xyz;
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
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	mediump vec3 _BackLight2Col;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _BackLightLimitForFrontFaces;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump vec4 _BackLightPos;
uniform 	mediump vec4 _BackLight2Pos;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump vec4 _BackLight2Dir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_13;
mediump vec2 u_xlat16_19;
float u_xlat24;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xzw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat16_11.xyz = (-u_xlat0.xzw) + _BackLightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat0.xzw) + _BackLight2Pos.xyz;
    u_xlat16_28 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_5 = inversesqrt(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _BackLightPos.w;
    u_xlat16_28 = (-u_xlat16_28) * 0.00499999989 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_5);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_5 = u_xlat0.z * u_xlat24 + 0.800000012;
    u_xlat16_5 = max(u_xlat16_5, _BackLightLimitForFrontFaces);
    u_xlat16_5 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_11.x = dot(u_xlat1.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = u_xlat16_5 * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_11.x * _BackLightDir.w;
    u_xlat16_19.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_19.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * _GradientSubColor.w;
    u_xlat16_19.xy = (-vec2(u_xlat16_3)) * vec2(_GradientBackLightCut, _GradientShadowCut) + vec2(1.0, 1.0);
    u_xlat16_11.x = u_xlat16_19.x * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_28 * u_xlat16_11.x;
    u_xlat16_13.xyz = u_xlat16_11.xxx * _BackLightCol.xyz;
    u_xlat16_11.x = (-u_xlat16_3) * _GradientLightCut + 1.0;
    u_xlat16_28 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_6.x = max(u_xlat16_28, 0.0);
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * _MainLightDir.w;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_11.xxx * _MainLightCol.xyz;
    u_xlat16_11.x = u_xlat16_19.y * u_xlat16_28;
    u_xlat16_27 = (-in_COLOR0.z) + 1.0;
    u_xlat16_11.x = max(u_xlat16_27, u_xlat16_11.x);
    u_xlat16_7.xyz = u_xlat16_11.xxx * _ShadowSub.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz * in_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat16_11.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _BackLight2Pos.w;
    u_xlat16_11.x = (-u_xlat16_11.x) * 0.00499999989 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11.x = min(max(u_xlat16_11.x, 0.0), 1.0);
#else
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_4.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_27 = dot(u_xlat1.xyz, u_xlat16_4.xyz);
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_27 = u_xlat16_5 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * _BackLight2Dir.w;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_27;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_19.x;
    u_xlat16_11.xyz = u_xlat16_11.xxx * _BackLight2Col.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * in_COLOR0.yyy + u_xlat16_13.xyz;
    vs_COLOR0.xyz = _GradientSubColor.xyz * vec3(u_xlat16_3) + u_xlat16_11.xyz;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR0.xyz;
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