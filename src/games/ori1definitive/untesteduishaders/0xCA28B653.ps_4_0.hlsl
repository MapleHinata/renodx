#include "../common.hlsl"

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[22];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = saturate(v1.yx);
  r0.xy = -cb0[20].yx + r0.xy;
  r0.xy = saturate(r0.xy / cb0[20].wz);
  r0.zw = cb0[7].yy * r0.xy;
  r1.x = 1 + -cb0[7].y;
  r0.xy = r0.yx * r1.xx + r0.zw;
  r0.xy = r0.xy * cb0[19].zw + cb0[19].xy;
  r0.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xyzw = cb0[21].xyzw * r0.xyzw;
  r0.xyzw = r0.xyzw + r0.xyzw;
  o0.xyzw = v2.xyzw * r0.xyzw;

  o0 = ClampUI(o0);

  return;

}