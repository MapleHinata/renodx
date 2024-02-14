// LUT + TONEMAPPER

#include "../common/DICE.hlsl"
#include "../common/Open_DRT.hlsl"
#include "../common/aces.hlsl"
#include "../common/color.hlsl"
#include "./cp2077.h"

static const float HEATMAP_COLORS[27] = {
  0.0f, 0.0f, 0.0f,  // Black
  0.0f, 0.0f, 1.0f,  // Blue
  0.0f, 1.0f, 1.0f,  // Cyan
  0.0f, 1.0f, 0.0f,  // Green
  1.0f, 1.0f, 0.0f,  // Yellow
  1.0f, 0.0f, 0.0f,  // Red
  1.0f, 0.0f, 1.0f,  // Magenta
  1.0f, 1.0f, 1.0f,  // White
  1.0f, 1.0f, 1.0f   // White
};

static const float SQRT_HALF = sqrt(0.5f);

// 32x32bit
struct SColorGrading {
  float4 const00;  // _20_m0[0u].xyzw
  float4 const01;  // _20_m0[1u].xyzw
  float4 const02;  // _20_m0[2u].xyzw
  float3 const03;  // _20_m0[3u].xyz
  float const04;   // _20_m0[3u].w
  float3 const05;  // _20_m0[4u].xyz
  float const06;   // _20_m0[4u].w
  float3 const07;  // _20_m0[5u].xyz
  float const08;   // _20_m0[5u].w
  float3 const09;  // _20_m0[6u].xyz
  float const10;   // _20_m0[6u].w
  float const11;   // _20_m0[7u].x
  float const12;   // _20_m0[7u].y
  float const13;   // _20_m0[7u].z
  float const14;   // _20_m0[7u].w
};

// 82x32bit
struct STonemappingACES {
  float4 const00
    [10];  // _20_m0[8u].xyzw  _20_m0[9u].xyzw _20_m0[10u].xyzw _20_m0[11u].xyzw _20_m0[12u].xyzw _20_m0[13u].xyzw _20_m0[14u].xyzw _20_m0[15u].xyzw _20_m0[16u].xyzw _20_m0[17u].xyzw
  float2 const01;  // _20_m0[18u].xy
  float2 const02;  // _20_m0[18u].zw
  float2 const03;  // _20_m0[19u].xy
  float2 const04;  // _20_m0[19u].zw
  float2 const05;  // _20_m0[20u].xy
  float2 const06;  // _20_m0[20u].zw
  float3 const07
    [3];  // _20_m0[21u].xyz (_20_m0[21u].w _20_m0[22u].xy) (_20_m0[22u].zw _20_m0[23u].x)
  float3 const08
    [3];  // _20_m0[23u].yzw (_20_m0[24u].x _20_m0[24u].yz) (_20_m0[24u].w  _20_m0[25u].xy)
  float2 const09;  // _20_m0[25u].zw
  float const10;   // _20_m0[26u].x
  float const11;   // _20_m0[26u].y
  float const12;   // _20_m0[26u].z
  float const13;   // _20_m0[26u].w
  float const14;   // _20_m0[27u].x
  float const15;   // _20_m0[27u].y
  float const16;   // _20_m0[27u].z
  float3 const17;  // (_20_m0[27u].w + _20_m0[28u].xy)
};

// 12x32bit
struct LottesTonemapperParams {
  float const00;   // _20_m0[28u].z
  float const01;   // _20_m0[28u].w
  float const02;   // _20_m0[29u].x
  float const03;   // _20_m0[29u].y
  float3 const04;  // (_20_m0[29u].zw _20_m0[30u].x)
  float const05;   // _20_m0[30u].y
  float3 const06;  // _20_m0[30u].y
  float const07;
};

// 4x32bit
struct InputLutSettings {
  float inputScale;
  float inputFloor;
  float outputScale;
  uint lutType;
};

// 32 + 82 + 12 + (8*4) + 7
struct COM {
  SColorGrading sColorGrading;
  STonemappingACES sTonemappingACES;
  LottesTonemapperParams lottesTonemapperParams;
  InputLutSettings inputLutSettings[8];
  int const00;
  int const01;
  float const02;
  float const03;
  int const04;
  int const05;
  float const06;
};

