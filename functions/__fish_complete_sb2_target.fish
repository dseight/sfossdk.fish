function __fish_complete_sb2_target
    if test "$SFOSSDK_USE_VM" = "y"
        sdk sb2-config -l 2>/dev/null | tr -d '\015'
    else
        # Use faster approach when working locally
        ls $SFOSSDK_PLATFORM_SDK_PATH/../../targets
    end
end
