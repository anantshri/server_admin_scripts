# First read this page for system requirements:
# https://chromium.googlesource.com/chromium/src/+/master/docs/mac_build_instructions.md
BASE=/Users/xlr8/Chromium_builds
#!/bin/sh -x
LAST_STABLE=105.0.5195.68; #insert here last stable version number
BUILD_FOLDER="Release"
mkdir $BASE/chromium;
# fetch --nohooks chromium; #to download source the first time
cd $BASE/chromium/src;
git config --global core.precomposeUnicode true;
git fetch --tags;
git reset --hard "${LAST_STABLE}";
git clean -df;
gclient sync -D --with_branch_heads --jobs 16 --force;
gn gen out/$BUILD_FOLDER;
echo "is_debug = false\nis_component_build = false\nsymbol_level = 0\n" >> out/$BUILD_FOLDER/args.gn
# Full buildfile below
# # Set build arguments here. See `gn help buildargs`.
# is_debug = false
# is_component_build = false
# symbol_level = 0
# blink_symbol_level=0
# v8_symbol_level=0


# enable_hangout_services_extension=true

# enable_reading_list=false
# enable_remoting=false
# enable_reporting=false
# enable_service_discovery=false

# google_api_key=""
# google_default_client_id=""
# google_default_client_secret=""

# enable_widevine=true
# media_use_ffmpeg = true
# media_use_libvpx = true
# proprietary_codecs = true
# ffmpeg_branding = "Chrome"
# enable_mse_mpeg2ts_stream_parser=true

ninja -C out/$BUILD_FOLDER chrome;
# your binary is in ~/chromium/src/out/Release
