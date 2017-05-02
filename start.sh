#!/bin/bash

#for file in `find /input -name *.nii.gz`
#do
#    /usr/local/freesurfer/bin/freeview $file &
#done

#fibernavigator can open t1 with the same dimension
#https://github.com/scilus/fibernavigator/issues/219
#fibernavigator crashes if it tries to load dwi
#https://github.com/scilus/fibernavigator/issues/221

/fibernavigator/bin/fibernavigator `find /input -name t1.nii.gz`
