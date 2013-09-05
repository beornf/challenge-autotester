# Bash completion for challenges

_challenge()
{
    if [ $COMP_CWORD -lt 3 ]; then
        local cur=${COMP_WORDS[COMP_CWORD]}
        if [ $COMP_CWORD -eq 1 ]; then
            local opt=""
            for lang in `ls -d *-src/`
            do
                opt+=`echo " $lang" | cut -d'-' -f 1`
            done
        else
            local sel=`ls ${COMP_WORDS[COMP_CWORD-1]}-src`
            local opt="all"
            for file in `ls abstract`
            do
                local pass=`echo $sel | grep $file -c`
                if [ $pass -eq 1 ]; then
                    opt+=" $file"
                fi
            done
        fi
        COMPREPLY=($(compgen -W "$opt" -- $cur))
    fi
}
complete -F _challenge challenge
