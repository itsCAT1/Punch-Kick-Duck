//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/NoTex/PlantShader+EdgeFilter_lightBakedToUV2" {
Properties {
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 30934
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _DiffuseBaseCol;
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_COLOR0.xyz = in_COLOR0.xyz * _DiffuseBaseCol.xyz;
    vs_COLOR0.w = in_COLOR0.w;
    vs_TEXCOORD0.xyz = in_TEXCOORD1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = dFdx(vs_TEXCOORD0.x);
    u_xlat16_1 = dFdy(vs_TEXCOORD0.x);
    u_xlat16_0 = abs(u_xlat16_1) + abs(u_xlat16_0);
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_0) + vs_COLOR0.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	mediump vec3 _DiffuseBaseCol;
in mediump vec4 in_POSITION0;
in mediump vec3 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_COLOR0.xyz = in_COLOR0.xyz * _DiffuseBaseCol.xyz;
    vs_COLOR0.w = in_COLOR0.w;
    vs_TEXCOORD0.xyz = in_TEXCOORD1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = dFdx(vs_TEXCOORD0.x);
    u_xlat16_1 = dFdy(vs_TEXCOORD0.x);
    u_xlat16_0 = abs(u_xlat16_1) + abs(u_xlat16_0);
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_0) + vs_COLOR0.xyz;
    SV_Target0.w = vs_COLOR0.w;
    return;
}

#endif
"
}
}
}
}
}