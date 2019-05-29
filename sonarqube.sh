#!/usr/bin/env sh

# Install and run SonarQube
#
# Use it as a wrapper to your build command, eg: ./sonarqube.sh make VERBOSE=1

# You need to set your SONAR_TOKEN as a private variable on your CI

# Be verbose and fail fast
set -ex

# Install required software
installSonarQubeScanner() {
  local SONAR_SCANNER_VERSION=3.2.0.1227
  export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION
  rm -rf $SONAR_SCANNER_HOME
  mkdir -p $SONAR_SCANNER_HOME
  curl -sSLo $HOME/.sonar/sonar-scanner.zip http://repo1.maven.org/maven2/org/sonarsource/scanner/cli/sonar-scanner-cli/$SONAR_SCANNER_VERSION/sonar-scanner-cli-$SONAR_SCANNER_VERSION.zip
  unzip $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
  rm $HOME/.sonar/sonar-scanner.zip
  export PATH=$SONAR_SCANNER_HOME/bin:$PATH
  export SONAR_SCANNER_OPTS="-server"
}
installBuildWrapper() {
  curl -LsS https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip > build-wrapper-linux-x86.zip
  unzip build-wrapper-linux-x86.zip
}
installSonarQubeScanner
installBuildWrapper

# triggers the compilation through the build wrapper to gather compilation database
./build-wrapper-linux-x86/build-wrapper-linux-x86-64 --out-dir bw-outputs "$@"

# generate the gcov files
#ctest -D ExperimentalCoverage

# and finally execute the actual SonarQube analysis
# (the SONAR_TOKEN is set from the travis web interface, to not expose it with an ongoing "set -x")
# See https://docs.travis-ci.com/user/sonarqube/ for more info on tokens
# don't show the token in the logs
set +x
sonar-scanner -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=$SONAR_TOKEN 2>&1 \
  | grep -v 'INFO: Parsing /home/travis/build/simgrid/simgrid/Testing/CoverageInfo'  \
  | grep -v 'WARN: File not analysed by Sonar, so ignoring coverage: /usr/include/'

exit $outcome
