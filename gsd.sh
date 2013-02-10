#!/usr/bin/env bash

# edit this list, or set GSD_SITES to add your custom sites

CODER_SITES="reddit.com digg.com facebook.com youtube.com flickr.com vimeo.com stumbleupon.com myspace.com yelp.com"

HACKER_SITES=$CODER_SITES" techcrunch.com techdirt.com news.ycombinator.com meetup.com linkedin.com slashdot.org geekwire.com news.google.com"

ARCHITECT_SITES=$HACKER_SITES" twitter.com plus.google.com wikipedia.org pandora.com rdio.com spotify.com grooveshark.com"

BLACKOUT_SITES=$ARCHITECT_SITES" github.com"

SITES="$GSD_SITES $BASE_SITES"

HOSTFILE="/etc/hosts"

if [ ! -w $HOSTFILE ]
then
    echo "cannot write to $HOSTFILE, try running with sudo"
    exit 1
fi

# clean up previous entries from /etc/hosts
sed -i -e '/#gsd$/d' $HOSTFILE

if [ "$1" = "--coder" ]
  then
  for SITE in $CODER_SITES
  do
    echo -e "127.0.0.1\t$SITE\t#gsd" >> $HOSTFILE
    echo -e "127.0.0.1\twww.$SITE\t#gsd" >> $HOSTFILE 
  done
  echo "coder mode enabled, run with --play to disable"
fi

if [ "$1" = "--hacker" ]
  then
  for SITE in $HACKER_SITES
  do
    echo -e "127.0.0.1\t$SITE\t#gsd" >> $HOSTFILE
    echo -e "127.0.0.1\twww.$SITE\t#gsd" >> $HOSTFILE 
  done
  echo "hacker mode enabled, run with --play to disable"
fi

if [ "$1" = "--architect" ]
  then
  for SITE in $ARCHITECT_SITES
  do
    echo -e "127.0.0.1\t$SITE\t#gsd" >> $HOSTFILE
    echo -e "127.0.0.1\twww.$SITE\t#gsd" >> $HOSTFILE 
  done
  echo "architect mode enabled, run with --play to disable"
fi

if [ "$1" = "--blackout" ]
  then
  for SITE in $BLACKOUT_SITES
  do
    echo -e "127.0.0.1\t$SITE\t#gsd" >> $HOSTFILE
    echo -e "127.0.0.1\twww.$SITE\t#gsd" >> $HOSTFILE 
  done
  echo "architect mode enabled, run with --play to disable"
fi

if [ -z "$GSD_RESET" ]
then
    GSD_RESET="dscacheutil -flushcache"
fi

$GSD_RESET
