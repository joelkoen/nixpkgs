# This file was generated by pkgs.mastodon.updateScript.
{ fetchFromGitHub, applyPatches, patches ? [] }:
let
  version = "4.2.12";
in
(
  applyPatches {
    src = fetchFromGitHub {
      owner = "mastodon";
      repo = "mastodon";
      rev = "v${version}";
      hash = "sha256-q+j7zHJrIUOumJfk4w5BVu7eTUa1AjI5ho8XoOA2uJU=";
    };
    patches = patches ++ [];
  }) // {
  inherit version;
  yarnHash = "sha256-qoLesubmSvRsXhKwMEWHHXcpcqRszqcdZgHQqnTpNPE=";
}
