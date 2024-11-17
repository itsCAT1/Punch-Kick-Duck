//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/SpriteShaders/UI_BevelledSprites" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MainLightCol ("Light Tint", Vector) = (1,1,1,1)
_ShadowSub ("Shadow Tint", Vector) = (0,0,0,0)
_Color ("Grad Additive Col", Vector) = (0,0,0,0)
_GradientStart ("Zero gradient Y point", Float) = 0
_GradientEnd ("Full gradient Y point", Float) = 2
_EdgeDarken ("Darken towards screen edges strength", Float) = 3
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 48054
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 + (-_GradientStart);
    u_xlat16_5 = (-_GradientStart) + _GradientEnd;
    u_xlat16_2 = u_xlat16_2 / u_xlat16_5;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_2 * _Color.w;
    vs_COLOR0.xyz = _Color.xyz * vec3(u_xlat16_2) + in_COLOR0.xyz;
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
uniform 	mediump float _EdgeDarken;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.x + -0.5;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _EdgeDarken;
    u_xlat16_0.xyz = _ShadowSub.xyz * u_xlat16_0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyw;
    u_xlat16_2.xyz = u_xlat16_1.yyy * _ShadowSub.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowSub.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _MainLightCol.xyz;
    SV_Target0.w = u_xlat16_1.z * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _MainLightCol.www + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2 = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_2 = u_xlat16_2 + (-_GradientStart);
    u_xlat16_5 = (-_GradientStart) + _GradientEnd;
    u_xlat16_2 = u_xlat16_2 / u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_2 * _Color.w;
    vs_COLOR0.xyz = _Color.xyz * vec3(u_xlat16_2) + in_COLOR0.xyz;
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
uniform 	mediump float _EdgeDarken;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.x + -0.5;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _EdgeDarken;
    u_xlat16_0.xyz = _ShadowSub.xyz * u_xlat16_0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyw;
    u_xlat16_2.xyz = u_xlat16_1.yyy * _ShadowSub.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowSub.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _MainLightCol.xyz;
    SV_Target0.w = u_xlat16_1.z * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _MainLightCol.www + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
}
}
}
}