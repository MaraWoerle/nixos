{ ... }:

{
  services.thinkfan = {
    sensors = [
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp3_input";
      }
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp4_input";
      }
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp1_input";
      }
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp5_input";
      }
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp2_input";
      }
    ];

    fans = [
      {
        # type = "tpacpi";
        # query = "/proc/acpi/ibm/fan";
        type = "hwmon";
        query = "/sys/class/hwmon/hwmon1/pwm1";
      }
    ];
    
    levels = [
      #[0 0 40]
      #[1 35 45]
      #[2 40 50]
      #[3 45 55]
      #[4 50 60]
      #[5 55 70]
      #[6 65 80]
      #[7 75 90]
      #[127 85 32767]
      [0 0 41]
      [16 39 44]
      [32 42 47]
      [48 45 50]
      [64 48 53]
      [80 51 56]
      [96 54 59]
      [112 57 62]
      [128 60 65]
      [144 63 68]
      [160 66 71]
      [178 69 74]
      [192 72 77]
      [208 75 80]
      [224 78 83]
      [240 81 86]
      [255 84 32767]
    ];
  };
}
