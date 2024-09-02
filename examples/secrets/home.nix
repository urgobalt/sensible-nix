{user, ...}: {
  age.identityPaths = ["/home/${user}/.ssh/id_ed25519"];

  # Email
  # age.secrets.my-email.file = ./my-email.age;
}

