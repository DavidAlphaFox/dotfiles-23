# export PATH="$HOME/.local/bin:$HOME/.poetry/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
# export MESA_LOADER_DRIVER_OVERRIDE=iris
# export ANDROID_HOME=/opt/android-sdk
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME="$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d \"\'\")"
# export RIDER_JDK=/usr/share/rider/jbr
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="/home/think-crag/.local/share/neovim/bin:/home/think-crag/.local/bin:$PATH:/home/think-crag/.dotnet/tools"
export FZF_DEFAULT_COMMAND='fd . --type f --hidden --follow --exclude .git --no-ignore'
export FZF_DEFAULT_OPTS=" --prompt='ﰉ ' --pointer='ﰊ' --height 40% --reverse --bind='?:toggle-preview' \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
