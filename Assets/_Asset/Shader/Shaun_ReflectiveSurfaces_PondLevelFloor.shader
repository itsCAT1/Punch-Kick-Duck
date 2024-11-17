//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/ReflectiveSurfaces/PondLevelFloor" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_SurfaceTex ("FloorTex", 2D) = "white" { }
_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
_VBlur ("Blur", Float) = 0
_FloorSmoothnessMult ("Floor Ref Mult", Float) = 0
_AmbientT ("Ambient color top", Color) = (0,0,0,1)
_AmbientB ("Ambient color bott", Color) = (0,0,0,1)
_AddColT ("Add color top", Color) = (0,0,0,1)
_AddColB ("Add color bott", Color) = (0,0,0,1)
_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
_FogCol ("Fog color", Color) = (0,0,0,1)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 5655
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
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD1;
varying mediump float vs_sX0;
varying mediump vec3 vs_COLOR1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_8;
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
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_8 = in_POSITION0.y * 0.136999995 + 1.0;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    vs_TEXCOORD2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_8 * u_xlat16_2.x + u_xlat16_2.y;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat16_2.xyw = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_sX0 = u_xlat0.x * -0.0166599993;
    vs_TEXCOORD1.x = u_xlat16_2.w + u_xlat16_2.x;
    vs_TEXCOORD1.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.w;
    u_xlat16_2.xyw = _AddColT.xyz + (-_AddColB.xyz);
    vs_COLOR1.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyw + _AddColB.xyz;
    u_xlat16_2.xyw = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyw + _AmbientB.xyz;
    u_xlat16_2.x = max(in_POSITION0.y, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * 0.0441720001;
    vs_COLOR0.w = min(u_xlat16_2.x, 1.0);
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
uniform 	mediump float _FloorSmoothnessMult;
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec3 _FogCol;
uniform mediump sampler2D _SurfaceTex;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD1;
varying mediump float vs_sX0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_14;
mediump float u_xlat16_21;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_7 = (-u_xlat16_0.y) + _RefTexAdj.y;
    u_xlat16_1 = texture2D(_SurfaceTex, vs_TEXCOORD0.xy);
    u_xlat16_14.xy = u_xlat16_1.zz * vec2(0.0125000002, 0.0250000004);
    u_xlat16_2.w = u_xlat16_7 * _RefTexAdj.x + (-u_xlat16_14.y);
    u_xlat16_2.z = u_xlat16_14.x * vs_sX0 + u_xlat16_0.x;
    u_xlat16_2.y = u_xlat16_2.z + _VBlur;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_2.yw).xyz;
    u_xlat16_0.w = u_xlat16_2.y + _VBlur;
    u_xlat16_4.xyz = texture2D(_MainTex, u_xlat16_2.zw).xyz;
    u_xlat16_2.x = u_xlat16_2.z + (-_VBlur);
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_2.xw).xyz;
    u_xlat16_0.z = u_xlat16_2.x + (-_VBlur);
    u_xlat16_0.y = u_xlat16_2.w;
    u_xlat16_2.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_0.wy).xyz;
    u_xlat16_0.x = u_xlat16_0.w + _VBlur;
    u_xlat16_4.xyz = texture2D(_MainTex, u_xlat16_0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat16_0.zy).xyz;
    u_xlat16_0.x = u_xlat16_0.z + (-_VBlur);
    u_xlat16_6.xyz = texture2D(_MainTex, u_xlat16_0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * vec3(0.143000007, 0.143000007, 0.143000007) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_5.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.143000007, 0.143000007, 0.143000007) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_21 = u_xlat16_1.y + -0.5;
    u_xlat16_21 = u_xlat16_21 + _FloorSmoothnessMult;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_21 = u_xlat16_21 * vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_COLOR0.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_21 = u_xlat16_1.w * u_xlat16_1.w;
    u_xlat16_21 = u_xlat16_1.w * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_1.w + vs_TEXCOORD2.x;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(u_xlat16_21) + _FogCol.xyz;
    SV_Target0.w = u_xlat16_21;
    SV_Target0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
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
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD1;
out mediump float vs_sX0;
out mediump vec3 vs_COLOR1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_8;
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
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_8 = in_POSITION0.y * 0.136999995 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    vs_TEXCOORD2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD2.y = u_xlat16_8 * u_xlat16_2.x + u_xlat16_2.y;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat16_2.xyw = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_sX0 = u_xlat0.x * -0.0166599993;
    vs_TEXCOORD1.x = u_xlat16_2.w + u_xlat16_2.x;
    vs_TEXCOORD1.y = u_xlat16_2.y * _ProjectionParams.x + u_xlat16_2.w;
    u_xlat16_2.xyw = _AddColT.xyz + (-_AddColB.xyz);
    vs_COLOR1.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyw + _AddColB.xyz;
    u_xlat16_2.xyw = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyw + _AmbientB.xyz;
    u_xlat16_2.x = max(in_POSITION0.y, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * 0.0441720001;
    vs_COLOR0.w = min(u_xlat16_2.x, 1.0);
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
uniform 	mediump float _FloorSmoothnessMult;
uniform 	mediump vec4 _RefTexAdj;
uniform 	mediump vec3 _FogCol;
UNITY_LOCATION(0) uniform mediump sampler2D _SurfaceTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD1;
in mediump float vs_sX0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_14;
mediump float u_xlat16_21;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_7 = (-u_xlat16_0.y) + _RefTexAdj.y;
    u_xlat16_1 = texture(_SurfaceTex, vs_TEXCOORD0.xy);
    u_xlat16_14.xy = u_xlat16_1.zz * vec2(0.0125000002, 0.0250000004);
    u_xlat16_2.w = u_xlat16_7 * _RefTexAdj.x + (-u_xlat16_14.y);
    u_xlat16_2.z = u_xlat16_14.x * vs_sX0 + u_xlat16_0.x;
    u_xlat16_2.y = u_xlat16_2.z + _VBlur;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_2.yw).xyz;
    u_xlat16_0.w = u_xlat16_2.y + _VBlur;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat16_2.zw).xyz;
    u_xlat16_2.x = u_xlat16_2.z + (-_VBlur);
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_2.xw).xyz;
    u_xlat16_0.z = u_xlat16_2.x + (-_VBlur);
    u_xlat16_0.y = u_xlat16_2.w;
    u_xlat16_2.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_0.wy).xyz;
    u_xlat16_0.x = u_xlat16_0.w + _VBlur;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat16_0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat16_0.zy).xyz;
    u_xlat16_0.x = u_xlat16_0.z + (-_VBlur);
    u_xlat16_6.xyz = texture(_MainTex, u_xlat16_0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * vec3(0.143000007, 0.143000007, 0.143000007) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_5.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.143000007, 0.143000007, 0.143000007) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_21 = u_xlat16_1.y + -0.5;
    u_xlat16_21 = u_xlat16_21 + _FloorSmoothnessMult;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_21 = u_xlat16_21 * vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_COLOR0.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_21 = u_xlat16_1.w * u_xlat16_1.w;
    u_xlat16_21 = u_xlat16_1.w * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_1.w + vs_TEXCOORD2.x;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(u_xlat16_21) + _FogCol.xyz;
    SV_Target0.w = u_xlat16_21;
    SV_Target0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
}
}
}
}