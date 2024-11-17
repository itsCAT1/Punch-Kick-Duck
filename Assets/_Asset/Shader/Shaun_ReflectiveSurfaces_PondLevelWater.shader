//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/ReflectiveSurfaces/PondLevelWater" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_SurfaceTex ("DistortionTex", 2D) = "white" { }
_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
_AmbientT ("Ambient color top", Color) = (0,0,0,1)
_AmbientB ("Ambient color bott", Color) = (0,0,0,1)
_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
_RipplePosXY_EndAndStartSize ("Ripple pos, endsize, startsize", Vector) = (0.5,0.5,0,0)
_CurrRippleScales ("Curr ripple scales", Vector) = (0,0,0,1)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Fog {
   Mode Off
  }
  GpuProgramID 47012
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec4 _Reflectivity;
uniform 	mediump vec4 _MetalMult;
uniform 	mediump vec3 _AmbientT;
uniform 	mediump vec3 _AmbientB;
uniform 	mediump vec4 _CurrRippleScales;
uniform 	mediump vec4 _RipplePosXY_EndAndStartSize;
attribute mediump vec4 in_POSITION0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_6;
mediump vec2 u_xlat16_10;
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
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, in_POSITION0.xyz);
    u_xlat16_1 = _CurrRippleScales.xxyy * _RipplePosXY_EndAndStartSize.xyxy;
    u_xlat16_6.xy = u_xlat16_2.xx * _CurrRippleScales.xy + (-u_xlat16_1.xz);
    phase0_Output0_1.xz = u_xlat16_6.xy + vec2(0.5, 0.5);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat16_6.x = dot(u_xlat3.xyz, in_POSITION0.xyz);
    u_xlat16_10.xy = u_xlat16_6.xx * _CurrRippleScales.xy + (-u_xlat16_1.yw);
    phase0_Output0_1.yw = u_xlat16_10.xy + vec2(0.5, 0.5);
    u_xlat16_1 = _CurrRippleScales.zzww * _RipplePosXY_EndAndStartSize.xyxy;
    u_xlat16_2.xz = u_xlat16_2.xx * _CurrRippleScales.zw + (-u_xlat16_1.xz);
    u_xlat16_2.yw = u_xlat16_6.xx * _CurrRippleScales.zw + (-u_xlat16_1.yw);
    phase0_Output0_2 = u_xlat16_2 + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    u_xlat16_2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat0.x * -0.0166599993;
    vs_TEXCOORD4.x = u_xlat16_2.z + u_xlat16_2.x;
    vs_TEXCOORD4.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.z;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_10.x = in_POSITION0.y * 0.0952399969 + 1.0;
    vs_TEXCOORD5.x = u_xlat16_10.x * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD5.y = u_xlat16_10.x * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xyw = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = u_xlat16_10.xxx * u_xlat16_2.xyw + _AmbientB.xyz;
    vs_COLOR0.w = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec4 _CurrRippleScales;
