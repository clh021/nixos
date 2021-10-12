{ pkgs, ... }:

{
  fonts = {
        enableDefaultFonts = true;
        fontconfig = {
          enable = true;
          dpi = 0;
          hinting = {
            enable = true;
            autohint = false;
            # hintstyle = "hintslight(10px,12px)";
          };
	      defaultFonts.emoji = [ "Noto Color Emoji" ];
          defaultFonts.monospace = [ "Hack" "Sarasa Mono SC" ];
          defaultFonts.sansSerif = [ "DejaVu Sans" ];
          defaultFonts.serif = [ "DejaVu Serif" "Source Han Serif SC" ];                
	};
        
        fontDir.enable = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
          # sarasa-gothic
          # noto-fonts
          # noto-fonts-cjk
          noto-fonts-emoji
          wqy_microhei
          wqy_zenhei
          #nerdfonts # 图标字体 太大太大太大啦 # exa 使用
          # symbola  # 特殊字符
          jetbrains-mono
        ];
  };
}
