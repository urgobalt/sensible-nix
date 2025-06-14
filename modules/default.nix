{
  lib,
  importUnit,
  root,
}: let
  module = importUnit root;
in
  lib.flatten [
    (module "cli")
    (module "secrets")
  ]
