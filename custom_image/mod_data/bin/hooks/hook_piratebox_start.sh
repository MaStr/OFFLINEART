#!/bin/sh

# ---- TEMPLATE ----

# Runs on every Startup
#  get config file 

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
echo "------------------ Running $0 ------------------"


. /etc/piratebox.common

echo "Start generation of conf/lighttpd/offlineArt_mod_gen"
echo "Exporting hostname from uci"
un_hostname=$(oa_uci_export  'system' '@system[0].hostname' )

#Convert Hostname to lowercase only
hostname=$(echo $un_hostname | tr '[A-Z]' '[a-z]')

echo '
server.modules += ( "mod_simple_vhost" )

server.errorlog             = "/mnt/usb/offlineArt/lighttpd_error.log"
server.breakagelog          = "/mnt/usb/offlineArt/lighttpd_break.log"


server.document-root = "'$WWW_FOLDER'"

$HTTP["host"] == "'$hostname'" {
    server.document-root = "'$WWW_FOLDER/content'"
    accesslog.filename = "'/mnt/usb/offlineArt/content_access.log'"
}

$HTTP["host"] != "'$hostname'" {
    server.document-root = "'$WWW_FOLDER'"
    server.error-handler-404 = "/redirect.html"
    accesslog.filename = "'/mnt/usb/offlineArt/general_access.log'"

}


' > $PIRATEBOX_FOLDER/conf/lighttpd/offlineArt_mod_gen


echo "Generating correct redirection"

echo '
<html>
<head><title>Redirecting...</title>
<meta http-equiv="refresh" content="0;url=http://'$un_hostname'/" />
<meta http-equiv='cache-control' content='no-cache'>
</head>
<body>
Redirecting to <a href="=http://'$un_hostname'/">'$un_hostname'</a>
</body>
</html> 
' > $WWW_FOLDER/redirect.html
cp $WWW_FOLDER/redirect.html $WWW_FOLDER/index.html

echo " ... generation done"




