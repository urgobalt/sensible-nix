# Sensible nix
_A sensible base nixos configuration._

## Installation
This is not a regular nixos system, but rather is exposing a function to modularize your own configuration with sensible defaults.

### Adding secrets
There is some secrets that is required to build the configuration depending on what modules are enabled.

After installation you will be provided with a program called `agenix`, but before that you can use `nix run`.

You can use `agenix` by running the command `nix run github:aabrupt/sensible-nix#agenix -- -e mysecret.age` in the directory where the `secrets.nix` file is located. You can find an example of `secrets.nix` within `examples/secrets/secrets.nix`. That file will define how `agenix` should encrypt the secrets defined within the age file.

### Make system
To activate `sensible-nix` within your system, you can do the following:

```nix
{
    description = "Your system flake often located in /etc/nixos";
    inputs = {
    sensible-nix.url = "github:aabrupt/sensible-nix";
        nvim-config.url = "github:USERNAME/nvim"; # This can be a path also but that is more complex
    };
    outputs = {self, sensible-nix, nvim-config}: let
        mkSystem = sensible-nix.nixosModules.mkSystem {
          outPath = self.outPath;
          user = "USERNAME";
          full-name = "YOUR NAME";
          nvim-config = nvim-config;
        };
    in {
        nixosConfiguration.HOSTNAME = mkSystem "HOSTNAME" {
            system = "x86_64-linux";
        }
    };
}
```

Make sure to substitute the words in all caps with your information. As an example, switch `HOSTNAME` to `lenovo-yoga`.

## Configuration
The configuration is done with the files defined in the specific host directory. They are located within `hosts/HOSTNAME/` by default.

### Hardware
There is 2 files that target the hardware within the host directory.

- `hardware-configuration.nix`
- `disk-config.nix`

The `hardware-configuration.nix` is the file that is generated using `nixos-generate-config`. It will not be used when `wsl` is enabled.

The `disk-config.nix` is used when `disko` flag is enabled. It defines a disk configuration according to [disko](https://github.com/nix-community/disko) documentation. Disko is a replacement for formatting a harddrive and declaring that harddrive layout. **Note**: You should delete the filesystem spec in hardware-configuration or generate it using `nixos-generate-config --no-filesystems`.

### Modules
You can modify modules using `system.nix` and `user.nix` located in the host directory.

We can define system modules within `system.nix` and home-manager modules within `user.nix`. We import the modules and thereby expose the option automatically within the `mkSystem` function. You have to do the following to activate the options:

```nix
# hosts/HOSTNAME/system.nix
{
    config.modules = {
        # The name of the module and the options you want to enable.
        nvim.enable = true;
    }
}
```

## How-to
This section will guide you through enabling some more advanced modules.
### Declarative passwords
**!!Important!!**
This is a **dangerous** option so you need to know what you're doing before enabling. You will be required to do recovery on your computer if misconfigured.

### Preparation