struct UnknownType {
  float4 const00;
  float4 const01;
  float4 const02;
  float4 const03;
  float4 const04;
  float4 const05;
  float4 const06;
  float4 const07;
  float4 const08;
  float4 const09;
  float4 const10;
  float4 const11;
  float4 const12;
  float4 const13;
  float4 const14;
  float4 const15;
  float4 const16;
  float4 const17;
  float4 const18;
  float4 const19;
  float4 const20;
  float4 const21;
  float4 const22;
  float4 const23;
  float4 const24;
  float4 const25;
  float4 const26;
  float4 const27;
  float4 const28;
  float4 const29;
  float4 const30;
  float4 const31;
  float4 const32;
  // float4 const33;
  float const33x;  // _20_m0[33u].x 0.77226562
  float
    const33y;  // _20_m0[33u].y 0.01245117 (100) 0.00622558 (200) 0.00498046 (250) 0.004150039 (300) 0.00311279 (400)  0.00249023 (500)
  float4 const34;
  float4 const35;
  float4 const36;
  float4 const37;
  float4 const38;
  float4 const39;
  float4 const40;
  // float4 const41;
  uint textureCount;
  uint const41y;
  uint const41z;
  uint const41w;
  float4 const42;
};

cbuffer _18_20 : register(b6, space0) {
  float4 _20_m0[43] : packoffset(c0);
};

cbuffer injectedBuffer : register(b14, space0) {
  ShaderInjectData injectedData : packoffset(c0);
};

Texture3D<float4> LUT_TEXTURES[8] : register(t0, space0);
RWTexture3D<float4> OUTPUT_TEXTURE : register(u0, space0);
SamplerState SAMPLER : register(s0, space0);

static uint3 gl_GlobalInvocationID;
struct SPIRV_Cross_Input {
  uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
};

float3 sampleLUT(float4 lutSettings, const float3 inputColor,
                 uint textureIndex) {
  float3 color = inputColor;
  if (lutSettings.x > 0.0f) {           // LUT Strength
    uint _503 = asuint(lutSettings.w);  // lut Type
    uint _504 = _503 & 15u;

    float scale = 1.f;

    if (_504 < 2u) {
      // Gamut Compression?
      float maxChannel = max(max(max(color.r, color.g), color.b),
                             9.9999999747524270787835121154785e-07f);
      scale = ((abs(1.0f - maxChannel) < 0.52499997615814208984375f)
                 ? ((((5.809524059295654296875f -
                       (maxChannel * 1.9047620296478271484375f)) *
                      maxChannel) +
                     (-0.42976200580596923828125f)) *
                    0.25f)
                 : clamp(maxChannel, 0.0f, 1.0f)) /
              maxChannel;
      color *= scale;
    }

    if (_504 == 2u) {
      color = arriC800FromLinear(color);
    } else if (_504 == 1u) {
      color = srgbFromLinear(color);
    }

    if (injectedData.colorGradingScaling) {
      color *= lutSettings.x;  // input scale
      color += lutSettings.y;  // input floor
    }

    color = LUT_TEXTURES[textureIndex].SampleLevel(SAMPLER, color, 0.0f).rgb;

    if ((_503 & 240u) == 16u) {
      color = linearFromSRGB(color);
    }

    color /= scale;
  }
  if (injectedData.colorGradingScaling) {
    color *= lutSettings.z;  // output scale
  }
  return color;
}

