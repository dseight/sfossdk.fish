# Completions for the `sb2-config` command

set -l cmds showtarget showlog showenv setenv clearenv unsetenv

# Options
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -x
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s h -d "Show help"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s l -d "List all targets"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s f -d "List accessible (found) targets"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s d -d "Set default target" \
    -xa "(__fish_complete_sb2_target)"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s t -d "Set target to configure" \
    -xa "(__fish_complete_sb2_target)"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -s v -d "Display version"

# Commands
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a showtarget -d "Show default target"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a showlog -d "Show configuration log"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a showenv -d "Show target environment variables"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a setenv -d "Set target environment variable"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a clearenv -d "Set clearing for target environment variable"
complete -f -c sb2-config -n "not __fish_seen_subcommand_from $cmds" -a unsetenv -d "Remove target environment variable"
