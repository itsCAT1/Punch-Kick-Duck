//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/ReflectiveSurfaces/SculleryFloorShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_SurfaceTex ("FloorTex", 2D) = "white" { }
_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
_HDistort ("Hori Distortion", Float) = 0
_VDistort ("Vert Distortion", Float) = 0
_AmbientT ("Ambient color top", Color) = (0,0,0,1)
_AmbientB ("Ambient color bott", Color) = (0,0,0,1)
_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 23425
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
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec2 in_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump float vs_sX0;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_sX0 = u_xlat0.x * -0.0166599993;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat0.x = max(u_xlat16_2.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 1.10000002);
    u_xlat0.x = (-u_xlat16_2.y) + u_xlat0.x;
    u_xlat3 = in_POSITION0.y * 0.0952399969 + 1.0;
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat16_2.y;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD3.y = u_xlat3 * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _AmbientB.xyz;
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
uniform 	mediump float _HDistort;
uniform 	mediump float _VDistort;
uniform 	mediump vec4 _RefTexAdj;
uniform mediump sampler2D _SurfaceTex;
uniform mediump sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump float vs_sX0;
varying mediump vec3 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat6 = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat16_1.xyz = texture2D(_SurfaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat12 = u_xlat16_1.y + -1.0;
    u_xlat12 = u_xlat12 * _RefTexAdj.z;
    u_xlat16_2.xy = vec2(u_xlat12) * vec2(_HDistort, _VDistort);
    u_xlat3.y = u_xlat6 * _RefTexAdj.x + u_xlat16_2.y;
    u_xlat3.x = u_xlat16_2.x * vs_sX0 + u_xlat0.x;
    u_xlat16_0.xyz = texture2D(_MainTex, u_xlat3.xy).xyz;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-u_xlat3.xyz) * u_xlat4.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat3.xyz);
    u_xlat16_5.xy = u_xlat16_1.zz * vs_TEXCOORD3.xy;
    u_xlat16_2.xyz = u_xlat16_5.yyy * u_xlat16_2.xyz + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_11.xyz = u_xlat16_1.xxx * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + u_xlat16_11.xyz;
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
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump float vs_sX0;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_sX0 = u_xlat0.x * -0.0166599993;
    u_xlat16_2.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _Reflectivity.zw;
    u_xlat0.x = max(u_xlat16_2.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 1.10000002);
    u_xlat0.x = (-u_xlat16_2.y) + u_xlat0.x;
    u_xlat3 = in_POSITION0.y * 0.0952399969 + 1.0;
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat16_2.y;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD3.y = u_xlat3 * u_xlat16_2.x + u_xlat16_2.y;
    u_xlat16_2.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    vs_COLOR0.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _AmbientB.xyz;
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
uniform 	mediump float _HDistort;
uniform 	mediump float _VDistort;
uniform 	mediump vec4 _RefTexAdj;
UNITY_LOCATION(0) uniform mediump sampler2D _SurfaceTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump float vs_sX0;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat6 = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat16_1.xyz = texture(_SurfaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat12 = u_xlat16_1.y + -1.0;
    u_xlat12 = u_xlat12 * _RefTexAdj.z;
    u_xlat16_2.xy = vec2(u_xlat12) * vec2(_HDistort, _VDistort);
    u_xlat3.y = u_xlat6 * _RefTexAdj.x + u_xlat16_2.y;
    u_xlat3.x = u_xlat16_2.x * vs_sX0 + u_xlat0.x;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat3.xy).xyz;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-u_xlat3.xyz) * u_xlat4.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat3.xyz);
    u_xlat16_5.xy = u_xlat16_1.zz * vs_TEXCOORD3.xy;
    u_xlat16_2.xyz = u_xlat16_5.yyy * u_xlat16_2.xyz + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xxx) * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_11.xyz = u_xlat16_1.xxx * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + u_xlat16_11.xyz;
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