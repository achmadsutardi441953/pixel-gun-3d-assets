//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Optimized/VehicleShader" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Detail ("Detail (RGBA)", 2D) = "alpha" { }
_Power ("DetailPower", Range(0, 1)) = 0.1
_Damage ("Damage", Range(0, 1)) = 0
_CarColor ("ColorChange", Color) = (0,0,0,0)
_Alpha ("alpha", Range(0, 1)) = 1
_Cut ("cut", Float) = 0.1
}
SubShader {
 LOD 150
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 150
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 35564
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_Power==1.0);
#else
    u_xlatb16 = _Power==1.0;
#endif
    u_xlat16 = (u_xlatb16) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_17 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(u_xlat16_17) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat10_3.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz + (-u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(_Power) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_Power==1.0);
#else
    u_xlatb18 = _Power==1.0;
#endif
    u_xlat18 = (u_xlatb18) ? -0.400000006 : -0.0;
    u_xlat3.xyz = vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "PREPASS"
  LOD 150
  Tags { "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 68397
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb1;
void main()
{
    u_xlat16_0 = (-_Cut) + _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb1;
void main()
{
    u_xlat16_0 = (-_Cut) + _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb1;
void main()
{
    u_xlat16_0 = (-_Cut) + _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
}
}
 Pass {
  Name "PREPASS"
  LOD 150
  Tags { "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 166841
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat3.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat13 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _Alpha;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 150
  Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 227214
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target3.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target3.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target3.xyz = u_xlat1.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat16_0 = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_Power==1.0);
#else
    u_xlatb13 = _Power==1.0;
#endif
    u_xlat13 = (u_xlatb13) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat13) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_Power==1.0);
#else
    u_xlatb19 = _Power==1.0;
#endif
    u_xlat19 = (u_xlatb19) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_2.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_2.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_2.x);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target3.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    SV_Target3.w = 1.0;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "META"
  LOD 150
  Tags { "LIGHTMODE" = "META" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 278414
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat10 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat10 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Power;
uniform 	float _Damage;
uniform 	mediump vec4 _CarColor;
uniform 	mediump float _Alpha;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	mediump float _Cut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Detail;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.x = _Alpha + (-_Cut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.www * _CarColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat10_1.xyz = texture(_Detail, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(_Power) * u_xlat16_1.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_Power==1.0);
#else
    u_xlatb10 = _Power==1.0;
#endif
    u_xlat10 = (u_xlatb10) ? -0.400000006 : -0.0;
    u_xlat1.xyz = vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(vec3(_Damage, _Damage, _Damage)) * vec3(0.5, 0.0, 0.0) + u_xlat1.xyz;
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat10 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
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
}
}
}
Fallback "Mobile/VertexLit"
}