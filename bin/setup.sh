#!//bin/sh

if [ -n "$1" ]              # Tested variable is quoted.
then
  theme=$1
  instance=$2
  echo "Setting theme to $theme, instance to $instance"  # Need quotes to escape #

  mkdir -p ../${theme}_tmp_${instance}
  mkdir -p ../${theme}_log_${instance}

  ln -s ../${theme}_tmp_${instance} tmp
  ln -s ../${theme}_log_${instance} log

  mkdir -p ../${theme}_assets
  mkdir -p ../${theme}_assets/development
  mkdir -p ../${theme}_assets/production

  rm -rf   themes/current
  ln -s $theme themes/current

else
  echo "Usage: $0 os|ff 0|1|2|3"
fi 

