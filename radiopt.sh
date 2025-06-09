#!/usr/bin/bash

get_help() {
echo "
        Um programa CLI para ouvir rádios online portuguesas
        (English) A CLI program to listen to Portuguese online radio stations

        Usage:
                radiopt [OPTION/RADIO]

        Options:
                -h|--help ) Mostra esta mensagem
                -v|--version) Mostra a versão do programa
                --no-verbose) Não mostra o output do MPV
                --save) Salva o audio num arquivo.mp3 expecificado pelo usuário
        (English)
                -h|--help) Show this message
                -v|--version) Show the program version
                --no-verbose) Don't show MPV output
                --save) Saves audio to a user-specified .mp3 file

        Radios:
                m80
                m80-60s
                m80-70s
                m80-80s
                m80-90s
                m80-rock
                m80-ball (Ballads)
                m80-pop
                m80-dance
                m80-indie
                m80-port (Portugal)
                m80-bras (Brasil)
                m80-disco
                m80-soul
                cidade_fm
                cidade_hiphop
                cidade_latina
                rfm
                rfm-80s
                rfm-dance
                rfm-rock
                rfm-pacific (Oceano Pacifico)
                renascenca
                smoothfm
                smoothfm-vjazz (Vocal Jazz)
                smoothfm-soul
                smoothfm-blues
                smoothfm-bosno (Bossa Nova)
                smoothfm-jazz
                smoothfm-cool
                radiocomercial
                radiocomercial-rock
                radiocomercial-dance
                radiocomercial-bynight
                radiocomercial-ohw (One Hit Wonders)
                radiocomercial-kids
                radiocomercial-port (Portugal)
                radiocomercial-bras (Brasil)
                radiocomercial-90s
                radiocomercial-2ks (2000s)
                radiocomercial-sanpop (Santos Populares)
                batida
"
}


bauermedia() {
        # $1 = NO_VERBOSE
        # #2 = SAVE
        # $3 = FILE_MP3
        # $4 = Bauermedia radio ID
        PLAY_AUDIO_QUIET=" "
        FETCH_URL_QUIET=" "
        FETCH_NOQUIET_URL=" "
        SAVE_MP3=" "
        # Special URLs (no bauermedia)
        case $4 in 
                "rfm") URL="https://playerservices.streamtheworld.com/api/livestream-redirect/RFMAAC.aac" ;;
                "rfm-rock") URL="https://playerservices.streamtheworld.com/api/livestream-redirect/RFMONTHEROCKAAC.aac" ;;
                "rfm-pacific") URL="https://playerservices.streamtheworld.com/api/livestream-redirect/OCEANPACIFICAAC.aac" ;;
                "rfm-80s") URL="https://22533.live.streamtheworld.com/GR80SRFMAAC" ;;
                "renascenca") URL="https://25643.live.streamtheworld.com/RADIO_RENASCENCAAAC" ;;
                *) URL="\"https://bauermedia.pt/radiostream.aspx?radio=$4&type=MP3\" "
        esac
        # No verbose
        if [ "$1" == "true" ]; then                
                PLAY_AUDIO_QUIET='| ffplay -nodisp -autoexit -loglevel quiet -' 
                FETCH_URL_QUIET="
                ffmpeg -loglevel \
                        quiet -hide_banner \
                        -i $URL \
                        -f mp3 pipe:1"
        fi
        # Save in a file:
        if [ "$2" == "true" ]; then
                 SAVE_MP3=" | tee \"$3\".mp3"
        fi
        if [ "$1" == "false" ]; then
                FETCH_NOQUIET_URL="ffmpeg -i $URL -f mp3 pipe:1"
                PLAY_AUDIO='| ffplay -'
        fi
        COMMAND=$(printf "%s %s %s %s %s" "$FETCH_NOQUIET_URL" "$FETCH_URL_QUIET" "$SAVE_MP3" "$PLAY_AUDIO_QUIET" "$PLAY_AUDIO" | sed "s/'//g")
        eval "$COMMAND"
}

argument_manage() {
# Set all variablles to false
LOOP_NUM=0
NO_VERBOSE="false"
RADIO_ID="false"
SAVE="false"
FILE_MP3="false"
FIND_FILE="false"
# Saturated variables
SAVE_SATU="false"
NO_VERBOSE_SATU="false"
RADIO_ID_SATU="false"
for i in "$@"; do  
        LOOP_NUM=$((LOOP_NUM+1))
   case $i in 
           --no-verbose) 
                   if [ "$NO_VERBOSE_SATU" == "false" ]; then
                   NO_VERBOSE="true"
                   NO_VERBOSE_SATU="saturate"
                   fi
                   ;;
           --save)
                   if [ "$SAVE_SATU" == "false" ]; then
                   SAVE="true"
                   SAVE_SATU="saturate"
                   FIND_FILE="true"
                   fi
                   ;;
           *)
                   if [ "$LOOP_NUM" == 1 ]; then
                   if [ "$RADIO_ID_SATU" == "false" ]; then
                        RADIO_ID=$i
                        RADIO_ID_SATU="saturate"
                   fi
                elif [ "$FIND_FILE" == "true" ]; then
                       FILE_MP3=$i                         
                       FIND_FILE="saturate"
                   fi

   esac
