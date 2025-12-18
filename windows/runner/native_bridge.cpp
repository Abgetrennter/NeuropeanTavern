#include "native_bridge.h"

#include <windows.h>
#include <versionhelpers.h>

NativeBridge::NativeBridge(flutter::BinaryMessenger* messenger) {
  channel_ = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      messenger, "com.neuropean.app/bridge",
      &flutter::StandardMethodCodec::GetInstance());

  channel_->SetMethodCallHandler(
      [this](const auto& call, auto result) {
        HandleMethodCall(call, std::move(result));
      });
}

NativeBridge::~NativeBridge() {}

void NativeBridge::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::string version = "Windows ";
    if (IsWindows10OrGreater()) {
      version += "10+";
    } else if (IsWindows8OrGreater()) {
      version += "8";
    } else {
      version += "7 or lower";
    }
    result->Success(flutter::EncodableValue(version));
  } else {
    result->NotImplemented();
  }
}