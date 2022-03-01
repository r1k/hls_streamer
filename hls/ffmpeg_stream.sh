#!/bin/sh
# for Linux

DATA_DIR="/root/hls/data"

rm -rf $DATA_DIR || true
mkdir -p $DATA_DIR || true

ffmpeg -i input -f mpegts udp://$SRC_UDP?pkt_size=188&buffer_size=65535 \
       -c:v libx264 -vf format=yuv420p -preset veryfast -b:v 1000k \
       -b:a 128k \
       -f hls \
       -hls_list_size 5 \
       -hls_flags independent_segments \
       -hls_flags delete_segments \
       -hls_segment_type mpegts \
       -hls_segment_filename $DATA_DIR/segment_%05d.ts \
       -hls_base_url $ROOT_URL/data/  $DATA_DIR/playlist.m3u8