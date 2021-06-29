set -q SFOSSDK_PLATFORM_SDK_PATH
    or set -gx SFOSSDK_PLATFORM_SDK_PATH /srv/mer/sdks/sfossdk

# Set to "y" if you are using VM SDK (which is shipped with application SDK),
# otherwise local SDK will be used.
set -q SFOSSDK_USE_VM
    or set -gx SFOSSDK_USE_VM n

# There is no way to run Platform SDK natively on Darwin, so always use VM
if test (uname) = Darwin
    set SFOSSDK_USE_VM y
end

# Following variables are used only with VM SDK (not with local SDK)
set -q SFOSSDK_VM_ROOT
    or set -gx SFOSSDK_VM_ROOT ~/SailfishOS
set -q SFOSSDK_VM_NAME
    or set -gx SFOSSDK_VM_NAME "Sailfish OS Build Engine"
set -q SFOSSDK_VM_USER
    or set -gx SFOSSDK_VM_USER mersdk
set -q SFOSSDK_VM_HOST
    or set -gx SFOSSDK_VM_HOST localhost
set -q SFOSSDK_VM_PORT
    or set -gx SFOSSDK_VM_PORT 2222

function sfossdkstart
    VBoxManage startvm $SFOSSDK_VM_NAME --type headless
end

function sfossdkstop
    VBoxManage controlvm $SFOSSDK_VM_NAME acpipowerbutton
end

function _sfossdkvmkey
    echo $SFOSSDK_VM_ROOT/vmshare/ssh/private_keys/engine/mersdk
end

function _sfossdkwait
    set timeout $argv[1]
    ssh -q \
        -o ConnectTimeout=$timeout \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        -p $SFOSSDK_VM_PORT \
        -i (_sfossdkvmkey) \
        $SFOSSDK_VM_USER@$SFOSSDK_VM_HOST exit
end

function _sfossdk_vm
    if not _sfossdkwait 1
        if not sfossdkstart
            echo "Cannot start SDK VM"
            return 1
        end
        echo "Waiting for sshd..."
        if not _sfossdkwait 20
            echo "Cannot connect to SDK"
            return 1
        end
    end
    set internal_path /home/$SFOSSDK_VM_USER/share/(realpath --relative-to=$HOME .)
    ssh -t \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        -p $SFOSSDK_VM_PORT \
        -i (_sfossdkvmkey) \
        $SFOSSDK_VM_USER@$SFOSSDK_VM_HOST cd $internal_path\; $argv
end

function _sfossdk_chroot
    $SFOSSDK_PLATFORM_SDK_PATH/mer-sdk-chroot $argv
end

function sfossdk --description "Mer SDK chroot"
    if test "$SFOSSDK_USE_VM" = "y"
        _sfossdk_vm $argv
    else
        _sfossdk_chroot $argv
    end
end

function mb2
    sfossdk mb2 $argv
end

function sb2
    sfossdk sb2 $argv
end

function sb2-config
    sfossdk sb2-config $argv
end

function tooling
    set -l name (sfossdk sb2-config showtarget | tail -1 | sed -e 's/-\w*$//')
    set -l base_path (realpath -L $SFOSSDK_PLATFORM_SDK_PATH/../../toolings)
    sfossdk $base_path/$name/mer-tooling-chroot $argv
end
