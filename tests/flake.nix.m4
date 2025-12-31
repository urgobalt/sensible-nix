{
  inputs.sensible.url = "github:urgobalt/sensible-nix";
  outputs = {sensible, ...}:
    sensible.nixosModules.sensible {
      default = {
        username = "test";
        modules = [
          {
            fileSystems."/" = {
              device = "/dev/disk/by-uuid/4f999afe-6114-4531-ba37-4bf4a00efd9e";
              fsType = "exfat";
              options = [
                "users"
                "nofail"
              ];
            };
          }
          ./configuration.nix
        ];
      };
      systems = SYSTEMS;
    };
}
