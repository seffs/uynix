#video_pref="248+bestaudio/best"

#video_player="/usr/local/bin/mpv"

#video_player="/Applications/IINA.app/Contents/MacOS/iina-cli"

#video_player_format="/Applications/IINA.app/Contents/MacOS/iina-cli --mpv-ytdl-format="

#audio_player="/Applications/IINA.app/Contents/MacOS/iina-cli --mpv--no-video"

video_player () {
    # this function should not be set as the url_handler as it is part of multimedia_player
    command_exists "mpv" || die 3 "mpv is not installed\n"
    [ "$is_detach" -eq 1 ] && use_detach_cmd=detach_cmd || use_detach_cmd=''
    # shellcheck disable=SC2086
    $use_detach_cmd /opt/local/bin/mpv --ytdl-format="$ytdl_pref" $url_handler_opts "$@"
}
