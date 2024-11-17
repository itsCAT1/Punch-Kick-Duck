//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/FishShader" {
Properties {
_MainTex ("Diffuse Tex", 2D) = "white" { }
_Radians_Speed_Curve ("Rads, speed, & curve", Vector) = (0,0,0,1)
_UVOffset ("UV Offset", Vector) = (0,0,0,1)
_AFloatVal ("Near Z Limit", Float) = -5.5
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_GradientStart ("Gradient start", Float) = 0
_GradientEnd ("Gradient end", Float) = 2
_GradientLightCut ("Grad Light Cut", Float) = 1
_GradientBackLightCut ("Grad Backlight Cut", Float) = 0.75
_GradientShadowCut ("Grad Shadow Cut", Float) = 0.5
_GradientSpecCut ("Grad Specular Cut", Float) = 1
_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
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
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 39364
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _Radians_Speed_Curve;
uniform 	mediump vec2 _UVOffset;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _GradientSpecCut;
uniform 	mediump float _AFloatVal;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump float u_xlat16_9;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat16;
mediump float u_xlat16_17;
float u_xlat18;
mediump vec2 u_xlat16_19;
float u_xlat24;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = in_POSITION0.x + 0.649999976;
    u_xlat0.x = _Radians_Speed_Curve.y * 0.100000001 + u_xlat0.x;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat16_1.x * 0.449999988;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_9 = u_xlat0.x * u_xlat0.x + _Radians_Speed_Curve.x;
    u_xlat16_9 = sin(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat0.xy = _Radians_Speed_Curve.yy * vec2(0.00999999978, 0.00999999978) + vec2(0.200000003, 0.5);
    u_xlat16_17 = u_xlat0.x * _Radians_Speed_Curve.y;
    u_xlat0.z = u_xlat16_17 * 0.0500000007;
    u_xlat8.xy = u_xlat0.yz * vec2(u_xlat16_9);
    u_xlat16 = u_xlat16_1.x * u_xlat0.x + (-u_xlat8.y);
    u_xlat16_1.x = in_POSITION0.z * in_POSITION0.z;
    u_xlat16_1.x = u_xlat16_9 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * in_POSITION0.z;
    u_xlat16_1.x = u_xlat16_1.x * _Radians_Speed_Curve.y;
    u_xlat16_1.xz = (-u_xlat16_1.xx) * vec2(0.0250000004, 0.0250000004) + in_POSITION0.yx;
    u_xlat2.xy = u_xlat16_1.xz + vec2(-0.100000001, -0.600000024);
    u_xlat16_25 = u_xlat16_9 * u_xlat2.x;
    u_xlat16_25 = u_xlat2.x * u_xlat16_25;
    u_xlat16_25 = u_xlat2.x * u_xlat16_25;
    u_xlat24 = max(u_xlat2.y, 0.0);
    u_xlat24 = u_xlat24 * 0.349999994;
    u_xlat16_3 = u_xlat24 * u_xlat24;
    u_xlat16_25 = u_xlat16_25 * _Radians_Speed_Curve.y;
    u_xlat24 = u_xlat16_25 * 0.0199999996 + in_POSITION0.z;
    u_xlat16 = u_xlat16 + u_xlat24;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_3;
    u_xlat16_9 = dot(vec2(u_xlat16_9), u_xlat0.xx);
    u_xlat0.x = u_xlat8.x * u_xlat16_3 + u_xlat16_9;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16;
    u_xlat16_9 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_25 = u_xlat16_9 * _Radians_Speed_Curve.z + u_xlat0.x;
    u_xlat16_1.y = u_xlat16_9 * _Radians_Speed_Curve.z;
    u_xlatb0.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_1.yyzy).xz;
    u_xlat16_9 = (u_xlatb0.x) ? (-u_xlat16_1.y) : u_xlat16_1.y;
    u_xlat0.x = u_xlat16_9 * 0.5 + u_xlat16_1.z;
    u_xlat8.x = (-u_xlat16_9) * 0.5 + u_xlat16_1.z;
    u_xlat2.xyz = u_xlat16_1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat16_1.x = (u_xlatb0.z) ? u_xlat0.x : u_xlat8.x;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vec3(u_xlat16_25) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat16_3 = (-u_xlat0.z) + _AFloatVal;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat0.w = u_xlat0.z + u_xlat16_3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + _UVOffset.xy;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = (-u_xlat0.xyw) + _WorldSpaceCameraPos.xyz;
    u_xlat16_11 = (-_GradientStart) + _GradientEnd;
    u_xlat2.x = u_xlat16_3 / u_xlat16_11;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * _GradientSubColor.w;
    u_xlat10.xy = u_xlat0.ww + vec2(0.5, -2.5);
    u_xlat16_3 = u_xlat0.w + -4.5;
    u_xlat16_3 = u_xlat16_3 * 0.0500000007;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat24 = u_xlat10.x + u_xlat10.x;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat10.x = u_xlat10.y * -2.0;
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat18 = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat18;
    u_xlat18 = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = u_xlat10.x * u_xlat18;
    u_xlat24 = min(u_xlat24, u_xlat10.x);
    u_xlat24 = u_xlat24 * _GradientSubColor.w;
    u_xlat16_11 = u_xlat24 * 0.637500048;
    u_xlat16_11 = max(u_xlat2.x, u_xlat16_11);
    u_xlat2.xy = (-vec2(u_xlat16_11)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat18 = u_xlat4.z * u_xlat24 + 0.850000024;
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = max(u_xlat18, 0.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat16_19.x = u_xlat24 * u_xlat24;
    u_xlat16_27 = dot(u_xlat4.xyz, _BackLightDir.xyz);
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_27;
    u_xlat16_19.x = u_xlat16_19.x * _BackLightDir.w;
    u_xlat16_19.x = u_xlat2.y * u_xlat16_19.x;
    u_xlat16_5.xyz = u_xlat16_19.xxx * _BackLightCol.xyz;
    u_xlat2.yz = (-vec2(u_xlat16_11)) * vec2(_GradientShadowCut, _GradientSpecCut) + vec2(1.0, 1.0);
    u_xlat16_19.x = dot(u_xlat4.xyz, _MainLightDir.xyz);
    u_xlat16_27 = max(u_xlat16_19.x, 0.0);
    u_xlat16_29 = (-u_xlat16_19.x) + u_xlat16_27;
    u_xlatb24 = u_xlat16_19.x>=0.25;
    u_xlat16_19.x = (u_xlatb24) ? _SpecPower : 0.0;
    u_xlat16_19.y = u_xlat16_27 * _MainLightDir.w;
    u_xlat16_19.xy = u_xlat2.zx * u_xlat16_19.xy;
    u_xlat16_6.xyz = u_xlat16_19.yyy * _MainLightCol.xyz;
    u_xlat24 = (-in_COLOR0.z) + 1.0;
    u_xlat24 = max(u_xlat24, u_xlat16_29);
    u_xlat24 = u_xlat2.y * u_xlat24;
    u_xlat16_7.xyz = vec3(u_xlat24) * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_6.xyz = u_xlat16_6.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat16_5.xyz = _GradientSubColor.xyz * vec3(u_xlat16_11) + u_xlat16_5.xyz;
    u_xlat16_11 = dot((-_MainLightDir.xyz), u_xlat4.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_6.xyz = u_xlat4.xyz * (-vec3(u_xlat16_11)) + (-_MainLightDir.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_11 = dot(u_xlat16_6.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _Shininess;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_6.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz;
    vs_COLOR0.xyz = u_xlat16_19.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_3;
    vs_COLOR0.w = (-u_xlat16_3) * u_xlat16_11 + 1.0;
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
uniform 	mediump vec3 _DiffuseBaseCol;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(0.150000006, 0.150000006, 0.224999994);
    SV_Target0.xyz = vs_COLOR0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	mediump vec3 _Radians_Speed_Curve;
uniform 	mediump vec2 _UVOffset;
uniform 	mediump vec3 _MainLightCol;
uniform 	mediump vec3 _BackLightCol;
uniform 	mediump vec3 _SpecCol;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecPower;
uniform 	mediump vec3 _ShadowSub;
uniform 	mediump vec4 _GradientSubColor;
uniform 	mediump float _GradientStart;
uniform 	mediump float _GradientEnd;
uniform 	mediump float _GradientLightCut;
uniform 	mediump float _GradientBackLightCut;
uniform 	mediump float _GradientShadowCut;
uniform 	mediump float _GradientSpecCut;
uniform 	mediump float _AFloatVal;
uniform 	mediump vec4 _MainLightDir;
uniform 	mediump vec4 _BackLightDir;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec3 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump float u_xlat16_9;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat16;
mediump float u_xlat16_17;
float u_xlat18;
mediump vec2 u_xlat16_19;
float u_xlat24;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = in_POSITION0.x + 0.649999976;
    u_xlat0.x = _Radians_Speed_Curve.y * 0.100000001 + u_xlat0.x;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat16_1.x * 0.449999988;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_9 = u_xlat0.x * u_xlat0.x + _Radians_Speed_Curve.x;
    u_xlat16_9 = sin(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat0.xy = _Radians_Speed_Curve.yy * vec2(0.00999999978, 0.00999999978) + vec2(0.200000003, 0.5);
    u_xlat16_17 = u_xlat0.x * _Radians_Speed_Curve.y;
    u_xlat0.z = u_xlat16_17 * 0.0500000007;
    u_xlat8.xy = u_xlat0.yz * vec2(u_xlat16_9);
    u_xlat16 = u_xlat16_1.x * u_xlat0.x + (-u_xlat8.y);
    u_xlat16_1.x = in_POSITION0.z * in_POSITION0.z;
    u_xlat16_1.x = u_xlat16_9 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * in_POSITION0.z;
    u_xlat16_1.x = u_xlat16_1.x * _Radians_Speed_Curve.y;
    u_xlat16_1.xz = (-u_xlat16_1.xx) * vec2(0.0250000004, 0.0250000004) + in_POSITION0.yx;
    u_xlat2.xy = u_xlat16_1.xz + vec2(-0.100000001, -0.600000024);
    u_xlat16_25 = u_xlat16_9 * u_xlat2.x;
    u_xlat16_25 = u_xlat2.x * u_xlat16_25;
    u_xlat16_25 = u_xlat2.x * u_xlat16_25;
    u_xlat24 = max(u_xlat2.y, 0.0);
    u_xlat24 = u_xlat24 * 0.349999994;
    u_xlat16_3 = u_xlat24 * u_xlat24;
    u_xlat16_25 = u_xlat16_25 * _Radians_Speed_Curve.y;
    u_xlat24 = u_xlat16_25 * 0.0199999996 + in_POSITION0.z;
    u_xlat16 = u_xlat16 + u_xlat24;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_3;
    u_xlat16_9 = dot(vec2(u_xlat16_9), u_xlat0.xx);
    u_xlat0.x = u_xlat8.x * u_xlat16_3 + u_xlat16_9;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16;
    u_xlat16_9 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_25 = u_xlat16_9 * _Radians_Speed_Curve.z + u_xlat0.x;
    u_xlat16_1.y = u_xlat16_9 * _Radians_Speed_Curve.z;
    u_xlatb0.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_1.yyzy).xz;
    u_xlat16_9 = (u_xlatb0.x) ? (-u_xlat16_1.y) : u_xlat16_1.y;
    u_xlat0.x = u_xlat16_9 * 0.5 + u_xlat16_1.z;
    u_xlat8.x = (-u_xlat16_9) * 0.5 + u_xlat16_1.z;
    u_xlat2.xyz = u_xlat16_1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat16_1.x = (u_xlatb0.z) ? u_xlat0.x : u_xlat8.x;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vec3(u_xlat16_25) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat16_3 = (-u_xlat0.z) + _AFloatVal;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat0.w = u_xlat0.z + u_xlat16_3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + _UVOffset.xy;
    u_xlat16_3 = u_xlat0.y + (-_GradientStart);
    u_xlat0.xyz = (-u_xlat0.xyw) + _WorldSpaceCameraPos.xyz;
    u_xlat16_11 = (-_GradientStart) + _GradientEnd;
    u_xlat2.x = u_xlat16_3 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * _GradientSubColor.w;
    u_xlat10.xy = u_xlat0.ww + vec2(0.5, -2.5);
    u_xlat16_3 = u_xlat0.w + -4.5;
    u_xlat16_3 = u_xlat16_3 * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat24 = u_xlat10.x + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.y * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat18;
    u_xlat18 = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = u_xlat10.x * u_xlat18;
    u_xlat24 = min(u_xlat24, u_xlat10.x);
    u_xlat24 = u_xlat24 * _GradientSubColor.w;
    u_xlat16_11 = u_xlat24 * 0.637500048;
    u_xlat16_11 = max(u_xlat2.x, u_xlat16_11);
    u_xlat2.xy = (-vec2(u_xlat16_11)) * vec2(_GradientLightCut, _GradientBackLightCut) + vec2(1.0, 1.0);
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat18 = u_xlat4.z * u_xlat24 + 0.850000024;
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = max(u_xlat18, 0.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat16_19.x = u_xlat24 * u_xlat24;
    u_xlat16_27 = dot(u_xlat4.xyz, _BackLightDir.xyz);
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_27;
    u_xlat16_19.x = u_xlat16_19.x * _BackLightDir.w;
    u_xlat16_19.x = u_xlat2.y * u_xlat16_19.x;
    u_xlat16_5.xyz = u_xlat16_19.xxx * _BackLightCol.xyz;
    u_xlat2.yz = (-vec2(u_xlat16_11)) * vec2(_GradientShadowCut, _GradientSpecCut) + vec2(1.0, 1.0);
    u_xlat16_19.x = dot(u_xlat4.xyz, _MainLightDir.xyz);
    u_xlat16_27 = max(u_xlat16_19.x, 0.0);
    u_xlat16_29 = (-u_xlat16_19.x) + u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_19.x>=0.25);
#else
    u_xlatb24 = u_xlat16_19.x>=0.25;
#endif
    u_xlat16_19.x = (u_xlatb24) ? _SpecPower : 0.0;
    u_xlat16_19.y = u_xlat16_27 * _MainLightDir.w;
    u_xlat16_19.xy = u_xlat2.zx * u_xlat16_19.xy;
    u_xlat16_6.xyz = u_xlat16_19.yyy * _MainLightCol.xyz;
    u_xlat24 = (-in_COLOR0.z) + 1.0;
    u_xlat24 = max(u_xlat24, u_xlat16_29);
    u_xlat24 = u_xlat2.y * u_xlat24;
    u_xlat16_7.xyz = vec3(u_xlat24) * vec3(_ShadowSub.x, _ShadowSub.y, _ShadowSub.z);
    u_xlat16_6.xyz = u_xlat16_6.xyz * in_COLOR0.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat16_5.xyz = _GradientSubColor.xyz * vec3(u_xlat16_11) + u_xlat16_5.xyz;
    u_xlat16_11 = dot((-_MainLightDir.xyz), u_xlat4.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_6.xyz = u_xlat4.xyz * (-vec3(u_xlat16_11)) + (-_MainLightDir.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_11 = dot(u_xlat16_6.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _Shininess;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_6.xyz = _MainLightCol.xyz * _SpecCol.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz;
    vs_COLOR0.xyz = u_xlat16_19.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_3;
    vs_COLOR0.w = (-u_xlat16_3) * u_xlat16_11 + 1.0;
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
uniform 	mediump vec3 _DiffuseBaseCol;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz * _DiffuseBaseCol.xyz + vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(0.150000006, 0.150000006, 0.224999994);
    SV_Target0.xyz = vs_COLOR0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
}
}
}
}