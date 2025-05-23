{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fetchpatch,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cosmic-wallpapers";
  version = "1.0.0-alpha.7";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-wallpapers";
    tag = "epoch-${finalAttrs.version}";
    forceFetchGit = true;
    fetchLFS = true;
    hash = "sha256-XtNmV6fxKFlirXQvxxgAYSQveQs8RCTfcFd8SVdEXtE=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/pop-os/cosmic-wallpapers/pull/2/commits/4d17ebe69335f8ffa80fd1c48baa7f3d3efa4dbe.patch";
      hash = "sha256-4QRtX5dbN6C/ZKU3pvV7mTT7EDrMWvRCFB4004RMylM=";
    })
  ];

  makeFlags = [ "prefix=${placeholder "out"}" ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "unstable"
      "--version-regex"
      "epoch-(.*)"
    ];
  };

  meta = {
    description = "Wallpapers for the COSMIC Desktop Environment";
    homepage = "https://system76.com/cosmic";
    license = with lib.licenses; [
      # A_stormy_stellar_nursery_esa_379309.jpg: https://www.esa.int/ESA_Multimedia/Images/2017/06/A_stormy_stellar_nursery
      # webb-inspired-wallpaper-system76.jpg
      cc-by-40

      # otherworldly_earth_nasa_ISS064-E-29444.jpg: https://earthobservatory.nasa.gov/image-use-policy
      # phytoplankton_bloom_nasa_oli2_20240121.jpg: https://earthobservatory.nasa.gov/image-use-policy
      # orion_nebula_nasa_heic0601a.jpg: https://hubblesite.org/copyright
      # tarantula_nebula_nasa_PIA23646.jpg: https://webbtelescope.org/copyright
      # round_moons_nasa.jpg: https://www.planetary.org/space-images/the-solar-systems-round-moons
      publicDomain
    ];
    teams = [ lib.teams.cosmic ];
    platforms = lib.platforms.unix;
  };
})
