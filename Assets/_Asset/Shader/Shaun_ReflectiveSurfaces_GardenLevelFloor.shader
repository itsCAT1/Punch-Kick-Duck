//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/ReflectiveSurfaces/GardenLevelFloor" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_BackLightPos ("Backlight Pos", Vector) = (0,0,0,1)
_Reflectivity ("Ref1:t, b. Ref2: t, b", Vector) = (0,0,0,0)
_MetalMult ("Metal Mult: t,b", Vector) = (0,0,0,0)
_Blur ("Blur", Float) = 0
_AmbientT ("Ambient color top", Color) = (0,0,0,1)
_AmbientB ("Ambient color bott", Color) = (0,0,0,1)
_AddColT ("Add color top", Color) = (0,0,0,1)
_AddColB ("Add color bott", Color) = (0,0,0,1)
_RefTexAdj ("Reflection Tex Adj", Vector) = (0,0,1,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Fog {
   Mode Off
  }
  GpuProgramID 31460
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
uniform 	mediump vec4 _BackLightCol;
uniform 	mediump vec4 _BackLightPos;
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_10;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat16_2.z = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_3.xyz = _BackLightPos.xyz * vec3(-1.0, 1.0, 1.0) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + _BackLightPos.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat0.x = u_xlat16_2.x * 0.00499999989;
    u_xlat0.x = (-u_xlat0.x) * _BackLightPos.w + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat4.x = u_xlat16_2.x * 0.00499999989;
    u_xlat4.x = (-u_xlat4.x) * _BackLightPos.w + 1.0;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat16_2.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_3.xyz = _AddColT.xyz + (-_AddColB.xyz);
    u_xlat0.x = in_POSITION0.y * 0.0952399969 + 1.0;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _AddColB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _BackLightCol.www + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _AmbientB.xyz;
    u_xlat16_2.xyz = in_COLOR0.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = (-in_POSITION0.zzz) * vec3(0.649999976, 0.649999976, 0.649999976) + u_xlat16_2.xyz;
    u_xlat1.x = in_POSITION0.y + 10.5100002;
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat1.xxx);
    vs_COLOR0.xyz = in_NORMAL0.yyy * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
    u_xlat16_2.x = min((-in_NORMAL0.z), 0.0);
    u_xlat16_2.x = u_xlat16_2.x + in_NORMAL0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_6.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_6.xy = _RefTexAdj.ww * u_xlat16_6.xy + _Reflectivity.zw;
    u_xlat16_10 = u_xlat16_6.y * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6.x + (-u_xlat16_10);
    vs_TEXCOORD1.x = u_xlat0.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat16_2.x + u_xlat16_2.y;
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
uniform 	mediump float _Blur;
uniform 	mediump vec4 _RefTexAdj;
uniform mediump sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat16_13 = (-_Blur) * 0.200000003 + u_xlat0.x;
    u_xlat1.xz = vec2(u_xlat16_13);
    u_xlat16_2 = _Blur * _RefTexAdj.z;
    u_xlat3.x = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat0.z = u_xlat3.x * _RefTexAdj.x + u_xlat16_2;
    u_xlat0.w = (-u_xlat16_2) * 2.0 + u_xlat0.z;
    u_xlat1.yw = u_xlat0.zw;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat0.xz).xyz;
    u_xlat16_4.xyz = texture2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_14 = _Blur * 0.200000003 + u_xlat0.x;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat0.xw).xyz;
    u_xlat2.xz = vec2(u_xlat16_14);
    u_xlat16_4.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = texture2D(_MainTex, u_xlat1.zw).xyz;
    u_xlat2.w = u_xlat1.w;
    u_xlat16_3.xyz = texture2D(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = (-u_xlat16_5.xyz) * vec3(0.166999996, 0.166999996, 0.166999996) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-vs_COLOR0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * u_xlat3.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.166999996, 0.166999996, 0.166999996) + (-u_xlat1.xyz);
    u_xlat16_5.xyz = vs_TEXCOORD1.yyy * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-vs_COLOR0.xyz);
    SV_Target0.xyz = vs_TEXCOORD1.xxx * u_xlat16_5.xyz + vs_COLOR0.xyz;
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
uniform 	mediump vec4 _BackLightCol;
uniform 	mediump vec4 _BackLightPos;
in mediump vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_10;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_2.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat16_2.z = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_3.xyz = _BackLightPos.xyz * vec3(-1.0, 1.0, 1.0) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + _BackLightPos.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat0.x = u_xlat16_2.x * 0.00499999989;
    u_xlat0.x = (-u_xlat0.x) * _BackLightPos.w + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat4.x = u_xlat16_2.x * 0.00499999989;
    u_xlat4.x = (-u_xlat4.x) * _BackLightPos.w + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _BackLightCol.xyz;
    u_xlat16_3.xyz = _AddColT.xyz + (-_AddColB.xyz);
    u_xlat0.x = in_POSITION0.y * 0.0952399969 + 1.0;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _AddColB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _BackLightCol.www + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _AmbientT.xyz + (-_AmbientB.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _AmbientB.xyz;
    u_xlat16_2.xyz = in_COLOR0.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = (-in_POSITION0.zzz) * vec3(0.649999976, 0.649999976, 0.649999976) + u_xlat16_2.xyz;
    u_xlat1.x = in_POSITION0.y + 10.5100002;
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat1.xxx);
    vs_COLOR0.xyz = in_NORMAL0.yyy * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
    u_xlat16_2.x = min((-in_NORMAL0.z), 0.0);
    u_xlat16_2.x = u_xlat16_2.x + in_NORMAL0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_6.xy = (-_Reflectivity.zw) + _Reflectivity.xy;
    u_xlat16_6.xy = _RefTexAdj.ww * u_xlat16_6.xy + _Reflectivity.zw;
    u_xlat16_10 = u_xlat16_6.y * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6.x + (-u_xlat16_10);
    vs_TEXCOORD1.x = u_xlat0.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.xy = (-_MetalMult.zw) + _MetalMult.xy;
    u_xlat16_2.xy = _RefTexAdj.ww * u_xlat16_2.xy + _MetalMult.zw;
    u_xlat16_2.x = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat16_2.x + u_xlat16_2.y;
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
uniform 	mediump float _Blur;
uniform 	mediump vec4 _RefTexAdj;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_COLOR0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat16_13 = (-_Blur) * 0.200000003 + u_xlat0.x;
    u_xlat1.xz = vec2(u_xlat16_13);
    u_xlat16_2 = _Blur * _RefTexAdj.z;
    u_xlat3.x = (-u_xlat0.y) + _RefTexAdj.y;
    u_xlat0.z = u_xlat3.x * _RefTexAdj.x + u_xlat16_2;
    u_xlat0.w = (-u_xlat16_2) * 2.0 + u_xlat0.z;
    u_xlat1.yw = u_xlat0.zw;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat0.xz).xyz;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_14 = _Blur * 0.200000003 + u_xlat0.x;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat0.xw).xyz;
    u_xlat2.xz = vec2(u_xlat16_14);
    u_xlat16_4.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat2.w = u_xlat1.w;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = (-u_xlat16_5.xyz) * vec3(0.166999996, 0.166999996, 0.166999996) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-vs_COLOR0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * u_xlat3.xyz + vec3(0.920000017, 0.920000017, 0.920000017);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.166999996, 0.166999996, 0.166999996) + (-u_xlat1.xyz);
    u_xlat16_5.xyz = vs_TEXCOORD1.yyy * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-vs_COLOR0.xyz);
    SV_Target0.xyz = vs_TEXCOORD1.xxx * u_xlat16_5.xyz + vs_COLOR0.xyz;
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