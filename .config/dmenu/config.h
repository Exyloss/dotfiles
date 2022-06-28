/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
static int border_width = 0;
static const unsigned int alpha = 0xc0;
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"monospace:size=10", "JoyPixels:pixelsize=8:antialias=true:autohint=true"};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char col_orange[]	 	  = "#933000";
static const char col_cyan[]	 	  = "#005577";
static const char col_magenta[]	 	  = "#371F79";
static const char *colors[SchemeLast][2] = {
	                        /*     fg         bg       */
	[SchemeNorm] =          { "#bbbbbb", "#000000" },
	[SchemeSel] =           { "#eeeeee", col_orange },
	[SchemeSelHighlight] =  { "#ffc978", col_orange },
	[SchemeNormHighlight] = { "#ffc978", "#000000" },
	[SchemeOut] =           { "#000000", "#00ffff" },
};

static const unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel] = { OPAQUE, alpha },
	[SchemeOut] = { OPAQUE, alpha },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
