let
  mara-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqYMfEDTw5VVlmpvC0l9PGjWhmJVsCYoF/VH4XTKhQQ mara@nixos-laptop";
  mara-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPct6O6tX9MTmTRDqWWD/vPvBXMUQvfleu0wuqdaTDG mara@nixos";
  mara-nipogi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPU/5uMqL7WoIG7/40ue1vGKxKovQx1YuGw+Qthjcefz mara@nixos-server";
  users = [ mara-laptop mara-desktop mara-nipogi ];

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkhqq59KuhJJVT5RE1tMQjs+mjo3/0FOAAmlnvHfbOX root@nixos";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITBJWYWh1E2ynIOSegt+qA1OIxSXjRaJbsVXMz3SXl6 root@nixos";
  nipogi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0brRmGvbRSHA0NbE9/r1sjAJWOzV0Z5TB4O4C0FIWi root@nixos";
  systems = [ laptop desktop nipogi ];
in
{
  "networks.age".publicKeys = [ mara-laptop laptop ];
  "searx.age".publicKeys = [ mara-nipogi nipogi ];
}
