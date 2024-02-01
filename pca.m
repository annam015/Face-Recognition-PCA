pkg load statistics
pkg load image

projectPath = '';  # set your own proejct path
imagesPath = ''; # set your own images path (projectPath + "\Images"
databasePath = ''; # set your own database path (projectPath + "\Database"

cd(imagesPath);
[selectedImageName, selectedImagePath] = uigetfile({'*.tif'});
selectedImage = [selectedImagePath, selectedImageName];
im = imread(selectedImage);
cd(projectPath);

imageList = dir(strcat(databasePath, '\*.tif'));
trainingData = [];
for index = 1 : length(imageList)
  path = strcat(databasePath, strcat('\', int2str(index), '.tif'));
  img = imread(path);
  [i, j] = size(img);
  imgColumnVector = reshape(img', i*j, 1);
  trainingData = [trainingData imgColumnVector];
end
meanVector = mean(trainingData, 2);
meanMatrix = [];
for i = 1 : size(trainingData, 2)
  meanMatrix = [meanMatrix meanVector];
end
centeredTrainingData = double(trainingData) - meanMatrix;

covarianceMatrix = centeredTrainingData' * centeredTrainingData;
[eigenVectors, eigenValues] = eig(covarianceMatrix);

significantEigenVectors = [];
for i = 1 : size(eigenVectors, 2)
  if(eigenValues(i, i) > 100)
    significantEigenVectors = [significantEigenVectors eigenVectors(:, i)];
  end
end

principalFaces = centeredTrainingData * significantEigenVectors;

projectedImages = [];
for i = 1 : size(centeredTrainingData, 2)
  projectionVector = principalFaces' * centeredTrainingData(:, i);
  projectedImages = [projectedImages projectionVector];
end

selectedImagePixels = imread(selectedImage);
[i, j] = size(selectedImagePixels);
selectedImagePixels = reshape(selectedImagePixels', i*j, 1);
difference = double(selectedImagePixels) - meanVector;
selectedImageProjection = principalFaces' * difference;

euclideanDistances = [];
for i = 1 : size(centeredTrainingData, 2)
  trainingImageProjection = projectedImages(:, i);
  euclideanDistance = norm(selectedImageProjection - trainingImageProjection);
  euclideanDistances = [euclideanDistances euclideanDistance];
end

[minDist, resultedImageIndex] = min(euclideanDistances);
resultedImageName = strcat(int2str(resultedImageIndex), '.tif');
resultedImage = imread(strcat(databasePath, '\', resultedImageName));

figure('name', 'Facial Recognition Result')
subplot(1, 2, 1);
imshow(im);
title('Selected Image');
subplot(1, 2, 2);
imshow(resultedImage);
title('Resulted Image');
