//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/CharShaders/CharShaderShiny_Alpha" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
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
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" "Replacement" = "CharLimbs" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" "Replacement" = "CharLimbs" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 32293
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
attribute mediump vec2 in_TEXCOORD1;
attribute mediump vec4 in_TANGENT0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec2 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    phase0_Output0_1 = in_TEXCOORD0;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_2.y * in_TANGENT0.x;
    vs_TEXCOORD2.y = u_xlat16_2.x * (-in_TANGENT0.y) + u_xlat16_11;
    vs_TEXCOORD2.x = dot(u_xlat16_2.xy, in_TANGENT0.xy);
    vs_TEXCOORD2.z = u_xlat16_2.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    u_xlat16_2.x = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_2.y * in_TANGENT0.x;
    vs_TEXCOORD3.y = u_xlat16_2.x * (-in_TANGENT0.y) + u_xlat16_11;
    vs_TEXCOORD3.x = dot(u_xlat16_2.xy, in_TANGENT0.xy);
    vs_TEXCOORD3.z = u_xlat16_2.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_COLOR0.xy = in_TEXCOORD1.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
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
uniform 	mediump vec4 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _BackLightLimiter;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec2 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_14;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_16;
mediump float u_xlat16_20;
void main()
{
    u_xlat0 = _BackLightLimiter + 1.0;
    u_xlat16_1 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_1.w * u_xlat0 + (-_BackLightLimiter);
    u_xlat6.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = max(u_xlat0, 0.0);
    u_xlat16_2.x = (-u_xlat0) + u_xlat1.x;
    u_xlat16_8 = min(_BackLightLimiter, 1.0);
    u_xlat16_8 = (-vs_COLOR0.x) * u_xlat16_8 + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_14 = dot(u_xlat6.xyz, vs_TEXCOORD3.xyz);
    u_xlat0 = max(u_xlat16_14, 0.0);
    u_xlat0 = u_xlat0 * _BackLightDir.w;
    u_xlat0 = u_xlat16_8 * u_xlat0;
    u_xlat16_14 = u_xlat0 * 0.5;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_14;
    u_xlat16_3.xyz = vec3(u_xlat16_14) * _BackLightCol.xyz;
    u_xlat16_2.x = max(u_xlat16_2.x, vs_COLOR0.y);
    u_xlat16_2.xzw = u_xlat16_2.xxx * _ShadowSub.xyz;
    u_xlat16_2.xzw = u_xlat16_3.xyz * u_xlat1.xxx + u_xlat16_2.xzw;
    u_xlat16_3.x = dot(u_xlat6.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_9.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat0 = max(u_xlat16_9.x, 0.0);
    u_xlat16_9.x = (-u_xlat16_3.x) * _MainLightDir.w + u_xlat0;
    u_xlat16_9.xyz = u_xlat16_9.xxx * _ShadowSub.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_9.xyz = _MainLightCol.xyz * vec3(u_xlat0) + u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xzw + u_xlat16_9.xyz;
    u_xlat16_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.yzw = u_xlat16_1.xyz * _DiffuseBaseCol.xyz;
    SV_Target0.w = u_xlat16_1.w;
    u_xlat16_20 = u_xlat6.z + 1.0;
    u_xlat16_20 = u_xlat16_4.y * u_xlat16_20;
    u_xlat16_4.x = u_xlat16_20 * 0.5;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xzw;
    u_xlat16_20 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD2.xyz;
    u_xlat16_20 = dot(u_xlat16_9.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z);
    u_xlat16_20 = (-vs_COLOR0.y) + 1.0;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_3.x = u_xlat16_20 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_2.xyz;
    u_xlat1.xy = (-u_xlat6.xy);
    u_xlat1.z = u_xlat6.z;
    u_xlat16_3.x = dot(u_xlat1.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_20 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat16_4.xy = u_xlat6.xy * u_xlat16_9.xx;
    u_xlat16_4.z = u_xlat1.z * (-u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.x = dot(u_xlat16_9.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlat16_9.x = log2(u_xlat16_9.x);
    u_xlat16_15.xy = vec2(_Shininess) * vec2(0.400000006, 2.5);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_15.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_4.xyz = vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z) * vec3(0.550000012, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_9.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_3.x = max(vs_TEXCOORD3.z, 0.0);
    u_xlat16_3.x = max(u_xlat16_3.x, (-vs_TEXCOORD3.z));
    u_xlat16_3.x = u_xlat16_3.x * 4.0;
    u_xlat16_3.z = min(u_xlat16_3.x, 0.649999976);
    u_xlat16_3.xy = vs_TEXCOORD3.xy * vec2(1.0, 0.5);
    u_xlat16_4.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_10.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx;
    u_xlat1.xz = u_xlat6.xz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
    u_xlat16_16 = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_10.x;
    u_xlat16_20 = u_xlat16_20 * _BackLightDir.w;
    u_xlat16_20 = u_xlat16_20 * 0.100000001;
    u_xlat16_5.xz = u_xlat1.xz * (-vec2(u_xlat16_16));
    u_xlat16_5.y = u_xlat6.y * u_xlat16_16;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
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
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_TANGENT0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec2 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    phase0_Output0_1 = in_TEXCOORD0;
    u_xlat16_2.x = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_MainLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_2.y * in_TANGENT0.x;
    vs_TEXCOORD2.y = u_xlat16_2.x * (-in_TANGENT0.y) + u_xlat16_11;
    vs_TEXCOORD2.x = dot(u_xlat16_2.xy, in_TANGENT0.xy);
    vs_TEXCOORD2.z = u_xlat16_2.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    u_xlat16_2.x = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat16_2.y = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat16_2.z = dot(_BackLightDir.xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_2.y * in_TANGENT0.x;
    vs_TEXCOORD3.y = u_xlat16_2.x * (-in_TANGENT0.y) + u_xlat16_11;
    vs_TEXCOORD3.x = dot(u_xlat16_2.xy, in_TANGENT0.xy);
    vs_TEXCOORD3.z = u_xlat16_2.z * (-hlslcc_mtx4x4unity_ObjectToWorld[2].z);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_COLOR0.xy = in_TEXCOORD1.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
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
uniform 	mediump vec4 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _BackLightLimiter;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec2 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_14;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_16;
mediump float u_xlat16_20;
void main()
{
    u_xlat0 = _BackLightLimiter + 1.0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_1.w * u_xlat0 + (-_BackLightLimiter);
    u_xlat6.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = max(u_xlat0, 0.0);
    u_xlat16_2.x = (-u_xlat0) + u_xlat1.x;
    u_xlat16_8 = min(_BackLightLimiter, 1.0);
    u_xlat16_8 = (-vs_COLOR0.x) * u_xlat16_8 + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_14 = dot(u_xlat6.xyz, vs_TEXCOORD3.xyz);
    u_xlat0 = max(u_xlat16_14, 0.0);
    u_xlat0 = u_xlat0 * _BackLightDir.w;
    u_xlat0 = u_xlat16_8 * u_xlat0;
    u_xlat16_14 = u_xlat0 * 0.5;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_14;
    u_xlat16_3.xyz = vec3(u_xlat16_14) * _BackLightCol.xyz;
    u_xlat16_2.x = max(u_xlat16_2.x, vs_COLOR0.y);
    u_xlat16_2.xzw = u_xlat16_2.xxx * _ShadowSub.xyz;
    u_xlat16_2.xzw = u_xlat16_3.xyz * u_xlat1.xxx + u_xlat16_2.xzw;
    u_xlat16_3.x = dot(u_xlat6.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_9.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat0 = max(u_xlat16_9.x, 0.0);
    u_xlat16_9.x = (-u_xlat16_3.x) * _MainLightDir.w + u_xlat0;
    u_xlat16_9.xyz = u_xlat16_9.xxx * _ShadowSub.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_9.xyz = _MainLightCol.xyz * vec3(u_xlat0) + u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xzw + u_xlat16_9.xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.yzw = u_xlat16_1.xyz * _DiffuseBaseCol.xyz;
    SV_Target0.w = u_xlat16_1.w;
    u_xlat16_20 = u_xlat6.z + 1.0;
    u_xlat16_20 = u_xlat16_4.y * u_xlat16_20;
    u_xlat16_4.x = u_xlat16_20 * 0.5;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xzw;
    u_xlat16_20 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD2.xyz;
    u_xlat16_20 = dot(u_xlat16_9.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z);
    u_xlat16_20 = (-vs_COLOR0.y) + 1.0;
    u_xlat16_20 = u_xlat16_20 * _SpecPower;
    u_xlat16_3.x = u_xlat16_20 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_2.xyz;
    u_xlat1.xy = (-u_xlat6.xy);
    u_xlat1.z = u_xlat6.z;
    u_xlat16_3.x = dot(u_xlat1.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_20 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat16_4.xy = u_xlat6.xy * u_xlat16_9.xx;
    u_xlat16_4.z = u_xlat1.z * (-u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.x = dot(u_xlat16_9.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlat16_9.x = log2(u_xlat16_9.x);
    u_xlat16_15.xy = vec2(_Shininess) * vec2(0.400000006, 2.5);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_15.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_4.xyz = vec3(_SpecCol.x, _SpecCol.y, _SpecCol.z) * vec3(0.550000012, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_9.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_3.x = max(vs_TEXCOORD3.z, 0.0);
    u_xlat16_3.x = max(u_xlat16_3.x, (-vs_TEXCOORD3.z));
    u_xlat16_3.x = u_xlat16_3.x * 4.0;
    u_xlat16_3.z = min(u_xlat16_3.x, 0.649999976);
    u_xlat16_3.xy = vs_TEXCOORD3.xy * vec2(1.0, 0.5);
    u_xlat16_4.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_10.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx;
    u_xlat1.xz = u_xlat6.xz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
    u_xlat16_16 = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_10.x;
    u_xlat16_20 = u_xlat16_20 * _BackLightDir.w;
    u_xlat16_20 = u_xlat16_20 * 0.100000001;
    u_xlat16_5.xz = u_xlat1.xz * (-vec2(u_xlat16_16));
    u_xlat16_5.y = u_xlat6.y * u_xlat16_16;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BackLightCol.xyz;
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