float3 sampleAllLUTs(const float3 color) {
  uint textureCount = asuint(_20_m0[41u]).x;

  float3 compositedColor;

  if (injectedData.colorGradingStrength) {  // 0 speed-hack
    compositedColor = lerp(color, sampleLUT(_20_m0[33u], color, 0u),
                           injectedData.colorGradingStrength);
  } else {
    compositedColor = color;
  }

  // This was probably a for loop (0-7)
  if (textureCount > 1u) {
    compositedColor += sampleLUT(_20_m0[34u], color, 1u);
  }
  if (textureCount > 2u) {
    compositedColor += sampleLUT(_20_m0[35u], color, 2u);
  }
  if (textureCount > 3u) {
    compositedColor += sampleLUT(_20_m0[36u], color, 3u);
  }
  if (textureCount > 4u) {
    compositedColor += sampleLUT(_20_m0[37u], color, 4u);
  }
  if (textureCount > 5u) {
    compositedColor += sampleLUT(_20_m0[38u], color, 5u);
  }
  if (textureCount > 6u) {
    compositedColor += sampleLUT(_20_m0[39u], color, 6u);
  }
  if (textureCount > 7u) {
    compositedColor += sampleLUT(_20_m0[40u], color, 7u);
  }

  return compositedColor;
}

// [41u].w = 0.59960937f
// _20_m0[41u].z = 0.06020507f
// _73 = 47.f;
// _20_m0[41u].y
// 69.y (gameplay 48) / (photo mode 24)

float3 applyGamma(float3 input, uint type) {
  if (type == 2u)
    return arriC800FromLinear(input);
  if (type == 1u)
    return srgbFromLinear(input);
  return input;
}

