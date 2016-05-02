#!/bin/sh
set -e
set -x
# This is a script to bootstrap pkgsrc on a mac and install some basic tools.

#Copyright (c) 2016 Rainbow
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#* Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
#* Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

cd $HOME
curl -OL http://ftp.netbsd.org/pub/pkgsrc/stable/pkgsrc.tar.bz2
tar xvfj pkgsrc.tar.bz2
cd $HOME/pkgsrc/bootstrap/
./bootstrap --abi=64 --prefer-pkgsrc=yes --unprivileged
# may also need --compiler=clang  i forget >.>
cd $HOME/pkgsrc/pkgtools/pkg_rolling-replace
$HOME/pkg/bin/bmake install clean
cd $HOME/pkgsrc/devel/scmcvs
$HOME/pkg/bin/bmake install clean
cd $HOME/bin/pkg
curl -L https://raw.githubusercontent.com/RainbowHackerHorse/Stuffnthings/master/porter.sh > porter
chmod +x $HOME/pkg/bin/porter
echo "Bootstrapped pkgsrc in ~/pkgsrc, installed CVS from pkgsrc to override xcode, and installed pkg_rolling-replace"
echo "Please remember to update with cd ~/pkgsrc && env CVS_RSH=ssh cvs up -dP"
echo "Alternatively, use the porter command to keep the tree up to date and upgrade installed packages"
echo "Please remember to add $HOME/pkg/bin/ to your \$PATH as well!"
exit 0
