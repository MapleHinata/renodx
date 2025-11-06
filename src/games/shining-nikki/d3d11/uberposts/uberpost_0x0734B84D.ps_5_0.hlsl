// ---- Created with 3Dmigoto v1.4.1 on Wed Nov  5 02:04:46 2025
// Used by the game during the splash screen, logos and patching scenes. Has support for a custom SDR lut.
// Only used in the initial 2D scenes, it's here just for completeness sake.
#include "../../shared.h"

cbuffer _Globals : register(b0) {
  float4 __ScreenParams : packoffset(c0);
  float4 __Lut_Params : packoffset(c1);
  float4 __UserLut_Params : packoffset(c2);
  float4 __Vignette_Params1 : packoffset(c3);
  float4 __Vignette_Params2 : packoffset(c4);
  float __EnableAlpha : packoffset(c5);
  float __UseCustomAlpha : packoffset(c6);
  float4 __OutlineParams : packoffset(c7);
  float4 __Outline3Params : packoffset(c8);
  float4 __OutlineColor : packoffset(c9);
}

SamplerState samplers2D_0__s : register(s0);
SamplerState samplers2D_1__s : register(s1);
SamplerState samplers2D_2__s : register(s2);
SamplerState samplers2D_3__s : register(s3);
SamplerState samplers2D_4__s : register(s4);
Texture2D<float4> textures2D_0_ : register(t0);
Texture2D<float4> textures2D_1_ : register(t1);
Texture2D<float4> textures2D_2_ : register(t2);
Texture2D<float4> textures2D_3_ : register(t3);
Texture2D<float4> textures2D_4_ : register(t4);

// 3Dmigoto declarations
#define cmp -

