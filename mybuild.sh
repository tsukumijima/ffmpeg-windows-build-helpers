
directory=$(cd $(dirname $0);pwd)
version=$1

sandbox_win32_static="${directory}/sandbox/win32/ffmpeg_git_with_fdk_aac_n${version}"
sandbox_win32_shared="${directory}/sandbox/win32/ffmpeg_git_with_fdk_aac_n${version}_shared"
sandbox_win64_static="${directory}/sandbox/win64/ffmpeg_git_with_fdk_aac_n${version}"
sandbox_win64_shared="${directory}/sandbox/win64/ffmpeg_git_with_fdk_aac_n${version}_shared"

build_win32_static="${directory}/packages/ffmpeg-${version}-win32-static"
build_win32_shared="${directory}/packages/ffmpeg-${version}-win32-shared"
build_win64_static="${directory}/packages/ffmpeg-${version}-win64-static"
build_win64_shared="${directory}/packages/ffmpeg-${version}-win64-shared"

echo -e ""

if [ $# != 1 ]; then
	echo -e "Error: ffmpeg version is not specified. (Example: ./mybuild.sh 4.3.1 )"
    echo -e ""
	exit 1
fi

time "${directory}/cross_compile_ffmpeg.sh" \
                  --build-ffmpeg-static=y \
                  --build-ffmpeg-shared=y \
                  --build-intel-qsv=y \
                  --build-amd-amf=y \
                  --build-lsw=y \
                  --disable-nonfree=n \
                  --ffmpeg-git-checkout-version=n${version} 

mkdir -p "${directory}/build"

if [ -e "${sandbox_win32_static}/ffmpeg.exe" ]; then
    echo -e "Packaging 32-bit static builds...\n"
    mkdir -p "${build_win32_static}"
    mkdir -p "${build_win32_static}/bin"
    mkdir -p "${build_win32_static}/doc"
    mkdir -p "${build_win32_static}/presets"
    cp "${sandbox_win32_static}/ffmpeg.exe" "${build_win32_static}/bin"
    cp "${sandbox_win32_static}/ffprobe.exe" "${build_win32_static}/bin"
    cp "${sandbox_win32_static}/ffplay.exe" "${build_win32_static}/bin"
    for doc in ${sandbox_win32_static}/doc/*.{html,css}; do
        cp "${doc}" "${build_win32_static}/doc"
    done
    for presets in ${sandbox_win32_static}/presets/*.ffpreset; do
        cp "${presets}" "${build_win32_static}/presets"
    done
    cp "${directory}/LICENSE" "${build_win32_static}/LICENSE.txt"
fi

if [ -e "${sandbox_win32_shared}/bin/ffmpeg.exe" ]; then
    echo -e "Packaging 32-bit shared builds...\n"
    mkdir -p "${build_win32_shared}"
    mkdir -p "${build_win32_shared}/bin"
    mkdir -p "${build_win32_shared}/doc"
    mkdir -p "${build_win32_shared}/presets"
    for bin in ${sandbox_win32_shared}/bin/*.{exe,dll}; do
        cp "${bin}" "${build_win32_shared}/bin"
    done
    for doc in ${sandbox_win32_shared}/doc/*.{html,css}; do
        cp "${doc}" "${build_win32_shared}/doc"
    done
    for presets in ${sandbox_win32_shared}/presets/*.ffpreset; do
        cp "${presets}" "${build_win32_shared}/presets"
    done
    cp "${directory}/LICENSE" "${build_win32_shared}/LICENSE.txt"
fi

if [ -e "${sandbox_win64_static}/ffmpeg.exe" ]; then
    echo -e "Packaging 64-bit static builds...\n"
    mkdir -p "${build_win64_static}"
    mkdir -p "${build_win64_static}/bin"
    mkdir -p "${build_win64_static}/doc"
    mkdir -p "${build_win64_static}/presets"
    cp "${sandbox_win64_static}/ffmpeg.exe" "${build_win64_static}/bin"
    cp "${sandbox_win64_static}/ffprobe.exe" "${build_win64_static}/bin"
    cp "${sandbox_win64_static}/ffplay.exe" "${build_win64_static}/bin"
    for doc in ${sandbox_win64_static}/doc/*.{html,css}; do
        cp "${doc}" "${build_win64_static}/doc"
    done
    for presets in ${sandbox_win64_static}/presets/*.ffpreset; do
        cp "${presets}" "${build_win64_static}/presets"
    done
    cp "${directory}/LICENSE" "${build_win64_static}/LICENSE.txt"
fi

if [ -e "${sandbox_win64_shared}/bin/ffmpeg.exe" ]; then
    echo -e "Packaging 64-bit shared builds...\n"
    mkdir -p "${build_win64_shared}"
    mkdir -p "${build_win64_shared}/bin"
    mkdir -p "${build_win64_shared}/doc"
    mkdir -p "${build_win64_shared}/presets"
    for bin in ${sandbox_win64_shared}/bin/*.{exe,dll}; do
        cp "${bin}" "${build_win64_shared}/bin"
    done
    for doc in ${sandbox_win64_shared}/doc/*.{html,css}; do
        cp "${doc}" "${build_win64_shared}/doc"
    done
    for presets in ${sandbox_win64_shared}/presets/*.ffpreset; do
        cp "${presets}" "${build_win64_shared}/presets"
    done
    cp "${directory}/LICENSE" "${build_win64_shared}/LICENSE.txt"
fi
