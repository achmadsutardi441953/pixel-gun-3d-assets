//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-ScreenSpaceShadows" {
Properties {
_ShadowMapTexture ("", any) = "" { }
}
SubShader {
 Tags { "ShadowmapFilter" = "HardShadow" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 13895
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat5 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat10 = (-u_xlat5) + u_xlat0.x;
    u_xlat5 = unity_OrthoParams.w * u_xlat10 + u_xlat5;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat5) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat5) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat5 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat10 = (-u_xlat5) + u_xlat0.x;
    u_xlat5 = unity_OrthoParams.w * u_xlat10 + u_xlat5;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat5) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat5) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat5 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat10 = (-u_xlat5) + u_xlat0.x;
    u_xlat5 = unity_OrthoParams.w * u_xlat10 + u_xlat5;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat5) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat5) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
float u_xlat8;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat4 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat8 = (-u_xlat4) + u_xlat0.x;
    u_xlat4 = unity_OrthoParams.w * u_xlat8 + u_xlat4;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat4) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat4) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
float u_xlat8;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat4 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat8 = (-u_xlat4) + u_xlat0.x;
    u_xlat4 = unity_OrthoParams.w * u_xlat8 + u_xlat4;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat4) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat4) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
float u_xlat8;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat4 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat8 = (-u_xlat4) + u_xlat0.x;
    u_xlat4 = unity_OrthoParams.w * u_xlat8 + u_xlat4;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat4) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat4) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 88231
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_4) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat16_3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * u_xlat16_3.xxxx + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    SV_Target0 = vec4(u_xlat10_0) * vec4(u_xlat16_2) + _LightShadowData.xxxx;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "PCF_SOFT" }
 Pass {
  Tags { "ShadowmapFilter" = "PCF_SOFT" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 136644
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
float u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat14 = (-u_xlat7) + u_xlat0.x;
    u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat7) + u_xlat0.xzw;
    u_xlat1.xyz = vec3(u_xlat7) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 203599
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
lowp float u_xlat10_14;
vec2 u_xlat16;
lowp float u_xlat10_16;
lowp float u_xlat10_21;
lowp float u_xlat10_23;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlatb1 = greaterThanEqual((-u_xlat0.zzzz), _LightSplitsNear);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlatb2 = lessThan((-u_xlat0.zzzz), _LightSplitsFar);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_1 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.yyy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.www + u_xlat2.xyz;
    u_xlat2.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2.xy);
    u_xlat16.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat3.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
    u_xlat1.xy = u_xlat3.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat16.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat16.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat16.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat1.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat16.y;
    u_xlat4.w = u_xlat16.x;
    u_xlat5.zw = u_xlat1.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat1.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat1.zwxz + u_xlat4.zwxz;
    u_xlat6.xyz = vec3(u_xlat1.x / u_xlat4.z, u_xlat1.z / u_xlat4.w, u_xlat1.w / u_xlat4.y);
    u_xlat6.xyz = u_xlat6.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat16.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat16.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat1 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_3 * u_xlat1.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_23 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_16 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat6 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat6.xy,u_xlat0.z);
    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat6.zw,u_xlat0.z);
    u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_16 + u_xlat0.x;
    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat1.xy,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat1.zw,u_xlat0.z);
    u_xlat10_9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat1 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat1.x * u_xlat10_2 + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat10_9 + u_xlat0.x;
    u_xlat0.x = u_xlat1.z * u_xlat10_23 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat1.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
lowp float u_xlat10_4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
vec3 u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat16_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat16_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.xyz = vec3(u_xlat16_3.x + u_xlat1.y, u_xlat16_3.y + u_xlat1.z, u_xlat16_3.z + u_xlat1.w);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat8.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[5].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat16_3.xxx * u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[9].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[13].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.zzz + u_xlat1.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat2.xxzz * u_xlat2.xxzz;
    u_xlat15.xy = vec2(u_xlat2.y * float(0.159999996), u_xlat2.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat4.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat2.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat5.z = u_xlat2.y;
    u_xlat5.w = u_xlat15.y;
    u_xlat2.w = u_xlat15.x;
    u_xlat3.zw = u_xlat4.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat5.xyz = vec3(u_xlat3.z / u_xlat0.x, u_xlat3.y / u_xlat0.y, u_xlat3.w / u_xlat0.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat5.xyz = u_xlat5.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat5.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat2 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat4.xyz = vec3(u_xlat4.x / u_xlat2.z, u_xlat4.z / u_xlat2.w, u_xlat4.w / u_xlat2.y);
    u_xlat4.xyz = u_xlat4.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat4.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat2.z, u_xlat0.x * u_xlat2.w, u_xlat0.x * u_xlat2.y, u_xlat0.y * u_xlat2.z);
    u_xlat0.x = u_xlat10_4 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat3 = vec4(u_xlat0.y * u_xlat2.x, u_xlat0.y * u_xlat2.y, u_xlat0.w * u_xlat2.z, u_xlat0.w * u_xlat2.w);
    u_xlat7 = u_xlat0.w * u_xlat2.y;
    u_xlat0.x = u_xlat3.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat3.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat4.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat4.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat3.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_TEXCOORD0.zw = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_CameraInvProjection[2].xyz);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    u_xlat1.w = (-u_xlat1.z);
    vs_TEXCOORD2.xyz = u_xlat1.xyw;
    u_xlat0.w = (-u_xlat0.z);
    vs_TEXCOORD3.xyz = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
