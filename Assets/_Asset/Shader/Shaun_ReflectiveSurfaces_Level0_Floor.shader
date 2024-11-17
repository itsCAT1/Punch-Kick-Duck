//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/ReflectiveSurfaces/Level0_Floor" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_SurfaceTex ("FloorTex", 2D) = "white" { }
_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
_VBlur ("Vertical Blur", Float) = 0
_AmbientT ("Ambient color top", Color) = (0,0,0,1)
_AmbientB ("Ambient color bott", Color) = (0,0,0,1)
_AddColT ("Add color top", Color) = (0,0,0,1)
_AddColB ("Add color bott", Color) = (0,0,0,1)
_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
_EdgeDarkening ("Edge darken factor", Float) = 0.5
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Fog {
   Mode Off
  }
  GpuProgramID 9770
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
uniform 	mediump vec3 _AddColT;
uniform 	mediump vec3 _AddColB;
uniform 	mediump float _EdgeDarkening;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat16_10 = min((-in_NORMAL0.z), 0.0);
    u_xlat16_14 = u_xlat16_10 + in_NORMAL0.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_3 = u_xlat16_14 + 1.0;
    u_xlat16_14 = u_xlat16_14 * _EdgeDarkening + 1.0;
    u_xlat16_6 = u_xlat16_2.y * u_xlat16_3;
    u_xlat16_2.x = u_xlat16_3 * u_xlat16_2.x + (-u_xlat16_6);
    u_xlat16_3 = in_POSITION0.y * 0.0952399969 + 1.0;
    vs_TEXCOORD2.x = u_xlat16_3 * u_xlat16_2.x + u_xlat16_6;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_3 * u_xlat16_2.x + u_xlat16_2.y;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat16_7.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.x = u_xlat16_7.z + u_xlat16_7.x;
    vs_TEXCOORD1.y = u_xlat16_7.y * _ProjectionParams.x + u_xlat16_7.z;
    u_xlat16_7.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_3) * u_xlat16_7.xyz + _AmbientB.xyz;
    u_xlat16_2.xyw = vec3(u_xlat16_14) * u_xlat16_7.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_2.xyw;
    u_xlat16_2.xyz = _AddColT.xyz + (-_AddColB.xyz);
    vs_COLOR1.xyz = vec3(u_xlat16_3) * u_xlat16_2.xyz + _AddColB.xyz;
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
uniform 	mediump float _VBlur;
uniform 	mediump vec4 _RefTexAdj;
uniform mediump sampler2D _SurfaceTex;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_COLOR1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
    u_xlat16_1.x = (-u_xlat16_0.x) + _RefTexAdj.y;
    u_xlat16_0.z = u_xlat16_1.x * _RefTexAdj.x;
    u_xlat16_2.xyz = texture2D(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_7 = _VBlur * _RefTexAdj.z;
    u_xlat16_0.w = u_xlat16_1.x * _RefTexAdj.x + u_xlat16_7;
    u_xlat16_0.x = u_xlat16_1.x * _RefTexAdj.x + (-u_xlat16_7);
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_0.yw).xyz;
    u_xlat16_0.z = _VBlur * _RefTexAdj.z + u_xlat16_0.w;
    u_xlat16_1.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = texture2D(_MainTex, u_xlat16_0.yx).xyz;
    u_xlat16_0.w = (-_VBlur) * _RefTexAdj.z + u_xlat16_0.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture2D(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_0.x = _VBlur * _RefTexAdj.z + u_xlat16_0.z;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture2D(_MainTex, u_xlat16_0.yw).xyz;
    u_xlat16_0.z = (-_VBlur) * _RefTexAdj.z + u_xlat16_0.w;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture2D(_MainTex, u_xlat16_0.yx).xyz;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * vec3(0.143000007, 0.143000007, 0.143000007) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2 = texture2D(_SurfaceTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_2.xyz + vs_COLOR1.xyz;
    u_xlat16_18 = u_xlat16_2.w * vs_TEXCOORD2.x;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.143000007, 0.143000007, 0.143000007) + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec3 _AddColT;
uniform 	mediump vec3 _AddColB;
uniform 	mediump float _EdgeDarkening;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat16_10 = min((-in_NORMAL0.z), 0.0);
    u_xlat16_14 = u_xlat16_10 + in_NORMAL0.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_3 = u_xlat16_14 + 1.0;
    u_xlat16_14 = u_xlat16_14 * _EdgeDarkening + 1.0;
    u_xlat16_6 = u_xlat16_2.y * u_xlat16_3;
    u_xlat16_2.x = u_xlat16_3 * u_xlat16_2.x + (-u_xlat16_6);
    u_xlat16_3 = in_POSITION0.y * 0.0952399969 + 1.0;
    vs_TEXCOORD2.x = u_xlat16_3 * u_xlat16_2.x + u_xlat16_6;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_3 * u_xlat16_2.x + u_xlat16_2.y;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat16_7.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.x = u_xlat16_7.z + u_xlat16_7.x;
    vs_TEXCOORD1.y = u_xlat16_7.y * _ProjectionParams.x + u_xlat16_7.z;
    u_xlat16_7.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_3) * u_xlat16_7.xyz + _AmbientB.xyz;
    u_xlat16_2.xyw = vec3(u_xlat16_14) * u_xlat16_7.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_2.xyw;
    u_xlat16_2.xyz = _AddColT.xyz + (-_AddColB.xyz);
    vs_COLOR1.xyz = vec3(u_xlat16_3) * u_xlat16_2.xyz + _AddColB.xyz;
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
uniform 	mediump float _VBlur;
uniform 	mediump vec4 _RefTexAdj;
UNITY_LOCATION(0) uniform mediump sampler2D _SurfaceTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
    u_xlat16_1.x = (-u_xlat16_0.x) + _RefTexAdj.y;
    u_xlat16_0.z = u_xlat16_1.x * _RefTexAdj.x;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_7 = _VBlur * _RefTexAdj.z;
    u_xlat16_0.w = u_xlat16_1.x * _RefTexAdj.x + u_xlat16_7;
    u_xlat16_0.x = u_xlat16_1.x * _RefTexAdj.x + (-u_xlat16_7);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_0.yw).xyz;
    u_xlat16_0.z = _VBlur * _RefTexAdj.z + u_xlat16_0.w;
    u_xlat16_1.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_0.yx).xyz;
    u_xlat16_0.w = (-_VBlur) * _RefTexAdj.z + u_xlat16_0.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_0.x = _VBlur * _RefTexAdj.z + u_xlat16_0.z;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_0.yw).xyz;
    u_xlat16_0.z = (-_VBlur) * _RefTexAdj.z + u_xlat16_0.w;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_0.yx).xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_0.yz).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * vec3(0.143000007, 0.143000007, 0.143000007) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2 = texture(_SurfaceTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_2.xyz + vs_COLOR1.xyz;
    u_xlat16_18 = u_xlat16_2.w * vs_TEXCOORD2.x;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.143000007, 0.143000007, 0.143000007) + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}