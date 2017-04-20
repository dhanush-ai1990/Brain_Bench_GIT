#!/bin/sh

matlab_exec=matlab
module load matlab/R2015b
X="${1}"
echo ${X} > matlab_command_${2}.m
echo "exit;" >> matlab_command_${2}.m
cat matlab_command_${2}.m
${matlab_exec} -nojvm -nodisplay -nosplash < matlab_command_${2}.m
rm matlab_command_${2}.m
