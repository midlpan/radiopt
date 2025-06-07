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
if [ "$2" == "--save" ]; then
        if [ "$4" == "--no-verbose" ]; then
                 ffmpeg -loglevel quiet -hide_banner -i "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3" -f mp3 pipe:1 | tee "$3".mp3| ffplay -nodisp -autoexit -loglevel quiet -
                 exit
        else
                ffmpeg -i "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3" -f mp3 pipe:1 | tee "$3".mp3 | ffplay -
                exit
        fi
fi


if [ "$2" == "--no-verbose" ]; then
        if [ "$3" == "--save" ]; then
                ffmpeg -loglevel quiet -hide_banner -i "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3" -f mp3 pipe:1  | tee "$4".mp3 | ffplay -nodisp -autoexit -loglevel quiet -
                exit
        fi
        mpv --force-seekable=yes "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3" &>/dev/null      
        exit
else 
        if [ "$2" == "--save" ]; then 
                ffmpeg -i "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3" -f mp3 pipe:1 | tee "$3".mp3 | ffplay -
                exit
        fi
        mpv --force-seekable=yes "https://bauermedia.pt/radiostream.aspx?radio=$1&type=MP3"
        exit
fi
}

get_version() {
        echo "radiopt version 0.1.0"
}

select_radio() {
case "$1" in
        "-h"|"--help") get_help ;;
        "-v"|"--version") get_version ;;
        # M80
        "m80") echo "Playing M80"  && bauermedia 30 "$2" "$3" "$4" ;;
        "m80-rock") echo "Playing M80 Rock"  && bauermedia 43 "$2" "$3" "$4" ;;
        "m80-80s") echo "Playing M80 80s" && bauermedia 35 "$2" "$3" "$4" ;;
        "m80-70s") echo "Playing M80 70s" && bauermedia 34 "$2" "$3" "$4" ;;
        "m80-90s") echo "Playing M80 90s" && bauermedia 36 "$2" "$3" "$4" ;;
        "m80-ball") echo "Playing M80 Ballads" && bauermedia 47 "$2" "$3" "$4" ;;
        "m80-pop") echo "Playing M80 Pop" && bauermedia 41 "$2" "$3" "$4" ;;
        "m80-dance") echo "Playing M80 Dance" && bauermedia 40 "$2" "$3" "$4" ;;
        "m80-indie") echo "Playing M80 Indie" && bauermedia 39 "$2" "$3" "$4" ;;
        "m80-port") echo "Playing M80 Portugal" && bauermedia 42 "$2" "$3" "$4" ;;
        "m80-bras") echo "Playing M80 Brasil" && bauermedia 80 "$2" "$3" "$4" ;;
        "m80-disco") echo "Playing M80 Disco" && bauermedia 75 "$2" "$3" "$4" ;;
        "m80-soul") echo "Playing M80 Soul" && bauermedia 44 "$2" "$3" "$4" ;;
        "m80-60s") echo "Playing M80 60s" && bauermedia 33 "$2" "$3" "$4" ;;
        # Cidade "$2" "$3" "$4" FM
        "cidade_fm") echo "Playing CidadeFM" && bauermedia 15 "$2" "$3" "$4" ;;
        "cidade_hiphop") echo "Playing Cidade_hip_hop" && bauermedia 59 "$2" "$3" "$4" ;;
        "cidade_latina") echo "Playing Cidade_latina" && bauermedia 78 "$2" "$3" "$4" ;;
        # Smooth"$2" "$3" "$4" FM
        "smoothfm") echo "Playing SmoothFM" && bauermedia 32 "$2" "$3" "$4" ;;
        "smoothfm-vjazz") echo "Playing SmoothFM Vocal Jazz" && bauermedia 63 "$2" "$3" "$4" ;;
        "smoothfm-soul") echo "Playing SmoothFM Soul" && bauermedia 56 "$2" "$3" "$4" ;;
        "smoothfm-blues") echo "Playing SmoothFM Blues" && bauermedia 37 "$2" "$3" "$4" ;;
        "smoothfm-bosno") echo "Playing SmoothFM Bossa Nova" && bauermedia 38 "$2" "$3" "$4" ;;
        "smoothfm-jazz") echo "Playing SmoothFM Jazz" && bauermedia 67 "$2" "$3" "$4" ;;
        "smoothfm-cool") echo "Playing SmoothFM Cool" && bauermedia 72 "$2" "$3" "$4" ;;
        # RadioComerci"$2" "$3" "$4" al
        "radiocomercial") echo "Playing Radio Comercial" && bauermedia 11 "$2" "$3" "$4" ;;
        "radiocomercial-rock") echo "Playing Radio Comercial Rock" && bauermedia 55 "$2" "$3" "$4" ;;
        "radiocomercial-dance") echo "Playing Radio Comercial Dance" && bauermedia 53 "$2" "$3" "$4" ;;
        "radiocomercial-bynight") echo "Playing Radio Comercial By Night" && bauermedia 65 "$2" "$3" "$4" ;;
        "radiocomercial-kids") echo "Playing Radio Comercial Kids" && bauermedia 76 "$2" "$3" "$4" ;;
        "radiocomercial-port") echo "Playing Radio Comercial Portugal" && bauermedia 64 "$2" "$3" "$4" ;;
        "radiocomercial-bras") echo "Playing Radio Comercial Brasil" && bauermedia 73 "$2" "$3" "$4" ;;
        "radiocomercial-90s") echo "Playing Radio Comercial 90s" && bauermedia 69 "$2" "$3" "$4" ;;
        "radiocomercial-2ks") echo "Playing Radio Comercial 2000s" && bauermedia 68 "$2" "$3" "$4" ;;
        "radiocomercial-sanpop") echo "Playing Radio Comercial Santos Populares" && bauermedia 79 "$2" "$3" "$4" ;;



        "batida") echo "Playing Batida" && bauermedia 82 "$2" ;;
        *) echo "Option not found: $1" 
esac
}

select_radio "$1" "$2" "$3" "$4"
