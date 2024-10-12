// ---- Created with 3Dmigoto v1.4.1 on Fri Oct 11 21:13:01 2024
#include "./shared.h"

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[19];
}




// 3Dmigoto declarations
#define cmp -


void main(
  linear noperspective float2 v0 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = -cb0[18].xy + v0.xy;
  r0.xyzw = t0.SampleLevel(s0_s, r0.xy, 0).xyzw;
  r1.xyzw = cb0[18].xyxy * float4(1,-1,-1,1) + v0.xyxy;
  r2.xyzw = t0.SampleLevel(s0_s, r1.xy, 0).xyzw;
  r1.xyzw = t0.SampleLevel(s0_s, r1.zw, 0).xyzw;
  r0.xyzw = r2.xyzw + r0.xyzw;
  r0.xyzw = r0.xyzw + r1.xyzw;
  r1.xy = cb0[18].xy + v0.xy;
  r1.xyzw = t0.SampleLevel(s0_s, r1.xy, 0).xyzw;
  r0.xyzw = r1.xyzw + r0.xyzw;
  r0.xyzw = float4(0.25,0.25,0.25,0.25) * r0.xyzw;
  o0.xyz = max(float3(0,0,0), r0.xyz);
  o0.w = r0.w;

  o0.rgb = renodx::math::SafePow(o0.rgb, 2.2f);                         // linearize
  o0.rgb *= injectedData.toneMapUINits / injectedData.toneMapGameNits;  // Ratio of UI:Game brightness
  o0.rgb = renodx::math::SafePow(o0.rgb, 1 / 2.2);                      // Go back to gamma space
  return;
}