float4 tonemap() {
  uint4 _69 = asuint(_20_m0[41u]);
  float _73 = float(_69.y + 4294967295u);

  float _88 = exp2(((float(gl_GlobalInvocationID.x) / _73) - _20_m0[41u].w) /
                   _20_m0[41u].z);
  float _89 = exp2(((float(gl_GlobalInvocationID.y) / _73) - _20_m0[41u].w) /
                   _20_m0[41u].z);
  float _90 = exp2(((float(gl_GlobalInvocationID.z) / _73) - _20_m0[41u].w) /
                   _20_m0[41u].z);

  const float3 inputColor = float3(_88, _89, _90);

  float3 color = inputColor;
  float exposureMin = _20_m0[5u].w;
  float exposureMax = _20_m0[6u].w;

  float _99 = 1.0f - _20_m0[6u].w;

  float _118 = _88 - exposureMin;
  float _119 = _89 - exposureMin;
  float _120 = _90 - exposureMin;
  float _136 = _88 - exposureMax;

  float _137 = _89 - exposureMax;
  float _138 = _90 - exposureMax;

  float _194 =
    ((((_118 * (_20_m0[5u].x + 1.0f)) + exposureMin) *
      float((_88 >= exposureMin) && (_88 <= exposureMax))) +
     ((float(_88 < exposureMin) * exposureMin) *
      (((1.0f - _20_m0[4u].x) * (_88 / exposureMin)) + _20_m0[4u].x))) +
    (((_136 * (_20_m0[6u].x + 1.0f)) + exposureMax) * float(_88 > exposureMax));
  float _195 =
    ((((_119 * (_20_m0[5u].y + 1.0f)) + exposureMin) *
      float((_89 >= exposureMin) && (_89 <= exposureMax))) +
     ((float(_89 < exposureMin) * exposureMin) *
      (((1.0f - _20_m0[4u].y) * (_89 / exposureMin)) + _20_m0[4u].y))) +
    (((_137 * (_20_m0[6u].y + 1.0f)) + exposureMax) * float(_89 > exposureMax));
  float _196 =
    ((((_120 * (_20_m0[5u].z + 1.0f)) + exposureMin) *
      float((_90 >= exposureMin) && (_90 <= exposureMax))) +
     ((float(_90 < exposureMin) * exposureMin) *
      (((1.0f - _20_m0[4u].z) * (_90 / exposureMin)) + _20_m0[4u].z))) +
    (((_138 * (_20_m0[6u].z + 1.0f)) + exposureMax) * float(_90 > exposureMax));

  color = float3(_194, _195, _196);
  float3 gradingMix = _20_m0[0u].rgb;
  float3 gradingPow = _20_m0[1u].rgb;
  float3 gradingMult = _20_m0[2u].rgb;
  float3 gradingGain = _20_m0[3u].rgb;
  float colorExtra = _20_m0[4u].w;
  float colorScaling = _20_m0[7u].x;

  color = (1.0f - color) * gradingMix + color;
  color *= gradingMult;
  color += gradingGain;
  color = pow(max(color, 0), gradingPow);
  color -= colorExtra;    // Could cause negative values
  color *= colorScaling;  // Could amplify negative values
  color += colorExtra;

  float _256 = color.r;
  float _257 = color.g;
  float _258 = color.b;

  float _260 = sin(_20_m0[7u].z);
  float _261 = cos(_20_m0[7u].z);
  float _262 = (-0.0f) - _260;
  float _264 = _260 * 0.8164966106414794921875f;
  float _266 = _261 * (-0.40824830532073974609375f);
  float _268 = mad(SQRT_HALF, _262, _266);
  float _270 = _260 * (-0.40824830532073974609375f);
  float _271 = mad(SQRT_HALF, _261, _270);
  float _272 = mad(-SQRT_HALF, _262, _266);
  float _274 = mad(-SQRT_HALF, _261, _270);
  float _279 = mad(0.5352036952972412109375f, 0.57735002040863037109375f,
                   mad(_264, -0.3726499974727630615234375f,
                       _261 * 0.69100105762481689453125f));
  float _282 = _261 * (-0.3089949786663055419921875f);
  float _286 = mad(0.5352036952972412109375f, 0.57735002040863037109375f,
                   mad(_264, 0.3344599902629852294921875f, _282));
  float _289 = mad(0.5352036952972412109375f, 0.57735002040863037109375f,
                   mad(_264, -1.07974994182586669921875f, _282));
  float _293 = mad(1.05481898784637451171875f, 0.57735002040863037109375f,
                   mad(_271, -0.3726499974727630615234375f,
                       _268 * 0.84630000591278076171875f));
  float _295 = _268 * (-0.3784399926662445068359375f);
  float _298 = mad(1.05481898784637451171875f, 0.57735002040863037109375f,
                   mad(_271, 0.3344599902629852294921875f, _295));
  float _300 = mad(1.05481898784637451171875f, 0.57735002040863037109375f,
                   mad(_271, -1.07974994182586669921875f, _295));
  float _303 = mad(0.1420280933380126953125f, 0.57735002040863037109375f,
                   mad(_274, -0.3726499974727630615234375f,
                       _272 * 0.84630000591278076171875f));
  float _305 = _272 * (-0.3784399926662445068359375f);
  float _307 = mad(0.1420280933380126953125f, 0.57735002040863037109375f,
                   mad(_274, 0.3344599902629852294921875f, _305));
  float _309 = mad(0.1420280933380126953125f, 0.57735002040863037109375f,
                   mad(_274, -1.07974994182586669921875f, _305));

  float bt601Strength = _20_m0[7u].y;  // 0.995483
  float inverseBt601Strength = 1.0f - bt601Strength;

  float _311 = 1.0f - _20_m0[7u].y;

  float _312 = _311 * 0.2989999949932098388671875f;
  float _314 = _312 + _20_m0[7u].y;

  float _315 = _311 * 0.58700001239776611328125f;
  float _317 = _315 + _20_m0[7u].y;

  float _318 = _311 * 0.114000000059604644775390625f;
  float _320 = _318 + _20_m0[7u].y;

  float _324 = _312 * _279;
  float _332 = _312 * _293;
  float _340 = _312 * _303;

  float _355 = _20_m0[3u].w +
               mad(_258, mad(_309, _318, mad(_307, _315, _314 * _303)),
                   mad(_257, mad(_300, _318, mad(_298, _315, _314 * _293)),
                       mad(_289, _318, mad(_286, _315, _314 * _279)) * _256));
  float _356 =
    _20_m0[3u].w + mad(_258, mad(_309, _318, mad(_307, _317, _340)),
                       mad(_257, mad(_300, _318, mad(_298, _317, _332)),
                           mad(_289, _318, mad(_286, _317, _324)) * _256));
  float _357 =
    _20_m0[3u].w + mad(_258, mad(_309, _320, mad(_307, _315, _340)),
                       mad(_257, mad(_300, _320, mad(_298, _315, _332)),
                           mad(_289, _320, mad(_286, _315, _324)) * _256));

  float3 outputRGB = float3(_355, _356, _357);

  if ((injectedData.colorGradingWorkflow == -1.f ||
       asuint(_20_m0[42u]).y == 1u) &&
      (_69.x != 0u)) {
    outputRGB = sampleAllLUTs(outputRGB);
  }

  const float toneMapperMidpoint = _20_m0[42u].z;

  float yMax = _20_m0[27u].y;  // User peak Nits
  float yMin = _20_m0[27u].x;  // 0.005

  outputRGB *= toneMapperMidpoint;  // Exposure

  outputRGB *= injectedData.toneMapperExposure;

  float3 odtFinal = outputRGB;
  float toneMapperType = injectedData.toneMapperType;
  if (toneMapperType == TONE_MAPPER_TYPE__NONE) {
    // noop
  } else if (toneMapperType == TONE_MAPPER_TYPE__VANILLA) {

    // BT709 to AP0 (TODO: flatten matrix)
    float3 outputXYZ = mul(BT709_To_XYZ, outputRGB);
    float3 outputXYZD60 = mul(D65_2_D60_CAT, outputXYZ);
    float3 aces = mul(XYZ_2_AP0_MAT, outputXYZD60);

    float3 rgbPost = aces_rrt_ap0(aces);

    // --- RGB rendering space to OCES --- //
    // CDPR converted AP1 to AP0 and back

    // _20_m0[18u].x 0.000085
    // _20_m0[18u].y 0.004944
    // _20_m0[18u].z 2.387695
    // _20_m0[18u].w 9.956054
    // _20_m0[19u].x 1092.500
    // _20_m0[19u].y 298.7500
    // _20_m0[19u].z 0.000000
    // _20_m0[19u].w 0.059738

    // Scales with paperwhite, which can be reversed

    const SegmentedSplineParams_c9 ODT_CONFIG = {
      // coefsLow[10]
      {_20_m0[8u].x, _20_m0[9u].x, _20_m0[10u].x, _20_m0[11u].x, _20_m0[12u].x,
       _20_m0[13u].x, _20_m0[14u].x, _20_m0[15u].x, _20_m0[16u].x,
       _20_m0[17u].x},
      // coefsHigh[10]
      {_20_m0[8u].y, _20_m0[9u].y, _20_m0[10u].y, _20_m0[11u].y, _20_m0[12u].y,
       _20_m0[13u].y, _20_m0[14u].y, _20_m0[15u].y, _20_m0[16u].y,
       _20_m0[17u].y},
      {_20_m0[18u].x, _20_m0[18u].y},  // minPoint
      {_20_m0[18u].z, _20_m0[18u].w},  // midPoint
      {_20_m0[19u].x, _20_m0[19u].y},  // maxPoint
      _20_m0[19u].z,                   // slopeLow
      _20_m0[19u].w                    // slopeHigh
    };

    float yRange = yMax - yMin;

    float3 toneMappedColor =
      float3(segmented_spline_c9_fwd(rgbPost.r, ODT_CONFIG),
             segmented_spline_c9_fwd(rgbPost.g, ODT_CONFIG),
             segmented_spline_c9_fwd(rgbPost.b, ODT_CONFIG));

    // Tone map by luminance
    if (_20_m0[28u].w != 0.0f) {
      float ap1Y = dot(rgbPost, AP1_RGB2Y);
      float toneMappedByLuminance = segmented_spline_c9_fwd(ap1Y, ODT_CONFIG);
      float scaleFactor = toneMappedByLuminance / ap1Y;
      float3 scaledAndToneMapped = (rgbPost * scaleFactor);
      toneMappedColor =
        (_20_m0[29u].x * (scaledAndToneMapped - toneMappedColor)) +
        toneMappedColor;
    }

    toneMappedColor = max(toneMappedColor, yMin);

    float3 linearCV = Y_2_linCV(toneMappedColor, yMax, yMin);

    // dimSurround
    if (_20_m0[28u].y != 0.0f) {
      float3 odtXYZ = mul(AP1_2_XYZ_MAT, linearCV);
      odtXYZ = darkToDim(odtXYZ, _20_m0[27u].w);
      linearCV = mul(XYZ_2_AP1_MAT, odtXYZ);
    }

    // Apply desaturation to compensate for luminance difference
    if (_20_m0[28u].x != 0.0f) {
      linearCV = mul(ODT_SAT_MAT, linearCV);
    }

    float3 odtXYZ = mul(AP1_2_XYZ_MAT, linearCV);

    if (_20_m0[28u].z != 0.0f) {
      odtXYZ = mul(D60_2_D65_CAT, odtXYZ);
    }

    // Custom Matrix D60_2_D65?

    float3x3 customMatrix0 = float3x3(
      _20_m0[21u].x, _20_m0[21u].y, _20_m0[21u].z, _20_m0[22u].x, _20_m0[22u].y,
      _20_m0[22u].z, _20_m0[23u].x, _20_m0[23u].y, _20_m0[23u].z);
    float3 odtUnknown =
      float3(mad(_20_m0[21u].z, odtXYZ.z,
                 mad(_20_m0[21u].y, odtXYZ.y, _20_m0[21u].x * odtXYZ.x)),
             mad(_20_m0[22u].z, odtXYZ.z,
                 mad(_20_m0[22u].y, odtXYZ.y, _20_m0[22u].x * odtXYZ.x)),
             mad(_20_m0[23u].z, odtXYZ.z,
                 mad(_20_m0[23u].y, odtXYZ.y, _20_m0[23u].x * odtXYZ.x)));

    // odtUnknown = mul(customMatrix0, odtXYZ);

    if (_20_m0[27u].z == 0.0f || _20_m0[27u].z == 1.f) {
      odtUnknown = saturate(odtUnknown);
    } else if (_20_m0[27u].z == 2.0f) {

      odtUnknown = max((yRange * odtUnknown) + yMin, 0);
      odtUnknown = float3(
        mad(_20_m0[24u].z, odtUnknown.z,
            mad(_20_m0[24u].y, odtUnknown.y, _20_m0[24u].x * odtUnknown.x)),
        mad(_20_m0[25u].z, odtUnknown.z,
            mad(_20_m0[25u].y, odtUnknown.y, _20_m0[25u].x * odtUnknown.x)),
        mad(_20_m0[26u].z, odtUnknown.z,
            mad(_20_m0[26u].y, odtUnknown.y, _20_m0[26u].x * odtUnknown.x)));
      float scale = 1.0f / min(80.0f, yMax);
      odtUnknown = mul(XYZ_2_REC709_MAT, odtUnknown);
      odtUnknown *= scale;
    } else if (_20_m0[27u].z == 3.0f) {
      odtUnknown = max((yRange * odtUnknown) + yMin, 0);
      odtUnknown = float3(
        mad(_20_m0[24u].z, odtUnknown.z,
            mad(_20_m0[24u].y, odtUnknown.y, _20_m0[24u].x * odtUnknown.x)),
        mad(_20_m0[25u].z, odtUnknown.z,
            mad(_20_m0[25u].y, odtUnknown.y, _20_m0[25u].x * odtUnknown.x)),
        mad(_20_m0[26u].z, odtUnknown.z,
            mad(_20_m0[26u].y, odtUnknown.y, _20_m0[26u].x * odtUnknown.x)));
      float scale = 1.0f / min(80.0f, yMax);
      odtUnknown = mul(XYZ_2_REC2020_MAT, odtUnknown);
    } else if (_20_m0[27u].z == 4.0f) {

      odtUnknown = max(odtUnknown, 0.f);
      float scale = max(yMax, 80.0f) * 0.001000000047497451305389404296875f;
      odtUnknown = float3(
        mad(_20_m0[24u].z, odtUnknown.z,
            mad(_20_m0[24u].y, odtUnknown.y, _20_m0[24u].x * odtUnknown.x)),
        mad(_20_m0[25u].z, odtUnknown.z,
            mad(_20_m0[25u].y, odtUnknown.y, _20_m0[25u].x * odtUnknown.x)),
        mad(_20_m0[26u].z, odtUnknown.z,
            mad(_20_m0[26u].y, odtUnknown.y, _20_m0[26u].x * odtUnknown.x)));
      odtUnknown *= scale;
      odtUnknown = saturate(odtUnknown);
      odtUnknown = pow(odtUnknown, 0.1593017578125f);
      odtUnknown = ((odtUnknown * 18.8515625f) + 0.8359375f) /
                   ((odtUnknown * 18.6875f) + 1.0f);
      odtUnknown = pow(odtUnknown, 78.84375f);
      odtUnknown = saturate(odtUnknown);
    } else {
      // Heatmap?
      float maxScaledChannel = max(
        (yRange * odtUnknown.r) + yMin,
        max((yRange * odtUnknown.g) + yMin, (yRange * odtUnknown.b) + yMin));
      float _3335 =
        max(min((log2(maxScaledChannel) * 0.5f) + 2.0f, 7.0f), 0.0f);
      uint _3336 = uint(int(_3335));
      float _3338 = _3335 - float(int(_3336));
      uint _3339 = _3336 + 1u;
      uint _3353 = 0u + (_3336 * 3u);
      uint _3357 = 1u + (_3336 * 3u);
      uint _3361 = 2u + (_3336 * 3u);
      odtUnknown = float3(
        ((HEATMAP_COLORS[0u + (_3339 * 3u)] - HEATMAP_COLORS[_3353]) * _3338) +
          HEATMAP_COLORS[_3353],
        ((HEATMAP_COLORS[1u + (_3339 * 3u)] - HEATMAP_COLORS[_3357]) * _3338) +
          HEATMAP_COLORS[_3357],
        ((HEATMAP_COLORS[2u + (_3339 * 3u)] - HEATMAP_COLORS[_3361]) * _3338) +
          HEATMAP_COLORS[_3361]);
    }

    odtFinal = odtUnknown;
  } else if (toneMapperType == TONE_MAPPER_TYPE__OPENDRT) {
    float peakNits = yMax;
    const float REFERENCE_WHITE = 203.f;
    const float CDPR_WHITE = 100.f;
    odtFinal =
      open_drt_transform_custom(
        outputRGB, yMax, injectedData.toneMapperPaperWhite / REFERENCE_WHITE,
        injectedData.toneMapperContrast, injectedData.toneMapperHighlights,
        injectedData.toneMapperShadows) *
      yMax / REFERENCE_WHITE;
    float paperwhiteScaler = REFERENCE_WHITE / CDPR_WHITE;
    odtFinal *= paperwhiteScaler;
  } else if (toneMapperType == TONE_MAPPER_TYPE__DICE) {
    odtFinal = DICETonemap(outputRGB, yMax / 100.f);
  } else if (toneMapperType == TONE_MAPPER_TYPE__ACES) {
    float peakNits = yMax;
    const float REFERENCE_WHITE = 203.f;
    const float CDPR_WHITE = 100.f;
    float whiteNits = injectedData.toneMapperPaperWhite;
    float acesMax = 108.f * (peakNits / whiteNits);
    // Should match 203 peak (and look like SDR)
    // 1 = 1e-4
    float yMin =
      pow(10.f, lerp(-8.f, 0.f, injectedData.toneMapperShadows * 0.5f));
    odtFinal =
      aces_rrt_odt(outputRGB, yMin, acesMax) * peakNits / REFERENCE_WHITE;

    float paperwhiteScaler = REFERENCE_WHITE / CDPR_WHITE;
    odtFinal *= paperwhiteScaler;
  }

  if (injectedData.colorGradingWorkflow == 1.f || asuint(_20_m0[42u]).y == 0u) {
    uint textureCount = asuint(_20_m0[41u]).x;
    if (textureCount != 0u) {
      odtFinal = sampleAllLUTs(odtFinal);
    }
  }

  return float4(odtFinal.rgb, 0.f);
}