#include "./common.hlsl"

struct FViewConstants {
  float4 TranslatedWorldToClip[4];
  float4 RelativeWorldToClip[4];
  float4 ClipToRelativeWorld[4];
  float4 TranslatedWorldToView[4];
  float4 ViewToTranslatedWorld[4];
  float4 TranslatedWorldToCameraView[4];
  float4 CameraViewToTranslatedWorld[4];
  float4 ViewToClip[4];
  float4 ViewToClipNoAA[4];
  float4 ClipToView[4];
  float4 ClipToTranslatedWorld[4];
  float4 SVPositionToTranslatedWorld[4];
  float4 ScreenToRelativeWorld[4];
  float4 ScreenToTranslatedWorld[4];
  float4 MobileMultiviewShadowTransform[4];
  float3 ViewOriginHigh;
  float Padding972;
  float3 ViewForward;
  float Padding988;
  float3 ViewUp;
  float Padding1004;
  float3 ViewRight;
  float Padding1020;
  float3 HMDViewNoRollUp;
  float Padding1036;
  float3 HMDViewNoRollRight;
  float Padding1052;
  float4 InvDeviceZToWorldZTransform;
  float4 ScreenPositionScaleBias;
  float3 ViewOriginLow;
  float Padding1100;
  float3 TranslatedWorldCameraOrigin;
  float Padding1116;
  float3 WorldViewOriginHigh;
  float Padding1132;
  float3 WorldViewOriginLow;
  float Padding1148;
  float3 PreViewTranslationHigh;
  float Padding1164;
  float3 PreViewTranslationLow;
  float Padding1180;
  float4 PrevViewToClip[4];
  float4 PrevClipToView[4];
  float4 PrevTranslatedWorldToClip[4];
  float4 PrevTranslatedWorldToView[4];
  float4 PrevViewToTranslatedWorld[4];
  float4 PrevTranslatedWorldToCameraView[4];
  float4 PrevCameraViewToTranslatedWorld[4];
  float3 PrevTranslatedWorldCameraOrigin;
  float Padding1644;
  float3 PrevWorldCameraOriginHigh;
  float Padding1660;
  float3 PrevWorldCameraOriginLow;
  float Padding1676;
  float3 PrevWorldViewOriginHigh;
  float Padding1692;
  float3 PrevWorldViewOriginLow;
  float Padding1708;
  float3 PrevPreViewTranslationHigh;
  float Padding1724;
  float3 PrevPreViewTranslationLow;
  float Padding1740;
  float3 ViewTilePosition;
  float Padding1756;
  float3 RelativeWorldCameraOriginTO;
  float Padding1772;
  float3 RelativeWorldViewOriginTO;
  float Padding1788;
  float3 RelativePreViewTranslationTO;
  float Padding1804;
  float3 PrevRelativeWorldCameraOriginTO;
  float Padding1820;
  float3 PrevRelativeWorldViewOriginTO;
  float Padding1836;
  float3 RelativePrevPreViewTranslationTO;
  float Padding1852;
  float4 PrevClipToRelativeWorld[4];
  float4 PrevScreenToTranslatedWorld[4];
  float4 ClipToPrevClip[4];
  float4 ClipToPrevClipWithAA[4];
  float4 TemporalAAJitter;
  float4 GlobalClippingPlane;
  float2 FieldOfViewWideAngles;
  float2 PrevFieldOfViewWideAngles;
  float4 ViewRectMin;
  float4 ViewSizeAndInvSize;
  uint4 ViewRectMinAndSize;
  float4 LightProbeSizeRatioAndInvSizeRatio;
  float4 BufferSizeAndInvSize;
  float4 BufferBilinearUVMinMax;
  float4 ScreenToViewSpace;
  float2 BufferToSceneTextureScale;
  float2 ResolutionFractionAndInv;
  int NumSceneColorMSAASamples;
  float ProjectionDepthThicknessScale;
  float PreExposure;
  float OneOverPreExposure;
  float4 DiffuseOverrideParameter;
  float4 SpecularOverrideParameter;
  float4 NormalOverrideParameter;
  float2 RoughnessOverrideParameter;
  float PrevFrameGameTime;
  float PrevFrameRealTime;
  float OutOfBoundsMask;
  float Padding2372;
  float Padding2376;
  float Padding2380;
  float3 WorldCameraMovementSinceLastFrame;
  float CullingSign;
  float NearPlane;
  float GameTime;
  float RealTime;
  float DeltaTime;
  float MaterialTextureMipBias;
  float MaterialTextureDerivativeMultiply;
  uint Random;
  uint FrameNumber;
  uint FrameCounter;
  uint StateFrameIndexMod8;
  uint StateFrameIndex;
  uint DebugViewModeMask;
  uint WorldIsPaused;
  float CameraCut;
  float UnlitViewmodeMask;
  float Padding2460;
  float4 DirectionalLightColor;
  float3 DirectionalLightDirection;
  float Padding2492;
  float4 TranslucencyLightingVolumeMin[2];
  float4 TranslucencyLightingVolumeInvSize[2];
  float4 TemporalAAParams;
  float4 CircleDOFParams;
  float DepthOfFieldSensorWidth;
  float DepthOfFieldFocalDistance;
  float DepthOfFieldScale;
  float DepthOfFieldFocalLength;
  float DepthOfFieldFocalRegion;
  float DepthOfFieldNearTransitionRegion;
  float DepthOfFieldFarTransitionRegion;
  float MotionBlurNormalizedToPixel;
  float GeneralPurposeTweak;
  float GeneralPurposeTweak2;
  float DemosaicVposOffset;
  float DecalDepthBias;
  float3 IndirectLightingColorScale;
  float Padding2652;
  float3 PrecomputedIndirectLightingColorScale;
  float Padding2668;
  float3 PrecomputedIndirectSpecularColorScale;
  float Padding2684;
  float4 AtmosphereLightDirection[2];
  float4 AtmosphereLightIlluminanceOnGroundPostTransmittance[2];
  float4 AtmosphereLightIlluminanceOuterSpace[2];
  float4 AtmosphereLightDiscLuminance[2];
  float4 AtmosphereLightDiscCosHalfApexAngle_PPTrans[2];
  float4 SkyViewLutSizeAndInvSize;
  float3 SkyCameraTranslatedWorldOrigin;
  float Padding2876;
  float4 SkyPlanetTranslatedWorldCenterAndViewHeight;
  float4 SkyViewLutReferential[4];
  float4 SkyAtmosphereSkyLuminanceFactor;
  float SkyAtmospherePresentInScene;
  float SkyAtmosphereHeightFogContribution;
  float SkyAtmosphereBottomRadiusKm;
  float SkyAtmosphereTopRadiusKm;
  float4 SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
  float SkyAtmosphereAerialPerspectiveStartDepthKm;
  float SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
  float SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
  float SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKm;
  float SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
  float SkyAtmosphereApplyCameraAerialPerspectiveVolume;
  float Padding3032;
  float Padding3036;
  float3 NormalCurvatureToRoughnessScaleBias;
  float RenderingReflectionCaptureMask;
  float RealTimeReflectionCapture;
  float RealTimeReflectionCapturePreExposure;
  float Padding3064;
  float Padding3068;
  float4 AmbientCubemapTint;
  float AmbientCubemapIntensity;
  float SkyLightApplyPrecomputedBentNormalShadowingFlag;
  float SkyLightAffectReflectionFlag;
  float SkyLightAffectGlobalIlluminationFlag;
  float4 SkyLightColor;
  float SkyLightVolumetricScatteringIntensity;
  float Padding3124;
  float Padding3128;
  float Padding3132;
  float4 MobileSkyIrradianceEnvironmentMap[8];
  float MobilePreviewMode;
  float HMDEyePaddingOffset;
  float ReflectionCubemapMaxMip;
  float ShowDecalsMask;
  uint DistanceFieldAOSpecularOcclusionMode;
  float IndirectCapsuleSelfShadowingIntensity;
  float Padding3288;
  float Padding3292;
  float3 ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
  int StereoPassIndex;
  float4 GlobalVolumeTranslatedCenterAndExtent[6];
  float4 GlobalVolumeTranslatedWorldToUVAddAndMul[6];
  float4 GlobalDistanceFieldMipTranslatedWorldToUVScale[6];
  float4 GlobalDistanceFieldMipTranslatedWorldToUVBias[6];
  float GlobalDistanceFieldMipFactor;
  float GlobalDistanceFieldMipTransition;
  int GlobalDistanceFieldClipmapSizeInPages;
  int Padding3708;
  float3 GlobalDistanceFieldInvPageAtlasSize;
  float Padding3724;
  float3 GlobalDistanceFieldInvCoverageAtlasSize;
  float GlobalVolumeDimension;
  float GlobalVolumeTexelSize;
  float MaxGlobalDFAOConeDistance;
  uint NumGlobalSDFClipmaps;
  float CoveredExpandSurfaceScale;
  float NotCoveredExpandSurfaceScale;
  float NotCoveredMinStepScale;
  float DitheredTransparencyStepThreshold;
  float DitheredTransparencyTraceThreshold;
  int2 CursorPosition;
  float bCheckerboardSubsurfaceProfileRendering;
  float Padding3788;
  float3 VolumetricFogInvGridSize;
  float Padding3804;
  float3 VolumetricFogGridZParams;
  float Padding3820;
  float2 VolumetricFogSVPosToVolumeUV;
  float2 VolumetricFogViewGridUVToPrevViewRectUV;
  float2 VolumetricFogPrevViewGridRectUVToResourceUV;
  float2 VolumetricFogPrevUVMax;
  float2 VolumetricFogPrevUVMaxForTemporalBlend;
  float2 VolumetricFogScreenToResourceUV;
  float2 VolumetricFogUVMax;
  float VolumetricFogMaxDistance;
  float Padding3884;
  float3 VolumetricLightmapWorldToUVScale;
  float Padding3900;
  float3 VolumetricLightmapWorldToUVAdd;
  float Padding3916;
  float3 VolumetricLightmapIndirectionTextureSize;
  float VolumetricLightmapBrickSize;
  float3 VolumetricLightmapBrickTexelSize;
  float IndirectLightingCacheShowFlag;
  float EyeToPixelSpreadAngle;
  float Padding3956;
  float Padding3960;
  float Padding3964;
  float4 XRPassthroughCameraUVs[2];
  float GlobalVirtualTextureMipBias;
  uint VirtualTextureFeedbackShift;
  uint VirtualTextureFeedbackMask;
  uint VirtualTextureFeedbackStride;
  uint VirtualTextureFeedbackJitterOffset;
  uint VirtualTextureFeedbackSampleOffset;
  uint Padding4024;
  uint Padding4028;
  float4 RuntimeVirtualTextureMipLevel;
  float2 RuntimeVirtualTexturePackHeight;
  float Padding4056;
  float Padding4060;
  float4 RuntimeVirtualTextureDebugParams;
  int FarShadowStaticMeshLODBias;
  float MinRoughness;
  float Padding4088;
  float Padding4092;
  float4 HairRenderInfo;
  uint EnableSkyLight;
  uint HairRenderInfoBits;
  uint HairComponents;
  float bSubsurfacePostprocessEnabled;
  float4 SSProfilesTextureSizeAndInvSize;
  float4 SSProfilesPreIntegratedTextureSizeAndInvSize;
  float4 SpecularProfileTextureSizeAndInvSize;
  float3 PhysicsFieldClipmapCenter;
  float PhysicsFieldClipmapDistance;
  int PhysicsFieldClipmapResolution;
  int PhysicsFieldClipmapExponent;
  int PhysicsFieldClipmapCount;
  int PhysicsFieldTargetCount;
  int4 PhysicsFieldTargets[32];
  uint GPUSceneViewId;
  float ViewResolutionFraction;
  float SubSurfaceColorAsTransmittanceAtDistanceInMeters;
  float Padding4732;
  float4 TanAndInvTanHalfFOV;
  float4 PrevTanAndInvTanHalfFOV;
  float2 WorldDepthToPixelWorldRadius;
  float Padding4776;
  float Padding4780;
  float4 ScreenRayLengthMultiplier;
  float4 GlintLUTParameters0;
  float4 GlintLUTParameters1;
  int4 EnvironmentComponentsFlags;
  uint BindlessSampler_MaterialTextureBilinearWrapedSampler;
  uint Padding4852;
  uint BindlessSampler_MaterialTextureBilinearClampedSampler;
  uint Padding4860;
  uint BindlessSRV_VolumetricLightmapIndirectionTexture;
  uint Padding4868;
  uint BindlessSRV_VolumetricLightmapBrickAmbientVector;
  uint Padding4876;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients0;
  uint Padding4884;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients1;
  uint Padding4892;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients2;
  uint Padding4900;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients3;
  uint Padding4908;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients4;
  uint Padding4916;
  uint BindlessSRV_VolumetricLightmapBrickSHCoefficients5;
  uint Padding4924;
  uint BindlessSRV_SkyBentNormalBrickTexture;
  uint Padding4932;
  uint BindlessSRV_DirectionalLightShadowingBrickTexture;
  uint Padding4940;
  uint BindlessSampler_VolumetricLightmapBrickAmbientVectorSampler;
  uint Padding4948;
  uint BindlessSampler_VolumetricLightmapTextureSampler0;
  uint Padding4956;
  uint BindlessSampler_VolumetricLightmapTextureSampler1;
  uint Padding4964;
  uint BindlessSampler_VolumetricLightmapTextureSampler2;
  uint Padding4972;
  uint BindlessSampler_VolumetricLightmapTextureSampler3;
  uint Padding4980;
  uint BindlessSampler_VolumetricLightmapTextureSampler4;
  uint Padding4988;
  uint BindlessSampler_VolumetricLightmapTextureSampler5;
  uint Padding4996;
  uint BindlessSampler_SkyBentNormalTextureSampler;
  uint Padding5004;
  uint BindlessSampler_DirectionalLightShadowingTextureSampler;
  uint Padding5012;
  uint BindlessSRV_GlobalDistanceFieldPageAtlasTexture;
  uint Padding5020;
  uint BindlessSRV_GlobalDistanceFieldCoverageAtlasTexture;
  uint Padding5028;
  uint BindlessSRV_GlobalDistanceFieldPageTableTexture;
  uint Padding5036;
  uint BindlessSRV_GlobalDistanceFieldMipTexture;
  uint Padding5044;
  uint BindlessSampler_GlobalDistanceFieldPageAtlasTextureSampler;
  uint Padding5052;
  uint BindlessSampler_GlobalDistanceFieldCoverageAtlasTextureSampler;
  uint Padding5060;
  uint BindlessSampler_GlobalDistanceFieldMipTextureSampler;
  uint Padding5068;
  uint BindlessSRV_AtmosphereTransmittanceTexture;
  uint Padding5076;
  uint BindlessSampler_AtmosphereTransmittanceTextureSampler;
  uint Padding5084;
  uint BindlessSRV_AtmosphereIrradianceTexture;
  uint Padding5092;
  uint BindlessSampler_AtmosphereIrradianceTextureSampler;
  uint Padding5100;
  uint BindlessSRV_AtmosphereInscatterTexture;
  uint Padding5108;
  uint BindlessSampler_AtmosphereInscatterTextureSampler;
  uint Padding5116;
  uint BindlessSRV_PerlinNoiseGradientTexture;
  uint Padding5124;
  uint BindlessSampler_PerlinNoiseGradientTextureSampler;
  uint Padding5132;
  uint BindlessSRV_PerlinNoise3DTexture;
  uint Padding5140;
  uint BindlessSampler_PerlinNoise3DTextureSampler;
  uint Padding5148;
  uint BindlessSRV_SobolSamplingTexture;
  uint Padding5156;
  uint BindlessSampler_SharedPointWrappedSampler;
  uint Padding5164;
  uint BindlessSampler_SharedPointClampedSampler;
  uint Padding5172;
  uint BindlessSampler_SharedBilinearWrappedSampler;
  uint Padding5180;
  uint BindlessSampler_SharedBilinearClampedSampler;
  uint Padding5188;
  uint BindlessSampler_SharedBilinearAnisoClampedSampler;
  uint Padding5196;
  uint BindlessSampler_SharedTrilinearWrappedSampler;
  uint Padding5204;
  uint BindlessSampler_SharedTrilinearClampedSampler;
  uint Padding5212;
  uint BindlessSRV_PreIntegratedBRDF;
  uint Padding5220;
  uint BindlessSampler_PreIntegratedBRDFSampler;
  uint Padding5228;
  uint BindlessSRV_SkyIrradianceEnvironmentMap;
  uint Padding5236;
  uint BindlessSRV_TransmittanceLutTexture;
  uint Padding5244;
  uint BindlessSampler_TransmittanceLutTextureSampler;
  uint Padding5252;
  uint BindlessSRV_SkyViewLutTexture;
  uint Padding5260;
  uint BindlessSampler_SkyViewLutTextureSampler;
  uint Padding5268;
  uint BindlessSRV_DistantSkyLightLutTexture;
  uint Padding5276;
  uint BindlessSampler_DistantSkyLightLutTextureSampler;
  uint Padding5284;
  uint BindlessSRV_CameraAerialPerspectiveVolume;
  uint Padding5292;
  uint BindlessSampler_CameraAerialPerspectiveVolumeSampler;
  uint Padding5300;
  uint BindlessSRV_CameraAerialPerspectiveVolumeMieOnly;
  uint Padding5308;
  uint BindlessSampler_CameraAerialPerspectiveVolumeMieOnlySampler;
  uint Padding5316;
  uint BindlessSRV_CameraAerialPerspectiveVolumeRayOnly;
  uint Padding5324;
  uint BindlessSampler_CameraAerialPerspectiveVolumeRayOnlySampler;
  uint Padding5332;
  uint BindlessSRV_HairScatteringLUTTexture;
  uint Padding5340;
  uint BindlessSampler_HairScatteringLUTSampler;
  uint Padding5348;
  uint BindlessSRV_GGXLTCMatTexture;
  uint Padding5356;
  uint BindlessSampler_GGXLTCMatSampler;
  uint Padding5364;
  uint BindlessSRV_GGXLTCAmpTexture;
  uint Padding5372;
  uint BindlessSampler_GGXLTCAmpSampler;
  uint Padding5380;
  uint BindlessSRV_SheenLTCTexture;
  uint Padding5388;
  uint BindlessSampler_SheenLTCSampler;
  uint Padding5396;
  uint bShadingEnergyConservation;
  uint bShadingEnergyPreservation;
  uint BindlessSRV_ShadingEnergyGGXSpecTexture;
  uint Padding5412;
  uint BindlessSRV_ShadingEnergyGGXGlassTexture;
  uint Padding5420;
  uint BindlessSRV_ShadingEnergyClothSpecTexture;
  uint Padding5428;
  uint BindlessSRV_ShadingEnergyDiffuseTexture;
  uint Padding5436;
  uint BindlessSampler_ShadingEnergySampler;
  uint Padding5444;
  uint BindlessSRV_GlintTexture;
  uint Padding5452;
  uint BindlessSampler_GlintSampler;
  uint Padding5460;
  uint BindlessSRV_SimpleVolumeTexture;
  uint Padding5468;
  uint BindlessSampler_SimpleVolumeTextureSampler;
  uint Padding5476;
  uint BindlessSRV_SimpleVolumeEnvTexture;
  uint Padding5484;
  uint BindlessSampler_SimpleVolumeEnvTextureSampler;
  uint Padding5492;
  uint BindlessSRV_SSProfilesTexture;
  uint Padding5500;
  uint BindlessSampler_SSProfilesSampler;
  uint Padding5508;
  uint BindlessSampler_SSProfilesTransmissionSampler;
  uint Padding5516;
  uint BindlessSRV_SSProfilesPreIntegratedTexture;
  uint Padding5524;
  uint BindlessSampler_SSProfilesPreIntegratedSampler;
  uint Padding5532;
  uint BindlessSRV_SpecularProfileTexture;
  uint Padding5540;
  uint BindlessSampler_SpecularProfileSampler;
  uint Padding5548;
  uint BindlessSRV_WaterIndirection;
  uint Padding5556;
  uint BindlessSRV_WaterData;
  uint Padding5564;
  float4 RectLightAtlasSizeAndInvSize;
  float RectLightAtlasMaxMipLevel;
  float Padding5588;
  uint BindlessSRV_RectLightAtlasTexture;
  uint Padding5596;
  uint BindlessSampler_RectLightAtlasSampler;
  uint Padding5604;
  uint Padding5608;
  uint Padding5612;
  float4 IESAtlasSizeAndInvSize;
  uint BindlessSRV_IESAtlasTexture;
  uint Padding5636;
  uint BindlessSampler_IESAtlasSampler;
  uint Padding5644;
  uint BindlessSampler_LandscapeWeightmapSampler;
  uint Padding5652;
  uint BindlessSRV_LandscapeIndirection;
  uint Padding5660;
  uint BindlessSRV_LandscapePerComponentData;
  uint Padding5668;
  uint BindlessUAV_VTFeedbackBuffer;
  uint Padding5676;
  uint BindlessSRV_PhysicsFieldClipmapBuffer;
  uint Padding5684;
  uint Padding5688;
  uint Padding5692;
  float3 TLASPreViewTranslationHigh;
  float Padding5708;
  float3 TLASPreViewTranslationLow;
};


