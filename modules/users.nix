{pkgs, ... }:
{
  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "vboxusers" "docker" "audio" "sound" "video" "input" "tty" "camera"]; 
  };
  users.defaultUserShell = pkgs.zsh;

  security.sudo.extraRules = [
    {
      users = [ "lee" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  #security.polkit = {
  #  enable = true;
  #  extraConfig = ''
  #     /* Log authorization checks. */
  #    polkit.addRule(function(action, subject) {
  #      polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
  #    });
  #
  #    /* Allow any local user to do anything (dangerous!). */
  #    polkit.addRule(function(action, subject) {
  #      if (subject.local) return "yes";
  #    });

  #  '';
  #};

}
