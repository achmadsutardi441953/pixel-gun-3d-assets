//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Optimized/FakeLit" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_CutOut ("Cutout", Range(0, 1)) = 1
_SunX ("SunX", Range(-1, 1)) = 1
_SunY ("SunY", Range(-1, 1)) = 1
_SunZ ("SunZ", Range(-1, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-100" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-100" "RenderType" = "Transparent" }
  ZTest Less
  Cull Off
  GpuProgramID 18469
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp float _SunX;
uniform lowp float _SunY;
uniform lowp float _SunZ;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec3 _normal_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  _normal_1 = tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4.x = _SunX;
  tmpvar_4.y = _SunY;
  tmpvar_4.z = _SunZ;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.5, dot (_normal_1, tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.x = tmpvar_5;
  tmpvar_7.y = tmpvar_5;
  tmpvar_7.z = (tmpvar_5 * 1.3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _CutOut;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR1);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = clamp (tmpvar_2.w, 0.01, 1.0);
  if ((col_1.w < _CutOut)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
}
}
}
}