StructuredBuffer<float4> EyeAdaptationBuffer : register(t0);

Texture2D<float4> ColorTexture : register(t1);

Texture2D<float4> BloomTexture : register(t2);

StructuredBuffer<float4> SceneColorApplyParamaters : register(t3);

Texture3D<float4> LumBilateralGrid : register(t4);

Texture2D<float4> BlurredLogLum : register(t5);

Texture2D<float4> BloomDirtMaskTexture : register(t6);

Texture3D<float4> ColorGradingLUT : register(t7);

cbuffer _RootShaderParameters : register(b0) {
  float2 Color_UVViewportBilinearMin : packoffset(c015.x);
  float2 Color_UVViewportBilinearMax : packoffset(c015.z);
  float EyeAdaptation_HistogramScale : packoffset(c025.y);
  float EyeAdaptation_HistogramBias : packoffset(c025.z);
  float EyeAdaptation_LuminanceMin : packoffset(c025.w);
  float3 EyeAdaptation_LuminanceWeights : packoffset(c027.x);
  float LocalExposure_HighlightContrastScale : packoffset(c032.x);
  float LocalExposure_ShadowContrastScale : packoffset(c032.y);
  float LocalExposure_DetailStrength : packoffset(c032.z);
  float LocalExposure_BlurredLuminanceBlend : packoffset(c032.w);
  float LocalExposure_MiddleGreyExposureCompensation : packoffset(c033.x);
  float2 LocalExposure_BilateralGridUVScale : packoffset(c033.z);
  float LocalExposure_HighlightThreshold : packoffset(c034.x);
  float LocalExposure_ShadowThreshold : packoffset(c034.y);
  float4 ColorToBloom : packoffset(c036.x);
  float2 BloomUVViewportBilinearMin : packoffset(c037.x);
  float2 BloomUVViewportBilinearMax : packoffset(c037.z);
  float4 ColorScale0 : packoffset(c044.x);
  float4 BloomDirtMaskTint : packoffset(c045.x);
  float4 LensPrincipalPointOffsetScale : packoffset(c048.x);
  float LUTScale : packoffset(c050.z);
  float LUTOffset : packoffset(c050.w);
  float EditorNITLevel : packoffset(c051.x);
  float BackbufferQuantizationDithering : packoffset(c051.y);
  uint bOutputInHDR : packoffset(c051.z);
};

