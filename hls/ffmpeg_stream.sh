#!/bin/sh
# for Linux

DATA_DIR="/root/hls/web/data"

mkdir -p $DATA_DIR || true
rm -rf $DATA_DIR/*.ts $DATA_DIR/*.m3u8 || true

# Hardware accelerated - not working
#ffmpeg -i udp://"${SRC_UDP}" \
#       -c:v h264_vaapi -vaapi_device /dev/dri/card0 -vf 'format=nv12|vaapi,hwupload,scale_vaapi=w=1280:h=720' -b:v 1M \
#       -c:a aac -b:a 128k \
#       -f hls \
#       -hls_list_size 5 \
#       -hls_flags independent_segments \
#       -hls_flags delete_segments \
#       -hls_segment_type mpegts \
#       -hls_segment_filename $DATA_DIR/segment_%05d.ts \
#       -hls_base_url $ROOT_URL/data/  $DATA_DIR/playlist.m3u8

# Transcode variant
#ffmpeg -i udp://"${SRC_UDP}" \
#       -c:v libx264 -x264-params "nal-hrd=cbr" -vf format=yuv420p,scale=-1:720 -preset veryfast -b:v 1M -minrate 1M -maxrate 1M -bufsize 2M \
#       -c:a aac -b:a 128k \
#       -f hls \
#       -hls_list_size 5 \
#       -hls_flags independent_segments \
#       -hls_flags delete_segments \
#       -hls_segment_type mpegts \
#       -hls_segment_filename $DATA_DIR/segment_%05d.ts \
#       -hls_base_url $ROOT_URL/data/  $DATA_DIR/playlist.m3u8

# Copy original encoding
ffmpeg -i udp://"${SRC_UDP}" \
       -c:v copy \
       -c:a aac -b:a 128k \
       -f hls \
       -hls_list_size 5 \
       -hls_flags independent_segments \
       -hls_flags delete_segments \
       -hls_segment_type mpegts \
       -hls_segment_filename $DATA_DIR/segment_%05d.ts \
       -hls_base_url $ROOT_URL/data/  $DATA_DIR/playlist.m3u8