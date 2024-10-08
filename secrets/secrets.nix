let
  mara-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqYMfEDTw5VVlmpvC0l9PGjWhmJVsCYoF/VH4XTKhQQ mara@nixos-laptop";
  mara-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPct6O6tX9MTmTRDqWWD/vPvBXMUQvfleu0wuqdaTDG mara@nixos";
  users = [ mara-laptop mara-desktop ];

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkhqq59KuhJJVT5RE1tMQjs+mjo3/0FOAAmlnvHfbOX root@nixos";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITBJWYWh1E2ynIOSegt+qA1OIxSXjRaJbsVXMz3SXl6 root@nixos";
  systems = [ laptop desktop ];
in
{
  "networks.age".publicKeys = [ mara-laptop laptop ];
}
