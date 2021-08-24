#!/bin/bash

#### FUNCTION DEFINING AREA ####
go_live() {
    echo -e "\e[1mStarting modules for mixing audio sinks-sources...\e[0m"

    loading_modules=("module-null-sink sink_name=Virtual1" "module-loopback source=@DEFAULT_SOURCE@ sink=Virtual1" "module-loopback source=Virtual1.monitor sink=@DEFAULT_SINK@")

    for i in "${loading_modules[@]}"; do
        pactl load-module $i | tr '\n' ' ' >>/tmp/discordgolive_module_codes
    done

    echo -e "\e[1mMutting physical mic so streaming audio goes clear\e[0m"
        pactl set-source-mute @DEFAULT_SOURCE@ 1
    echo "--------------------------------------"
    echo -e "\e[1m\e[92mDone ✅ \e[0m"
}

stop_live() {
    if [ $# == 1 -a /tmp/discordgolive_module_codes ]; then
        echo -e "\e[1mUndoing virtual sink...\e[0m"

        mod_num=`/bin/cat /tmp/discordgolive_module_codes`
        for i in $mod_num; do
            pactl unload-module $i
        done
        
        echo -e "\e[1mUnmutting mic\e[0m"
            pactl set-source-mute @DEFAULT_SOURCE@ 0
            pactl set-source-volume @DEFAULT_SOURCE@ 39%
        echo "--------------------------------------"

        echo -e "\e[1m\e[92mDone ✅\e[0m"
    else
        echo -e "\e[1m\e[91mERROR: NOT INPUT MODULES FILE\e[0m"
        echo -e "\e[1m\e[93mAre you sure you've run Go Live first?\e[0m"
    fi
}

pulse_restart() {
    echo -e "\e[1mAre you sure you wanna restart PulseAudio?\e[0m"
    select reset_pulse in "Yes" "No, return to the main menu"; do
        if [ $REPLY == 1 ]; then
            echo "    Restarting Pulse..."
            pulseaudio --kill && pulseaudio --start
            echo -e "\e[1m\e[92m    Done \e[0m"
            break
        elif [ $REPLY == 2 ]; then
            clear
            break
        else
            echo "Select a valid option"
        fi
    done
}

mute_unmute() {
    echo -e "\e[1mSelect an option:\e[0m"
    select manually_control_mic in "Mute" "Unmute" "Return to the main menu"; do
        if [ $REPLY == 1 ]; then
            echo -e "\e[1m    Muting mic\e[0m"
            pactl set-source-mute @DEFAULT_SOURCE@ 1
            echo -e "\e[1m\e[92m    Done \e[0m"
            break
        elif [ $REPLY == 2 ]; then
            echo -e "\e[1m    Unmuting mic\e[0m"
            pactl set-source-mute @DEFAULT_SOURCE@ 0
            pactl set-source-volume @DEFAULT_SOURCE@ 39%
            echo -e "\e[1m\e[92m    Done \e[0m"
            break
        elif [ $REPLY == 3 ]; then
            clear
            break
        else
            echo "Select a valid option"
        fi
    done
}

#### MAIN PROGRAM AREA ####
echo -e "\e[1m\e[7;49;33mWelcome to Discord Go Live\e[0m"
while true; do
    echo -e "\e[1mPlease select the number of choose:\e[0m"
    echo -e "+-----------------------------------------+"
    echo -en "1) Go Live\n2) Stop Live\n3) Reset PulseAudio\n4) Manually mute or unmute\n5) Exit\nInput: "
    read menu_option
    if [ $menu_option ]; then
        if [ $menu_option == 1 ]; then
            go_live
        elif [ $menu_option == 2 ]; then
            stop_live /tmp/discordgolive_module_codes
        elif [ $menu_option == 3 ]; then
            pulse_restart
        elif [ $menu_option == 4 ]; then
            mute_unmute
        elif [ $menu_option == 5 ]; then
            exit 0
        else
            echo "Select a valid option"
        fi
    fi
done