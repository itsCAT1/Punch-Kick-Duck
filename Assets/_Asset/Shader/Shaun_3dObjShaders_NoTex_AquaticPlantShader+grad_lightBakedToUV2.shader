//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shaun/3dObjShaders/NoTex/AquaticPlantShader+grad_lightBakedToUV2" {
Properties {
_DiffuseBaseCol ("Diffuse base Color", Color) = (1,1,1,1)
_GradientSubColor ("Gradient additive color", Vector) = (0,0,0,1)
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 28891
Program "vp" {
SubProgram "gles " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec4 _GradientSubColor;
uniform 	float _zeroToTwoPiTimeCount_qSpeed;
attribute mediump vec4 in_POSITION0;
attribute mediump vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
void main()
{
    u_xlat16_0.x = in_POSITION0.y * 6.0;
    u_xlat1.x = _zeroToTwoPiTimeCount_qSpeed * 3.0 + (-u_xlat16_0.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat1.x = u_xlat1.x * 0.0149999997;
    u_xlat16_0.xy = u_xlat1.xx * in_COLOR0.ww + in_POSITION0.zx;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat16_0.yyyy + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat16_3 = u_xlat2 + -4.5;
    u_xlat16_3 = u_xlat16_3 * 0.0850000009;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * u_xlat16_3 + 1.0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat16_8.xyz = in_TEXCOORD1.www * _GradientSubColor.xyz;
    u_xlat16_8.xyz = in_COLOR0.xyz * _DiffuseBaseCol.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + in_TEXCOORD1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + vec3(0.200000003, 0.200000003, 0.270000011);
    vs_COLOR0.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz + u_xlat16_8.xyz;
    vs_COLOR0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _DiffuseBaseCol;
uniform 	mediump vec4 _GradientSubColor;
uniform 	float _zeroToTwoPiTimeCount_qSpeed;
in mediump vec4 in_POSITION0;
in mediump vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
void main()
{
    u_xlat16_0.x = in_POSITION0.y * 6.0;
    u_xlat1.x = _zeroToTwoPiTimeCount_qSpeed * 3.0 + (-u_xlat16_0.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat1.x = u_xlat1.x * 0.0149999997;
    u_xlat16_0.xy = u_xlat1.xx * in_COLOR0.ww + in_POSITION0.zx;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat16_0.yyyy + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.z;
    u_xlat16_3 = u_xlat2 + -4.5;
    u_xlat16_3 = u_xlat16_3 * 0.0850000009;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * u_xlat16_3 + 1.0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat16_8.xyz = in_TEXCOORD1.www * _GradientSubColor.xyz;
    u_xlat16_8.xyz = in_COLOR0.xyz * _DiffuseBaseCol.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + in_TEXCOORD1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + vec3(0.200000003, 0.200000003, 0.270000011);
    vs_COLOR0.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz + u_xlat16_8.xyz;
    vs_COLOR0.w = 1.0;
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