//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/WallShaders/WallShader_BakedLight_AmbShadOnly" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_ShadTex ("Shadow Tex", 2D) = "white" { }
_DiffuseBaseTint ("Diffuse base tint", Color) = (1,1,1,0)
_AmbPosAndScale ("Amb pos + scale", Vector) = (0.5,0.5,0,0)
_AmbCol ("Amb color", Color) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 49036
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _AmbPosAndScale;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_COLOR0;
attribute mediump vec3 in_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_5;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_5.xy = _AmbPosAndScale.zw * _AmbPosAndScale.xy;
    u_xlat16_2 = u_xlat16_2 * _AmbPosAndScale.z + (-u_xlat16_5.x);
    u_xlat0.x = u_xlat16_2 + 0.5;
    vs_TEXCOORD1.x = u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 * _AmbPosAndScale.w + (-u_xlat16_5.y);
    u_xlat0.x = u_xlat16_2 + 0.5;
    vs_TEXCOORD1.y = u_xlat0.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR1.xyz = in_TEXCOORD1.xyz;
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
uniform 	mediump vec4 _DiffuseBaseTint;
uniform 	mediump vec4 _AmbCol;
uniform mediump sampler2D _ShadTex;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _DiffuseBaseTint.xyz;
    u_xlat16_12 = texture2D(_ShadTex, vs_TEXCOORD1.xy).y;
    u_xlat16_1.x = u_xlat16_12 + _AmbCol.w;
    u_xlat2 = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat2) * vs_COLOR0.xyz;
    u_xlat16_3.xyz = (-_AmbCol.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_12) * u_xlat16_3.xyz + _AmbCol.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _AmbPosAndScale;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
in mediump vec3 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_5;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_5.xy = _AmbPosAndScale.zw * _AmbPosAndScale.xy;
    u_xlat16_2 = u_xlat16_2 * _AmbPosAndScale.z + (-u_xlat16_5.x);
    u_xlat0.x = u_xlat16_2 + 0.5;
    vs_TEXCOORD1.x = u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 * _AmbPosAndScale.w + (-u_xlat16_5.y);
    u_xlat0.x = u_xlat16_2 + 0.5;
    vs_TEXCOORD1.y = u_xlat0.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR1.xyz = in_TEXCOORD1.xyz;
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
uniform 	mediump vec4 _DiffuseBaseTint;
uniform 	mediump vec4 _AmbCol;
UNITY_LOCATION(0) uniform mediump sampler2D _ShadTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _DiffuseBaseTint.xyz;
    u_xlat16_12 = texture(_ShadTex, vs_TEXCOORD1.xy).y;
    u_xlat16_1.x = u_xlat16_12 + _AmbCol.w;
    u_xlat2 = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat2) * vs_COLOR0.xyz;
    u_xlat16_3.xyz = (-_AmbCol.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_12) * u_xlat16_3.xyz + _AmbCol.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR1.xyz;
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