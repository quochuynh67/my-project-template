#! /bin/bash
export LC_CTYPE=C
export LANG=C

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
  
  #copy to new folder
  cp -R ${template_path}/$f ./${project_name};

done


### replace the flutterbaseproject to project_name (anywhere)
cd $project_name
pwd

# place all folder for first round

echo "Start change folder"
find . -exec rename  -s 'flutterbaseproject' $project_name {} +


echo "Start change file content"
## place all text inside the file for second round
grep -ilr 'flutterbaseproject' * | xargs -I@ sed -i '' "s/flutterbaseproject/${project_name}/g" @

