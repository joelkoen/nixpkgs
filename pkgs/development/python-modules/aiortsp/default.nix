{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, dpkt
}:

buildPythonPackage rec {
  pname = "aiortsp";
  version = "1.3.7";

  src = fetchFromGitHub {
    owner = "marss";
    repo = pname;
    rev = version;
    hash = "sha256-bxfnKAzMYh0lhS3he617eGhO7hmNbiwEYHh8k/PZ6r4=";
  };

  propagatedBuildInputs = [
    dpkt
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aiortsp"
  ];

  meta = with lib; {
    description = "asyncio library for interacting with an RTSP server";
    homepage = "https://github.com/marss/aiortsp";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ joelkoen ];
  };
}
