{ lib
, stdenv
, fetchFromGitHub
, python
, cmake
, ninja
}:

let
  pyEnv = python.withPackages (ps: [ ps.setuptools ps.tomli ps.pip ps.setuptools ]);
in
stdenv.mkDerivation rec {
  pname = "lief";
  version = "0.16.3";

  src = fetchFromGitHub {
    owner = "lief-project";
    repo = "LIEF";
    rev = version;
    sha256 = "sha256-tV9L4UUl+gwpzJIqrMsNeCCtcxX+wsHvPxNTqtvsoV0=";
  };

  outputs = [ "out" "py" ];

  nativeBuildInputs = [
    cmake
    ninja
  ];

  # Not in propagatedBuildInputs because only the $py output needs it; $out is
  # just the library itself (e.g. C/C++ headers).
  buildInputs = with python.pkgs; [
    python
    build
    pathspec
    pip
    pydantic
    scikit-build-core
  ];

  postBuild = ''
    pushd ../api/python
    ${pyEnv.interpreter} -m build --no-isolation --wheel --skip-dependency-check --config-setting=--parallel=$NIX_BUILD_CORES
    popd
  '';

  postInstall = ''
    pushd ../api/python
    ${pyEnv.interpreter} -m pip install --prefix $py dist/*.whl
    popd
  '';

  meta = with lib; {
    description = "Library to Instrument Executable Formats";
    homepage = "https://lief.quarkslab.com/";
    license = [ licenses.asl20 ];
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ lassulus genericnerdyusername ];
  };
}
