# Face-Recognition-PCA

This GNU Octave project applies Principal Component Analysis (PCA) for facial recognition. 

## Dataset

This project uses images from the AT&T Database of Faces representing 32 people, with 3 reference images per person in the "Images" folder and 6 target recognition images per person in the "Database" folder.

## Project Setup

### Requirements

- GNU Octave (version 8.3.0+)
- Octave packages: Image and Statistics

### Installation and Running

Clone this repository:
   ```bash
git clone https://github.com/annam015/Face-Recognition-PCA.git
   ```

Before executing the script, you need to set up your project environment:
1. Open the `pca.m` script.
2. Set the `projectPath`, `imagesPath`, and `databasePath` variables to your local paths.

To run the project:
1. Open GNU Octave.
2. Navigate to the directory where the project is located.
3. Run the `pca.m` script. 
4. Follow the prompts to select an image for recognition. The script will process the image and attempt to identify the face using the PCA method.

## How It Works

The `pca.m` script reads the image from the specified path, performs Principal Component Analysis to extract features and compares the selected image against the database to find the closest match.
