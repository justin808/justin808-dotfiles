# Be sure to define OCTO_HOME before loading this file

ogen() {
  cd $OCTO_HOME; bundle exec rake generate; cd -
}

osave() {
  cd $OCTO_HOME
  git commit -am "Updates" && git push origin source
  cd -
}

opush() {
  cd $OCTO_HOME
  git push origin source
  cd -
}

odeploy () {
  cd $OCTO_HOME; bundle exec rake gen_deploy; cd -
}

opost() {
  cd $OCTO_HOME
  #echo param is ${1}
  title=${1}
  title_no_comma=${title//,/_}
  output=$(bundle exec rake new_post\["${title_no_comma}"\])
  # echo output is $output
  new_file=$(echo $output | awk '{print $4}')
  # echo new_file is $new_file
  base=$(basename $new_file)
  # echo base is $base
  new_location=$OCTO_HOME/source/org_posts/
  # echo new_location is $new_location
  mv $OCTO_HOME/$new_file $new_location
  new_file=$new_location$base
  echo created $new_file
  images_dir=$OCTO_HOME/source/images/${base:r}
  mkdir ${images_dir}
  echo created images dir ${images_dir}
  emacsclient $new_location$base &
  cd -
}

opage() {
  cd $OCTO_HOME
  bundle exec rake new_page["${1}"]
  cd -
}

owatch() {
  cd $OCTO_HOME
  bundle exec rake generate && bundle exec rake watch
  cd -
}

alias odraft='vim $(git diff --name-only source -- org_posts/)'
alias png2jgp="for i in *.png; do sips -s format jpeg $i --out ${i%.png}.jpg; done"
