
# Win32・Win64 両方ビルドすることが前提です

# ベースディレクトリ
directory=$(cd $(dirname $0);pwd)

# 引数で指定されたバージョン
version=$1

# サンドボックス内の exe・dll の場所
sandbox_win32_static="${directory}/sandbox/win32/ffmpeg_git_with_fdk_aac_n${version}"
sandbox_win32_shared="${directory}/sandbox/win32/ffmpeg_git_with_fdk_aac_n${version}_shared"
sandbox_win64_static="${directory}/sandbox/win64/ffmpeg_git_with_fdk_aac_n${version}"
sandbox_win64_shared="${directory}/sandbox/win64/ffmpeg_git_with_fdk_aac_n${version}_shared"
sandbox_x264_win32="${directory}/sandbox/win32/x264_all_bitdepth"
sandbox_x264_win64="${directory}/sandbox/win64/x264_all_bitdepth"
sandbox_x265_win32="${directory}/sandbox/win32/x265_all_bitdepth"
sandbox_x265_win64="${directory}/sandbox/win64/x265_all_bitdepth"
sandbox_l_smash_win32="${directory}/sandbox/win32/l-smash"
sandbox_l_smash_win64="${directory}/sandbox/win64/l-smash"
sandbox_l_smash_works_win32="${directory}/sandbox/win32/lsw"
sandbox_l_smash_works_win64="${directory}/sandbox/win64/lsw"

# パッケージして配置する場所
package_win32_static="${directory}/packages/FFmpeg-${version}-32bit-Static"
package_win32_shared="${directory}/packages/FFmpeg-${version}-32bit-Shared"
package_win64_static="${directory}/packages/FFmpeg-${version}-64bit-Static"
package_win64_shared="${directory}/packages/FFmpeg-${version}-64bit-Shared"
package_x264="${directory}/packages/x264-FFmpeg-${version}"
package_x265="${directory}/packages/x265-FFmpeg-${version}"
package_l_smash="${directory}/packages/L-SMASH-FFmpeg-${version}"
package_l_smash_works="${directory}/packages/L-SMASH-Works-FFmpeg-${version}"

echo -e ""

