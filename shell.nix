# NOTE: This should work on OSX but I haven't tested it...
let
  pkgs =
    let rev = "9ff408a2a4cb784160afef9a43c73a7a37ba38c9";
    in import (builtins.fetchTarball {
      name = "nixpkgs-${rev}";
      url = "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz";
      sha256 = "0dv0yhz7cscw6vrn3vnwpf2pa1nbpwh5dn3229bvkinj42yig0z9";
    }) {};

  fetchReleaseBin = { bin, version, url, sha256, buildInputs, extract }:
    pkgs.stdenv.mkDerivation rec {
      name = "${bin}-${version}";
      inherit version;
      src = pkgs.fetchurl { inherit url sha256; };
      inherit buildInputs;
      buildCommand = ''
        ${extract}
        mkdir -p $out/bin
        EXE="$out/bin/${bin}"
        install -D -m555 -T ${bin} $EXE
        ${if pkgs.stdenv.isDarwin then "" else ''
        chmod u+w $EXE
        patchelf --interpreter ${pkgs.stdenv.cc.bintools.dynamicLinker} \
          --set-rpath ${pkgs.lib.makeLibraryPath buildInputs} $EXE
        chmod u-w $EXE
        ''}
      '';
    };

  purs =
    let version = "0.13.2";
    in fetchReleaseBin ({
      bin = "purs";
      inherit version;
      url = "https://github.com/purescript/purescript/releases/download/v${version}/linux64.tar.gz";
      sha256 = "00jm8hmg7xq4c6z1b00b4y229n6bpbvfkzbij2idanms1p1m4mfm";
      buildInputs = with pkgs; [ zlib gmp ncurses5 ];
      extract = "tar -zxf $src --strip-components 1 purescript/purs";

    } // (if pkgs.stdenv.isDarwin then {
      url = "https://github.com/purescript/purescript/releases/download/v${version}/macos.tar.gz";
      sha256 = "14svlra2vhbxyk2l76czhxj16w9jhnwagb8mwv9pw4siiayqa8cz";

    } else {}));

  spago =
    let version = "0.8.5.0";
    in fetchReleaseBin {
      bin = "spago";
      inherit version;
      url = "https://github.com/spacchetti/spago/releases/download/${version}/linux.tar.gz";
      sha256 = "0r66pmjfwv89c1h71s95nkq9hgbk7b8h9sk05bfmhsx2gprnd3bq";
      buildInputs = with pkgs; [ zlib gmp ncurses5 stdenv.cc.cc.lib ];
      extract = "tar -zxf $src spago";
    } // (if pkgs.stdenv.isDarwin then {
      url = "https://github.com/spacchetti/spago/releases/download/${version}/osx.tar.gz";
      sha256 = "0a6s4xpzdvbyh16ffcn0qsc3f9q15chg0qfaxhrgc8a7qg84ym5n";
    } else {});

  purty =
    let version = "4.5.1";
    in fetchReleaseBin {
      bin = "purty";
      inherit version;
      url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-${version}-linux.tar.gz";
      sha256 = "050m7wnaz7d20amsprps02j65qywa4r0n873f444g6db9alvazrv";
      buildInputs = with pkgs; [ zlib gmp ncurses5 ];
      extract = "tar -zxf $src purty";
    } // (if pkgs.stdenv.isDarwin then {
      url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-${version}-osx.tar.gz";
      sha256 = "1nl86ajix0kzz7l6my1nj22zra4pcz7mp6kb730p2a9jxdk37f12";
    } else {});

in
pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.nodejs-10_x  # lts
    pkgs.yarn
    purs
    spago
    purty
  ];
}
