//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/CharShaders/CharShaderShiny_NoAlpha" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_NormalMapTex ("Normal Map Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse Material Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
_BackLightLimiter ("Back Light Limiter", Float) = 0
_SpecCol ("Spec col", Color) = (1,1,1,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
_RedReduction ("Red reduction at edges", Float) = 0.5
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" "Replacement" = "CharBody" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" "Replacement" = "CharBody" }
  Cull Off
  GpuProgramID 25590
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat10;
mediump float u_xlat16_11;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD1.xyz = u_xlat16_0.xyw;
    u_xlat16_2.x = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD2.xyz = u_xlat16_0.xyw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
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
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec4 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _BackLightLimiter;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump float _RedReduction;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _NormalMapTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
void main()
{
    u_xlat0 = _BackLightLimiter + 1.0;
    u_xlat16_1 = texture2D(_NormalMapTex, vs_TEXCOORD0.zw);
    u_xlat0 = u_xlat16_1.w * u_xlat0 + (-_BackLightLimiter);
    u_xlat16_1 = u_xlat16_1.xyzz * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -2.0);
    u_xlat6 = max(u_xlat0, 0.0);
    u_xlat16_2.x = (-u_xlat0) + u_xlat6;
    u_xlat16_8.x = dot(u_xlat16_1.xyz, vs_TEXCOORD2.xyz);
    u_xlat0 = max(u_xlat16_8.x, 0.0);
    u_xlat0 = u_xlat0 * _BackLightDir.w;
    u_xlat16_8.x = u_xlat0 * 0.5;
    u_xlat16_3.xyz = u_xlat16_8.xxx * _ShadowSub.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * _BackLightCol.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(u_xlat6) + u_xlat16_3.xyz;
    u_xlat16_20 = dot(u_xlat16_1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_3.x = u_xlat16_20 * _MainLightDir.w;
    u_xlat0 = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = (-u_xlat16_20) * _MainLightDir.w + u_xlat0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _ShadowSub.xyz;
    u_xlat16_3.xyz = _MainLightCol.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.yzw = u_xlat16_0.xyz * _DiffuseBaseCol.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_4.x = _RedReduction * u_xlat16_1.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.y * u_xlat16_4.x;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xzw;
    u_xlat16_3.x = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_20 = u_xlat16_20 * _MainLightDir.w;
    u_xlat16_3.xyz = u_xlat16_1.xyz * (-u_xlat16_3.xxx) + vs_TEXCOORD1.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Shininess;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(1.0, -1.0, 1.0);
    u_xlat16_20 = dot(u_xlat16_3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_21 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_20 = u_xlat16_20 * _MainLightDir.w;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_3.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_21)) + vs_TEXCOORD1.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_9.xy = vec2(_Shininess) * vec2(0.400000006, 2.5);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_5.xyz = vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z) * vec3(0.550000012, 1.0, 1.0);
    u_xlat16_3.xyw = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyw + u_xlat16_2.xyz;
    u_xlat16_20 = max(vs_TEXCOORD2.z, 0.0);
    u_xlat16_20 = max(u_xlat16_20, (-vs_TEXCOORD2.z));
    u_xlat16_20 = u_xlat16_20 * 4.0;
    u_xlat16_5.z = min(u_xlat16_20, 0.649999976);
    u_xlat16_5.xy = vs_TEXCOORD2.xy * vec2(0.75, 0.5);
    u_xlat16_20 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyw = vec3(u_xlat16_20) * u_xlat16_5.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_3.xyw);
    u_xlat16_22 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_3.xyw = u_xlat16_4.xyz * (-vec3(u_xlat16_22)) + u_xlat16_3.xyw;
    u_xlat16_3.x = dot(u_xlat16_3.xyw, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
    u_xlat16_21 = min(_BackLightDir.w, 0.300000012);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_21;
    SV_Target0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat10;
mediump float u_xlat16_11;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD1.xyz = u_xlat16_0.xyw;
    u_xlat16_2.x = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_0.w = u_xlat16_0.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    vs_TEXCOORD2.xyz = u_xlat16_0.xyw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
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
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec4 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _BackLightLimiter;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump float _RedReduction;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _NormalMapTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
void main()
{
    u_xlat0 = _BackLightLimiter + 1.0;
    u_xlat16_1 = texture(_NormalMapTex, vs_TEXCOORD0.zw);
    u_xlat0 = u_xlat16_1.w * u_xlat0 + (-_BackLightLimiter);
    u_xlat16_1 = u_xlat16_1.xyzz * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -2.0);
    u_xlat6 = max(u_xlat0, 0.0);
    u_xlat16_2.x = (-u_xlat0) + u_xlat6;
    u_xlat16_8.x = dot(u_xlat16_1.xyz, vs_TEXCOORD2.xyz);
    u_xlat0 = max(u_xlat16_8.x, 0.0);
    u_xlat0 = u_xlat0 * _BackLightDir.w;
    u_xlat16_8.x = u_xlat0 * 0.5;
    u_xlat16_3.xyz = u_xlat16_8.xxx * _ShadowSub.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * _BackLightCol.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(u_xlat6) + u_xlat16_3.xyz;
    u_xlat16_20 = dot(u_xlat16_1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_3.x = u_xlat16_20 * _MainLightDir.w;
    u_xlat0 = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = (-u_xlat16_20) * _MainLightDir.w + u_xlat0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _ShadowSub.xyz;
    u_xlat16_3.xyz = _MainLightCol.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.yzw = u_xlat16_0.xyz * _DiffuseBaseCol.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_4.x = _RedReduction * u_xlat16_1.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.y * u_xlat16_4.x;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xzw;
    u_xlat16_3.x = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_20 = u_xlat16_20 * _MainLightDir.w;
    u_xlat16_3.xyz = u_xlat16_1.xyz * (-u_xlat16_3.xxx) + vs_TEXCOORD1.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Shininess;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(1.0, -1.0, 1.0);
    u_xlat16_20 = dot(u_xlat16_3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_21 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_20 = u_xlat16_20 * _MainLightDir.w;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_3.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_21)) + vs_TEXCOORD1.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_9.xy = vec2(_Shininess) * vec2(0.400000006, 2.5);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_5.xyz = vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z) * vec3(0.550000012, 1.0, 1.0);
    u_xlat16_3.xyw = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyw + u_xlat16_2.xyz;
    u_xlat16_20 = max(vs_TEXCOORD2.z, 0.0);
    u_xlat16_20 = max(u_xlat16_20, (-vs_TEXCOORD2.z));
    u_xlat16_20 = u_xlat16_20 * 4.0;
    u_xlat16_5.z = min(u_xlat16_20, 0.649999976);
    u_xlat16_5.xy = vs_TEXCOORD2.xy * vec2(0.75, 0.5);
    u_xlat16_20 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyw = vec3(u_xlat16_20) * u_xlat16_5.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_3.xyw);
    u_xlat16_22 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_3.xyw = u_xlat16_4.xyz * (-vec3(u_xlat16_22)) + u_xlat16_3.xyw;
    u_xlat16_3.x = dot(u_xlat16_3.xyw, vs_TEXCOORD3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
    u_xlat16_21 = min(_BackLightDir.w, 0.300000012);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_21;
    SV_Target0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
}
}
}
}