# エラー：バージョンが指定されていない
if [ $# != 1 ]; then
	echo -e "Error: ffmpeg version is not specified. (Example: ./mybuild.sh 4.3.1 )"
    echo -e ""
	exit 1
fi

# ビルド開始
time "${directory}/cross_compile_ffmpeg.sh" \
                  --build-ffmpeg-static=y \
                  --build-ffmpeg-shared=y \
                  --build-intel-qsv=y \
                  --build-amd-amf=y \
                  --build-lsw=y \
                  --disable-nonfree=n \
                  --ffmpeg-git-checkout-version=n${version} 

# パッケージフォルダを作成
mkdir -p "${directory}/packages"

# FFmpeg 32bit (Static)
if [ -e "${sandbox_win32_static}/ffmpeg.exe" ]; then
    echo -e "Packaging 32-bit static builds...\n"
    mkdir -p "${package_win32_static}"
    mkdir -p "${package_win32_static}/bin"
    mkdir -p "${package_win32_static}/doc"
    mkdir -p "${package_win32_static}/presets"
    cp "${sandbox_win32_static}/ffmpeg.exe" "${package_win32_static}/bin"
    cp "${sandbox_win32_static}/ffprobe.exe" "${package_win32_static}/bin"
    cp "${sandbox_win32_static}/ffplay.exe" "${package_win32_static}/bin"
    for doc in ${sandbox_win32_static}/doc/*.{html,css}; do
        cp "${doc}" "${package_win32_static}/doc"
    done
    for presets in ${sandbox_win32_static}/presets/*.ffpreset; do
        cp "${presets}" "${package_win32_static}/presets"
    done
    cp "${directory}/LICENSE" "${package_win32_static}/LICENSE.txt"
fi

# FFmpeg 32bit (Shared)
if [ -e "${sandbox_win32_shared}/bin/ffmpeg.exe" ]; then
    echo -e "Packaging 32-bit shared builds...\n"
    mkdir -p "${package_win32_shared}"
    mkdir -p "${package_win32_shared}/bin"
    mkdir -p "${package_win32_shared}/doc"
    mkdir -p "${package_win32_shared}/presets"
    for bin in ${sandbox_win32_shared}/bin/*.{exe,dll}; do
        cp "${bin}" "${package_win32_shared}/bin"
    done
    for doc in ${sandbox_win32_shared}/doc/*.{html,css}; do
        cp "${doc}" "${package_win32_shared}/doc"
    done
    for presets in ${sandbox_win32_shared}/presets/*.ffpreset; do
        cp "${presets}" "${package_win32_shared}/presets"
    done
    cp "${directory}/LICENSE" "${package_win32_shared}/LICENSE.txt"
fi

# FFmpeg 64bit (Static)
if [ -e "${sandbox_win64_static}/ffmpeg.exe" ]; then
    echo -e "Packaging 64-bit static builds...\n"
    mkdir -p "${package_win64_static}"
    mkdir -p "${package_win64_static}/bin"
    mkdir -p "${package_win64_static}/doc"
    mkdir -p "${package_win64_static}/presets"
    cp "${sandbox_win64_static}/ffmpeg.exe" "${package_win64_static}/bin"
    cp "${sandbox_win64_static}/ffprobe.exe" "${package_win64_static}/bin"
    cp "${sandbox_win64_static}/ffplay.exe" "${package_win64_static}/bin"
    for doc in ${sandbox_win64_static}/doc/*.{html,css}; do
        cp "${doc}" "${package_win64_static}/doc"
    done
    for presets in ${sandbox_win64_static}/presets/*.ffpreset; do
        cp "${presets}" "${package_win64_static}/presets"
    done
    cp "${directory}/LICENSE" "${package_win64_static}/LICENSE.txt"
fi

# FFmpeg 64bit (Shared)
if [ -e "${sandbox_win64_shared}/bin/ffmpeg.exe" ]; then
    echo -e "Packaging 64-bit shared builds...\n"
    mkdir -p "${package_win64_shared}"
    mkdir -p "${package_win64_shared}/bin"
    mkdir -p "${package_win64_shared}/doc"
    mkdir -p "${package_win64_shared}/presets"
    for bin in ${sandbox_win64_shared}/bin/*.{exe,dll}; do
        cp "${bin}" "${package_win64_shared}/bin"
    done
    for doc in ${sandbox_win64_shared}/doc/*.{html,css}; do
        cp "${doc}" "${package_win64_shared}/doc"
    done
    for presets in ${sandbox_win64_shared}/presets/*.ffpreset; do
        cp "${presets}" "${package_win64_shared}/presets"
    done
    cp "${directory}/LICENSE" "${package_win64_shared}/LICENSE.txt"
fi

# x264
if [ -e "${sandbox_x264_win32}/x264.exe" ] && [ -e "${sandbox_x264_win64}/x264.exe" ]; then
    echo -e "Packaging x264 builds...\n"
    mkdir -p "${package_x264}"
    mkdir -p "${package_x264}/x64"
    mkdir -p "${package_x264}/doc"
    cp "${sandbox_x264_win32}/x264.exe" "${package_x264}"
    cp "${sandbox_x264_win64}/x264.exe" "${package_x264}/x64"
    cp "${sandbox_x264_win32}/AUTHORS" "${package_x264}/AUTHORS.txt"
    cp "${sandbox_x264_win32}/COPYING" "${package_x264}/COPYING.txt"
    for doc in ${sandbox_x264_win32}/doc/*.txt; do
        cp "${doc}" "${package_x264}/doc"
    done
fi

# x265
if [ -e "${sandbox_x265_win32}/8bit/x265.exe" ] && [ -e "${sandbox_x265_win64}/8bit/x265.exe" ]; then
    echo -e "Packaging x265 builds...\n"
    mkdir -p "${package_x265}"
    mkdir -p "${package_x265}/x64"
    mkdir -p "${package_x265}/doc"
    mkdir -p "${package_x265}/doc/intra"
    mkdir -p "${package_x265}/doc/reST"
    cp "${sandbox_x265_win32}/8bit/x265.exe" "${package_x265}"
    cp "${sandbox_x265_win64}/8bit/x265.exe" "${package_x265}/x64"
    cp "${sandbox_x265_win32}/COPYING" "${package_x265}/COPYING.txt"
    cp "${sandbox_x265_win32}/readme.rst" "${package_x265}/"
    for doc in ${sandbox_x265_win32}/doc/intra/*.txt; do
        cp "${doc}" "${package_x265}/doc/intra"
    done
    for doc in ${sandbox_x265_win32}/doc/reST/*.rst; do
        cp "${doc}" "${package_x265}/doc/reST"
    done
fi

# L-SMASH
if [ -e "${sandbox_l_smash_win32}/cli/boxdumper.exe" ] && [ -e "${sandbox_l_smash_win64}/cli/boxdumper.exe" ]; then
    echo -e "Packaging L-SMASH builds...\n"
    mkdir -p "${package_l_smash}"
    mkdir -p "${package_l_smash}/x64"
    cp "${sandbox_l_smash_win32}/cli/boxdumper.exe" "${package_l_smash}"
    cp "${sandbox_l_smash_win32}/cli/muxer.exe" "${package_l_smash}"
    cp "${sandbox_l_smash_win32}/cli/remuxer.exe" "${package_l_smash}"
    cp "${sandbox_l_smash_win32}/cli/timelineeditor.exe" "${package_l_smash}"
    cp "${sandbox_l_smash_win64}/cli/boxdumper.exe" "${package_l_smash}/x64"
    cp "${sandbox_l_smash_win64}/cli/muxer.exe" "${package_l_smash}/x64"
    cp "${sandbox_l_smash_win64}/cli/remuxer.exe" "${package_l_smash}/x64"
    cp "${sandbox_l_smash_win64}/cli/timelineeditor.exe" "${package_l_smash}/x64"
    cp "${sandbox_l_smash_win32}/LICENSE" "${package_l_smash}/LICENSE.txt"
fi

# L-SMASH Works
# AviUtl は 32bit のみ
if [ -e "${sandbox_l_smash_works_win32}/VapourSynth/vslsmashsource.dll" ] && [ -e "${sandbox_l_smash_works_win64}/VapourSynth/vslsmashsource.dll" ]; then
    echo -e "Packaging L-SMASH Works builds...\n"
    mkdir -p "${package_l_smash_works}"
    mkdir -p "${package_l_smash_works}/VapourSynth"
    mkdir -p "${package_l_smash_works}/VapourSynth/x64"
    cp "${sandbox_l_smash_works_win32}/AviUtl/lwcolor.auc" "${package_l_smash_works}"
    cp "${sandbox_l_smash_works_win32}/AviUtl/lwdumper.auf" "${package_l_smash_works}"
    cp "${sandbox_l_smash_works_win32}/AviUtl/lwinput.aui" "${package_l_smash_works}"
    cp "${sandbox_l_smash_works_win32}/AviUtl/lwmuxer.auf" "${package_l_smash_works}"
    cp "${sandbox_l_smash_works_win32}/VapourSynth/vslsmashsource.dll" "${package_l_smash_works}/VapourSynth"
    cp "${sandbox_l_smash_works_win64}/VapourSynth/vslsmashsource.dll" "${package_l_smash_works}/VapourSynth/x64"
    cp "${sandbox_l_smash_works_win32}/AviUtl/LICENSE" "${package_l_smash_works}/LICENSE.txt"
    cp "${sandbox_l_smash_works_win32}/AviUtl/README" "${package_l_smash_works}/README.txt"
    cp "${sandbox_l_smash_works_win32}/AviUtl/README.ja" "${package_l_smash_works}/README.ja.txt"
    cp "${sandbox_l_smash_works_win32}/VapourSynth/LICENSE" "${package_l_smash_works}/VapourSynth/LICENSE.txt"
    cp "${sandbox_l_smash_works_win32}/VapourSynth/README" "${package_l_smash_works}/VapourSynth/README.txt"
fi
