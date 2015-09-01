#!/usr/bin/bash

# Called in .travis.yml, decrypts chef.io credentials and runs deploy to
#   upload cookbooks to the Chef server.
echo "Running deploy step"
if [ "$TRAVIS_BRANCH" == 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]
then
  echo "master branch detected, proceeding with deploy"

  # place user pem key for chef.io
  echo "Placing user PEM"
  openssl aes-256-cbc -pass env:aes_key -in $CHEFDIR/$OPSCODE_USER.pem.enc -out $CHEFDIR/$OPSCODE_USER.pem -d ;

  # place org validator pem key for chef.io
  echo "Placing org validator PEM"
  openssl aes-256-cbc -pass env:aes_key -in $CHEFDIR/chef_validator.pem.enc -out $CHEFDIR/$ORGNAME-validator.pem -d ;

  bundle exec rake deploy_chef_repo_changes;
fi
