//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/WaterPourShader" {
Properties {
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_MainLightCol ("Main Light Color", Vector) = (0,0,0,1)
_BackLightCol ("Back Light Color", Vector) = (0,0,0,1)
_SpecCol ("Specular Color", Color) = (0,0,0,1)
_Shininess ("Shininess", Float) = 0
_SpecPower ("Specular Brightness", Float) = 1
_ShadowSub ("Shadow Subtraction Color", Vector) = (0,0,0,1)
_MainLightDir ("Main Light Direction", Vector) = (0,0,0,0)
_BackLightDir ("Back Light Direction", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  GpuProgramID 50465
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_1.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_7.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat2 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.x = u_xlat16_1.x * 7.0 + u_xlat2.x;
    gl_Position.yzw = u_xlat2.yzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = (-u_xlat2.y) * u_xlat18 + 1.0;
    u_xlat16_1.y = u_xlat2.z * u_xlat18 + 0.850000024;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.5, 0.0));
    u_xlat16_1.z = dot((-_MainLightDir.xyz), u_xlat3.xyz);
    u_xlat16_7.xy = u_xlat16_1.yz + u_xlat16_1.yz;
    u_xlat16_4.xyz = u_xlat3.xyz * (-u_xlat16_7.yyy) + (-_MainLightDir.xyz);
    u_xlat16_13 = dot(u_xlat16_4.xyz, u_xlat0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _Shininess;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_4.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_13) * u_xlat16_4.xyz;
    u_xlat16_13 = dot(u_xlat3.xyz, _MainLightDir.xyz);
    u_xlat16_19 = dot(u_xlat3.xyz, _BackLightDir.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_19;
    u_xlat16_7.x = u_xlat16_7.x * _BackLightDir.w;
    u_xlatb0 = u_xlat16_13>=0.25;
    u_xlat16_19 = (u_xlatb0) ? _SpecPower : 0.0;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_13, 0.0);
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * _MainLightDir.w;
    u_xlat16_5.xyz = vec3(u_xlat16_13) * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_5.xyz = _MainLightCol.xyz * vec3(u_xlat16_19) + u_xlat16_5.xyz;
    u_xlat16_7.xyz = _BackLightCol.xyz * u_xlat16_7.xxx + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xxx + u_xlat16_4.xyz;
    vs_COLOR0.w = u_xlat16_1.z + 0.150000006;
    vs_COLOR0.xyz = _DiffuseBaseCol.xyz * vec3(0.0500000007, 0.0500000007, 0.100000001) + u_xlat16_1.xyz;
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat16_1.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat16_7.x = dot(u_xlat0.xyz, in_POSITION0.xyz);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat2 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.x = u_xlat16_1.x * 7.0 + u_xlat2.x;
    gl_Position.yzw = u_xlat2.yzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = (-u_xlat2.y) * u_xlat18 + 1.0;
    u_xlat16_1.y = u_xlat2.z * u_xlat18 + 0.850000024;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.5, 0.0));
    u_xlat16_1.z = dot((-_MainLightDir.xyz), u_xlat3.xyz);
    u_xlat16_7.xy = u_xlat16_1.yz + u_xlat16_1.yz;
    u_xlat16_4.xyz = u_xlat3.xyz * (-u_xlat16_7.yyy) + (-_MainLightDir.xyz);
    u_xlat16_13 = dot(u_xlat16_4.xyz, u_xlat0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _Shininess;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_4.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_13) * u_xlat16_4.xyz;
    u_xlat16_13 = dot(u_xlat3.xyz, _MainLightDir.xyz);
    u_xlat16_19 = dot(u_xlat3.xyz, _BackLightDir.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_19;
    u_xlat16_7.x = u_xlat16_7.x * _BackLightDir.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_13>=0.25);
#else
    u_xlatb0 = u_xlat16_13>=0.25;
#endif
    u_xlat16_19 = (u_xlatb0) ? _SpecPower : 0.0;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_13, 0.0);
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * _MainLightDir.w;
    u_xlat16_5.xyz = vec3(u_xlat16_13) * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_5.xyz = _MainLightCol.xyz * vec3(u_xlat16_19) + u_xlat16_5.xyz;
    u_xlat16_7.xyz = _BackLightCol.xyz * u_xlat16_7.xxx + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xxx + u_xlat16_4.xyz;
    vs_COLOR0.w = u_xlat16_1.z + 0.150000006;
    vs_COLOR0.xyz = _DiffuseBaseCol.xyz * vec3(0.0500000007, 0.0500000007, 0.100000001) + u_xlat16_1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}