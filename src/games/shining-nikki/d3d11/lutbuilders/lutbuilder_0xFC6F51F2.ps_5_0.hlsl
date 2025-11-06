// ---- Created with 3Dmigoto v1.4.1 on Wed Nov  5 06:36:06 2025
/*Main lutbuilder, has a custom Tonemap curve from Paper at the end.
This is not the original shader, since that original shader miscompiled.
I have taken a similar lutbuilder from a native D3D11 game and added the differences back in.
Looks accurate in-game to the vanilla shader when running under Vanilla mode.
*/
#include "../../shared.h"

cbuffer _Globals : register(b0) {
  float4 __Lut_Params : packoffset(c0);
  float4 __ColorBalance : packoffset(c1);
  float4 __ColorFilter : packoffset(c2);
  float4 __ChannelMixerRed : packoffset(c3);
  float4 __ChannelMixerGreen : packoffset(c4);
  float4 __ChannelMixerBlue : packoffset(c5);
  float4 __HueSatCon : packoffset(c6);
  float4 __Lift : packoffset(c7);
  float4 __Gamma : packoffset(c8);
  float4 __Gain : packoffset(c9);
  float4 __Shadows : packoffset(c10);
  float4 __Midtones : packoffset(c11);
  float4 __Highlights : packoffset(c12);
  float4 __ShaHiLimits : packoffset(c13);
  float4 __SplitShadows : packoffset(c14);
  float4 __SplitHighlights : packoffset(c15);
  float4 __HdrMaxContrast : packoffset(c16);
  float4 __GenericToneMapParam : packoffset(c17);
}

SamplerState samplers2D_0__s : register(s0);
SamplerState samplers2D_1__s : register(s1);
SamplerState samplers2D_2__s : register(s2);
SamplerState samplers2D_3__s : register(s3);
SamplerState samplers2D_4__s : register(s4);
SamplerState samplers2D_5__s : register(s5);
SamplerState samplers2D_6__s : register(s6);
SamplerState samplers2D_7__s : register(s7);
Texture2D<float4> textures2D_0_ : register(t0);
Texture2D<float4> textures2D_1_ : register(t1);
Texture2D<float4> textures2D_2_ : register(t2);
Texture2D<float4> textures2D_3_ : register(t3);
Texture2D<float4> textures2D_4_ : register(t4);
Texture2D<float4> textures2D_5_ : register(t5);
Texture2D<float4> textures2D_6_ : register(t6);
Texture2D<float4> textures2D_7_ : register(t7);

// 3Dmigoto declarations
#define cmp -

