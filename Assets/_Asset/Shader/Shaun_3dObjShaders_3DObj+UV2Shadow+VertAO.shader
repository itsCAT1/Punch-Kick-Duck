//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/3DObj+UV2Shadow+VertAO" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
_UV2ShadowYAdj ("UV2 Shadow Y offset", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 48986
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
uniform 	mediump float _UV2ShadowYAdj;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec2 in_TEXCOORD1;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat16_2.x = u_xlat0.x * -0.075000003 + _UV2ShadowYAdj;
    vs_TEXCOORD1.y = u_xlat16_2.x + in_TEXCOORD1.y;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = in_TEXCOORD1.x;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.z * u_xlat12 + 0.649999976;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + 0.150000006;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_6 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_10 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyw = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * in_COLOR0.yyy;
    u_xlat16_3.x = max(u_xlat16_10, 0.0);
    u_xlat16_10 = (-u_xlat16_10) + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _MainLightCol.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz * in_COLOR0.xxx + u_xlat16_2.xyw;
    u_xlat16_2.x = (-in_COLOR0.z) + 1.0;
    vs_COLOR0.w = max(u_xlat16_2.x, u_xlat16_10);
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
uniform 	mediump vec3 _ShadowSub;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_3.xyz = vs_COLOR0.www * _ShadowSub.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + u_xlat16_1.xyz;
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
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump float _UV2ShadowYAdj;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat16_2.x = u_xlat0.x * -0.075000003 + _UV2ShadowYAdj;
    vs_TEXCOORD1.y = u_xlat16_2.x + in_TEXCOORD1.y;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = in_TEXCOORD1.x;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.z * u_xlat12 + 0.649999976;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + 0.150000006;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_6 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_10 = dot(u_xlat1.xyz, _MainLightDir.xyz);
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
    u_xlat16_2.x = u_xlat16_2.x * _BackLightDir.w;
    u_xlat16_2.xyw = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * in_COLOR0.yyy;
    u_xlat16_3.x = max(u_xlat16_10, 0.0);
    u_xlat16_10 = (-u_xlat16_10) + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _MainLightDir.w;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _MainLightCol.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz * in_COLOR0.xxx + u_xlat16_2.xyw;
    u_xlat16_2.x = (-in_COLOR0.z) + 1.0;
    vs_COLOR0.w = max(u_xlat16_2.x, u_xlat16_10);
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
uniform 	mediump vec3 _ShadowSub;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_3.xyz = vs_COLOR0.www * _ShadowSub.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + u_xlat16_1.xyz;
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