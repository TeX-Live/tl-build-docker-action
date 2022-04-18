#!/bin/sh -l

arch="$1"
echo "GOT ARCH = $1"

# for CentOS we need to activate gcc-9
if [ -f /opt/rh/devtoolset-9/enable ]
then
  # we cannot call scl enable devtoolset-9 here since we need
  # the settings in the running shell
  . /opt/rh/devtoolset-9/enable
fi


find . -name \*.info -exec touch '{}' \;
touch ./texk/detex/detex-src/detex.c
touch ./texk/detex/detex-src/detex.h
touch ./texk/gregorio/gregorio-src/src/gabc/gabc-score-determination.c
touch ./texk/gregorio/gregorio-src/src/gabc/gabc-score-determination.h
touch ./texk/gregorio/gregorio-src/src/vowel/vowel-rules.h
touch ./texk/web2c/omegafonts/pl-lexer.c
touch ./texk/web2c/omegafonts/pl-parser.c
touch ./texk/web2c/omegafonts/pl-parser.h
touch ./texk/web2c/otps/otp-lexer.c
touch ./texk/web2c/otps/otp-parser.c
touch ./texk/web2c/otps/otp-parser.h
touch ./texk/web2c/web2c/web2c-lexer.c
touch ./texk/web2c/web2c/web2c-parser.c
touch ./texk/web2c/web2c/web2c-parser.h
touch ./utils/asymptote/camp.tab.cc
touch ./utils/asymptote/camp.tab.h
touch ./utils/lacheck/lacheck.c
touch ./utils/xindy/xindy-src/tex2xindy/tex2xindy.c

if [ $arch = armhf-linux ] ; then
  TL_MAKE_FLAGS="-j 1"
else
  TL_MAKE_FLAGS="-j 2"
fi
export TL_MAKE_FLAGS

./Build -C

mv inst/bin/* $arch
tar czvf texlive-bin-$arch.tar.gz $arch

#before_deploy:
#  - if [ -n "$package" ]; then sudo mv inst/bin/* inst/bin/$tldir ; tar czvf ${package} -C inst/bin .; fi
#  - if [ -r inst/bin/*/luahbtex ] ; then cp inst/bin/*/luahbtex luahbtex.$tldir ; fi
#  - if [ -r inst/bin/*/luajithbtex ] ; then cp inst/bin/*/luajithbtex luajithbtex.$tldir ; fi
#
#deploy:
#  - provider: releases
#    api_key: $GH_TOKEN
#    file: $package
#    skip_cleanup: true
#    on:
#      tags: true
#      condition: $package != ""
#
#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"
