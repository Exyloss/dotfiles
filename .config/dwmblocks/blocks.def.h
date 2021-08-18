//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"",		"sb-music",			1,		0},
	{"",		"sb-volume",			0,		11},
	{"📼 ", 	"sb-mem",			3,		0},
	{"",    	"sb-bat", 			3, 		0},
	{"",    	"date '+%a %d %b | %I:%M%p'",	60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
