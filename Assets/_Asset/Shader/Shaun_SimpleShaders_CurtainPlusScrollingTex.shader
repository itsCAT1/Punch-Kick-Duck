//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/SimpleShaders/CurtainPlusScrollingTex" {
Properties {
_PatternTex ("Pattern Tex", 2D) = "white" { }
_TexScale ("Pattern scale", Vector) = (0.0017,0.0025,0,0)
_PatternCol ("Pattern col", Color) = (1,1,1,1)
_ColorTop ("Top Color", Color) = (1,1,1,1)
_ColorBottom ("Bottom Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 5803
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorTop;
uniform 	mediump vec4 _ColorBottom;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat16_2.xyz = _ColorTop.xyz + (-_ColorBottom.xyz);
    vs_COLOR0.xyz = in_TEXCOORD0.yyy * u_xlat16_2.xyz + _ColorBottom.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _TexScale;
uniform 	mediump vec4 _PatternCol;
uniform 	float _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause;
uniform mediump sampler2D _PatternTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat4;
void main()
{
    u_xlat0.x = max(_ScreenParams.y, _ScreenParams.x);
    u_xlat0.x = 100.0 / u_xlat0.x;
    u_xlat0.xy = u_xlat0.xx * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * _TexScale.xy;
    u_xlat16_1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat4 = dot(u_xlat0.xy, vec2(1.0, -0.0350000001));
    u_xlat0.x = dot(u_xlat0.xy, vec2(0.0350000001, 1.0));
    u_xlat0.y = _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause * 3.0 + u_xlat0.x;
    u_xlat0.x = u_xlat4 + _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause;
    u_xlat16_0 = texture2D(_PatternTex, u_xlat0.xy).w;
    u_xlat16_1.xyz = vec3(u_xlat16_0) * _PatternCol.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _PatternCol.www + vs_COLOR0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorTop;
uniform 	mediump vec4 _ColorBottom;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat16_2.xyz = _ColorTop.xyz + (-_ColorBottom.xyz);
    vs_COLOR0.xyz = in_TEXCOORD0.yyy * u_xlat16_2.xyz + _ColorBottom.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _TexScale;
uniform 	mediump vec4 _PatternCol;
uniform 	float _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause;
UNITY_LOCATION(0) uniform mediump sampler2D _PatternTex;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat4;
void main()
{
    u_xlat0.x = max(_ScreenParams.y, _ScreenParams.x);
    u_xlat0.x = 100.0 / u_xlat0.x;
    u_xlat0.xy = u_xlat0.xx * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * _TexScale.xy;
    u_xlat16_1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat4 = dot(u_xlat0.xy, vec2(1.0, -0.0350000001));
    u_xlat0.x = dot(u_xlat0.xy, vec2(0.0350000001, 1.0));
    u_xlat0.y = _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause * 3.0 + u_xlat0.x;
    u_xlat0.x = u_xlat4 + _zeroToOneTimeCount_pointZeroOneFiveSpeed_noPause;
    u_xlat16_0 = texture(_PatternTex, u_xlat0.xy).w;
    u_xlat16_1.xyz = vec3(u_xlat16_0) * _PatternCol.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _PatternCol.www + vs_COLOR0.xyz;
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