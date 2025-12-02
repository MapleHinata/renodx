/*
 * Copyright (C) 2025 Maple Hinata
 * Copyright (C) 2025 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <include/reshade.hpp>

#include <src/d3d9/d3d9_interfaces.h>
#include <winerror.h>


#include "./vtable.hpp"

namespace renodx::utils::d3d9_hook {
namespace internal {
static bool attached = false;
}  // namespace internal


void UnlockFormatsForDirect3D9(IDirect3D9* pD3D9){
  ID3D9VkExtInterface* dxvk_interface;
  if (SUCCEEDED(pD3D9->QueryInterface(IID_PPV_ARGS(&dxvk_interface)))) {
    dxvk_interface->UnlockAdditionalFormats();
    dxvk_interface->Release();
    dxvk_interface = nullptr;
  }
}

decltype(&Direct3DCreate9) real_Direct3DCreate9 = nullptr;
IDirect3D9* WINAPI HookDirect3DCreate9(UINT SDKVersion) {
  OutputDebugStringW(L"HookDirect3DCreate9: intercepted Direct3DCreate9\n");
  auto* d3d9 = real_Direct3DCreate9(SDKVersion);
  UnlockFormatsForDirect3D9(d3d9);
  return d3d9;
}

decltype(&Direct3DCreate9Ex) real_Direct3DCreate9Ex = nullptr;
HRESULT WINAPI HookDirect3DCreate9Ex(UINT SDKVersion, IDirect3D9Ex** ppD3D) {
  OutputDebugStringW(L"HookDirect3DCreate9Ex: intercepted Direct3DCreate9Ex\n");
  auto result = real_Direct3DCreate9Ex(SDKVersion, ppD3D);
  if(SUCCEEDED(result)){
    UnlockFormatsForDirect3D9(*ppD3D);
  }

  return result;
}


static void HookDirect3D9Create() {
  static std::array<renodx::utils::vtable::HookItem, 2> g_d3d9_hook_items = {{
      {"Direct3DCreate9", reinterpret_cast<void**>(&real_Direct3DCreate9), reinterpret_cast<void*>(&HookDirect3DCreate9)},
      {"Direct3DCreate9Ex", reinterpret_cast<void**>(&real_Direct3DCreate9Ex), reinterpret_cast<void*>(&HookDirect3DCreate9Ex)},
  }};

  HMODULE h_d3d9 = GetModuleHandleW(L"d3d9.dll");
  if (h_d3d9 == nullptr) {
    reshade::log::message(reshade::log::level::error, "Failed to get handle for d3d9.dll");
  }

  bool hooked = renodx::utils::vtable::Hook(h_d3d9, g_d3d9_hook_items);
}

static void Use(DWORD fdw_reason) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (internal::attached) return;
      internal::attached = true;

      reshade::log::message(reshade::log::level::info, "utils::d3d9_hook attached.");

      HookDirect3D9Create();

      break;

    case DLL_PROCESS_DETACH:
      if (!internal::attached) return;
      internal::attached = false;
      break;
  }
}

}  // namespace renodx::utils::d3d9_hook
