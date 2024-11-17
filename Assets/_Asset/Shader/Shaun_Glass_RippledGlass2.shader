//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/Glass/RippledGlass2" {
Properties {
_BGTex ("BG1 Texture", 2D) = "white" { }
_NoiseTex ("Ripple Texture", 2D) = "white" { }
_BGDistStr ("BG distortion strenght", Float) = 1
_LeadLinesTex ("Lead tex", 2D) = "white" { }
_GlassColTex ("Glass Colors", 2D) = "white" { }
_GlassColPower ("Overall additional glass col", Float) = 0
_GlassColFromDist ("Additional glass col due to distortion", Float) = 1
_YOffsetDueToWorldX ("Y offset due to world X", Float) = 0
_BGTexXOffset ("BG tex x offset", Float) = 0
_WorldColTintFromDist ("Dist driven world col multi", Float) = 1
_LeadlinesBrightness ("Leadlines brightness", Float) = 0
_SkyCol ("Sky Color", Color) = (1,1,1,1)
_BGTint ("BG tint multi", Color) = (1,1,1,1)
}
SubShader {
 Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 44290
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BGTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	vec4 _GlassColTex_ST;
uniform 	mediump float _YOffsetDueToWorldX;
uniform 	mediump float _BGTexXOffset;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_TEXCOORD0;
attribute mediump vec3 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.x = in_POSITION0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x * in_POSITION0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].x * in_POSITION0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].x * in_POSITION0.w + u_xlat1.x;
    u_xlat16_2 = (-u_xlat1.x) + _BGTexXOffset;
    u_xlat5 = (-u_xlat0.x) * 0.100000001 + u_xlat16_2;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat9 = (-_BGTex_ST.z) + 1.0;
    u_xlat5 = u_xlat9 * u_xlat5;
    u_xlat5 = (-u_xlat0.x) * _BGTex_ST.z + u_xlat5;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat5 * _BGTex_ST.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat4 = dot(u_xlat3.xyz, in_POSITION0.xyz);
    u_xlat0.x = u_xlat4 * _BGTex_ST.x + (-u_xlat0.x);
    u_xlat16_2 = (-u_xlat4) + u_xlat1.x;
    u_xlat16_2 = u_xlat16_2 + -245.0;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat16_6 = u_xlat16_2 * 0.0500000007 + -1.0;
    u_xlat16_6 = u_xlat16_6 + u_xlat16_6;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2 = u_xlat16_2 * 0.0500000007 + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_2 * _YOffsetDueToWorldX;
    vs_TEXCOORD0.x = u_xlat0.x * in_TEXCOORD0.z + u_xlat16_6;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat0.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat4 = _BGTex_ST.y * _BGTex_ST.w;
    u_xlat0.x = u_xlat0.x * _BGTex_ST.y + (-u_xlat4);
    u_xlat0.x = u_xlat0.x + 0.5;
    vs_TEXCOORD0.y = u_xlat16_2 * _YOffsetDueToWorldX + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _GlassColTex_ST.xy + _GlassColTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_COLOR0.xyz = in_COLOR0.xyz;
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
uniform 	mediump vec4 _SkyCol;
uniform 	mediump vec3 _BGTint;
uniform 	mediump float _GlassColPower;
uniform 	mediump float _GlassColFromDist;
uniform 	mediump float _WorldColTintFromDist;
uniform 	mediump float _BGDistStr;
uniform 	mediump float _LeadlinesBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BGTex;
uniform lowp sampler2D _GlassColTex;
uniform lowp sampler2D _LeadLinesTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0.xyz = texture2D(_GlassColTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_15 = texture2D(_LeadLinesTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.x = u_xlat10_15 + _LeadlinesBrightness;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0.x = texture2D(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat0 = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_16 = max(u_xlat0, 0.0);
    u_xlat16_16 = u_xlat10_15 * u_xlat16_16;
    u_xlat16_2.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat5.xy = vec2(u_xlat0) * vec2(vec2(_BGDistStr, _BGDistStr)) + vs_TEXCOORD0.xy;
    u_xlat16_16 = max((-u_xlat0), 0.0);
    u_xlat16_16 = u_xlat10_15 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * _WorldColTintFromDist;
    u_xlat10_0 = texture2D(_BGTex, u_xlat5.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _BGTint.xyz;
    u_xlat16_17 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4 = vec4(u_xlat16_17) * _SkyCol;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GlassColPower, _GlassColPower, _GlassColPower)) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_GlassColFromDist) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _BGTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	vec4 _GlassColTex_ST;
uniform 	mediump float _YOffsetDueToWorldX;
uniform 	mediump float _BGTexXOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.x = in_POSITION0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x * in_POSITION0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].x * in_POSITION0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].x * in_POSITION0.w + u_xlat1.x;
    u_xlat16_2 = (-u_xlat1.x) + _BGTexXOffset;
    u_xlat5 = (-u_xlat0.x) * 0.100000001 + u_xlat16_2;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat9 = (-_BGTex_ST.z) + 1.0;
    u_xlat5 = u_xlat9 * u_xlat5;
    u_xlat5 = (-u_xlat0.x) * _BGTex_ST.z + u_xlat5;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat5 * _BGTex_ST.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat4 = dot(u_xlat3.xyz, in_POSITION0.xyz);
    u_xlat0.x = u_xlat4 * _BGTex_ST.x + (-u_xlat0.x);
    u_xlat16_2 = (-u_xlat4) + u_xlat1.x;
    u_xlat16_2 = u_xlat16_2 + -245.0;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat16_6 = u_xlat16_2 * 0.0500000007 + -1.0;
    u_xlat16_6 = u_xlat16_6 + u_xlat16_6;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2 = u_xlat16_2 * 0.0500000007 + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_2 * _YOffsetDueToWorldX;
    vs_TEXCOORD0.x = u_xlat0.x * in_TEXCOORD0.z + u_xlat16_6;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat0.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat4 = _BGTex_ST.y * _BGTex_ST.w;
    u_xlat0.x = u_xlat0.x * _BGTex_ST.y + (-u_xlat4);
    u_xlat0.x = u_xlat0.x + 0.5;
    vs_TEXCOORD0.y = u_xlat16_2 * _YOffsetDueToWorldX + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _GlassColTex_ST.xy + _GlassColTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_COLOR0.xyz = in_COLOR0.xyz;
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
uniform 	mediump vec4 _SkyCol;
uniform 	mediump vec3 _BGTint;
uniform 	mediump float _GlassColPower;
uniform 	mediump float _GlassColFromDist;
uniform 	mediump float _WorldColTintFromDist;
uniform 	mediump float _BGDistStr;
uniform 	mediump float _LeadlinesBrightness;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(1) uniform mediump sampler2D _BGTex;
UNITY_LOCATION(2) uniform mediump sampler2D _GlassColTex;
UNITY_LOCATION(3) uniform mediump sampler2D _LeadLinesTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0.xyz = texture(_GlassColTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_15 = texture(_LeadLinesTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.x = u_xlat16_15 + _LeadlinesBrightness;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_0.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat0 = u_xlat16_0.x * 2.0 + -1.0;
    u_xlat16_16 = max(u_xlat0, 0.0);
    u_xlat16_16 = u_xlat16_15 * u_xlat16_16;
    u_xlat16_2.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat5.xy = vec2(u_xlat0) * vec2(vec2(_BGDistStr, _BGDistStr)) + vs_TEXCOORD0.xy;
    u_xlat16_16 = max((-u_xlat0), 0.0);
    u_xlat16_16 = u_xlat16_15 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * _WorldColTintFromDist;
    u_xlat16_0 = texture(_BGTex, u_xlat5.xy);
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BGTint.xyz;
    u_xlat16_17 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4 = vec4(u_xlat16_17) * _SkyCol;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.www + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GlassColPower, _GlassColPower, _GlassColPower)) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_GlassColFromDist) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
}
}
}
}