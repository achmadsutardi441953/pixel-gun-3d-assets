//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Noise Shader YUV" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_GrainTex ("Base (RGB)", 2D) = "gray" { }
_ScratchTex ("Base (RGB)", 2D) = "gray" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 21584
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _GrainOffsetScale;
uniform highp vec4 _ScratchOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 inUV_3;
  inUV_3 = tmpvar_1;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = inUV_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (mat4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0) * tmpvar_4).xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GrainOffsetScale.zw) + _GrainOffsetScale.xy);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScratchOffsetScale.zw) + _ScratchOffsetScale.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrainTex;
uniform sampler2D _ScratchTex;
uniform lowp vec4 _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 yuv_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  yuv_1.x = dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114));
  yuv_1.y = ((tmpvar_3.z - yuv_1.x) * 0.492);
  yuv_1.z = ((tmpvar_3.x - yuv_1.x) * 0.877);
  yuv_1 = (yuv_1 + ((
    (texture2D (_GrainTex, xlv_TEXCOORD1).xyz * 2.0)
   - 1.0) * _Intensity.x));
  col_2.x = ((yuv_1.z * 1.14) + yuv_1.x);
  col_2.y = (((yuv_1.z * -0.581) + (yuv_1.y * -0.395)) + yuv_1.x);
  col_2.z = ((yuv_1.y * 2.032) + yuv_1.x);
  col_2.xyz = (col_2.xyz + ((
    (texture2D (_ScratchTex, xlv_TEXCOORD2).xyz * 2.0)
   - 1.0) * _Intensity.y));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _GrainOffsetScale;
uniform highp vec4 _ScratchOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 inUV_3;
  inUV_3 = tmpvar_1;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = inUV_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (mat4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0) * tmpvar_4).xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GrainOffsetScale.zw) + _GrainOffsetScale.xy);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScratchOffsetScale.zw) + _ScratchOffsetScale.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrainTex;
uniform sampler2D _ScratchTex;
uniform lowp vec4 _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 yuv_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  yuv_1.x = dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114));
  yuv_1.y = ((tmpvar_3.z - yuv_1.x) * 0.492);
  yuv_1.z = ((tmpvar_3.x - yuv_1.x) * 0.877);
  yuv_1 = (yuv_1 + ((
    (texture2D (_GrainTex, xlv_TEXCOORD1).xyz * 2.0)
   - 1.0) * _Intensity.x));
  col_2.x = ((yuv_1.z * 1.14) + yuv_1.x);
  col_2.y = (((yuv_1.z * -0.581) + (yuv_1.y * -0.395)) + yuv_1.x);
  col_2.z = ((yuv_1.y * 2.032) + yuv_1.x);
  col_2.xyz = (col_2.xyz + ((
    (texture2D (_ScratchTex, xlv_TEXCOORD2).xyz * 2.0)
   - 1.0) * _Intensity.y));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _GrainOffsetScale;
uniform highp vec4 _ScratchOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 inUV_3;
  inUV_3 = tmpvar_1;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = inUV_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (mat4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0) * tmpvar_4).xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GrainOffsetScale.zw) + _GrainOffsetScale.xy);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScratchOffsetScale.zw) + _ScratchOffsetScale.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrainTex;
uniform sampler2D _ScratchTex;
uniform lowp vec4 _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 yuv_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  yuv_1.x = dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114));
  yuv_1.y = ((tmpvar_3.z - yuv_1.x) * 0.492);
  yuv_1.z = ((tmpvar_3.x - yuv_1.x) * 0.877);
  yuv_1 = (yuv_1 + ((
    (texture2D (_GrainTex, xlv_TEXCOORD1).xyz * 2.0)
   - 1.0) * _Intensity.x));
  col_2.x = ((yuv_1.z * 1.14) + yuv_1.x);
  col_2.y = (((yuv_1.z * -0.581) + (yuv_1.y * -0.395)) + yuv_1.x);
  col_2.z = ((yuv_1.y * 2.032) + yuv_1.x);
  col_2.xyz = (col_2.xyz + ((
    (texture2D (_ScratchTex, xlv_TEXCOORD2).xyz * 2.0)
   - 1.0) * _Intensity.y));
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
}