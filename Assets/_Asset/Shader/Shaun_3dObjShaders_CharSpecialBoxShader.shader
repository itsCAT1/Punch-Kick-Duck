//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/CharSpecialBoxShader" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_BGTex ("BG Tex", 2D) = "white" { }
_CharTex ("Char portrait", 2D) = "white" { }
_RBTex ("Rainbow Tex", 2D) = "black" { }
_DistTex ("Dist Tex", 2D) = "white" { }
_TexScaleRatio ("Tex scale ratio", Float) = 1
_BGScaleAndPos ("BG scale + pos", Vector) = (1,0.5,0.5,0)
_CharScaleAndPos ("Char portrait scale + pos", Vector) = (1,0.5,0.5,0)
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_BannerCol1 ("Banner Color 1", Color) = (1,1,1,1)
_BannerCol2 ("Banner Color 2", Color) = (1,1,1,1)
_GradientStart ("Zero gradient Y point", Float) = 0
_GradientEnd ("Full gradient Y point", Float) = 2
_GradientLightCut ("Grad Light Cut", Float) = 1
_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_BackLightLimitForFrontFaces ("Backlight limit on front faces", Float) = 0.25
_ShadowSub ("Shadow Additive Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
_SpecCol ("Specular Color", Color) = (0,0,0,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
}
SubShader {
 Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 12538
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _BackLightLimitForFrontFaces;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump vec3 _BGScaleAndPos;
uniform 	mediump vec3 _CharScaleAndPos;
uniform 	mediump float _TexScaleRatio;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3.x = _BGScaleAndPos.x * _TexScaleRatio;
    vs_TEXCOORD1.y = in_TEXCOORD0.y * abs(u_xlat16_3.x) + _BGScaleAndPos.z;
    u_xlat16_3.x = in_TEXCOORD0.y * _CharScaleAndPos.x;
    vs_TEXCOORD1.w = u_xlat16_3.x * _TexScaleRatio + _CharScaleAndPos.z;
    vs_TEXCOORD1.x = in_TEXCOORD0.x * _BGScaleAndPos.x + _BGScaleAndPos.y;
    vs_TEXCOORD1.z = in_TEXCOORD0.x * _CharScaleAndPos.x + _CharScaleAndPos.y;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_3.x = u_xlat1.z * u_xlat18 + 0.75;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = max(u_xlat16_3.x, _BackLightLimitForFrontFaces);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_9 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_9 = max(u_xlat16_9, 0.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * _BackLightDir.w;
    u_xlat16_9 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_15.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_9 = u_xlat16_9 / u_xlat16_15.x;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * _GradientSubColor.w;
    u_xlat16_15.xy = (-vec2(u_xlat16_9)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_3.x = u_xlat16_15.y * u_xlat16_3.x;
    u_xlat16_15.y = (-u_xlat16_9) * _GradientShadowCut + 1.0;
    u_xlat16_4.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_10 = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_10;
    u_xlat16_4.y = u_xlat16_10 * _MainLightDir.w;
    u_xlat16_15.xy = u_xlat16_15.xy * u_xlat16_4.yx;
    u_xlat16_4.xyz = u_xlat16_15.yyy * _ShadowSub.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_21 = u_xlat0.z + -1.0;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_21 = (-u_xlat16_21) * 0.0500000007 + 0.800000012;
    u_xlat16_5.xy = vec2(u_xlat16_21);
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_5.y;
    u_xlat16_4.xyz = _MainLightCol.xyz * u_xlat16_15.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xzw = _BackLightCol.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_COLOR0.xyz = _GradientSubColor.xyz * vec3(u_xlat16_9) + u_xlat16_3.xzw;
    vs_COLOR1.z = u_xlat16_5.y * 0.5 + 0.5;
    vs_COLOR1.xy = u_xlat16_5.xy;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * vec3(-3.0, -3.0, -3.0) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat1.x = dot(u_xlat0.xy, vec2(0.600000024, 0.349999994));
    u_xlat1.y = dot(u_xlat0.xy, vec2(-0.349999994, 0.600000024));
    u_xlat1.z = u_xlat0.z;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BannerCol1;
uniform 	mediump vec3 _BannerCol2;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _RBTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BGTex;
uniform lowp sampler2D _CharTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.xy = vs_TEXCOORD0.xy * vec2(2.5, 2.5);
    u_xlat10_18 = texture2D(_DistTex, u_xlat16_1.xy).w;
    u_xlat16_1.x = u_xlat10_18 * 1.64999998 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * 0.25;
    u_xlat16_1.yz = u_xlat16_1.xx * vec2(1.0, -1.0) + vec2(0.317999989, 0.423999995);
    u_xlat16_1.w = -0.84799999;
    u_xlat16_2.xyz = u_xlat16_1.xzw + vec3(0.317999989, 0.0, 0.0);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot((-u_xlat16_2.xyz), u_xlat16_3.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_2.xyz = u_xlat16_3.xyz * (-u_xlat16_1.xxx) + (-u_xlat16_2.xyz);
    u_xlat16_1.x = dot(u_xlat16_3.xyz, u_xlat16_1.yzw);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _Shininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture2D(_BGTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_19 = u_xlat10_2.w + -0.5;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_19;
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) * vec3(u_xlat16_19) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = u_xlat16_3.y * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.z * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_19 * u_xlat16_3.x;
    u_xlat16_9.xy = vec2(u_xlat16_19) * u_xlat10_2.xy;
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_4.xyz = u_xlat16_9.xxx * _BannerCol1.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xzw = _BannerCol2.xyz * u_xlat16_9.yyy + u_xlat16_4.xyz;
    u_xlat16_3.xzw = u_xlat10_2.xyz * vec3(u_xlat16_19) + u_xlat16_3.xzw;
    u_xlat16_19 = u_xlat10_2.w + u_xlat10_2.w;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat10_2 = texture2D(_CharTex, vs_TEXCOORD1.zw);
    u_xlat16_4.x = u_xlat10_2.w + u_xlat10_2.w;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_19) + u_xlat16_4.x;
    u_xlat16_10.x = u_xlat10_2.w + -0.5;
    u_xlat16_4.y = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_10.xyz = u_xlat10_2.xyz * u_xlat16_4.xxx;
    u_xlat16_5 = (-u_xlat16_4.x) + 1.0;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_4.x;
    SV_Target0.w = min(u_xlat16_19, 1.0);
    u_xlat16_3.xzw = u_xlat16_3.xzw * vec3(u_xlat16_5) + u_xlat16_10.xyz;
    u_xlat16_19 = u_xlat16_9.x * u_xlat16_5;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vs_TEXCOORD2.xy;
    u_xlat16_4.xy = vec2(u_xlat10_18) * vec2(0.349999994, 0.349999994) + u_xlat16_4.xy;
    u_xlat16_4.z = u_xlat16_4.x + 1.10000002;
    u_xlat16_4.xy = u_xlat16_4.zy * vec2(0.174999997, 0.174999997);
    u_xlat10_0.xyz = texture2D(_RBTex, u_xlat16_4.xy).xyz;
    u_xlat16_9.x = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_9.x = u_xlat10_0.z + u_xlat16_9.x;
    u_xlat16_4.xyz = u_xlat16_9.xxx * vec3(0.349999994, 0.349999994, 0.349999994) + u_xlat10_0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_19) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(0.349999994, 0.349999994, 0.349999994) + u_xlat16_3.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + u_xlat16_3.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _BackLightLimitForFrontFaces;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
uniform 	mediump vec3 _BGScaleAndPos;
uniform 	mediump vec3 _CharScaleAndPos;
uniform 	mediump float _TexScaleRatio;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3.x = _BGScaleAndPos.x * _TexScaleRatio;
    vs_TEXCOORD1.y = in_TEXCOORD0.y * abs(u_xlat16_3.x) + _BGScaleAndPos.z;
    u_xlat16_3.x = in_TEXCOORD0.y * _CharScaleAndPos.x;
    vs_TEXCOORD1.w = u_xlat16_3.x * _TexScaleRatio + _CharScaleAndPos.z;
    vs_TEXCOORD1.x = in_TEXCOORD0.x * _BGScaleAndPos.x + _BGScaleAndPos.y;
    vs_TEXCOORD1.z = in_TEXCOORD0.x * _CharScaleAndPos.x + _CharScaleAndPos.y;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_3.x = u_xlat1.z * u_xlat18 + 0.75;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = max(u_xlat16_3.x, _BackLightLimitForFrontFaces);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_9 = dot(u_xlat1.xyz, _BackLightDir.xyz);
    u_xlat16_9 = max(u_xlat16_9, 0.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * _BackLightDir.w;
    u_xlat16_9 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_15.x = (-_GradientStart) + _GradientEnd;
    u_xlat16_9 = u_xlat16_9 / u_xlat16_15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * _GradientSubColor.w;
    u_xlat16_15.xy = (-vec2(u_xlat16_9)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat16_3.x = u_xlat16_15.y * u_xlat16_3.x;
    u_xlat16_15.y = (-u_xlat16_9) * _GradientShadowCut + 1.0;
    u_xlat16_4.x = dot(u_xlat1.xyz, _MainLightDir.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_10 = max(u_xlat16_4.x, 0.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_10;
    u_xlat16_4.y = u_xlat16_10 * _MainLightDir.w;
    u_xlat16_15.xy = u_xlat16_15.xy * u_xlat16_4.yx;
    u_xlat16_4.xyz = u_xlat16_15.yyy * _ShadowSub.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_21 = u_xlat0.z + -1.0;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_21 = (-u_xlat16_21) * 0.0500000007 + 0.800000012;
    u_xlat16_5.xy = vec2(u_xlat16_21);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_5.y;
    u_xlat16_4.xyz = _MainLightCol.xyz * u_xlat16_15.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xzw = _BackLightCol.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_COLOR0.xyz = _GradientSubColor.xyz * vec3(u_xlat16_9) + u_xlat16_3.xzw;
    vs_COLOR1.z = u_xlat16_5.y * 0.5 + 0.5;
    vs_COLOR1.xy = u_xlat16_5.xy;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * vec3(-3.0, -3.0, -3.0) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat1.x = dot(u_xlat0.xy, vec2(0.600000024, 0.349999994));
    u_xlat1.y = dot(u_xlat0.xy, vec2(-0.349999994, 0.600000024));
    u_xlat1.z = u_xlat0.z;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BannerCol1;
uniform 	mediump vec3 _BannerCol2;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RBTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(3) uniform mediump sampler2D _BGTex;
UNITY_LOCATION(4) uniform mediump sampler2D _CharTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.xy = vs_TEXCOORD0.xy * vec2(2.5, 2.5);
    u_xlat16_18 = texture(_DistTex, u_xlat16_1.xy).w;
    u_xlat16_1.x = u_xlat16_18 * 1.64999998 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * 0.25;
    u_xlat16_1.yz = u_xlat16_1.xx * vec2(1.0, -1.0) + vec2(0.317999989, 0.423999995);
    u_xlat16_1.w = -0.84799999;
    u_xlat16_2.xyz = u_xlat16_1.xzw + vec3(0.317999989, 0.0, 0.0);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot((-u_xlat16_2.xyz), u_xlat16_3.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_2.xyz = u_xlat16_3.xyz * (-u_xlat16_1.xxx) + (-u_xlat16_2.xyz);
    u_xlat16_1.x = dot(u_xlat16_3.xyz, u_xlat16_1.yzw);
    u_xlat16_1.x = u_xlat16_1.x * _SpecPower;
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _Shininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_2.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xxx;
    u_xlat16_0.xyz = texture(_BGTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_19 = u_xlat16_2.w + -0.5;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_19;
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) * vec3(u_xlat16_19) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = u_xlat16_3.y * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.z * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_19 * u_xlat16_3.x;
    u_xlat16_9.xy = vec2(u_xlat16_19) * u_xlat16_2.xy;
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_4.xyz = u_xlat16_9.xxx * _BannerCol1.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xzw = _BannerCol2.xyz * u_xlat16_9.yyy + u_xlat16_4.xyz;
    u_xlat16_3.xzw = u_xlat16_2.xyz * vec3(u_xlat16_19) + u_xlat16_3.xzw;
    u_xlat16_19 = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_2 = texture(_CharTex, vs_TEXCOORD1.zw);
    u_xlat16_4.x = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_19) + u_xlat16_4.x;
    u_xlat16_10.x = u_xlat16_2.w + -0.5;
    u_xlat16_4.y = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_10.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
    u_xlat16_5 = (-u_xlat16_4.x) + 1.0;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_4.x;
    SV_Target0.w = min(u_xlat16_19, 1.0);
    u_xlat16_3.xzw = u_xlat16_3.xzw * vec3(u_xlat16_5) + u_xlat16_10.xyz;
    u_xlat16_19 = u_xlat16_9.x * u_xlat16_5;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vs_TEXCOORD2.xy;
    u_xlat16_4.xy = vec2(u_xlat16_18) * vec2(0.349999994, 0.349999994) + u_xlat16_4.xy;
    u_xlat16_4.z = u_xlat16_4.x + 1.10000002;
    u_xlat16_4.xy = u_xlat16_4.zy * vec2(0.174999997, 0.174999997);
    u_xlat16_0.xyz = texture(_RBTex, u_xlat16_4.xy).xyz;
    u_xlat16_9.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_9.x = u_xlat16_0.z + u_xlat16_9.x;
    u_xlat16_4.xyz = u_xlat16_9.xxx * vec3(0.349999994, 0.349999994, 0.349999994) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_19) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(0.349999994, 0.349999994, 0.349999994) + u_xlat16_3.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + u_xlat16_3.xyz;
    return;
}

#endif
"
}
}
}
}
}