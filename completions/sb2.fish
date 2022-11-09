# Completions for the `sb2` (scratchbox2) command

# Options listed by sb2 -h
set -l __sb2_opts v L= d h t= e m= M= n= s= Q= O= R U= p S= J= D= P= W= c C= T= u g G= b= B= q N x=

function __fish_sb2_print_provided_target --inherit-variable __sb2_opts
    set -l tokens (commandline -opc) (commandline -ct)
    set -e tokens[1]
    argparse -s $__sb2_opts -- $tokens 2>/dev/null

    if test -n "$_flag_t"
        echo "$_flag_t"
    end
end

function __fish_sb2_complete_local_executables
    set -l target $argv[1]

    # No target was provided by user, try to get name of default target
    # without sb2 invocation
    if test -z "$target"
        if not test -r ~/.scratchbox2/config
            # There is no scratchbox2 configuration, so no way to get default
            # target and provide completions
            return 1
        end

        set -l default (cat ~/.scratchbox2/config | string match -r 'DEFAULT_TARGET=(\S+)')
        set target $default[-1]

        if test -z "$target"
            return 1
        end
    end

    set -l target_path $SFOSSDK_PLATFORM_SDK_PATH/../../targets/$target

    if test -d $target_path
        find $target_path/{bin,usr/bin} -maxdepth 1 -executable -printf '%f\n'
    end
end

function __fish_sb2_complete_executable_path --description "Complete using path"
    set -l targets (path filter -x "$argv[1]"*)
    if set -q targets[1]
        # Use ls to append '/' to directories
        printf "%s\n" (command ls -dp $targets)
    end
end

function __fish_sb2_print_remaining_args --inherit-variable __sb2_opts
    set -l tokens (commandline -opc) (commandline -ct)
    set -e tokens[1]
    argparse -s $__sb2_opts -- $tokens 2>/dev/null
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

function __fish_sb2_no_subcommand
    not __fish_sb2_print_remaining_args >/dev/null
end

function __fish_complete_sb2_subcommand
    set -l args (__fish_sb2_print_remaining_args | string split0)

    if test (count $args) -le 1
        set -l target_name (__fish_sb2_print_provided_target)

        if test "$SFOSSDK_USE_VM" = "y"
            if test -n "$target_name"
                set target -t $target_name
            end
            # List all executables, removing output from sb2 command itself
            # (like 'Mounting system directories...' and stuff like that).
            sdk sb2 $target find /bin/ /usr/bin/ -maxdepth 1 -executable 2>/dev/null | tr -d '\015' | xargs -n 1 basename
        else
            # When using locally installed platform sdk, try to provide
            # significantly faster completions
            __fish_sb2_complete_local_executables $target_name
        end

        # Add executable files from the current directory
        __fish_sb2_complete_executable_path $args[1]
    else
        __fish_complete_subcommand --commandline $args
    end
end

function __fish_complete_sb2_mode
    if test "$SFOSSDK_USE_VM" = "y"
        sdk ls -1 /usr/share/scratchbox2/modes/ 2>/dev/null | tr -d '\015'
    else
        ls $SFOSSDK_PLATFORM_SDK_PATH/usr/share/scratchbox2/modes/
    end
end

function __fish_complete_sb2_net_mode
    if test "$SFOSSDK_USE_VM" = "y"
        sdk ls -1 /usr/share/scratchbox2/net_rules/ 2>/dev/null | tr -d '\015'
    else
        ls $SFOSSDK_PLATFORM_SDK_PATH/usr/share/scratchbox2/net_rules/
    end
end

complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s v -d "Display version"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s L -d "Enable logging with level" \
    -xa "error warning notice net info debug noise noise2 noise3"d
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s t -d "Target to use" \
    -xa "(__fish_complete_sb2_target)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s e -d "Use 'emulation' mapping mode"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s m -d "Use specified mapping mode" \
    -xa "(__fish_complete_sb2_mode)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s m -d "Read mapping rules from file"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s n -d "Use specified mapping mode" \
    -xa "(__fish_complete_sb2_net_mode)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s s -d "Load mapping scripts from alternative location" \
    -xa "(__fish_complete_directories)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s Q -d "Emulate bugs of the old scratchbox 1" \
    -xa "x"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s O -d "Set options for the selected mapping mode"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s R -d "Use simulated root permissions"
complete -x -c sb2 -n "__fish_sb2_no_subcommand" -s U -d "Use UID and GID as owner and group of 'unknown' files"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s p -d "Do not simulate special FS privileges of the 'root' user with -R option"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s S -d "Write session information to file"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s J -d "Don't create a new session; join an existing one"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s D -d "Delete an old session"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s P -d "Print all logs related to a persistent session"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s W -d "Use specified path as the session directory"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s c -d "Create a private copy of target_root"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s C -d "Create copy of specified directory and use it as the target_root" \
    -xa "(__fish_complete_directories)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s T -d "Override tools_root with specified directory" \
    -xa "(__fish_complete_directories)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s u -d "Disable automatic configuration upgrade"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s g -d "Create a new session with setsid()"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s G -d "Append process group number to file"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s b -d "Produce graphs and log summaries to directory" \
    -xa "(__fish_complete_directories)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s b -d "Produce graphs and log summaries (including process accounting data)" \
    -xa "(__fish_complete_directories)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s q -d "Be quiet (don't print debugging details to stdout)"
complete -f -c sb2 -n "__fish_sb2_no_subcommand" -s N -d "Do not delete the session dir (even on sb2 fail)"
complete -r -c sb2 -n "__fish_sb2_no_subcommand" -s x -d "Specify additional options for sb2d"

# Complete the command we are executing under sb2
complete -c sb2 -xa "(__fish_complete_sb2_subcommand)"
