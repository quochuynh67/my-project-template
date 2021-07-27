#! /bin/bash

echo "Welcome!!!!"

echo "Enter project name: "
read project_name
echo "=========> [$project_name]"

### Create project folder with new project name
mkdir $project_name

### Input template path

echo "Enter template path. Make sure it was cloned"
read template_path
echo "=========> [$template_path]"

### copy all subfolder of template to new project folder
for f in $(ls $template_path);
do
  cp -R ${template_path}/$f ./${project_name};
  sed -i '' "s/flutterbaseproject/${project_name}/g" ./${project_name}/$f
done
