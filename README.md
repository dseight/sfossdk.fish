# sfossdk.fish

[Fish shell](https://fishshell.com/) completions and wrappers for Sailfish (Platform) SDK.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```
fisher install dseight/sfossdk.fish
```

## Usage

You need either [Sailfish Platform SDK](https://sailfishos.org/wiki/Platform_SDK) or [Sailfish SDK](https://sailfishos.org/wiki/Sailfish_SDK) installed on your machine. If SDK is installed with default paths, completion should work right out of the box. If not, override default variables (like a path to the SDK, VM port, etc.) by putting them into the `~/.config/fish/config.fish` or by using [universal variables](https://fishshell.com/docs/current/tutorial.html#universal-variables), e.g.:

```
set -u SFOSSDK_PLATFORM_SDK_PATH /srv/mer/sdks/customsdk
```

To check how completion works, just type something like `sb2 -t` on your host machine and press the <kbd>Tab</kbd> key. You'll see a list of available targets like this:
```console
$ sb2 -t
SailfishOS-3.4.0.24-aarch64  (Target to use)
SailfishOS-3.4.0.24-armv7hl  (Target to use)
SailfishOS-3.4.0.24-i486     (Target to use)
```

## License

[MIT](LICENSE)
