/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx	    = 5;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 20;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static	     int smartgaps	    = 0;
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#000000";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#192E4C";
static const char col_orange[]	    = "#ff8c00";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_orange  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };


static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
	{ NULL,	     NULL,     "qpdfview",     0,         0,	      0,	   1,        -1 },
};
/* window swallowing */

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]     = { "dmenu_run", "-c", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]      = { "st", NULL };
static const char *volumep[]      = { "amixer", "-c", "1", "sset", "Master", "2%+",  NULL };
static const char *volumem[]      = { "amixer", "-c", "1", "sset", "Master", "2%-",  NULL };
static const char *lightm[]       = { "xbacklight", "-dec", "10", NULL };
static const char *lightp[]       = { "xbacklight", "-inc", "10", NULL };
static const char *firefox[]      = { "firefox", NULL };
static const char *libreo[]       = { "libreoffice", NULL };
static const char *codium[]       = { "vscodium", NULL };
static const char *keepass[]      = { "keepassxc", NULL };
static const char *fm[]           = { "st", "-e", "lf", NULL };
static const char *dmount[]       = { "dmount", NULL };
static const char *dumount[]      = { "dumount", NULL };
static const char *dmount_phone[] = { "dmount_phone", NULL };
static const char *dpower[]	  = { "dpower", NULL };

#include "shiftview.c"
static char *endx[] = { "/bin/sh", "-c", "endx", "externalpipe", NULL };
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_a,      spawn,          {.v = dmenucmd } },
	{ MODKEY,             		XK_Return,  spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_v,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,             		XK_o,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY|Mod1Mask,              XK_u,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_i,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_o,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_minus,  incrihgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_minus,  incrihgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_egrave, incrivgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_egrave, incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_underscore,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_underscore,      incrohgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_ccedilla,      incrovgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_ccedilla,      incrovgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_a, 	   togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_agrave, defaultgaps,    {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,             		XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
	//{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
	//{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,			XK_f,	   togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,              		XK_n,      shiftview,  	   {.i = +1 } },
	{ MODKEY,              		XK_b,      shiftview,      {.i = -1 } },
	{ MODKEY,			XK_e,	   spawn,          {.v = fm } },
	{ 0,	                        XF86XK_AudioRaiseVolume,           spawn,          {.v = volumep } },
	{ 0,				XF86XK_AudioLowerVolume,	   spawn,	   {.v = volumem } },
	{ 0,				XF86XK_MonBrightnessDown,	   spawn,          {.v = lightm } },
	{ 0,				XF86XK_MonBrightnessUp,	           spawn,	   {.v = lightp } },
	{ MODKEY,			XK_w,	   spawn,	   {.v = firefox } },
	{ MODKEY|ShiftMask,		XK_l,	   spawn,	   {.v = libreo } },
	{ MODKEY,			XK_c,	   spawn, 	   {.v = codium } },
	{ MODKEY|ShiftMask,		XK_k,	   spawn,	   {.v = keepass } },
	{ MODKEY,			XK_F1,	   spawn, 	   {.v = dmount } },
	{ MODKEY,			XK_F2,	   spawn,	   {.v = dumount } },
	{ MODKEY,			XK_F3,	   spawn,	   {.v = dmount_phone } },
	{ MODKEY|ShiftMask,		XK_e,	   spawn,	   {.v = dpower } },
	TAGKEYS(                        XK_ampersand,               0)
	TAGKEYS(                        XK_eacute,                  1)
	TAGKEYS(                        XK_quotedbl,                2)
	TAGKEYS(                        XK_apostrophe,              3)
	TAGKEYS(                        XK_parenleft,               4)
	TAGKEYS(                        XK_minus,                   5)
	TAGKEYS(                        XK_egrave,                  6)
	TAGKEYS(                        XK_underscore,              7)
	TAGKEYS(                        XK_ccedilla,                8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[1]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

