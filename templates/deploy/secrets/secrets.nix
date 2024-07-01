let
  eriador = ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXmmWIeLhoQMNXK9Q8qybmeBH7m9HULzARfp3C+RrbRuDcJORGMF3iT0K+zPnfAeruRBSyLN6EbruW51JihUN+NeHD3KpFfGI2BErjSOB0mvhKEUjvQDRwO9fHcYIiL9vsiLt3umyQmnJPhKipixEWIWbMiZeSLYwDpHP2smVItcxszeNPXc3iN977xi/SnkKW+njyl38oM8Oc9TAUBLvfxdPBhlB0rEELN74ySxoY5sFx7bTbQkEjOttM6WWWhrZZnC1vua9c/Da3uZg8H0QKYR2vR2JH0hbWbmH1jovBzZP2wVFkI/2zGx1cf+9AsMKG1LQgNRInPF+DT7Ul4mTdHwN1Fq6IEfPNoqeCqt4vcgVRQgW4kdfVoIXBAFjsISYcVyRCQCCimPf2I1vOJsWDGnus58suD0fL5pdJEm7LjfF6DL202gbJ7dKPTXp0HsFp4F8OHM0ppyjDySEtFpizf2b1jmu5x+///17DZls+L4m2dYxZML6prRN94YeBWbc= beat@nixos'';
  numenor = ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRG8q4HRFY2ZRSNid323FbRO9U3hLnxqUpF7kBBB/P9xy4Lwqs2wY5UwMqu9GPZwhapAXGFnvoZPvfVyi/5DWAfK6nwq5fon/1nU7denm8mqBdi9JQ7qjDjLaOdIwMQtoazwAh+XaNt49dYldegThqolKxOmQ871aznYPE1pY7b2EiGyRtPYI4ZsBr8WbvI+eX0uFfyIe8MnKekGj6FkE8Sg6z1Dsit1eEbpCbsVESSLNBXq+TvW29np8riWiqYb+9i2zam+AaXMQzbDn/Q7EFbmp/c8327RRjeJ2tId8/CZdjBc6oyD/VkWnFskdi+lfzh9w/Uce9Ykws6NQuJxCHFs+hvwNRb/OqT2+VIJDivmdnL8M9wg7Dmq7BPoV3qdliUT/Hfi8hHbTeTAfv4QMnd39ap+rM8/rq7dt+d3sa/1wSHzBQPfaRBP5Ie8+DjSEmsDzLml1wxGMnhX72kI3VWFWRsXmfS3krbDm3R/6hfdGGgxEboO4uUHKO1MU6SGM= beat@numenor'';
  gondor = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILD4jhHznn3K7uZGhNTu3En3vDyiLmbColfok2Qm/MKS beat@gondor'';
  dev-machines = [ eriador numenor gondor ];
in
{
  "secret-key-base.age".publicKeys = dev-machines;
}