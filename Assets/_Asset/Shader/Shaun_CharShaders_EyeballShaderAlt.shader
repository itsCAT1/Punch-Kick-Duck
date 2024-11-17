//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/CharShaders/EyeballShaderAlt" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DiffuseBaseCol ("Diffuse Material Color", Color) = (1,1,1,1)
_PupilCol ("Pupil Color", Color) = (0,0,0,1)
_PupilOffsetAndSize ("Pupil Offset & size", Vector) = (0,0,0,1)
_Lids ("Lid Encroachment", Vector) = (0,0,0,0)
_UpperLidTint ("Upper Lid Edge Tint", Color) = (0,0,0,1)
_LowerLidTint ("Lower Lid Edge Tint", Color) = (0,0,0,1)
_LidThickness ("Lid thicknesses", Vector) = (0,0,0,0)
_LidEdgeBlur ("Lid Edge Softness", Float) = 30
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  Cull Off
  GpuProgramID 31546
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _PupilOffsetAndSize;
uniform 	mediump vec4 _Lids;
uniform 	mediump vec4 _LidThickness;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PupilOffsetAndSize.xy);
    u_xlat16_1 = float(1.0) / _PupilOffsetAndSize.z;
    u_xlat16_4 = (-u_xlat16_1) + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(u_xlat16_1) + vec2(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.xy = (-_Lids.xz) + _Lids.yw;
    u_xlat0.xy = u_xlat16_2.xy * in_TEXCOORD0.xx + _Lids.xz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.xy = u_xlat0.xx + _LidThickness.xy;
    vs_TEXCOORD2.x = u_xlat0.x;
    u_xlat16_5 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat0.x = u_xlat16_5 * in_TEXCOORD0.x + u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat0.y + (-_LidThickness.z);
    vs_TEXCOORD2.yz = u_xlat0.yx;
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
uniform 	mediump vec3 _PupilCol;
uniform 	mediump vec3 _UpperLidTint;
uniform 	mediump vec3 _LowerLidTint;
uniform 	mediump float _LidEdgeBlur;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + _DiffuseBaseCol.w;
    u_xlat16_1 = u_xlat16_1 + 2.0;
    u_xlat16_4.xy = (-vs_TEXCOORD0.yy) + vs_TEXCOORD2.xz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_LidEdgeBlur, _LidEdgeBlur)) + vec2(0.5, 0.5);
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1 = (-u_xlat16_4.x) + u_xlat16_1;
    u_xlat16_2.xy = vs_TEXCOORD0.yy + (-vs_TEXCOORD2.yw);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_LidEdgeBlur, _LidEdgeBlur)) + vec2(0.5, 0.5);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_4.y * u_xlat16_2.y;
    u_xlat16_1 = u_xlat16_7 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_5.xyz = (-_DiffuseBaseCol.xyz) + _PupilCol.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * u_xlat16_5.xyz + _DiffuseBaseCol.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_UpperLidTint.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _UpperLidTint.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + (-_LowerLidTint.xyz);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + _LowerLidTint.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump vec3 _PupilOffsetAndSize;
uniform 	mediump vec4 _Lids;
uniform 	mediump vec4 _LidThickness;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PupilOffsetAndSize.xy);
    u_xlat16_1 = float(1.0) / _PupilOffsetAndSize.z;
    u_xlat16_4 = (-u_xlat16_1) + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(u_xlat16_1) + vec2(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_2.xy = (-_Lids.xz) + _Lids.yw;
    u_xlat0.xy = u_xlat16_2.xy * in_TEXCOORD0.xx + _Lids.xz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.xy = u_xlat0.xx + _LidThickness.xy;
    vs_TEXCOORD2.x = u_xlat0.x;
    u_xlat16_5 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat0.x = u_xlat16_5 * in_TEXCOORD0.x + u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat0.y + (-_LidThickness.z);
    vs_TEXCOORD2.yz = u_xlat0.yx;
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
uniform 	mediump vec3 _PupilCol;
uniform 	mediump vec3 _UpperLidTint;
uniform 	mediump vec3 _LowerLidTint;
uniform 	mediump float _LidEdgeBlur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + _DiffuseBaseCol.w;
    u_xlat16_1 = u_xlat16_1 + 2.0;
    u_xlat16_4.xy = (-vs_TEXCOORD0.yy) + vs_TEXCOORD2.xz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_LidEdgeBlur, _LidEdgeBlur)) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_4.x) + u_xlat16_1;
    u_xlat16_2.xy = vs_TEXCOORD0.yy + (-vs_TEXCOORD2.yw);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_LidEdgeBlur, _LidEdgeBlur)) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_4.y * u_xlat16_2.y;
    u_xlat16_1 = u_xlat16_7 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_5.xyz = (-_DiffuseBaseCol.xyz) + _PupilCol.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * u_xlat16_5.xyz + _DiffuseBaseCol.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_UpperLidTint.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _UpperLidTint.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + (-_LowerLidTint.xyz);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + _LowerLidTint.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
}
}
}
}