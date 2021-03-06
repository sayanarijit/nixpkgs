{ stdenv, lib, fetchzip, fetchpatch, which, ocsigen_server, ocaml,
  lwt_react,
  opaline, ppx_deriving, findlib
, ocaml-migrate-parsetree
, ppx_tools_versioned
, js_of_ocaml-ocamlbuild, js_of_ocaml-ppx, js_of_ocaml-ppx_deriving_json
, js_of_ocaml-lwt
, js_of_ocaml-tyxml
, lwt_ppx
}:

if !lib.versionAtLeast ocaml.version "4.07"
then throw "eliom is not available for OCaml ${ocaml.version}"
else

stdenv.mkDerivation rec
{
  pname = "eliom";
  version = "6.12.4";

  src = fetchzip {
    url = "https://github.com/ocsigen/eliom/archive/${version}.tar.gz";
    sha256 = "00m6v2k4mg8705dy41934lznl6gj91i6dk7p1nkaccm51nna25kz";
  };

  patches = [
    # Compatibility with js_of_ocaml >= 3.9.0, remove at next release
    (fetchpatch {
      url = "https://github.com/ocsigen/eliom/commit/4106a4217956f7b74a8ef3f73a1e1f55e02ade45.patch";
      sha256 = "1cgbvpljn9x6zxirxf3rdjrsdwy319ykz3qq03c36cc40hy2w13p";
    })
  ];

  buildInputs = [ ocaml which findlib js_of_ocaml-ocamlbuild
    ocaml-migrate-parsetree
    js_of_ocaml-ppx_deriving_json opaline
    ppx_tools_versioned
  ];

  propagatedBuildInputs = [
    js_of_ocaml-lwt
    js_of_ocaml-ppx
    js_of_ocaml-tyxml
    lwt_ppx
    lwt_react
    ocsigen_server
    ppx_deriving
  ];

  installPhase = "opaline -prefix $out -libdir $OCAMLFIND_DESTDIR";

  setupHook = [ ./setup-hook.sh ];

  meta = {
    homepage = "http://ocsigen.org/eliom/";
    description = "OCaml Framework for programming Web sites and client/server Web applications";

    longDescription =''Eliom is a framework for programming Web sites
    and client/server Web applications. It introduces new concepts to
    simplify programming common behaviours and uses advanced static
    typing features of OCaml to check many properties of the Web site
    at compile time. If you want to write a Web application, Eliom
    makes possible to write the whole application as a single program
    (client and server parts). A syntax extension is used to
    distinguish both parts and the client side is compiled to JS using
    Ocsigen Js_of_ocaml.'';

    license = lib.licenses.lgpl21;

    maintainers = [ lib.maintainers.gal_bolle ];
  };
}
