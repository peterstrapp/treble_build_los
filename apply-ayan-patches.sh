#!/bin/bash

echo "Applying universal patches"
cd frameworks/base
if git apply --check ../../0001-Disable-vendor-mismatch-warning.patch;then
    git am ../../0001-Disable-vendor-mismatch-warning.patch
fi
if git apply --check ../../0001-Keyguard-Show-shortcuts-by-default.patch;then
    git am ../../0001-Keyguard-Show-shortcuts-by-default.patch
fi
if git apply --check ../../0001-core-Add-support-for-MicroG.patch;then
    git am ../../0001-core-Add-support-for-MicroG.patch
fi
cd ../..
cd lineage-sdk
if git apply --check ../0001-sdk-Invert-per-app-stretch-to-fullscreen.patch;then
    git am ../0001-sdk-Invert-per-app-stretch-to-fullscreen.patch
fi
cd ..
cd packages/apps/LineageParts
if git apply --check ../../../0001-LineageParts-Invert-per-app-stretch-to-fullscreen.patch;then
    git am ../../../0001-LineageParts-Invert-per-app-stretch-to-fullscreen.patch
fi
cd ../../..
cd vendor/lineage
if git apply --check ../../0001-vendor_lineage-Log-privapp-permissions-whitelist-vio.patch;then
    git am ../../0001-vendor_lineage-Log-privapp-permissions-whitelist-vio.patch
fi
cd ../..
echo ""

echo "Applying GSI-specific patches"
cd build/make
git am ../../0001-Revert-Enable-dyanmic-image-size-for-GSI.patch
cd ../..
cd device/phh/treble
git revert 82b15278bad816632dcaeaed623b569978e9840d --no-edit #Update lineage.mk for LineageOS 16.0
git revert df25576594f684ed35610b7cc1db2b72bc1fc4d6 --no-edit #exfat fsck/mkfs selinux label
if git apply --check ../../../0001-treble-Add-overlay-lineage.patch;then
    git am ../../../0001-treble-Add-overlay-lineage.patch
fi
if git apply --check ../../../0001-treble-Don-t-specify-config_wallpaperCropperPackage.patch;then
    git am ../../../0001-treble-Don-t-specify-config_wallpaperCropperPackage.patch
fi
if git apply --check ../../../0001-Increase-system-partition-size-for-arm_ab.patch;then
    git am ../../../0001-Increase-system-partition-size-for-arm_ab.patch
fi
cd ../../..
cd external/tinycompress
git revert fbe2bd5c3d670234c3c92f875986acc148e6d792 --no-edit #tinycompress: Use generated kernel headers
cd ../..
cd vendor/lineage
if git apply --check ../../0001-build_soong-Disable-generated_kernel_headers.patch;then
    git am ../../0001-build_soong-Disable-generated_kernel_headers.patch
fi
cd ../..
cd vendor/qcom/opensource/cryptfs_hw
git revert 6a3fc11bcc95d1abebb60e5d714adf75ece83102 --no-edit #cryptfs_hw: Use generated kernel headers
if git apply --check ../../../../0001-Header-hack-to-compile-for-8974.patch;then
    git am ../../../../0001-Header-hack-to-compile-for-8974.patch
fi
cd ../../../..
echo ""

echo "Patching complete"
