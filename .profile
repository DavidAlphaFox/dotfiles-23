export PATH="$HOME/.local/bin:$HOME/.poetry/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
# export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
export MESA_LOADER_DRIVER_OVERRIDE=iris
export ANDROID_HOME=/opt/android-sdk
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME="$(grep 'gtk-theme-name' "${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini" | sed 's/.*\s*=\s*//')"
export RIDER_JDK=/usr/share/rider/jbr
export DOTNET_CLI_TELEMETRY_OPTOUT=1
