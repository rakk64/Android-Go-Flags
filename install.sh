AUTOMOUNT=true
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

ui_print "- Checking Android version."
A_API=$(getprop ro.build.version.sdk)
A_VER=$(getprop ro.build.version.release)
if [[ $A_API -ge 26 ]]; then
  ui_print "- Android $A_VER detected."
else
  abort "- ERROR: This module is only compatible on your Android."
fi

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

ui_print "*******************************************************"
ui_print "   Android Go Flags Stable"
ui_print "   Patch by Rakk Standalone"
ui_print "   Hehe Enjoyy"
ui_print "*******************************************************"

# Copy/extract your module files into $MODPATH in on_install.

on_install() {
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  # Extract folder common
  unzip -o "$ZIPFILE" 'common/*' -d $MODPATH >&2 
  # Extract file service.sh, uninstall.sh, system.prop, banner.png, post-fs-data.sh
  unzip -o "$ZIPFILE" 'service.sh' 'banner.png' 'post-fs-data.sh' 'uninstall.sh' 'system.prop' -d $MODPATH >&2
}

ui_print "- Setting permissions."
set_perm_recursive $MODPATH 0 0 0755 0644
