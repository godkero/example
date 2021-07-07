


#pragma pack(push,1)
typedef struct _BITMAPINFOHEADER
{

	unsigned int biSize;
	int 	     bitWidth;
	int 	     bitHeight;
	unsigned short biPlanes;
	unsigned short biBitCount;
	unsigned int biCompression;
	unsigned int biSizeImage;
	int 	     biXpelsPerMeter;
	int 	     biYPelsPerMeter;
	unsigned int biClrUsed;
	unsigned int biClrImportant;
}BITMAPINFOHEADER;

typedef struct _BITMAPFILEHEADER
{
	unsigned short bfType;
	unsigned int   bfSize;
	unsigned short bfReserved1;
	unsigned short bfReserved2;
	unsigned int bfOffBits;
}BITMAPFILEHEADER;

typedef struct _RGBTRIPLE
{
	unsigned char rgbtBlue;
	unsigned char rgbtGreen;
	unsigned char rgbRed;
}RGBTRIPLE;


#pragma pack(pop)
