#include "./shared.h"

sampler BaseTextureSampler : register(s0);
sampler FBTextureSampler : register(s1);
sampler ColorCorrectionVolumeTexture0 : register(s2);

float4 uvTransform : register(c2);  // Transform BaseTexture UVs for use with the FBTexture
float ColorCorrectionDefaultWeight : register(c3);
float4 ColorCorrectionVolumeWeights : register(c4);
float BloomFactor : register(c5);

#define TONEMAP_SCALE_NONE   0
#define TONEMAP_SCALE_LINEAR 1
#define TONEMAP_SCALE_GAMMA  2

#define PIXEL_FOG_TYPE_NONE         -1  // MATERIAL_FOG_NONE is handled by PIXEL_FOG_TYPE_RANGE, this is for explicitly disabling fog in the shader
#define PIXEL_FOG_TYPE_RANGE        0   // range+none packed together in ps2b. Simply none in ps20 (instruction limits)
#define PIXEL_FOG_TYPE_HEIGHT       1
#define PIXEL_FOG_TYPE_RANGE_RADIAL 2

float4 FinalOutput(const float4 vShaderColor, float pixelFogFactor, const int iPIXELFOGTYPE, const int iTONEMAP_SCALE_TYPE, const bool bWriteDepthToDestAlpha = false, const float flProjZ = 1.0f) {
  float4 result;
  if (iTONEMAP_SCALE_TYPE == TONEMAP_SCALE_LINEAR) {
    // result.rgb = vShaderColor.rgb * LINEAR_LIGHT_SCALE;
  } else if (iTONEMAP_SCALE_TYPE == TONEMAP_SCALE_GAMMA) {
    // result.rgb = vShaderColor.rgb * GAMMA_LIGHT_SCALE;
  } else if (iTONEMAP_SCALE_TYPE == TONEMAP_SCALE_NONE) {
    result.rgb = vShaderColor.rgb;
  }

  if (bWriteDepthToDestAlpha)
    result.a = vShaderColor.a;
  // result.a = DepthToDestAlpha(flProjZ);
  else
    result.a = vShaderColor.a;

  // result.rgb = BlendPixelFog(result.rgb, pixelFogFactor, g_LinearFogColor.rgb, iPIXELFOGTYPE);
  result.rgb = renodx::draw::RenderIntermediatePass(result.rgb);
  
  return result;
}

float4 PerformColorCorrection(float4 outColor, float2 fbTexCoord) {
  // NOTE: This code requires the color correction texture to be 32 units to be correct.
  // This code will cause (0,0,0) to be read from 0.5f/32
  // and (1,1,1) to be read from 31.5f/32
  float4 offsetOutColor = outColor * (31.0f / 32.0f) + (0.5f / 32.0f);

  outColor.rgb = outColor.rgb * ColorCorrectionDefaultWeight;
  outColor.rgb += tex3D(ColorCorrectionVolumeTexture0, offsetOutColor.rgb) * ColorCorrectionVolumeWeights.x;

  return outColor;
}

float4 GetBloomColor(float2 bloomUV) {
  return tex2D(BaseTextureSampler, bloomUV);
}

float2 PerformUVTransform(float2 bloomUVs) {
  // NOTE: 'wz' is used since 'zw' is not a valid swizzle for ps20 shaders
  return bloomUVs * uvTransform.wz + uvTransform.xy;
}

struct PS_INPUT {
  float2 baseTexCoord : TEXCOORD0;
};

float4 main(PS_INPUT i) : COLOR {
  float2 fbTexCoord = PerformUVTransform(i.baseTexCoord);
  float3 baseColor = tex2D(FBTextureSampler, fbTexCoord).rgb;

  float4 outColor = float4(baseColor, 1);

  float4 bloomColor = BloomFactor * GetBloomColor(i.baseTexCoord);
  outColor.rgb += bloomColor.rgb;

  float3 untonemapped = outColor.rgb;

  outColor = PerformColorCorrection(outColor, fbTexCoord);
  outColor.rgb = renodx::draw::ToneMapPass(untonemapped, outColor.rgb);
  outColor = FinalOutput(outColor, 0, PIXEL_FOG_TYPE_NONE, TONEMAP_SCALE_NONE);

  return renodx::draw::SwapChainPass(outColor);
}