void main(
    float4 v0: SV_Position0,
    float4 v1: TEXCOORD1,
    float2 v2: TEXCOORD0,
    out float4 o0: SV_TARGET0) {
  float4 r0, r1, r2, r3, r4, r5, r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v2.xy;
  r1.xyzw = textures2D_0_.Sample(samplers2D_0__s, v2.xy).xyzw;
  r1.xyzw = r1.xyzw;
  r0.z = cmp(0 < __EnableAlpha);
  if (r0.z != 0) {
    r1.w = textures2D_3_.Sample(samplers2D_3__s, v2.xy).x;
    r1.w = r1.w;
    r1.w = r1.w;
  } else {
    r1.w = r1.w;
  }
  r0.z = cmp(0.5 < __OutlineParams.w);
  if (r0.z != 0) {
    r0.z = cmp(__Outline3Params.w < 0.5);
    if (r0.z != 0) {
      r0.zw = float2(-0.5, -0.5) + r0.xy;
      r2.x = r0.w / r0.z;
      r2.y = -r2.x;
      r2.y = max(r2.x, r2.y);
      r2.y = min(1, r2.y);
      r2.z = -r2.x;
      r2.z = max(r2.x, r2.z);
      r2.z = max(1, r2.z);
      r2.z = 1 / r2.z;
      r2.y = r2.z * r2.y;
      r2.z = r2.y * r2.y;
      r2.w = 0.0208350997 * r2.z;
      r2.w = -0.0851330012 + r2.w;
      r2.w = r2.z * r2.w;
      r2.w = 0.180141002 + r2.w;
      r2.w = r2.z * r2.w;
      r2.w = -0.330299497 + r2.w;
      r2.z = r2.z * r2.w;
      r2.z = 0.999866009 + r2.z;
      r2.w = r2.z * r2.y;
      r3.x = -r2.x;
      r3.x = max(r3.x, r2.x);
      r3.x = cmp(1 < r3.x);
      r2.w = -2 * r2.w;
      r2.w = 1.57079637 + r2.w;
      if (r3.x != 0) {
        r2.w = r2.w;
      } else {
        r2.w = 0;
      }
      r2.w = r2.w;
      r2.y = r2.y * r2.z;
      r2.y = r2.y + r2.w;
      r2.x = min(1, r2.x);
      r2.z = -r2.x;
      r2.x = cmp(r2.x < r2.z);
      if (r2.x != 0) {
        r2.y = -r2.y;
      } else {
        r2.y = r2.y;
      }
      r2.y = r2.y;
      r2.xz = cmp(float2(0, 0) >= r0.zw);
      r0.z = cmp(r0.w >= 0);
      if (r2.x != 0) {
        r0.w = 1;
      } else {
        r0.w = 0;
      }
      r0.w = r0.w;
      if (r0.z != 0) {
        r0.z = 1;
      } else {
        r0.z = 0;
      }
      r0.z = r0.z;
      if (r2.z != 0) {
        r2.x = 1;
      } else {
        r2.x = 0;
      }
      r2.x = r2.x;
      r0.z = r0.z * r0.w;
      r2.y = 0.318309873 * r2.y;
      r0.z = r2.y + r0.z;
      r0.w = -r0.w;
      r0.w = r0.w * r2.x;
      r0.z = r0.w + r0.z;
      r0.z = 1 + r0.z;
      r2.x = 0.5 * r0.z;
      r2.x = r2.x;
      r2.y = 0.5;
      r0.z = textures2D_4_.Sample(samplers2D_4__s, r2.xy).x;
      r0.z = r0.z;
      r0.z = r0.z;
    } else {
      r0.z = 1;
    }
    r0.zw = __OutlineParams.xx * r0.zz;
    r0.zw = r0.zw;
    r0.zw = r0.zw;
    r2.yz = r0.zw / __ScreenParams.yx;
    r2.xw = -r2.zy;
    r3.xyzw = r2.xyzw + r0.xyxy;
    r3.xy = r3.xy;
    r0.z = textures2D_3_.Sample(samplers2D_3__s, r3.xy).x;
    r0.z = r0.z;
    r0.z = r0.z;
    r0.z = cmp(r0.z >= 0.0500000007);
    if (r0.z != 0) {
      r0.z = 1;
    } else {
      r0.z = 0;
    }
    r0.z = r0.z;
    r3.zw = r3.zw;
    r0.w = textures2D_3_.Sample(samplers2D_3__s, r3.zw).x;
    r0.w = r0.w;
    r0.w = r0.w;
    r0.w = cmp(r0.w >= 0.0500000007);
    r2.xw = -r2.zy;
    r2.xw = r2.xw + r0.xy;
    r2.xw = r2.xw;
    r2.x = textures2D_3_.Sample(samplers2D_3__s, r2.xw).x;
    r2.x = r2.x;
    r2.x = cmp(r2.x >= 0.0500000007);
    r2.yz = r2.zy + r0.xy;
    r2.yz = r2.yz;
    r2.y = textures2D_3_.Sample(samplers2D_3__s, r2.yz).x;
    r2.y = r2.y;
    r2.y = r2.y;
    r2.y = cmp(r2.y >= 0.0500000007);
    if (r2.y != 0) {
      r2.y = 1;
    } else {
      r2.y = 0;
    }
    r2.y = r2.y;
    if (r0.w != 0) {
      r0.w = -1;
    } else {
      r0.w = -0;
    }
    r0.w = r0.w;
    r0.z = r0.w + r0.z;
    if (r2.x != 0) {
      r0.w = -1;
    } else {
      r0.w = -0;
    }
    r0.w = r0.w;
    r0.w = r0.w + r2.y;
    r0.w = r0.w * r0.w;
    r0.z = r0.z * r0.z;
    r0.z = r0.z + r0.w;
    r0.z = sqrt(r0.z);
    r0.w = textures2D_3_.Sample(samplers2D_3__s, v2.xy).x;
    r0.w = r0.w;
    r0.w = r0.w;
    r2.x = cmp(r0.w >= 0.0500000007);
    if (r2.x != 0) {
      r0.z = r0.z;
    } else {
      r0.z = 0;
    }
    r0.z = r0.z;
    r2.x = cmp(0.00999999978 < __UseCustomAlpha);
    r0.w = cmp(r0.w < 0.119999997);
    if (r0.w != 0) {
      r2.yzw = float3(1, 0, 0);
    } else {
      r2.yzw = float3(1, 1, 1);
    }
    r2.yzw = r2.yzw;
    if (r2.x != 0) {
      r2.yzw = r2.yzw;
    } else {
      r2.yzw = float3(1, 1, 1);
    }
    r2.yzw = r2.yzw;
    r3.xyz = __OutlineColor.xyz * r2.yzw;
    r4.xyz = -__OutlineColor.xyz;
    r2.xyz = r4.xyz * r2.yzw;
    r2.xyz = r2.xyz + r1.xyz;
    r2.xyz = __OutlineParams.yyy * r2.xyz;
    r2.xyz = r2.xyz + r3.xyz;
    r0.w = -__OutlineParams.z;
    r0.w = 1 + r0.w;
    r2.w = -__OutlineParams.z;
    r0.z = r2.w + r0.z;
    r0.w = 1 / r0.w;
    r0.z = r0.w * r0.z;
    r0.z = max(0, r0.z);
    r0.z = min(1, r0.z);
    r0.w = -2 * r0.z;
    r0.w = 3 + r0.w;
    r0.z = r0.z * r0.z;
    r3.xyz = r0.zzz * r0.www;
    r4.xyz = -r1.xyz;
    r2.xyz = r4.xyz + r2.xyz;
    r3.xyz = r3.xyz;
    r3.xyz = r3.xyz;
    r2.xyz = r3.xyz * r2.xyz;
    r1.xyz = r2.xyz + r1.xyz;
    r1.xyz = r1.xyz;
  } else {
    r1.xyz = r1.xyz;
  }
  r0.z = cmp(0 < __Vignette_Params2.z);
  if (r0.z != 0) {
    r0.zw = -__Vignette_Params2.xy;
    r0.xy = r0.xy + r0.zw;
    r0.zw = -r0.xy;
    r0.xy = max(r0.xy, r0.zw);
    r0.yz = __Vignette_Params2.zz * r0.xy;
    r0.x = __Vignette_Params1.w * r0.y;
    r0.x = dot(r0.xz, r0.xz);
    r0.x = -r0.x;
    r0.x = 1 + r0.x;
    r0.x = max(0, r0.x);
    r0.x = log2(r0.x);
    r0.x = __Vignette_Params2.w * r0.x;
    r0.x = exp2(r0.x);
    r0.yzw = -__Vignette_Params1.xyz;
    r0.yzw = float3(1, 1, 1) + r0.yzw;
    r0.xyz = r0.xxx * r0.yzw;
    r0.xyz = __Vignette_Params1.xyz + r0.xyz;
    r1.xyz = r0.xyz * r1.xyz;
    r1.xyz = r1.xyz;
  }

  float3 untonemapped = r1.xyz;

  r0.xyz = __Lut_Params.www * r1.zxy;
  r0.xyz = float3(5.55555582, 5.55555582, 5.55555582) * r0.xyz;
  r0.xyz = float3(0.0479959995, 0.0479959995, 0.0479959995) + r0.xyz;
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(0.0734997839, 0.0734997839, 0.0734997839) * r0.xyz;
  r0.xyz = float3(0.386036009, 0.386036009, 0.386036009) + r0.xyz;
  r0.xyz = max(float3(0, 0, 0), r0.xyz);
  r0.xyz = min(float3(1, 1, 1), r0.xyz);
  r0.yzw = __Lut_Params.zzz * r0.xyz;
  r0.y = floor(r0.y);
  r2.xy = __Lut_Params.xy * float2(0.5, 0.5);
  r0.zw = __Lut_Params.xy * r0.zw;
  r2.yz = r0.wz + r2.yx;
  r0.z = __Lut_Params.y * r0.y;
  r2.x = r0.z + r2.z;
  r2.x = r2.x;
  r2.y = r2.y;
  r0.z = 0;
  r3.xyz = textures2D_1_.SampleLevel(samplers2D_1__s, r2.xy, r0.z).xyz;
  r3.xyz = r3.xyz;
  r3.xyz = r3.xyz;
  r4.x = __Lut_Params.y;
  r4.y = 0;
  r0.zw = r4.xy + r2.xy;
  r0.zw = r0.zw;
  r2.x = 0;
  r2.xyz = textures2D_1_.SampleLevel(samplers2D_1__s, r0.zw, r2.x).xyz;
  r2.xyz = r2.xyz;
  r0.x = __Lut_Params.z * r0.x;
  r0.y = -r0.y;
  r0.x = r0.x + r0.y;
  r0.yzw = -r3.xyz;
  r0.yzw = r0.yzw + r2.xyz;
  r0.xyz = r0.xxx * r0.yzw;
  r0.xyz = r0.xyz + r3.xyz;

  r0.w = cmp(0 < __UserLut_Params.w);
  if (r0.w != 0) {
    r0.xyz = r0.xyz;
    r2.xyz = max(float3(0, 0, 0), r0.xyz);
    r2.xyz = min(float3(1, 1, 1), r2.xyz);
    r3.xyz = float3(12.9200001, 12.9200001, 12.9200001) * r2.xyz;
    r4.xyz = log2(r2.xyz);
    r4.xyz = float3(0.416666657, 0.416666657, 0.416666657) * r4.xyz;
    r4.xyz = exp2(r4.xyz);
    r4.xyz = float3(1.05499995, 1.05499995, 1.05499995) * r4.xyz;
    r4.xyz = float3(-0.0549999997, -0.0549999997, -0.0549999997) + r4.xyz;
    r2.xyz = cmp(float3(0.00313080009, 0.00313080009, 0.00313080009) >= r2.xyz);
    if (r2.x != 0) {
      r4.x = r3.x;
    } else {
      r4.x = r4.x;
    }
    r4.x = r4.x;
    if (r2.y != 0) {
      r4.y = r3.y;
    } else {
      r4.y = r4.y;
    }
    r4.y = r4.y;
    if (r2.z != 0) {
      r4.z = r3.z;
    } else {
      r4.z = r4.z;
    }
    r4.z = r4.z;
    r2.xyz = __UserLut_Params.zzz * r4.zxy;
    r0.w = floor(r2.x);
    r2.xw = __UserLut_Params.xy * float2(0.5, 0.5);
    r2.yz = __UserLut_Params.xy * r2.yz;
    r2.yz = r2.zy + r2.wx;
    r2.w = __UserLut_Params.y * r0.w;
    r2.x = r2.w + r2.z;
    r2.x = r2.x;
    r2.y = r2.y;
    r2.z = 0;
    r3.xyz = textures2D_2_.SampleLevel(samplers2D_2__s, r2.xy, r2.z).xyz;
    r3.xyz = r3.xyz;
    r5.x = __UserLut_Params.y;
    r5.y = 0;
    r2.xy = r5.xy + r2.xy;
    r2.xy = r2.xy;
    r2.z = 0;
    r2.xyz = textures2D_2_.SampleLevel(samplers2D_2__s, r2.xy, r2.z).xyz;
    r2.xyz = r2.xyz;
    r2.w = __UserLut_Params.z * r4.z;
    r0.w = -r0.w;
    r5.xyz = r2.www + r0.www;
    r6.xyz = -r3.xyz;
    r2.xyz = r6.xyz + r2.xyz;
    r5.xyz = r5.xyz;
    r5.xyz = r5.xyz;
    r2.xyz = r5.xyz * r2.xyz;
    r2.xyz = r2.xyz + r3.xyz;
    r3.xyz = -r4.xyz;
    r2.xyz = r3.xyz + r2.xyz;
    r2.xyz = __UserLut_Params.www * r2.xyz;
    r2.xyz = r2.xyz + r4.xyz;
    r3.xyz = float3(0.0773993805, 0.0773993805, 0.0773993805) * r2.xyz;
    r4.xyz = float3(0.0549999997, 0.0549999997, 0.0549999997) + r2.xyz;
    r4.xyz = float3(0.947867334, 0.947867334, 0.947867334) * r4.xyz;
    r5.xyz = -r4.xyz;
    r4.xyz = max(r5.xyz, r4.xyz);
    r4.xyz = log2(r4.xyz);
    r4.xyz = float3(2.4000001, 2.4000001, 2.4000001) * r4.xyz;
    r0.xyz = exp2(r4.xyz);
    r2.xyz = cmp(float3(0.0404499993, 0.0404499993, 0.0404499993) >= r2.xyz);
    if (r2.x != 0) {
      r0.x = r3.x;
    } else {
      r0.x = r0.x;
    }
    r0.x = r0.x;
    if (r2.y != 0) {
      r0.y = r3.y;
    } else {
      r0.y = r0.y;
    }
    r0.y = r0.y;
    if (r2.z != 0) {
      r0.z = r3.z;
    } else {
      r0.z = r0.z;
    }
    r0.z = r0.z;
    r0.x = r0.x;
    r0.y = r0.y;
    r0.z = r0.z;
  } else {
    r0.xyz = r0.xyz;
  }
  r2.xyz = float3(12.9200001, 12.9200001, 12.9200001) * r0.xyz;
  r3.xyz = -r0.xyz;
  r3.xyz = max(r3.xyz, r0.xyz);
  r3.xyz = log2(r3.xyz);
  r3.xyz = float3(0.416666657, 0.416666657, 0.416666657) * r3.xyz;
  r3.xyz = exp2(r3.xyz);
  r3.xyz = float3(1.05499995, 1.05499995, 1.05499995) * r3.xyz;
  r1.xyz = float3(-0.0549999997, -0.0549999997, -0.0549999997) + r3.xyz;
  r0.xyz = cmp(float3(0.00313080009, 0.00313080009, 0.00313080009) >= r0.xyz);
  if (r0.x != 0) {
    r1.x = r2.x;
  } else {
    r1.x = r1.x;
  }
  r1.x = r1.x;
  if (r0.y != 0) {
    r1.y = r2.y;
  } else {
    r1.y = r1.y;
  }
  r1.y = r1.y;
  if (r0.z != 0) {
    r1.z = r2.z;
  } else {
    r1.z = r1.z;
  }

  /*3dmigoto generates some awful code with ANGLE-translated shaders, what is this?
  I should probably fix the other instances of unnecessary assignments too, but lazy.
  (And i think the compiler ignores this?)
  r1.z = r1.z;
  r1.x = r1.x;
  r1.y = r1.y;
  r1.z = r1.z;
  r1.w = r1.w;
  r1.xyzw = r1.xyzw;*/
  r1.xyz = renodx::color::srgb::DecodeSafe(r1.xyz);
  o0.xyz = renodx::draw::RenderIntermediatePass(r1.xyz);
  o0.w = r1.w;
  return;
}
