### Build Notes:

```
export CCACHE_DIR=./.ccache
mkdir -p CCACHE_DIR
ccache -C
export USE_CCACHE=1
export CCACHE_COMPRESS=1
ccache -M 50G



mkdir ~/lineage &&  cd ~/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-16.0

mkdir -p bin; cd bin; ln -s $(which python2) python; cd ..;
export PATH=`pwd`/bin:$PATH

git clone https://github.com/phhusson/treble_manifest .repo/local_manifests -b android-9.0
git clone git@github.com:peterstrapp/treble_patches.git
git clone https://github.com/peterstrapp/treble_build_los.git

rm -f .repo/local_manifests/replace.xml

** REMOVE extfat reference from .repo/local_manifests/manifest.xml **

repo sync

./treble_build_los/apply-phh-patches.sh treble_patches

yes | cp -f treble_build_los/*.patch ./
./treble_build_los/apply-ayan-patches.sh

rm -f device/*/sepolicy/common/private/genfs_contexts
(cd device/phh/treble; git clean -fdx; bash generate.sh lineage)
(cd vendor/foss; git clean -fdx; bash update.sh)

. build/envsetup.sh
lunch treble_arm64_bvN-userdebug

time WITHOUT_CHECK_API=true make -j8 systemimage

xz -c system.img > system.img.xz
```