void main(
    float4 v0: SV_Position0,
    float4 v1: TEXCOORD1,
    float2 v2: TEXCOORD0,
    out float4 o0: SV_TARGET0) {
  float4 r0, r1, r2, r3, r4, r5, r6, r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  /*Game is using Unity 2019.4.25f1, seems to match with SRP 7.x.x
  Reference source code can be found here:
  https://github.com/Unity-Technologies/Graphics/blob/v7.7.1/com.unity.render-pipelines.universal/Shaders/PostProcessing/LutBuilderHdr.shader
  */

  // float3 colorLinear = LogCToLinear(colorLutSpace);
  r0.yz = -__Lut_Params.yz + v2.xy;
  r1.x = __Lut_Params.x * r0.y;
  r0.x = frac(r1.x);
  r1.x = r0.x / __Lut_Params.x;
  r0.w = -r1.x + r0.y;

  r0.xyz = r0.xzw * __Lut_Params.www;
  r0.xyz += float3(-0.386036009, -0.386036009, -0.386036009);
  r0.xyz = float3(13.6054821, 13.6054821, 13.6054821) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r0.xyz = float3(-0.0479959995, -0.0479959995, -0.0479959995) + r0.xyz;
  r0.xyz = float3(0.179999992, 0.179999992, 0.179999992) * r0.xyz;

  // float3 colorLMS = LinearToLMS(colorLinear);
  r1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), r0.xyz);
  r1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), r0.xyz);
  r1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), r0.xyz);

  // colorLMS *= _ColorBalance.xyz;
  r0.xyz = __ColorBalance.xyz * r1.xyz;
  r1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), r0.xyz);
  r1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), r0.xyz);
  r1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), r0.xyz);

  //  colorLinear = LMSToLinear(colorLMS);
  r0.xyz = r1.xyz * float3(5.55555582, 5.55555582, 5.55555582) + float3(0.0479959995, 0.0479959995, 0.0479959995);
  r0.xyz = max(float3(0, 0, 0), r0.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = r0.xyz * float3(0.0734997839, 0.0734997839, 0.0734997839) + float3(-0.0275523961, -0.0275523961, -0.0275523961);

  // colorLog = (colorLog - ACEScc_MIDGRAY) * _HueSatCon.z + ACEScc_MIDGRAY;
  r0.xyz = __HueSatCon.zzz * r0.xyz;
  r0.xyz = float3(0.413588405, 0.413588405, 0.413588405) + r0.xyz;
  r0.xyz = float3(-0.386036009, -0.386036009, -0.386036009) + r0.xyz;

  // colorLinear = LogCToLinear(colorLog);
  r0.xyz = float3(13.6054821, 13.6054821, 13.6054821) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r0.xyz = float3(-0.0479959995, -0.0479959995, -0.0479959995) + r0.xyz;

  // colorLinear *= _ColorFilter.xyz;
  r0.xyz = __ColorFilter.xyz * r0.xyz;

  //  colorLinear = max(0.0, colorLinear);
  //  0.18 from LogCToLinear
  r0.xyz = float3(0.179999992, 0.179999992, 0.179999992) * r0.xyz;
  r0.xyz = max(float3(0, 0, 0), r0.xyz);

  // float3 colorGamma = PositivePow(colorLinear, 1.0 / 2.2);
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(0.454545468, 0.454545468, 0.454545468) * r0.xyz;
  r0.xyz = exp2(r0.xyz);

  // Split toning
  r1.xyz = min(float3(1, 1, 1), r0.xyz);
  r0.w = dot(r1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
  r0.w = saturate(__SplitShadows.w + r0.w);
  r1.x = 1 + -r0.w;
  r1.yzw = float3(-0.5, -0.5, -0.5) + __SplitShadows.xyz;
  r1.xyz = r1.xxx * r1.yzw + float3(0.5, 0.5, 0.5);
  r2.xyz = float3(-0.5, -0.5, -0.5) + __SplitShadows.xyz;
  r2.xyz = r0.www * r2.xyz + float3(0.5, 0.5, 0.5);
  r3.xyz = r0.xyz + r0.xyz;
  r4.xyz = r0.xyz * r0.xyz;
  r5.xyz = -r1.xyz * float3(2, 2, 2) + float3(1, 1, 1);
  r4.xyz = r5.xyz * r4.xyz;
  r4.xyz = r3.xyz * r1.xyz + r4.xyz;
  r0.xyz = sqrt(r0.xyz);
  r5.xyz = r1.xyz * float3(2, 2, 2) + float3(-1, -1, -1);
  r6.xyz = float3(1, 1, 1) + -r1.xyz;
  r3.xyz = r6.xyz * r3.xyz;
  r0.xyz = r0.xyz * r5.xyz + r3.xyz;
  r1.xyz = cmp(r1.xyz >= float3(0.5, 0.5, 0.5));
  r3.xyz = r1.xyz ? float3(1, 1, 1) : 0;
  r1.xyz = r1.xyz ? float3(0, 0, 0) : float3(1, 1, 1);
  r1.xyz = r1.xyz * r4.xyz;
  r0.xyz = r0.xyz * r3.xyz + r1.xyz;
  r1.xyz = r0.xyz + r0.xyz;
  r3.xyz = r0.xyz * r0.xyz;
  r4.xyz = -r2.xyz * float3(2, 2, 2) + float3(1, 1, 1);
  r3.xyz = r4.xyz * r3.xyz;
  r3.xyz = r1.xyz * r2.xyz + r3.xyz;
  r0.xyz = sqrt(r0.xyz);
  r4.xyz = r2.xyz * float3(2, 2, 2) + float3(-1, -1, -1);
  r5.xyz = float3(1, 1, 1) + -r2.xyz;
  r1.xyz = r5.xyz * r1.xyz;
  r0.xyz = r0.xyz * r4.xyz + r1.xyz;
  r1.xyz = cmp(r2.xyz >= float3(0.5, 0.5, 0.5));
  r2.xyz = r1.xyz ? float3(1, 1, 1) : 0;
  r1.xyz = r1.xyz ? float3(0, 0, 0) : float3(1, 1, 1);
  r1.xyz = r1.xyz * r3.xyz;
  r0.xyz = r0.xyz * r2.xyz + r1.xyz;

  // colorLinear = PositivePow(colorGamma, 2.2);
  r0.xyz = log2(abs(r0.xyz));
  r0.xyz = float3(2.20000005, 2.20000005, 2.20000005) * r0.xyz;
  r0.xyz = exp2(r0.xyz);

  // Channel mixing (Adobe style)
  r1.x = dot(r0.xyz, __ChannelMixerRed.xyz);
  r1.y = dot(r0.xyz, __ChannelMixerGreen.xyz);
  r1.z = dot(r0.xyz, __ChannelMixerBlue.xyz);

  // Shadows, midtones, highlights
  r0.x = dot(r1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
  r0.yz = __ShaHiLimits.yw + -__ShaHiLimits.xz;
  r0.xw = -__ShaHiLimits.xz + r0.xx;
  r0.yz = float2(1, 1) / r0.yz;
  r0.xy = saturate(r0.xw * r0.yz);
  r0.zw = r0.xy * float2(-2, -2) + float2(3, 3);
  r0.xy = r0.xy * r0.xy;
  r1.w = r0.w * r0.y;
  r0.x = -r0.z * r0.x + 1;
  r0.z = 1 + -r0.x;
  r0.y = -r0.w * r0.y + r0.z;
  r2.xyz = __Shadows.xyz * r1.xyz;
  r3.xyz = __Midtones.xyz * r1.xyz;
  r0.yzw = r3.xyz * r0.yyy;
  r0.xyz = r2.xyz * r0.xxx + r0.yzw;
  r1.xyz = __Highlights.xyz * r1.xyz;
  r0.xyz = r1.xyz * r1.www + r0.xyz;

  // Lift, gamma, gain
  // TODO: Reduce Lift in HDR
  r0.xyz = r0.xyz * __Gain.xyz + __Lift.xyz;
  r1.xyz = cmp(float3(0, 0, 0) < r0.xyz);
  r2.xyz = cmp(r0.xyz < float3(0, 0, 0));
  r1.xyz = (int3)-r1.xyz + (int3)r2.xyz;
  r1.xyz = (int3)r1.xyz;
  r0.xyz = log2(abs(r0.xyz));
  r0.xyz = __Gamma.xyz * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r2.xyz = r1.xyz * r0.xyz;

  // HSV operations
  r0.x = cmp(r2.y >= r2.z);
  r0.x = r0.x ? 1.000000 : 0;
  r3.xy = r2.zy;
  r3.zw = float2(-1, 0.666666687);
  r1.xy = r1.yz * r0.yz + -r3.xy;
  r1.zw = float2(1, -1);
  r0.xyzw = r0.xxxx * r1.xyzw + r3.xyzw;
  r1.x = cmp(r2.x >= r0.x);
  r1.x = r1.x ? 1.000000 : 0;
  r3.xyz = r0.xyw;
  r3.w = r2.x;
  r0.xyw = r3.wyx;
  r0.xyzw = r0.xyzw + -r3.xyzw;
  r0.xyzw = r1.xxxx * r0.xyzw + r3.xyzw;
  r1.x = min(r0.w, r0.y);
  r1.x = -r1.x + r0.x;
  r0.y = r0.w + -r0.y;
  r0.w = r1.x * 6 + 9.99999975e-05;
  r0.y = r0.y / r0.w;
  r0.y = r0.z + r0.y;
  r3.x = abs(r0.y);
  r0.y = 9.99999975e-05 + r0.x;
  r3.z = r1.x / r0.y;
  r3.yw = float2(0, 0);
  r1.xyzw = textures2D_5_.Sample(samplers2D_5__s, r3.xy).xyzw;
  r1.x = saturate(r1.x);
  r0.y = r1.x + r1.x;
  r1.xyzw = textures2D_6_.Sample(samplers2D_6__s, r3.zw).xyzw;
  r1.x = saturate(r1.x);
  r0.y = dot(r1.xx, r0.yy);
  r1.x = dot(r2.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
  r1.yw = float2(0, 0);
  r2.xyzw = textures2D_7_.Sample(samplers2D_7__s, r1.xy).xyzw;
  r2.x = saturate(r2.x);
  r0.y = r2.x * r0.y;
  r1.z = __HueSatCon.x + r3.x;
  r2.xyzw = textures2D_4_.Sample(samplers2D_4__s, r1.zw).xyzw;
  r2.x = saturate(r2.x);
  r0.z = r2.x + r1.z;
  r1.xyz = float3(-0.5, 0.5, -1.5) + r0.zzz;
  r0.z = cmp(r1.x < 0);
  r0.w = cmp(1 < r1.x);
  r0.w = r0.w ? r1.z : r1.x;
  r0.z = r0.z ? r1.y : r0.w;
  r1.xyz = float3(1, 0.666666687, 0.333333343) + r0.zzz;
  r1.xyz = frac(r1.xyz);
  r1.xyz = r1.xyz * float3(6, 6, 6) + float3(-3, -3, -3);
  r1.xyz = saturate(float3(-1, -1, -1) + abs(r1.xyz));
  r1.xyz = float3(-1, -1, -1) + r1.xyz;
  r1.xyz = r3.zzz * r1.xyz + float3(1, 1, 1);
  r2.xyz = r1.xyz * r0.xxx;

  // Global saturation
  r0.z = dot(r2.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
  r0.y = dot(__HueSatCon.yy, r0.yy);
  r1.xyz = r0.xxx * r1.xyz + -r0.zzz;
  r0.xyz = r0.yyy * r1.xyz + r0.zzz;

  // YRGB curves

  // colorLinear = FastTonemap(colorLinear);
  r0.w = max(r0.x, r0.y);
  r0.w = max(r0.w, r0.z);
  r0.w = 1 + r0.w;
  r0.w = 1 / r0.w;

  r0.xyz = r0.xyz * r0.www + float3(0.00390625, 0.00390625, 0.00390625);
  r0.w = 0;
  // Y (master)
  r1.xyzw = textures2D_0_.Sample(samplers2D_0__s, r0.xw).xyzw;
  r1.x = saturate(r1.x);
  r2.xyzw = textures2D_0_.Sample(samplers2D_0__s, r0.yw).xyzw;
  r1.y = saturate(r2.x);
  r0.xyzw = textures2D_0_.Sample(samplers2D_0__s, r0.zw).xyzw;
  r1.z = saturate(r0.x);
  r0.xyz = float3(0.00390625, 0.00390625, 0.00390625) + r1.xyz;
  r0.w = 0;
  r1.xyzw = textures2D_1_.Sample(samplers2D_1__s, r0.xw).xyzw;
  r1.x = saturate(r1.x);
  r2.xyzw = textures2D_2_.Sample(samplers2D_2__s, r0.yw).xyzw;
  r1.y = saturate(r2.x);
  r0.xyzw = textures2D_3_.Sample(samplers2D_3__s, r0.zw).xyzw;
  r1.z = saturate(r0.x);

  //     colorLinear = FastTonemapInvert(colorLinear);
  r0.x = max(r1.x, r1.y);
  r0.x = max(r0.x, r1.z);
  r0.x = 1 + -r0.x;
  r0.x = 1 / r0.x;
  r0.xyz = r1.xyz * r0.xxx;

  r0.xyz = max(float3(0, 0, 0), r0.xyz);

  float3 untonemapped = r0.xyz;

  // Custom tonemapping

  r0.xyz = min(__HdrMaxContrast.xxx, r0.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = __HdrMaxContrast.yyy * r0.xyz;
  r1.xyz = __GenericToneMapParam.zzz * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r1.xyz = exp2(r1.xyz);
  r1.xyz = __GenericToneMapParam.xxx * r1.xyz;
  r1.xyz = __GenericToneMapParam.yyy + r1.xyz;
  r0.xyz = r0.xyz / r1.xyz;
  r0.xyz = max(float3(0, 0, 0), r0.xyz);
  r0.xyz = min(float3(1, 1, 1), r0.xyz);
  r0.w = 1;

  if (RENODX_TONE_MAP_TYPE == 0.f) {
    o0.xyzw = r0.xyzw;
    return;
  }

  float3 tonemapped = renodx::draw::ToneMapPass(untonemapped, r0.xyz);
  o0.xyz = tonemapped;
  o0.w = r0.w;
  return;
}
