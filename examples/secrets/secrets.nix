let
  ssh = import ../ssh.nix;
  default = ssh.users ++ ssh.systems;
in
  with ssh; {
    "user-password.age".publicKeys = default;
    "wifi-env.age".publicKeys = default;

    # Email
    "personal-email.age".publicKeys = ssh.users;
    "professional-email.age".publicKeys = ssh.users;
  }