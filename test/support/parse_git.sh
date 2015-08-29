#!/usr/bin/bash

# parse_git.sh
# Parse git log and identify which parts of the Chef repo have been modified
# in the current commit.  Expose this info via environment variables so test
# and deploy scripts can intelligently target new code.
#
# Author: David Berner david@teacherspayteachers.com

# Get the commit

commit="$TRAVIS_COMMIT"
echo "Commit is $commit"
