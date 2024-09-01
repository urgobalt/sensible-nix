{user, ...}: {
  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key" "/home/${user}/.ssh/id_ed25519"];
  # MAKE SURE THAT THE FILE user-password.age DOES NOT EXIST IF YOU ARE DOING THIS FOR THE FIRST TIME AND DONT HAVE A CORRECTLY GENERATED AGEFILE.

  # IF YOU HAVE AN EMPTY FILE user-password.age IT IS UB AND RECOVERY IS NOT GARANTIED UOCURE
  # Make sure to add ssh keys too be safe
  age.secrets.user-password.file = ./user-password.age;
  age.secrets.wifi-env.file = ./wifi-env.age;
}