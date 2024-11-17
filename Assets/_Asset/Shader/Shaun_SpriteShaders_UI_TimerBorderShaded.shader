//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/SpriteShaders/UI_TimerBorderShaded" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MainLightCol ("Light Tint", Vector) = (1,1,1,1)
_ShadowSub ("Shadow Tint", Vector) = (0,0,0,0)
_GradCol ("Grad Additive Col", Vector) = (0,0,0,0)
_GradientStart ("Zero gradient Y point", Float) = 0
_GradientEnd ("Full gradient Y point", Float) = 2
_TimerValue ("0-1 Timer Value", Float) = 1
_Color ("Secondary Color", Color) = (1,0,0,1)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  Cull Off
  GpuProgramID 4999
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _GradCol;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_gs0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_1.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + (-_GradientStart);
    u_xlat16_3 = (-_GradientStart) + _GradientEnd;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_3;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _GradCol.w;
    vs_gs0 = u_xlat16_1.x;
    u_xlat16_1.xyz = _GradCol.xyz * u_xlat16_1.xxx + in_COLOR0.xyz;
    vs_COLOR0.xyz = u_xlat16_1.xyz * in_COLOR0.www;
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
    vs_COLOR0.w = in_COLOR0.w;
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
uniform 	mediump vec4 _MainLightCol;
uniform 	mediump vec4 _ShadowSub;
uniform 	mediump vec4 _GradCol;
uniform 	mediump vec3 _Color;
uniform 	mediump float _TimerValue;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_gs0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
void main()
{
    u_xlat0 = _TimerValue + -0.00850000046;
    u_xlat16_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = (-u_xlat0) + u_xlat16_1.z;
    u_xlat0 = u_xlat0 * 58.8235245;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat5 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat16_2.xyz = _GradCol.xyz * vec3(vs_gs0) + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _MainLightCol.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainLightCol.www;
    u_xlat16_4.xyz = u_xlat16_1.yyy * _ShadowSub.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _ShadowSub.www + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    SV_Target0 = u_xlat16_1.wwww * u_xlat16_0;
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
uniform 	mediump vec4 _GradCol;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_gs0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_1.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + (-_GradientStart);
    u_xlat16_3 = (-_GradientStart) + _GradientEnd;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * _GradCol.w;
    vs_gs0 = u_xlat16_1.x;
    u_xlat16_1.xyz = _GradCol.xyz * u_xlat16_1.xxx + in_COLOR0.xyz;
    vs_COLOR0.xyz = u_xlat16_1.xyz * in_COLOR0.www;
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
    vs_COLOR0.w = in_COLOR0.w;
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
uniform 	mediump vec4 _MainLightCol;
uniform 	mediump vec4 _ShadowSub;
uniform 	mediump vec4 _GradCol;
uniform 	mediump vec3 _Color;
uniform 	mediump float _TimerValue;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_gs0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
void main()
{
    u_xlat0 = _TimerValue + -0.00850000046;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = (-u_xlat0) + u_xlat16_1.z;
    u_xlat0 = u_xlat0 * 58.8235245;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat16_2.xyz = _GradCol.xyz * vec3(vs_gs0) + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _MainLightCol.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainLightCol.www;
    u_xlat16_4.xyz = u_xlat16_1.yyy * _ShadowSub.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _ShadowSub.www + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    SV_Target0 = u_xlat16_1.wwww * u_xlat16_0;
    return;
}

#endif
"
}
}
}
}
}