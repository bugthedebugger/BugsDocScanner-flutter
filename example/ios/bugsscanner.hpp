#include <stdint.h>

struct ImgBuffer {
  uint8_t* buffer;
  uint64 size;
};

'
ImgBuffer createImgBuffer(uint8_t* buffer, uint64 size);

struct Coordinates {
  int64 x;
  int64 y;
};

'
Coordinates createCoordinates(int64 x, int64 y);

struct Contour {
  Coordinates topLeft;
  Coordinates bottomLeft;
  Coordinates bottomRight;
  Coordinates topRight;
};

'
Contour createContour(
  Coordinates topLeft,
  Coordinates bottomLeft,
  Coordinates bottomRight,
  Coordinates topRight
);

// Return unique file name
'
char* getFileName(char* ext);
// Warp and save image with original color to file using default contours
'
char* warpAndGetOriginalImageSaveFile(char* filePath, char* savePath, char* ext);
// Warp and get buffer of image with original color with default contours;
'
ImgBuffer warpAndGetOriginalImageBuf(char* filePath);
// Warp and save image as bw color to file using default contours
'
char* warpAndGetBWImageSaveFile(char* filePath, char* savePath, char* ext);
// Warp and get buffer of image with bw color with default contours
'
ImgBuffer warpAndGetBWImageBuf(char* filePath);

// The following methods read image from buffer
// Warp and save image with original color to file using default contours
'
char* warpAndGetOriginalImageSaveFileInbuf(uchar* buf,  uint64 bufSize, char* savePath, char* ext);
// Warp and get buffer of image with original color with default contours;
'
ImgBuffer warpAndGetOriginalImageSaveBufInBuf(uchar* buf,  uint64 bufSize);
// Warp and save image as bw color to file using default contours
'
char* warpAndGetBWImageSaveFileInBuf(uchar* buf,  uint64 bufSize, char* savePath, char* ext);
// Warp and get buffer of image with bw color with default contours
'
ImgBuffer warpAndGetBWImageSaveBufInBuf(uchar* buf,  uint64 bufSize);

// Warp and save image with original color to file using custom contours
'
char* warpAndGetOriginalImageSaveFileCustomContour(char* filePath, char* savePath, struct Contour contour, char* ext);
// Warp and get buffer of image with original color with custom contours;
'
ImgBuffer warpAndGetOriginalImageBufCustomContour(char* filePath, struct Contour contour);
// Warp and save image as bw color to file using custom contours
'
char* warpAndGetBWImageSaveFileCustomContour(char*filePath, char* savePath, struct Contour contour, char* ext);
// Warp and get buffer of image with bw color with custom contours
'
ImgBuffer warpAndGetBWImageBufCustomContour(char* filePath, struct Contour contour);

// The following methods read image from buffer
// Warp and save image with original color to file using custom contours
'
char* warpAndGetOriginalImageSaveFileCustomContourInBuf(uchar* buf,  uint64 bufSize, char* savePath, struct Contour contour, char* ext);
// Warp and get buffer of image with original color with custom contours;
'
ImgBuffer warpAndGetOriginalImageBufCustonContourInBuf(uchar* buf,  uint64 bufSize, struct Contour contour);
// Warp and save image as bw color to file using custom contours
'
char* warpAndGetBWImageSaveFileCustomContourInBuf(uchar* buf,  uint64 bufSize, char* savePath, struct Contour contour, char* ext);
// Warp and get buffer of image with bw color with custom contours
'
ImgBuffer warpAndGetBWImageBufCustomContourInBuf(uchar* buf,  uint64 bufSize, struct Contour contour);

// Function to calculate contour
// find contour from image path
'
Contour findContourFromImagePath(char* src);
// find contour from image buffer
'
Contour findContourFromImageBuffer(uchar* buf,  uint64 bufSize);