cbuffer View : register(b1) {
  FViewConstants View : packoffset(c000.x);
};

SamplerState ColorSampler : register(s0);

SamplerState BloomSampler : register(s1);

SamplerState LumBilateralGridSampler : register(s2);

SamplerState BlurredLogLumSampler : register(s3);

SamplerState BloomDirtMaskSampler : register(s4);

SamplerState ColorGradingLUTSampler : register(s5);

/* struct OutputSignature {
  float4 SV_Target : SV_Target;
  float SV_Target_1 : SV_Target1;
}; */

OutputSignature main(
  noperspective float2 TEXCOORD : TEXCOORD,
  noperspective float2 TEXCOORD_1 : TEXCOORD1,
  noperspective float4 TEXCOORD_2 : TEXCOORD2,
  noperspective float2 TEXCOORD_3 : TEXCOORD3,
  noperspective float2 TEXCOORD_4 : TEXCOORD4,
  noperspective float4 SV_Position : SV_Position
) {
  float4 SV_Target;
  float SV_Target_1;
  float _31 = EyeAdaptationBuffer[0].x;
  float _32 = EyeAdaptationBuffer[0].w;
  float4 _44 = ColorTexture.Sample(ColorSampler, float2(min(max(TEXCOORD.x, Color_UVViewportBilinearMin.x), Color_UVViewportBilinearMax.x), min(max(TEXCOORD.y, Color_UVViewportBilinearMin.y), Color_UVViewportBilinearMax.y)));
  float4 _68 = BloomTexture.Sample(BloomSampler, float2(min(max(((ColorToBloom.x * TEXCOORD.x) + ColorToBloom.z), BloomUVViewportBilinearMin.x), BloomUVViewportBilinearMax.x), min(max(((ColorToBloom.y * TEXCOORD.y) + ColorToBloom.w), BloomUVViewportBilinearMin.y), BloomUVViewportBilinearMax.y)));
  float4 _87 = BloomDirtMaskTexture.Sample(BloomDirtMaskSampler, float2(((((LensPrincipalPointOffsetScale.z * TEXCOORD_3.x) + LensPrincipalPointOffsetScale.x) * 0.5f) + 0.5f), (0.5f - (((LensPrincipalPointOffsetScale.w * TEXCOORD_3.y) + LensPrincipalPointOffsetScale.y) * 0.5f))));
  float _107 = SceneColorApplyParamaters[0].x;
  float _108 = SceneColorApplyParamaters[0].y;
  float _109 = SceneColorApplyParamaters[0].z;
  float _121 = log2(max(dot(float3((_44.x * View.OneOverPreExposure), (_44.y * View.OneOverPreExposure), (_44.z * View.OneOverPreExposure)), float3(EyeAdaptation_LuminanceWeights.x, EyeAdaptation_LuminanceWeights.y, EyeAdaptation_LuminanceWeights.z)), EyeAdaptation_LuminanceMin));
  float4 _141 = LumBilateralGrid.Sample(LumBilateralGridSampler, float3((LocalExposure_BilateralGridUVScale.x * TEXCOORD_4.x), (LocalExposure_BilateralGridUVScale.y * TEXCOORD_4.y), ((((EyeAdaptation_HistogramScale * _121) + EyeAdaptation_HistogramBias) * 0.96875f) + 0.015625f)));
  float4 _147 = BlurredLogLum.Sample(BlurredLogLumSampler, float2(TEXCOORD_4.x, TEXCOORD_4.y));
  float _150 = select((_141.y < 0.0010000000474974513f), _147.x, (_141.x / _141.y));
  float _153 = log2(_31);
  float _155 = (_150 + _153) + ((_147.x - _150) * LocalExposure_BlurredLuminanceBlend);
  float _160 = _153 + _121;
  float _162 = _155 - log2((_32 * 0.18000000715255737f) * LocalExposure_MiddleGreyExposureCompensation);
  bool _163 = (_162 > 0.0f);
  float _175;
  float _310;
  float _311;
  float _312;
  if (_163) {
    _175 = max(0.0f, (_162 - LocalExposure_HighlightThreshold));
  } else {
    _175 = min(0.0f, (LocalExposure_ShadowThreshold + _162));
  }
  float _183 = _31 * View.OneOverPreExposure;
  float _184 = _183 * exp2((((_155 - _160) + ((_160 - _155) * LocalExposure_DetailStrength)) - _175) + (_175 * select(_163, LocalExposure_HighlightContrastScale, LocalExposure_ShadowContrastScale)));
  float4 _229 = ColorGradingLUT.Sample(ColorGradingLUTSampler, float3(((LUTScale * saturate((log2((((_68.x * _183) * ((BloomDirtMaskTint.x * _87.x) + 1.0f)) + 0.002667719265446067f) + (((ColorScale0.x * _44.x) * _107) * _184)) * 0.0714285746216774f) + 0.6107269525527954f)) + LUTOffset), ((LUTScale * saturate((log2((((_68.y * _183) * ((BloomDirtMaskTint.y * _87.y) + 1.0f)) + 0.002667719265446067f) + (((ColorScale0.y * _44.y) * _108) * _184)) * 0.0714285746216774f) + 0.6107269525527954f)) + LUTOffset), ((LUTScale * saturate((log2((((_68.z * _183) * ((BloomDirtMaskTint.z * _87.z) + 1.0f)) + 0.002667719265446067f) + (((ColorScale0.z * _44.z) * _109) * _184)) * 0.0714285746216774f) + 0.6107269525527954f)) + LUTOffset)));

  float3 untonemapped = _44.rgb;
  float3 midgray = (((ColorScale0.rgb * 0.18f) * SceneColorApplyParamaters[0].rgb) * _184);
  float midgray_lum = renodx::color::y::from::BT709(midgray);
  return LutToneMap(untonemapped, _229.rgb, TEXCOORD, midgray_lum);

  float _233 = _229.x * 1.0499999523162842f;
  float _234 = _229.y * 1.0499999523162842f;
  float _235 = _229.z * 1.0499999523162842f;
  [branch]
  if (!((uint)(bOutputInHDR) == 0)) {
    float _247 = (pow(_233, 0.012683313339948654f));
    float _248 = (pow(_234, 0.012683313339948654f));
    float _249 = (pow(_235, 0.012683313339948654f));
    float _282 = max(6.103519990574569e-05f, ((exp2(log2(max(0.0f, (_247 + -0.8359375f)) / (18.8515625f - (_247 * 18.6875f))) * 6.277394771575928f) * 10000.0f) / EditorNITLevel));
    float _283 = max(6.103519990574569e-05f, ((exp2(log2(max(0.0f, (_248 + -0.8359375f)) / (18.8515625f - (_248 * 18.6875f))) * 6.277394771575928f) * 10000.0f) / EditorNITLevel));
    float _284 = max(6.103519990574569e-05f, ((exp2(log2(max(0.0f, (_249 + -0.8359375f)) / (18.8515625f - (_249 * 18.6875f))) * 6.277394771575928f) * 10000.0f) / EditorNITLevel));
    _310 = min((_282 * 12.920000076293945f), ((exp2(log2(max(_282, 0.0031306699384003878f)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f));
    _311 = min((_283 * 12.920000076293945f), ((exp2(log2(max(_283, 0.0031306699384003878f)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f));
    _312 = min((_284 * 12.920000076293945f), ((exp2(log2(max(_284, 0.0031306699384003878f)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f));
  } else {
    _310 = _233;
    _311 = _234;
    _312 = _235;
  }
  float _319 = (frac(sin((TEXCOORD_2.w * 543.3099975585938f) + TEXCOORD_2.z) * 493013.0f) * 2.0f) + -1.0f;
  float _322 = min(max((_319 * 0x7FF0000000000000), -1.0f), 1.0f);
  float _331 = (_322 - (sqrt(saturate(1.0f - abs(_319))) * _322)) * BackbufferQuantizationDithering;
  SV_Target.x = (_331 + _310);
  SV_Target.y = (_331 + _311);
  SV_Target.z = (_331 + _312);
  SV_Target.w = 0.0f;
  SV_Target_1 = dot(float3(_233, _234, _235), float3(0.29899999499320984f, 0.5870000123977661f, 0.11400000005960464f));
  OutputSignature output_signature = { SV_Target, SV_Target_1 };
  return output_signature;
}
