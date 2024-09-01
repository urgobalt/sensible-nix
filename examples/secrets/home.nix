{user, ...}: {
  age.identityPaths = ["/home/${user}/.ssh/id_ed25519"];

  # Email
  age.secrets.personal-email.file = ./personal-email.age;
  age.secrets.professional-email.file = ./professional-email.age;
}