//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TextMeshPro/Mobile/Distance Field_SEdit2" {
Properties {
_FaceColor ("Face Color", Color) = (1,1,1,1)
_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
_UnderlayColor ("Border Color", Color) = (0,0,0,0.5)
_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
_WeightNormal ("Weight Normal", Float) = 0
_WeightBold ("Weight Bold", Float) = 0.5
_ShaderFlags ("Flags", Float) = 0
_ScaleRatioA ("Scale RatioA", Float) = 1
_ScaleRatioB ("Scale RatioB", Float) = 1
_ScaleRatioC ("Scale RatioC", Float) = 1
_MainTex ("Font Atlas", 2D) = "white" { }
_TextureWidth ("Texture Width", Float) = 512
_TextureHeight ("Texture Height", Float) = 512
_GradientScale ("Gradient Scale", Float) = 5
_ScaleX ("Scale X", Float) = 1
_ScaleY ("Scale Y", Float) = 1
_Sharpness ("Sharpness", Range(-1, 1)) = 0
_VertexOffsetX ("Vertex OffsetX", Float) = 0
_VertexOffsetY ("Vertex OffsetY", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 41642
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _Sharpness;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
float u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = in_COLOR0 * _FaceColor;
    vs_COLOR0.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    vs_COLOR0.w = u_xlat16_1.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat0.xy = u_xlat0.ww / u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat6 = _Sharpness + 1.0;
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlatb2 = 0.0>=in_TEXCOORD1.y;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat2 = u_xlat2 * u_xlat5 + _WeightNormal;
    u_xlat2 = u_xlat2 * 0.25 + _FaceDilate;
    u_xlat2 = u_xlat2 * _ScaleRatioA;
    u_xlat2 = (-u_xlat2) * 0.5 + 0.5;
    u_xlat0.yzw = vec3(u_xlat2) * u_xlat0.xxx + vec3(-0.5, -0.5, -0.5);
    vs_TEXCOORD1 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _Sharpness;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
float u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = in_COLOR0 * _FaceColor;
    vs_COLOR0.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    vs_COLOR0.w = u_xlat16_1.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat0.xy = u_xlat0.ww / u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat6 = _Sharpness + 1.0;
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb2 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat2 = u_xlat2 * u_xlat5 + _WeightNormal;
    u_xlat2 = u_xlat2 * 0.25 + _FaceDilate;
    u_xlat2 = u_xlat2 * _ScaleRatioA;
    u_xlat2 = (-u_xlat2) * 0.5 + 0.5;
    u_xlat0.yzw = vec3(u_xlat2) * u_xlat0.xxx + vec3(-0.5, -0.5, -0.5);
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "UNDERLAY_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _Sharpness;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1.xyz = in_COLOR0.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = u_xlat16_1 * _FaceColor;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat16_1.www + (-_UnderlayColor.xyz);
    vs_COLOR1.xyz = u_xlat16_3.xyz * _UnderlayColor.www;
    vs_COLOR0.xyz = u_xlat16_2.xyz;
    vs_COLOR0.w = _FaceColor.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat0.xy = u_xlat0.ww / u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat10.x = _Sharpness + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlatb4 = 0.0>=in_TEXCOORD1.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat9 = (-_WeightNormal) + _WeightBold;
    u_xlat4 = u_xlat4 * u_xlat9 + _WeightNormal;
    u_xlat4 = u_xlat4 * 0.25 + _FaceDilate;
    u_xlat4 = u_xlat4 * _ScaleRatioA;
    u_xlat4 = (-u_xlat4) * 0.5 + 0.5;
    u_xlat0.yzw = vec3(u_xlat4) * u_xlat0.xxx + vec3(-0.5, -0.5, -0.5);
    vs_TEXCOORD1 = u_xlat0;
    vs_TEXCOORD3.z = in_COLOR0.w;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat5.xy = (-u_xlat1.zw) * vec2(_GradientScale);
    u_xlat5.xy = u_xlat5.xy / vec2(_TextureWidth, _TextureHeight);
    vs_TEXCOORD3.xy = u_xlat5.xy + in_TEXCOORD0.xy;
    u_xlat5.x = u_xlat1.x * u_xlat0.x + 1.0;
    u_xlat10.x = u_xlat0.x / u_xlat5.x;
    u_xlat0.x = u_xlat10.x * u_xlat1.y;
    u_xlat5.x = u_xlat4 * u_xlat10.x + -0.5;
    u_xlat10.y = (-u_xlat0.x) * 0.5 + u_xlat5.x;
    vs_TEXCOORD4.xy = u_xlat10.xy;
    vs_COLOR1.w = _UnderlayColor.w;
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
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat10_0 * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR1;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_2 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNDERLAY_ON" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _Sharpness;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1.xyz = in_COLOR0.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = u_xlat16_1 * _FaceColor;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat16_1.www + (-_UnderlayColor.xyz);
    vs_COLOR1.xyz = u_xlat16_3.xyz * _UnderlayColor.www;
    vs_COLOR0.xyz = u_xlat16_2.xyz;
    vs_COLOR0.w = _FaceColor.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat0.xy = u_xlat0.ww / u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat10.x = _Sharpness + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb4 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat9 = (-_WeightNormal) + _WeightBold;
    u_xlat4 = u_xlat4 * u_xlat9 + _WeightNormal;
    u_xlat4 = u_xlat4 * 0.25 + _FaceDilate;
    u_xlat4 = u_xlat4 * _ScaleRatioA;
    u_xlat4 = (-u_xlat4) * 0.5 + 0.5;
    u_xlat0.yzw = vec3(u_xlat4) * u_xlat0.xxx + vec3(-0.5, -0.5, -0.5);
    vs_TEXCOORD1 = u_xlat0;
    vs_TEXCOORD3.z = in_COLOR0.w;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat5.xy = (-u_xlat1.zw) * vec2(_GradientScale);
    u_xlat5.xy = u_xlat5.xy / vec2(_TextureWidth, _TextureHeight);
    vs_TEXCOORD3.xy = u_xlat5.xy + in_TEXCOORD0.xy;
    u_xlat5.x = u_xlat1.x * u_xlat0.x + 1.0;
    u_xlat10.x = u_xlat0.x / u_xlat5.x;
    u_xlat0.x = u_xlat10.x * u_xlat1.y;
    u_xlat5.x = u_xlat4 * u_xlat10.x + -0.5;
    u_xlat10.y = (-u_xlat0.x) * 0.5 + u_xlat5.x;
    vs_TEXCOORD4.xy = u_xlat10.xy;
    vs_COLOR1.w = _UnderlayColor.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR1;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}