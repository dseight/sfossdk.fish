# Completions for the `mb2` command

set -l cmds build-requires prepare apply build qmake cmake make make-install package build-shell compiledb check deploy undeploy

# mb2
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -x
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l help -d "Show help"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s i -l increment -d "Increment release number in .spec file"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s t -l target -d "Specify the sb2 target to use" \
    -xa "(__fish_complete_sb2_target)"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s d -l device -d "Specify the device"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s o -l output-dir -d "Override output directory (default: RPMS)" \
    -xa "(__fish_complete_directories)"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s O -l output-prefix -d "Like '--output-dir', but with target subdirectory" \
    -xa "(__fish_complete_directories)"
# XXX: Maybe add some parsing for option arguments with "=" sign?
# There are a lot of options requiring this.
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l search-output-dir -d "Use output directory to search dependencies (verbose by default)"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l search-output-dir=verbose -d "Use output directory to search dependencies"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l search-output-dir=quiet -d "Use output directory to search dependencies"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l no-search-output-dir -d "Override '--search-output-dir' option"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s s -l specfile -d "Specify the .spec file" \
    -xa "(__fish_complete_suffix .spec)"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s S -l snapshot -d "Use target snapshot"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l no-snapshot -d "Force mb2 to directly use a target"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s f -l shared-folder -d "Directory where QtCreator shares devices.xml and ssh keys"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s T -l task -d "Task name or git regex"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l no-task -d "Override --task option"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -l wrap -d "Use the given wrapper as a replacement for the command"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s x -l fix-version -d "Derive package version from the latest tag in current git branch"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s X -l no-fix-version -d "Override --fix-version option"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s n -l no-deps -d "Do not update target dependencies"
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -s c -l git-change-log -d "Include change log generated from Git history"

# mb2 build-requires
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a build-requires -d "Install or update build-time dependencies"
complete -f -c mb2 -n "__fish_seen_subcommand_from build-requires" -l no-refresh -d "Do not refresh package cache"
complete -f -c mb2 -n "__fish_seen_subcommand_from build-requires; and __fish_contains_opt snapshot" -l refresh -d "Do not use unless you know what you are doing"
complete -f -c mb2 -n "__fish_seen_subcommand_from build-requires" -a pull -d "Install or update the build-time dependencies"
complete -f -c mb2 -n "__fish_seen_subcommand_from build-requires; and __fish_contains_opt snapshot" -a reset -d "Reset target snapshot to the (possibly updated) state of the original target"

# mb2 prepare
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a prepare -d "Execute %prep section of the .spec"

# mb2 apply
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a apply -d "Apply all patches defined in the .spec"
complete -f -c mb2 -n "__fish_seen_subcommand_from apply" -s R -d "Reverse apply patches"

# mb2 build
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a build -d "Run rpmbuild (except for %prep section)"
complete -f -c mb2 -n "__fish_seen_subcommand_from build" -s p -l doprep -d "Run %prep phase as well"
complete -f -c mb2 -n "__fish_seen_subcommand_from build" -l no-check -d "Skip the %check section and rpmlint"
complete -f -c mb2 -n "__fish_seen_subcommand_from build" -s d -l enable-debug -d "Enable debug build"
complete -f -c mb2 -n "__fish_seen_subcommand_from build" -s j -x -d "Number of concurrent jobs"

# mb2 qmake
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a qmake -d "Execute %build section of the .spec"

# mb2 cmake
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a cmake -d "Execute %build section of the .spec"
complete -f -c mb2 -n "__fish_seen_subcommand_from cmake" -l build -d "Run cmake --build"

# mb2 make
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a make -d "Execute %build section, suppressing qmake or cmake invocations"

# mb2 make-install
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a make-install -d "Execute %install section of the .spec"

# mb2 package
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a package -d "Execute %install section and build binary packages"

# mb2 build-shell
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a build-shell -d "Execute command in the build environment"

# mb2 compiledb
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a compiledb -d "Generate Compilation Database"

# mb2 check
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a check -d "Perform quality checks"
complete -f -c mb2 -n "__fish_seen_subcommand_from check" -l list-suites -d "List available test suites"
complete -f -c mb2 -n "__fish_seen_subcommand_from check" -s l -l levels -d "Select testing levels" \
    -xa "source package static unit system dynamic"
complete -f -c mb2 -n "__fish_seen_subcommand_from check" -s s -l suites -d "Select test suites to use"

# mb2 deploy
set -l mb2_rpm_deploy_methods pkcon sdk zypper manual
set -l mb2_deploy_methods $mb2_rpm_deploy_methods rsync
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a deploy -d "Deploy build results to device"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_deploy_methods" -l pkcon -d "Use 'pkcon' to install RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_deploy_methods" -l rsync -d "Use 'rsync' to copy the installed files under '/opt/sdk/<name>'"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_deploy_methods" -l sdk -d "Use method native to the SDK to install RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_deploy_methods" -l zypper -d "Use 'zypper' to install RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_deploy_methods" -l manual -d "Only transfers the RPM package(s) to '~/RPMS' directory on the device"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and __fish_contains_opt $mb2_rpm_deploy_methods" -l all -d "Deploy all packages found under the output directory"

# mb2 undeploy
set -l mb2_undeploy_methods pkcon rpm rsync zypper
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a deploy -d "Deploy build results to device"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_undeploy_methods" -l pkcon -d "Use 'pkcon' to remove RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_undeploy_methods" -l rpm -d "Use plain 'rpm' to remove RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_undeploy_methods" -l rsync -d "Remove files previously copied under '/opt/sdk'"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and not __fish_contains_opt $mb2_undeploy_methods" -l zypper -d "Use 'zypper' to remove RPM package(s)"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and __fish_contains_opt $mb2_undeploy_methods" -l all -d "Remove any build results originated from this build host"
complete -f -c mb2 -n "__fish_seen_subcommand_from deploy; and __fish_contains_opt $mb2_undeploy_methods" -s n -l dry-run -d "Only list packages to be removed"

# mb2 run
complete -f -c mb2 -n "not __fish_seen_subcommand_from $cmds" -a run -d "Run command on the device"
