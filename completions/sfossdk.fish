# Completions for Sailfish SDK, based on the sudo completions

function __fish_sfossdk_print_remaining_args
    set -l tokens (commandline -opc) (commandline -ct)
    set -e tokens[1]
    set -l opts u= m= r= h
    argparse -s $opts -- $tokens 2>/dev/null
    # The remaining argv is the subcommand with all its options, which is what
    # we want.
    if test -n "$argv"
        and not string match -qr '^-' $argv[1]
        string join0 -- $argv
        return 0
    else
        return 1
    end
end

function __fish_sfossdk_no_subcommand
    not __fish_sfossdk_print_remaining_args >/dev/null
end

function __fish_complete_sfossdk_subcommand
    set -l args (__fish_sfossdk_print_remaining_args | string split0)

    if test (count $args) -le 1
        if test "$SFOSSDK_USE_VM" = "y"
            sdk find /bin/ /usr/bin/ -maxdepth 1 -executable -type f 2>/dev/null | tr -d '\015' | xargs -n 1 basename
        else
            find $SFOSSDK_PLATFORM_SDK_PATH/{bin,usr/bin} -maxdepth 1 -executable -printf '%f\n'
        end
    else
        __fish_complete_subcommand --commandline $args
    end
end

complete -c sdk -n "__fish_no_arguments" -s h -f -d "Display help and exit"
complete -c sdk -n "__fish_sfossdk_no_subcommand" -s u -xa "(__fish_complete_users)" -d "System user to link into SDK"
complete -c sdk -n "__fish_sfossdk_no_subcommand" -s m -xa "none all root home" -d "Devices to bind mount from host"
complete -c sdk -n "__fish_sfossdk_no_subcommand" -s r -xa "(__fish_complete_directories)" -d "The root of the SDK to use"

# Complete the command we are executing under sdk
complete -c sdk -xa "(__fish_complete_sfossdk_subcommand)"
