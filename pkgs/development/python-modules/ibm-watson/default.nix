{ lib
, buildPythonPackage
, fetchFromGitHub
, responses
, pytestCheckHook
, python-dotenv
, pytest-rerunfailures
, tox
, requests
, python-dateutil
, websocket-client
, ibm-cloud-sdk-core
}:

buildPythonPackage rec {
  pname = "ibm-watson";
  version = "5.2.1";

  src = fetchFromGitHub {
    owner = "watson-developer-cloud";
    repo = "python-sdk";
    rev = "v${version}";
    sha256 = "sha256-0F4BZf0D0dqGm0OkJaSgmH5RxEA8KCzOlbnhIQVsgzQ=";
  };

  checkInputs = [
    responses
    pytestCheckHook
    python-dotenv
    pytest-rerunfailures
    tox
  ];

  propagatedBuildInputs = [
    requests
    python-dateutil
    websocket-client
    ibm-cloud-sdk-core
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace websocket-client==1.1.0 websocket-client>=1.1.0
  '';

  meta = with lib; {
    description = "Client library to use the IBM Watson Services";
    homepage = "https://github.com/watson-developer-cloud/python-sdk";
    license = licenses.asl20;
    maintainers = with maintainers; [ globin lheckemann ];
  };
}
