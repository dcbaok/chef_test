#!/usr/bin/bash

# Called in .travis.yml, decrypts chef.io credentials and runs deploy to
#   upload cookbooks to the Chef server.
if [ "$TRAVIS_BRANCH" == 'master' ] ; then

  # place user pem key for chef.io
  echo "Placing user PEM"
  openssl aes-256-cbc -pass env:TRAVIS_PEM_PW -in $CHEFDIR/$OPSCODE_USER.pem.enc -out $CHEFDIR/$OPSCODE_USER.pem -d ;

  # place org validator pem key for chef.io
  echo "Placing org validator PEM"
  openssl aes-256-cbc -pass env:TRAVIS_PEM_PW -in $CHEFDIR/$ORGNAME.pem.enc -out $CHEFDIR/$ORGNAME-validator.pem -d ;

  bundle exec rake deploy ;
fi