//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/CelShadingForward" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 55251
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = (c_1 + c_12).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = (c_1 + c_12).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = (c_1 + c_12).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_4 + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_4 + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_5;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * lm_1);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_4.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_9;
  c_3.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * min (lm_1, vec3((tmpvar_4 * 2.0))));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = (c_1 + c_8).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1.xyz = (c_1 + c_22).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1.xyz = (c_1 + c_24).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1 = (c_1 + c_12);
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1 = (c_1 + c_12);
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  mediump float shadowMaskAttenuation_8;
  lowp float tmpvar_9;
  tmpvar_9 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_8 = tmpvar_9;
  atten_2 = shadowMaskAttenuation_8;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1 = (c_1 + c_12);
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord1.xy * unity_LightmapST.xy);
  tmpvar_1.xy = (tmpvar_5 + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (tmpvar_5 + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_6;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * lm_1);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_7));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 lm_1;
  lowp vec4 lmtex_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_5;
  highp float lightShadowDataX_6;
  mediump float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_6);
  tmpvar_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  lmtex_2 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (unity_Lightmap_HDR.x * lmtex_2.xyz);
  lm_1 = tmpvar_10;
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_6.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1 = (c_1 + c_8);
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_9.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_9.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_9.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_2 = (tmpvar_2 + col_22);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_9.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_9.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_9.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_2 = (tmpvar_2 + col_22);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_9.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_9.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_9.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_2 = (tmpvar_2 + col_22);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  highp vec4 v_9;
  v_9.x = unity_MatrixV[0].z;
  v_9.y = unity_MatrixV[1].z;
  v_9.z = unity_MatrixV[2].z;
  v_9.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_9.xyz), sqrt(dot (tmpvar_10, tmpvar_10)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_14;
  highp vec4 shadowCoord_15;
  shadowCoord_15 = (unity_WorldToShadow[0] * tmpvar_13);
  highp float lightShadowDataX_16;
  mediump float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((texture2D (_ShadowMapTexture, shadowCoord_15.xy).x > shadowCoord_15.z)), lightShadowDataX_16);
  tmpvar_14 = tmpvar_18;
  realtimeShadowAttenuation_8 = tmpvar_14;
  mediump float tmpvar_19;
  tmpvar_19 = clamp ((realtimeShadowAttenuation_8 + tmpvar_11), 0.0, 1.0);
  atten_2 = tmpvar_19;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_4;
  mediump float atten_21;
  atten_21 = atten_2;
  mediump vec4 c_22;
  mediump float NdotL_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, lightDir_20);
  NdotL_23 = tmpvar_24;
  if (((tmpvar_24 <= 0.4) && (tmpvar_24 >= 0.01))) {
    NdotL_23 = 0.7;
  } else {
    if (((NdotL_23 >= 0.4) && (NdotL_23 <= 0.45))) {
      NdotL_23 = mix (-2.0, 1.0, (NdotL_23 / 0.45));
    } else {
      if ((NdotL_23 <= 0.01)) {
        NdotL_23 = mix (0.7, 0.4, (NdotL_23 + 0.1));
      } else {
        NdotL_23 = 1.0;
      };
    };
  };
  c_22.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_23 * atten_21));
  c_22.w = tmpvar_6;
  c_1 = (c_1 + c_22);
  highp float tmpvar_25;
  tmpvar_25 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_25));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = mix (realtimeShadowAttenuation_8, shadowMaskAttenuation_9, tmpvar_12);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_2 = (tmpvar_2 + col_21);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_ShadowMask;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_6 = tmpvar_7.w;
  mediump float realtimeShadowAttenuation_8;
  mediump float shadowMaskAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (dot (texture2D (unity_ShadowMask, xlv_TEXCOORD4), unity_OcclusionMaskSelector), 0.0, 1.0);
  shadowMaskAttenuation_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_8 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = min (clamp ((realtimeShadowAttenuation_8 + tmpvar_12), 0.0, 1.0), shadowMaskAttenuation_9);
  atten_2 = tmpvar_21;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_7.xyz * xlv_TEXCOORD3);
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_4;
  mediump float atten_23;
  atten_23 = atten_2;
  mediump vec4 c_24;
  mediump float NdotL_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_3, lightDir_22);
  NdotL_25 = tmpvar_26;
  if (((tmpvar_26 <= 0.4) && (tmpvar_26 >= 0.01))) {
    NdotL_25 = 0.7;
  } else {
    if (((NdotL_25 >= 0.4) && (NdotL_25 <= 0.45))) {
      NdotL_25 = mix (-2.0, 1.0, (NdotL_25 / 0.45));
    } else {
      if ((NdotL_25 <= 0.01)) {
        NdotL_25 = mix (0.7, 0.4, (NdotL_25 + 0.1));
      } else {
        NdotL_25 = 1.0;
      };
    };
  };
  c_24.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_25 * atten_23));
  c_24.w = tmpvar_6;
  c_1 = (c_1 + c_24);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_27));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 86172
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_3, lightCoord_3))).w;
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_6.w;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_7;
  lightDir_7 = lightDir_4;
  mediump vec4 c_8;
  mediump float NdotL_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_2, lightDir_7);
  NdotL_9 = tmpvar_10;
  if (((tmpvar_10 <= 0.4) && (tmpvar_10 >= 0.01))) {
    NdotL_9 = 0.7;
  } else {
    if (((NdotL_9 >= 0.4) && (NdotL_9 <= 0.45))) {
      NdotL_9 = mix (-2.0, 1.0, (NdotL_9 / 0.45));
    } else {
      if ((NdotL_9 <= 0.01)) {
        NdotL_9 = mix (0.7, 0.4, (NdotL_9 + 0.1));
      } else {
        NdotL_9 = 1.0;
      };
    };
  };
  c_8.xyz = ((tmpvar_6.xyz * _LightColor0.xyz) * NdotL_9);
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_11));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  highp float tmpvar_20;
  tmpvar_20 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_20));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  highp float tmpvar_20;
  tmpvar_20 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_20));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec4 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  lowp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, ((lightCoord_3.xy / lightCoord_3.w) + 0.5));
  tmpvar_10 = tmpvar_11.w;
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(dot (lightCoord_3.xyz, lightCoord_3.xyz)));
  tmpvar_12 = tmpvar_13.w;
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_3.z > 0.0)
  ) * tmpvar_10) * tmpvar_12);
  atten_2 = tmpvar_14;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump float atten_16;
  atten_16 = atten_2;
  mediump vec4 c_17;
  mediump float NdotL_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_4, lightDir_15);
  NdotL_18 = tmpvar_19;
  if (((tmpvar_19 <= 0.4) && (tmpvar_19 >= 0.01))) {
    NdotL_18 = 0.7;
  } else {
    if (((NdotL_18 >= 0.4) && (NdotL_18 <= 0.45))) {
      NdotL_18 = mix (-2.0, 1.0, (NdotL_18 / 0.45));
    } else {
      if ((NdotL_18 <= 0.01)) {
        NdotL_18 = mix (0.7, 0.4, (NdotL_18 + 0.1));
      } else {
        NdotL_18 = 1.0;
      };
    };
  };
  c_17.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_18 * atten_16));
  c_17.w = tmpvar_5;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  highp float tmpvar_20;
  tmpvar_20 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_20));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  highp vec3 lightCoord_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_5 = tmpvar_8.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9).xyz;
  highp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_3, lightCoord_3))).w * textureCube (_LightTexture0, lightCoord_3).w);
  atten_2 = tmpvar_10;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_6;
  mediump float atten_12;
  atten_12 = atten_2;
  mediump vec4 c_13;
  mediump float NdotL_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_4, lightDir_11);
  NdotL_14 = tmpvar_15;
  if (((tmpvar_15 <= 0.4) && (tmpvar_15 >= 0.01))) {
    NdotL_14 = 0.7;
  } else {
    if (((NdotL_14 >= 0.4) && (NdotL_14 <= 0.45))) {
      NdotL_14 = mix (-2.0, 1.0, (NdotL_14 / 0.45));
    } else {
      if ((NdotL_14 <= 0.01)) {
        NdotL_14 = mix (0.7, 0.4, (NdotL_14 + 0.1));
      } else {
        NdotL_14 = 1.0;
      };
    };
  };
  c_13.xyz = ((tmpvar_8.xyz * _LightColor0.xyz) * (NdotL_14 * atten_12));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  highp float tmpvar_16;
  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_16));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_4 = tmpvar_7.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_8).xy).w;
  atten_2 = tmpvar_9;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_5;
  mediump float atten_11;
  atten_11 = atten_2;
  mediump vec4 c_12;
  mediump float NdotL_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, lightDir_10);
  NdotL_13 = tmpvar_14;
  if (((tmpvar_14 <= 0.4) && (tmpvar_14 >= 0.01))) {
    NdotL_13 = 0.7;
  } else {
    if (((NdotL_13 >= 0.4) && (NdotL_13 <= 0.45))) {
      NdotL_13 = mix (-2.0, 1.0, (NdotL_13 / 0.45));
    } else {
      if ((NdotL_13 <= 0.01)) {
        NdotL_13 = mix (0.7, 0.4, (NdotL_13 + 0.1));
      } else {
        NdotL_13 = 1.0;
      };
    };
  };
  c_12.xyz = ((tmpvar_7.xyz * _LightColor0.xyz) * (NdotL_13 * atten_11));
  c_12.w = tmpvar_4;
  c_1.xyz = c_12.xyz;
  c_1.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = (c_1.xyz * vec3(tmpvar_15));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "META"
  LOD 200
  Tags { "LIGHTMODE" = "META" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 188879
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
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
Fallback "Diffuse"
}