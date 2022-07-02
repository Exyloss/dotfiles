//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"",		"sb-music",			0,		11},
	{"",		"sb-volume",		0,		10},
	{"📼 ", 	"sb-mem",			3,		0},
	{"",    	"sb-bat", 			5, 		0},
	{"",    	"date '+%a %d %b | %H:%M '",	60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
