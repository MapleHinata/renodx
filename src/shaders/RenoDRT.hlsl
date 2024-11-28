#ifndef SRC_SHADERS_RENODRT_HLSL_
#define SRC_SHADERS_RENODRT_HLSL_

#include "./color.hlsl"
#include "./math.hlsl"

namespace renodx {
namespace tonemap {
namespace renodrt {

struct Config {
  float nits_peak;
  float mid_gray_value;
  float mid_gray_nits;
  float exposure;
  float highlights;
  float shadows;
  float contrast;
  float saturation;
  float dechroma;
  float flare;
  float hue_correction_strength;
  float3 hue_correction_source;
  uint hue_correction_method;
  uint tone_map_method;
  uint hue_correction_type;
};
namespace config {

namespace hue_correction_type {
static const uint INPUT = 0u;
static const uint CUSTOM = 1u;
}

namespace hue_correction_method {
static const uint OKLAB = 0u;
static const uint ICTCP = 1u;
static const uint DARKTABLE_UCS = 2u;
}

namespace tone_map_method {
static const uint DANIELE = 0u;
static const uint REINHARD = 1u;
}

Config Create(
    float nits_peak = 1000.f / 203.f * 100.f,
    float mid_gray_value = 0.18f,
    float mid_gray_nits = 10.f,
    float exposure = 1.f,
    float highlights = 1.f,
    float shadows = 1.f,
    float contrast = 1.1f,
    float saturation = 1.f,
    float dechroma = 0.5f,
    float flare = 0.f,
    float hue_correction_strength = 1.f,
    float3 hue_correction_source = 0,
    uint hue_correction_method = config::hue_correction_method::OKLAB,
    uint tone_map_method = config::tone_map_method::DANIELE,
    uint hue_correction_type = config::hue_correction_type::INPUT) {
  const Config renodrt_config = {
    nits_peak,
    mid_gray_value,
    mid_gray_nits,
    exposure,
    highlights,
    shadows,
    contrast,
    saturation,
    dechroma,
    flare,
    hue_correction_strength,
    hue_correction_source,
    hue_correction_method,
    tone_map_method,
    hue_correction_type
  };
  return renodrt_config;
}
}

float3 BT709(float3 bt709, Config current_config) {
  const float n_r = 100.f;
  float n = 1000.f;

  // drt cam
  // n_r = 100
  // g = 1.15
  // c = 0.18
  // c_d = 10.013
  // w_g = 0.14
  // t_1 = 0.04
  // r_hit_min = 128
  // r_hit_max = 896

  float g = 1.1;            // gamma/contrast
  float c = 0.18;           // scene-referred gray
  float c_d = 10.013;       // output gray in nits
  const float w_g = 0.00f;  // gray change
  float t_1 = 0.01;         // shadow toe
  const float r_hit_min = 128;
  const float r_hit_max = 256;

  g = current_config.contrast;
  c = current_config.mid_gray_value;
  c_d = current_config.mid_gray_nits;
  n = current_config.nits_peak;
  t_1 = current_config.flare;

  float y_original = renodx::color::y::from::BT709(abs(bt709));

  float3 perceptual_old;
  if (current_config.hue_correction_strength != 0) {
    float3 source = (current_config.hue_correction_type == config::hue_correction_type::INPUT)
                        ? bt709
                        : current_config.hue_correction_source;
    if (current_config.hue_correction_method == config::hue_correction_method::OKLAB) {
      perceptual_old = renodx::color::oklab::from::BT709(source);
    } else if (current_config.hue_correction_method == config::hue_correction_method::ICTCP) {
      perceptual_old = renodx::color::ictcp::from::BT709(source);
    } else if (current_config.hue_correction_method == config::hue_correction_method::DARKTABLE_UCS) {
      perceptual_old = renodx::color::dtucs_uvY::from::BT709(source).zxy;
    }
  }

  float y = y_original * current_config.exposure;

  float y_normalized = y / 0.18f;

  if (current_config.tone_map_method == config::tone_map_method::REINHARD) {
    y_normalized = pow(y_normalized, current_config.contrast);
  }

  float y_highlighted = pow(y_normalized, current_config.highlights);
  y_highlighted = lerp(y_normalized, y_highlighted, saturate(y_normalized));

  float y_shadowed = pow(y_highlighted, -1.f * (current_config.shadows - 2.f));
  y_shadowed = lerp(y_shadowed, y_highlighted, saturate(y_highlighted));
  y_shadowed *= 0.18f;
  y = y_shadowed;

  float m_0 = (n / n_r);
  float ts;
  if (current_config.tone_map_method == config::tone_map_method::DANIELE) {
    float m_1 = 0.5 * (m_0 + sqrt(m_0 * (m_0 + (4.0 * t_1))));
    float r_hit = r_hit_min + ((r_hit_max - r_hit_min) * (log(m_0) / log(10000.0 / 100.0)));

    float u = pow((r_hit / m_1) / ((r_hit / m_1) + 1.0), g);
    const float m = m_1 / u;
    const float w_i = log(n / 100.0) / log(2.0);
    const float c_t = (c_d / n_r) * (1.0 + (w_i * w_g));
    const float g_ip = 0.5 * (c_t + sqrt(c_t * (c_t + (4.0 * t_1))));
    const float g_ipp2 = -m_1 * pow(g_ip / m, 1.0 / g) / (pow(g_ip / m, 1.0 / g) - 1.0);
    const float w_2 = c / g_ipp2;
    const float s_2 = w_2 * m_1;
    float u_2 = pow((r_hit / m_1) / ((r_hit / m_1) + w_2), g);
    float m_2 = m_1 / u_2;

    ts = pow(max(0, y) / (y + s_2), g) * m_2;
  } else if (current_config.tone_map_method == config::tone_map_method::REINHARD) {
    float x_max = m_0;
    float x_min = 0;
    float gray_in = 0.18;
    float gray_out = current_config.mid_gray_nits / 100.f;
    float reinard_exposure = (x_max * (x_min * gray_out + x_min - gray_out))
                             / (gray_in * (gray_out - x_max));
    float reinhard_result = mad(y, reinard_exposure, x_min) / mad(y, reinard_exposure / x_max, 1.f - x_min);
    ts = reinhard_result;
  }

  float flared = max(0, (ts * ts) / (ts + t_1));

  float y_new = clamp(flared, 0, m_0);

  float3 color_output = bt709 * (y_original > 0 ? (y_new / y_original) : 0);
  float3 color = color_output;

  if (current_config.dechroma != 0.f || current_config.saturation != 1.f || current_config.hue_correction_strength != 0.f) {
    float3 perceptual_new;
    if (current_config.hue_correction_method == config::hue_correction_method::OKLAB) {
      perceptual_new = renodx::color::oklab::from::BT709(color_output);
    } else if (current_config.hue_correction_method == config::hue_correction_method::ICTCP) {
      perceptual_new = renodx::color::ictcp::from::BT709(color_output);
    } else if (current_config.hue_correction_method == config::hue_correction_method::DARKTABLE_UCS) {
      perceptual_new = renodx::color::dtucs_uvY::from::BT709(color_output).zxy;
    }

    if (current_config.hue_correction_strength != 0.f) {
      // Save chrominance to apply black
      float chrominance_pre_adjust = distance(perceptual_new.yz, 0);

      perceptual_new.yz = lerp(perceptual_new.yz, perceptual_old.yz, current_config.hue_correction_strength);

      float chrominance_post_adjust = distance(perceptual_new.yz, 0);

      // Apply back previous chrominance
      if (chrominance_post_adjust != 0.f) {
        perceptual_new.yz *= chrominance_pre_adjust / chrominance_post_adjust;
      }
    }

    if (current_config.dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y_original / (10000.f / 100.f), (1.f - current_config.dechroma))));
    }

