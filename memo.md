
configure
---------

./configure \
--with-features=huge     \
--enable-fail-if-missing \
--enable-perlinterp      \
--enable-pythoninterp    \
--enable-python3interp   \
--enable-rubyinterp      \
--enable-tclinterp       \
--enable-luainterp       \
--with-lua-prefix=/usr   \
--enable-fontset         \
--enable-multibyte       \
--enable-gpm             \
--enable-cscope          \
--enable-gui=gtk2        \
--enable-xim             \
--disable-selinux



option                    | package      | 備考
:--                       |:--           |:--
--with-features=huge      | -            |-
--enable-fail-if-missing  | ncurses-dev  |-
--enable-perlinterp       | libperl-dev  |-
--enable-pythoninterp     | python3-dev  |-
--enable-rubyinterp       | ruby-dev     |-
--enable-tclinterp        | tcl-dev      |-
--enable-luainterp        | lua5.1 liblua5.1-0-dev | -

###memo4
すごいやつ2
    --with-compiledby="thinca <thinca@gmail.com>" \
    --enable-gui=gtk2 \
    --enable-mzschemeinterp \
    --enable-gpm \
    --enable-cscope \

### memo1
   すごいやつ1
 --enable-gui=gtk2
 --with-lua-prefix=/usr
 --enable-mzschemeinterp
 --enable-gpm
 --enable-cscope

 -enable-gui=gtk2 GVimをビルドする場合につける．
 --prefix=$HOME/local インストール先を指定する．デフォルトは「/usr/local」にインストールされる．
 --enable-mzschemeinterp  Schemeを有効にする．

###memo3
 クリップボードの設定
--enable-xim
--disable-selinux


###memo4
liblua5.2-dev

apparmor-easyprof
debhelper
dh-apparmor
docbook-dsssl
docbook-utils
gir1.2-gconf-2.0
gir1.2-gtk-2.0
jadetex
libacl1-dev
libart-2.0-dev
libatk1.0-dev
libattr1-dev
libavahi-client-dev
libavahi-common-dev
libavahi-glib-dev
libbonobo2-0
libbonobo2-common
libbonobo2-dev
libbonoboui2-0
libbonoboui2-common
libbonoboui2-dev
libcairo-script-interpreter2
libcairo2-dev
libcanberra-dev
libdbus-1-dev
libfontconfig1-dev
libfreetype6-dev
libgail-dev
libgconf2-dev
libgcrypt11-dev
libgdk-pixbuf2.0-dev
libglib2.0-dev
libgnome-keyring-dev
libgnome2-0
libgnome2-bin
libgnome2-common
libgnome2-dev
libgnomecanvas2-0
libgnomecanvas2-common
libgnomecanvas2-dev
libgnomeui-0
libgnomeui-common
libgnomeui-dev
libgnomevfs2-dev
libgnutls-dev
libgnutlsxx27
libgpg-error-dev
libgpm-dev
libgtk2.0-dev
libharfbuzz-dev
libice-dev
libidl-common
libidl-dev
libidl0
liborbit2
liborbit2-dev
libosp5
libostyle1c2
libp11-kit-dev
libpango1.0-dev
libpcre3-dev
libpcrecpp0
libpixman-1-dev
libpng12-dev
libpopt-dev
libptexenc1
libpthread-stubs0
libpthread-stubs0-dev
libreadline-dev
libreadline6-dev
libselinux1-dev
libsepol1-dev
libsgmls-perl
libsm-dev
libsp1c2
libtasn1-3-dev
libx11-dev
libxau-dev
libxaw7-dev
libxcb-render0-dev
libxcb-shm0-dev
libxcb1-dev
libxcomposite-dev
libxcursor-dev
libxdamage-dev
libxdmcp-dev
libxext-dev
libxfixes-dev
libxft-dev
libxi-dev
libxinerama-dev
libxml2-dev
libxml2-utils
libxmu-dev
libxmu-headers
libxpm-dev
libxrandr-dev
libxrender-dev
libxt-dev
lua5.2
luatex
lynx
lynx-cur
openjade
po-debconf
python-dev
python2.7-dev
sgmlspl
sp
tcl
tcl-dev
tcl-lib
tcl8.5-dev
tex-common
texlive-base
texlive-binaries
texlive-fonts-recommended
texlive-generic-recommended
texlive-latex-base
texlive-latex-recommended
tipa
ttf-marvosym
x11proto-composite-dev
x11proto-core-dev
x11proto-damage-dev
x11proto-fixes-dev
x11proto-input-dev
x11proto-kb-dev
x11proto-randr-dev
x11proto-render-dev
x11proto-xext-dev
x11proto-xinerama-dev
xorg-sgml-doctools
xtrans-dev
zlib1g-dev

