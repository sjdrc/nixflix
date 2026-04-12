{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) nixflix;
  cfg = config.nixflix.readarr;
in
{
  imports = [
    (import ./arr-common/mkArrServiceModule.nix { inherit config lib pkgs; } "readarr")
  ];

  config.nixflix.readarr = {
    group = lib.mkDefault "media";
    mediaDirs = lib.mkDefault [ "${nixflix.mediaDir}/books" ];
    config = {
      apiVersion = lib.mkDefault "v1";
      hostConfig = {
        port = lib.mkDefault 8787;
        branch = lib.mkDefault "develop";
      };
      rootFolders = lib.mkDefault (map (mediaDir: { path = mediaDir; }) cfg.mediaDirs);
    };
  };
}
