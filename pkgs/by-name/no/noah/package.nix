{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "noah";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "linux-noah";
    repo = pname;
    rev = version;
    sha256 = "0bivfsgb56kndz61lzjgdcnqlhjikqw89ma0h6f6radyvfzy0vis";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Bash on Ubuntu on macOS";
    homepage = "https://github.com/linux-noah/noah";
    license = [
      licenses.mit
      licenses.gpl2Only
    ];
    maintainers = [ ];
    platforms = platforms.darwin;
    # never built on aarch64-darwin since first introduction in nixpkgs
    broken = stdenv.hostPlatform.isDarwin && stdenv.hostPlatform.isAarch64;
  };
}