lowp float u_xlat10_14;
vec2 u_xlat15;
lowp float u_xlat10_15;
lowp float u_xlat10_21;
lowp float u_xlat10_22;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraToWorld[2] * (-u_xlat0.zzzz) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat0.xy = u_xlat0.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat1.xy);
    u_xlat15.xy = min(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat2.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat3.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat15.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat4 = u_xlat0.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
    u_xlat15.xy = (-u_xlat15.xy) * u_xlat15.xy + u_xlat4.yw;
    u_xlat15.xy = u_xlat15.xy + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat15.xy * vec2(0.159999996, 0.159999996);
    u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
    u_xlat15.xy = vec2(u_xlat4.y * float(0.159999996), u_xlat4.w * float(0.159999996));
    u_xlat0.xy = u_xlat6.xz * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat2.zw = vec2(u_xlat6.w * float(0.0799999982), u_xlat6.y * float(0.0799999982));
    u_xlat4.xy = u_xlat0.xy * vec2(0.159999996, 0.159999996);
    u_xlat3.z = u_xlat4.y;
    u_xlat3.w = u_xlat15.y;
    u_xlat4.w = u_xlat15.x;
    u_xlat5.zw = u_xlat2.yz;
    u_xlat0.xyw = vec3(u_xlat3.z + u_xlat5.z, u_xlat3.y + u_xlat5.y, u_xlat3.w + u_xlat5.w);
    u_xlat4.z = u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat5.z / u_xlat0.x, u_xlat5.y / u_xlat0.y, u_xlat5.w / u_xlat0.w);
    u_xlat2.z = u_xlat5.x;
    u_xlat3.xyz = u_xlat3.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
    u_xlat5.w = u_xlat3.x;
    u_xlat4 = u_xlat2.zwxz + u_xlat4.zwxz;
    u_xlat2.xyz = vec3(u_xlat2.x / u_xlat4.z, u_xlat2.z / u_xlat4.w, u_xlat2.w / u_xlat4.y);
    u_xlat2.xyz = u_xlat2.xyz + vec3(-2.5, -0.5, 1.5);
    u_xlat5.xyz = u_xlat2.yxz * _ShadowMapTexture_TexelSize.xxx;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
    u_xlat15.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
    vec3 txVec0 = vec3(u_xlat15.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    vec3 txVec2 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat6 = vec4(u_xlat0.x * u_xlat4.z, u_xlat0.x * u_xlat4.w, u_xlat0.x * u_xlat4.y, u_xlat0.y * u_xlat4.z);
    u_xlat0.x = u_xlat10_2 * u_xlat6.y;
    u_xlat0.x = u_xlat6.x * u_xlat10_22 + u_xlat0.x;
    u_xlat0.x = u_xlat6.z * u_xlat10_15 + u_xlat0.x;
    u_xlat3.w = u_xlat5.y;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
    u_xlat5.yw = u_xlat3.yz;
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    vec3 txVec4 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
    u_xlat0.x = u_xlat6.w * u_xlat10_15 + u_xlat0.x;
    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
    vec3 txVec5 = vec3(u_xlat2.xy,u_xlat0.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
    vec3 txVec6 = vec3(u_xlat2.zw,u_xlat0.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
    u_xlat2 = vec4(u_xlat0.y * u_xlat4.x, u_xlat0.y * u_xlat4.y, u_xlat0.w * u_xlat4.z, u_xlat0.w * u_xlat4.w);
    u_xlat7 = u_xlat0.w * u_xlat4.y;
    u_xlat0.x = u_xlat2.x * u_xlat10_1 + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
    u_xlat0.x = u_xlat2.z * u_xlat10_22 + u_xlat0.x;
    vec3 txVec7 = vec3(u_xlat3.xy,u_xlat0.z);
    u_xlat10_21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    vec3 txVec8 = vec3(u_xlat3.zw,u_xlat0.z);
    u_xlat10_14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
    u_xlat0.x = u_xlat2.w * u_xlat10_21 + u_xlat0.x;
    u_xlat0.x = u_xlat7 * u_xlat10_14 + u_xlat0.x;
    u_xlat16_7 = (-_LightShadowData.x) + 1.0;
    u_xlat0 = u_xlat0.xxxx * vec4(u_xlat16_7) + _LightShadowData.xxxx;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
}