#!/bin/bash

# Check for two arguments
if [ "$#" -ne 2 ]; then
    echo "\nUsage: $0 <arg1> <arg2> \n\n <arg1> Data root dir \n <arg2> Object name"
    exit 1
fi

# Print the arguments
echo "Data root dir: $1"
echo "Object name: $2"

# Initialize Conda in the script
CONDA_BASE=$(conda info --base)  # Get Conda's base installation path
. "$CONDA_BASE/etc/profile.d/conda.sh"  # Use dot instead of source for compatibility

################# Run Selective IGEV ################
conda activate Selective_Stereo
cd Selective-IGEV

# create folders for disparity images
cd output

FOLDER_PATH="./init_disparity"
if [ ! -d "$FOLDER_PATH" ]; then
    echo "Folder does not exist. Creating folder..."
    mkdir "$FOLDER_PATH"  # Create the folder
else
    echo "Folder $FOLDER_PATH already exists."
fi

FOLDER_PATH="./final_disparity"
if [ ! -d "$FOLDER_PATH" ]; then
    echo "Folder does not exist. Creating folder..."
    mkdir "$FOLDER_PATH"  # Create the folder
else
    echo "Folder $FOLDER_PATH already exists."
fi

cd ..

# SelectiveIGEV inference with mast3r initialization
# python demo_imgs_custom.py \
#     --restore_ckpt ./pretrained_models/middlebury_finetune.pth \
#     --valid_iters 80 --max_disp 768 \
#     -l $1/rgb_pairs/$2/zed1_cropped_resized.png \
#     -r $1/rgb_pairs/$2/zed2_cropped_resized.png \
#     --obj $2 \
#     --data_root_dir  $1 \
#     --mast3r_init True

# Selective IGEV inference original
python demo_imgs_custom.py \
    --restore_ckpt ./pretrained_models/middlebury_finetune.pth \
    --valid_iters 80 --max_disp 768 \
    -l $1/rgb_pairs/$2/zed1_cropped_resized.png \
    -r $1/rgb_pairs/$2/zed2_cropped_resized.png \
    --obj $2 \
    --data_root_dir  $1
