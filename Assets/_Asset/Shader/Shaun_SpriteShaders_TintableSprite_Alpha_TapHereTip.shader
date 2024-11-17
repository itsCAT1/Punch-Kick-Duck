//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/SpriteShaders/TintableSprite_Alpha_TapHereTip" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_AltTex ("Scrolling pattern", 2D) = "white" { }
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 1874
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
void main()
{
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = _ScreenParams.x / _ScreenParams.y;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_2.y;
    vs_TEXCOORD2.xzw = u_xlat0.xzw;
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
uniform 	vec4 unity_OrthoParams;
uniform 	float _zeroToOneTimeCount_oneFiftiethSpeed;
uniform 	mediump vec2 _ShaderVec4;
uniform mediump sampler2D _MainTex;
uniform lowp sampler2D _AltTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _zeroToOneTimeCount_oneFiftiethSpeed * 3.0;
    u_xlat16_1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = (-u_xlat0.x) * _ShaderVec4.x + u_xlat16_1.x;
    u_xlat2.y = u_xlat16_1.y * 36.0;
    u_xlat2.x = u_xlat0.x * 36.0;
    u_xlat0.x = unity_OrthoParams.x / unity_OrthoParams.y;
    u_xlat0.xy = u_xlat2.xy / u_xlat0.xx;
    u_xlat10_0 = texture2D(_AltTex, u_xlat0.xy).w;
    u_xlat16_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = (-u_xlat16_1.z) * vs_COLOR0.z + u_xlat10_0;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0.x = u_xlat0.x * _ShaderVec4.y;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.xyz = vs_COLOR0.xyz * u_xlat0.xxx + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
void main()
{
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = _ScreenParams.x / _ScreenParams.y;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_2.y;
    vs_TEXCOORD2.xzw = u_xlat0.xzw;
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
uniform 	vec4 unity_OrthoParams;
uniform 	float _zeroToOneTimeCount_oneFiftiethSpeed;
uniform 	mediump vec2 _ShaderVec4;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _AltTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _zeroToOneTimeCount_oneFiftiethSpeed * 3.0;
    u_xlat16_1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = (-u_xlat0.x) * _ShaderVec4.x + u_xlat16_1.x;
    u_xlat2.y = u_xlat16_1.y * 36.0;
    u_xlat2.x = u_xlat0.x * 36.0;
    u_xlat0.x = unity_OrthoParams.x / unity_OrthoParams.y;
    u_xlat0.xy = u_xlat2.xy / u_xlat0.xx;
    u_xlat16_0 = texture(_AltTex, u_xlat0.xy).w;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = (-u_xlat16_1.z) * vs_COLOR0.z + u_xlat16_0;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0.x = u_xlat0.x * _ShaderVec4.y;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.xyz = vs_COLOR0.xyz * u_xlat0.xxx + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
}
}
}
}