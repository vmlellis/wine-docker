FROM vmlellis/x11ubuntu
MAINTAINER Victor Lellis <vmlellis@gmail.com>

USER root

# Wine will not install/start without installing software-properties-common
RUN apt-get update --assume-yes \
    && apt-get install --no-install-recommends --assume-yes \
      curl software-properties-common \
    && add-apt-repository --yes ppa:ricotz/unstable \
    && apt-get purge --assume-yes software-properties-common \
    && dpkg --add-architecture i386

# Install wine and related packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl wine2.0 \
    && rm -rf /var/lib/apt/lists/*

# Use the latest version of winetricks
RUN curl -o /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/local/bin/winetricks \
    && which winetricks

# Wine really doesn't like to be run as root, so let's use a non-root user
USER xclient
ENV HOME /home/xclient
ENV WINEPREFIX /home/xclient/.wine

# Tell wine to behave like a 32-bit Windows.
# https://wiki.archlinux.org/index.php/Wine#WINEARCH
ENV WINEARCH win32

# We have a development build of wine, which means tons of debug output.
# Thus we should suppress it: https://www.winehq.org/docs/winedev-guide/dbg-control
ENV WINEDEBUG -all

RUN export DISPLAY=:0
WORKDIR /home/xclient