done
        bauermedia "$NO_VERBOSE" "$SAVE" "$FILE_MP3" "$RADIO_ID"
}

get_version() {
        echo "radiopt version 0.1.2"
}

select_radio() {
case "$1" in
        "-h"|"--help") get_help ;;
        "-v"|"--version") get_version ;;
        # M80
        "m80") echo "Playing M80"  && argument_manage 30 "$@" ;;
        "m80-rock") echo "Playing M80 Rock"  && argument_manage 43 "$@" ;;
        "m80-80s") echo "Playing M80 80s" && argument_manage 35 "$@" ;;
        "m80-70s") echo "Playing M80 70s" && argument_manage 34 "$@" ;;
        "m80-90s") echo "Playing M80 90s" && argument_manage 36 "$@" ;;
        "m80-ball") echo "Playing M80 Ballads" && argument_manage 47 "$@" ;;
        "m80-pop") echo "Playing M80 Pop" && argument_manage 41 "$@" ;;
        "m80-dance") echo "Playing M80 Dance" && argument_manage 40 "$@" ;;
        "m80-indie") echo "Playing M80 Indie" && argument_manage 39 "$@" ;;
        "m80-port") echo "Playing M80 Portugal" && argument_manage 42 "$@" ;;
        "m80-bras") echo "Playing M80 Brasil" && argument_manage 80 "$@" ;;
        "m80-disco") echo "Playing M80 Disco" && argument_manage 75 "$@" ;;
        "m80-soul") echo "Playing M80 Soul" && argument_manage 44 "$@" ;;
        "m80-60s") echo "Playing M80 60s" && argument_manage 33 "$@" ;;
        # RFM
        "rfm") echo "Playing RFM" && argument_manage "rfm" "$@" ;;
        "rfm-rock") echo "Playing RFM Rock" && argument_manage "rfm-rock" "$@" ;;
        "rfm-dance") echo "Playing RFM Dance On The Floor" && argument_manage "rfm-dance" "$@" ;;
        "rfm-80s") echo "Playing RFM 80s" && argument_manage "rfm-80s" "$@" ;;
        "rfm-pacific") echo "Playing RFM Oceno Pacifico" && argument_manage "rfm-pacific" "$@" ;;
        # Renascenca
        "renascenca") echo "Playing Radio Renascenca" && argument_manage "renascenca" "$@" ;;
        # Cidade "$2" "$3" "$4" FM
        "cidade_fm") echo "Playing CidadeFM" && argument_manage 15 "$@" ;;
        "cidade_hiphop") echo "Playing Cidade_hip_hop" && argument_manage 59 "$@" ;;
        "cidade_latina") echo "Playing Cidade_latina" && argument_manage 78 "$@" ;;
        # Smooth"$2" "$3" "$4" FM
        "smoothfm") echo "Playing SmoothFM" && argument_manage 32 "$@" ;;
        "smoothfm-vjazz") echo "Playing SmoothFM Vocal Jazz" && argument_manage 63 "$@" ;;
        "smoothfm-soul") echo "Playing SmoothFM Soul" && argument_manage 56 "$@" ;;
        "smoothfm-blues") echo "Playing SmoothFM Blues" && argument_manage 37 "$@" ;;
        "smoothfm-bosno") echo "Playing SmoothFM Bossa Nova" && argument_manage 38 "$@" ;;
        "smoothfm-jazz") echo "Playing SmoothFM Jazz" && argument_manage 67 "$@" ;;
        "smoothfm-cool") echo "Playing SmoothFM Cool" && argument_manage 72 "$@" ;;
        # RadioComerci"$2" "$3" "$4" al
        "radiocomercial") echo "Playing Radio Comercial" && argument_manage 11 "$@" ;;
        "radiocomercial-rock") echo "Playing Radio Comercial Rock" && argument_manage 55 "$@" ;;
        "radiocomercial-dance") echo "Playing Radio Comercial Dance" && argument_manage 53 "$@" ;;
        "radiocomercial-bynight") echo "Playing Radio Comercial By Night" && argument_manage 65 "$@" ;;
        "radiocomercial-kids") echo "Playing Radio Comercial Kids" && argument_manage 76 "$@" ;;
        "radiocomercial-port") echo "Playing Radio Comercial Portugal" && argument_manage 64 "$@" ;;
        "radiocomercial-bras") echo "Playing Radio Comercial Brasil" && argument_manage 73 "$@" ;;
        "radiocomercial-90s") echo "Playing Radio Comercial 90s" && argument_manage 69 "$@" ;;
        "radiocomercial-2ks") echo "Playing Radio Comercial 2000s" && argument_manage 68 "$@" ;;
        "radiocomercial-sanpop") echo "Playing Radio Comercial Santos Populares" && argument_manage 79 "$@" ;;



        "batida") echo "Playing Batida" && argument_manage 82 "$2" ;;
        *) echo "Option not found: $1" 
esac
}

select_radio "$@"
