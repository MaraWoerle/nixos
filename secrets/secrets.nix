let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqYMfEDTw5VVlmpvC0l9PGjWhmJVsCYoF/VH4XTKhQQ mara@nixos-laptop";
  users = [ user1 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkhqq59KuhJJVT5RE1tMQjs+mjo3/0FOAAmlnvHfbOX root@nixos";
  systems = [ system1 ];
in
{
  "networks.age".publicKeys = [ user1 system1 ];
}