uniform 	mediump vec4 _RipplePosXY_EndAndStartSize;
uniform mediump sampler2D _SurfaceTex;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.x = texture2D(_SurfaceTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3 = texture2D(_SurfaceTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.x = (-_RipplePosXY_EndAndStartSize.z) + _RipplePosXY_EndAndStartSize.w;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_2 = _CurrRippleScales + (-_RipplePosXY_EndAndStartSize.zzzz);
    u_xlat16_1 = u_xlat16_1.xxxx * u_xlat16_2;
    u_xlat3 = u_xlat16_3 * u_xlat16_1.y;
    u_xlat0.x = u_xlat16_0.x * u_xlat16_1.x + u_xlat3;
    u_xlat16_3 = texture2D(_SurfaceTex, vs_TEXCOORD2.xy).w;
    u_xlat0.x = u_xlat16_3 * u_xlat16_1.z + u_xlat0.x;
    u_xlat16_3 = texture2D(_SurfaceTex, vs_TEXCOORD3.xy).w;
    u_xlat0.x = u_xlat16_3 * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_4 = u_xlat0.x * 3.0;
    u_xlat16_1.x = u_xlat16_1.x * 2.5 + u_xlat16_4;
    u_xlat16_1.y = u_xlat16_1.x * vs_TEXCOORD5.z;
    u_xlat16_2.xy = u_xlat16_1.yx * vec2(0.0500000007, 0.0649999976);
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3 = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat0.z = u_xlat3 * _RefTexAdj.x;
    u_xlat0.xy = u_xlat16_2.xy + u_xlat0.xz;
    u_xlat16_0.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-vs_COLOR0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vs_TEXCOORD5.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.xxx * u_xlat16_1.xyz + vs_COLOR0.xyz;
    SV_Target0.w = vs_TEXCOORD5.x;
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
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec4 _Reflectivity;
uniform 	mediump vec4 _MetalMult;
uniform 	mediump vec3 _AmbientT;
uniform 	mediump vec3 _AmbientB;
uniform 	mediump vec4 _CurrRippleScales;
uniform 	mediump vec4 _RipplePosXY_EndAndStartSize;
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_6;
mediump vec2 u_xlat16_10;
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
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, in_POSITION0.xyz);
    u_xlat16_1 = _CurrRippleScales.xxyy * _RipplePosXY_EndAndStartSize.xyxy;
    u_xlat16_6.xy = u_xlat16_2.xx * _CurrRippleScales.xy + (-u_xlat16_1.xz);
    phase0_Output0_1.xz = u_xlat16_6.xy + vec2(0.5, 0.5);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat16_6.x = dot(u_xlat3.xyz, in_POSITION0.xyz);
    u_xlat16_10.xy = u_xlat16_6.xx * _CurrRippleScales.xy + (-u_xlat16_1.yw);
    phase0_Output0_1.yw = u_xlat16_10.xy + vec2(0.5, 0.5);
    u_xlat16_1 = _CurrRippleScales.zzww * _RipplePosXY_EndAndStartSize.xyxy;
    u_xlat16_2.xz = u_xlat16_2.xx * _CurrRippleScales.zw + (-u_xlat16_1.xz);
    u_xlat16_2.yw = u_xlat16_6.xx * _CurrRippleScales.zw + (-u_xlat16_1.yw);
    phase0_Output0_2 = u_xlat16_2 + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    u_xlat16_2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat0.x * -0.0166599993;
    vs_TEXCOORD4.x = u_xlat16_2.z + u_xlat16_2.x;
    vs_TEXCOORD4.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.z;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_10.x = in_POSITION0.y * 0.0952399969 + 1.0;
    vs_TEXCOORD5.x = u_xlat16_10.x * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD5.y = u_xlat16_10.x * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xyw = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = u_xlat16_10.xxx * u_xlat16_2.xyw + _AmbientB.xyz;
    vs_COLOR0.w = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec4 _CurrRippleScales;
uniform 	mediump vec4 _RipplePosXY_EndAndStartSize;
UNITY_LOCATION(0) uniform mediump sampler2D _SurfaceTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.x = texture(_SurfaceTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3 = texture(_SurfaceTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.x = (-_RipplePosXY_EndAndStartSize.z) + _RipplePosXY_EndAndStartSize.w;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_2 = _CurrRippleScales + (-_RipplePosXY_EndAndStartSize.zzzz);
    u_xlat16_1 = u_xlat16_1.xxxx * u_xlat16_2;
    u_xlat3 = u_xlat16_3 * u_xlat16_1.y;
    u_xlat0.x = u_xlat16_0.x * u_xlat16_1.x + u_xlat3;
    u_xlat16_3 = texture(_SurfaceTex, vs_TEXCOORD2.xy).w;
    u_xlat0.x = u_xlat16_3 * u_xlat16_1.z + u_xlat0.x;
    u_xlat16_3 = texture(_SurfaceTex, vs_TEXCOORD3.xy).w;
    u_xlat0.x = u_xlat16_3 * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_4 = u_xlat0.x * 3.0;
    u_xlat16_1.x = u_xlat16_1.x * 2.5 + u_xlat16_4;
    u_xlat16_1.y = u_xlat16_1.x * vs_TEXCOORD5.z;
    u_xlat16_2.xy = u_xlat16_1.yx * vec2(0.0500000007, 0.0649999976);
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3 = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat0.z = u_xlat3 * _RefTexAdj.x;
    u_xlat0.xy = u_xlat16_2.xy + u_xlat0.xz;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-vs_COLOR0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vs_TEXCOORD5.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.xxx * u_xlat16_1.xyz + vs_COLOR0.xyz;
    SV_Target0.w = vs_TEXCOORD5.x;
    return;
}

#endif
"
}
}
}
}
}