    perceptual_new.yz *= current_config.saturation;

    if (current_config.hue_correction_method == config::hue_correction_method::OKLAB) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (current_config.hue_correction_method == config::hue_correction_method::ICTCP) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (current_config.hue_correction_method == config::hue_correction_method::DARKTABLE_UCS) {
      color = renodx::color::bt709::from::dtucs_uvY(perceptual_new.yzx);
    }

    color = renodx::color::bt709::clamp::AP1(color);
    color = min(m_0, color);  // Clamp to Peak
  }
  return color;
}

float3 BT709(
    float3 bt709,
    float nits_peak,
    float mid_gray_value,
    float mid_gray_nits,
    float exposure,
    float highlights,
    float shadows,  // 0 = 0.10, 1.f = 0, >1 = contrast
    float contrast,
    float saturation,
    float dechroma,
    float flare,
    float hue_correction_strength,
    float3 hue_correction_source) {
  Config config = config::Create();
  config.nits_peak = nits_peak;
  config.mid_gray_value = mid_gray_value;
  config.mid_gray_nits = mid_gray_nits;
  config.exposure = exposure;
  config.highlights = highlights;
  config.shadows = shadows;
  config.contrast = contrast;
  config.saturation = saturation;
  config.dechroma = dechroma;
  config.flare = flare;
  config.hue_correction_strength = hue_correction_strength;
  config.hue_correction_source = hue_correction_source;
  config.hue_correction_type = renodrt::config::hue_correction_type::CUSTOM;
  return BT709(bt709, config);
}
float3 BT709(
    float3 bt709,
    float nits_peak = 1000.f / 203.f * 100.f,
    float mid_gray_value = 0.18f,
    float mid_gray_nits = 10.f,
    float exposure = 1.f,
    float highlights = 1.f,
    float shadows = 1.f,
    float contrast = 1.1f,
    float saturation = 1.f,
    float dechroma = 0.5f,
    float flare = 0.f,
    float hue_correction_strength = 1.f) {
  return BT709(
      bt709,
      nits_peak,
      mid_gray_value,
      mid_gray_nits,
      exposure,
      highlights,
      shadows,
      contrast,
      saturation,
      dechroma,
      flare,
      hue_correction_strength,
      bt709);
}
}  // namespace renodrt
}  // namespace tonemap
}  // namespace renodx

#endif  // SRC_SHADERS_RENODRT_HLSL_
