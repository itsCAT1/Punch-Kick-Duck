//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/BannerShader" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,0)
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,0)
_ShaderVec4 ("Wave pos, freq, power", Vector) = (0,10,1,1)
_YShiftAndEndYShift ("Y shift due to Z, Y shift at end", Vector) = (0.3,0.9,0,0)
_ShaderVec4Alt ("Foldiness, end X contract, billow", Vector) = (1.5,2.1,0.35,0)
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 15086
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainLightCol;
uniform 	mediump vec4 _ShadowSub;
uniform 	mediump vec4 _ShaderVec4;
uniform 	mediump vec3 _YShiftAndEndYShift;
uniform 	mediump vec3 _ShaderVec4Alt;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
mediump vec2 u_xlat16_0;
float u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx + vec2(-0.5, 0.449999988);
    u_xlat1 = -abs(u_xlat16_0.x) + 0.5;
    u_xlat1 = u_xlat1 * 3.14159989;
    u_xlat1 = sin(u_xlat1);
    u_xlat16_0.x = u_xlat1 * in_TEXCOORD0.x;
    u_xlat16_10 = in_TEXCOORD0.x * in_TEXCOORD0.x;
    u_xlat16_15 = u_xlat16_10 * _ShaderVec4Alt.y;
    u_xlat16_2 = in_TEXCOORD0.x * _ShaderVec4.y + (-_ShaderVec4.x);
    u_xlat16_2 = sin(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * in_TEXCOORD0.x;
    u_xlat16_15 = (-u_xlat16_2) * _ShaderVec4Alt.x + u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) + in_POSITION0.x;
    u_xlat6 = u_xlat16_0.x * _ShaderVec4Alt.z + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_2 * _ShaderVec4.z;
    u_xlat16_0.x = u_xlat16_0.x * _YShiftAndEndYShift.x + in_POSITION0.y;
    u_xlat16_0.x = (-u_xlat16_10) * _YShiftAndEndYShift.y + u_xlat16_0.x;
    u_xlat3 = u_xlat16_0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat6) + u_xlat3;
    u_xlat16_0.x = (-u_xlat16_2) * _ShaderVec4.z + in_POSITION0.z;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat16_0.xxxx + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_0.x = max(u_xlat16_2, 0.0);
    u_xlat16_10 = max((-u_xlat16_2), 0.0);
    u_xlat16_5.x = u_xlat16_0.x * 0.400000006 + u_xlat16_0.y;
    u_xlat16_0.x = u_xlat16_0.x + (-in_TEXCOORD0.x);
    u_xlat16_0.x = u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _MainLightCol.w;
    u_xlat1 = u_xlat1 * -0.0700000003 + u_xlat16_5.x;
    u_xlat1 = (-u_xlat1) * 1.5 + 1.0;
    u_xlat1 = max(u_xlat1, 0.0);
    u_xlat1 = u_xlat1 * 2.5;
    u_xlat16_5.x = u_xlat1 * u_xlat1;
    u_xlat16_5.x = u_xlat16_10 * _ShadowSub.w + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _ShadowSub.xyz;
    vs_COLOR0.xyz = _MainLightCol.xyz * u_xlat16_0.xxx + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainLightCol;
uniform 	mediump vec4 _ShadowSub;
uniform 	mediump vec4 _ShaderVec4;
uniform 	mediump vec3 _YShiftAndEndYShift;
uniform 	mediump vec3 _ShaderVec4Alt;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
mediump vec2 u_xlat16_0;
float u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx + vec2(-0.5, 0.449999988);
    u_xlat1 = -abs(u_xlat16_0.x) + 0.5;
    u_xlat1 = u_xlat1 * 3.14159989;
    u_xlat1 = sin(u_xlat1);
    u_xlat16_0.x = u_xlat1 * in_TEXCOORD0.x;
    u_xlat16_10 = in_TEXCOORD0.x * in_TEXCOORD0.x;
    u_xlat16_15 = u_xlat16_10 * _ShaderVec4Alt.y;
    u_xlat16_2 = in_TEXCOORD0.x * _ShaderVec4.y + (-_ShaderVec4.x);
    u_xlat16_2 = sin(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * in_TEXCOORD0.x;
    u_xlat16_15 = (-u_xlat16_2) * _ShaderVec4Alt.x + u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) + in_POSITION0.x;
    u_xlat6 = u_xlat16_0.x * _ShaderVec4Alt.z + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_2 * _ShaderVec4.z;
    u_xlat16_0.x = u_xlat16_0.x * _YShiftAndEndYShift.x + in_POSITION0.y;
    u_xlat16_0.x = (-u_xlat16_10) * _YShiftAndEndYShift.y + u_xlat16_0.x;
    u_xlat3 = u_xlat16_0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat6) + u_xlat3;
    u_xlat16_0.x = (-u_xlat16_2) * _ShaderVec4.z + in_POSITION0.z;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat16_0.xxxx + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_0.x = max(u_xlat16_2, 0.0);
    u_xlat16_10 = max((-u_xlat16_2), 0.0);
    u_xlat16_5.x = u_xlat16_0.x * 0.400000006 + u_xlat16_0.y;
    u_xlat16_0.x = u_xlat16_0.x + (-in_TEXCOORD0.x);
    u_xlat16_0.x = u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _MainLightCol.w;
    u_xlat1 = u_xlat1 * -0.0700000003 + u_xlat16_5.x;
    u_xlat1 = (-u_xlat1) * 1.5 + 1.0;
    u_xlat1 = max(u_xlat1, 0.0);
    u_xlat1 = u_xlat1 * 2.5;
    u_xlat16_5.x = u_xlat1 * u_xlat1;
    u_xlat16_5.x = u_xlat16_10 * _ShadowSub.w + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _ShadowSub.xyz;
    vs_COLOR0.xyz = _MainLightCol.xyz * u_xlat16_0.xxx + u_xlat16_5.xyz;
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