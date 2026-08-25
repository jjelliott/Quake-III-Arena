/*
===========================================================================
Copyright (C) 1999-2005 Id Software, Inc.

This file is part of Quake III Arena source code.

Quake III Arena source code is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

Quake III Arena source code is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/
//
/*
=============================================================================

SINGLE PLAYER LEVEL SELECT MENU

=============================================================================
*/

#include "ui_local.h"

#define MAX_SERVERMAPS	64
#define MAX_SP_EPISODES 512

#define ART_LEVELFRAME_FOCUS		"menu/art/maps_select"
#define ART_LEVELFRAME_SELECTED		"menu/art/maps_selected"
#define ART_ARROW					"menu/art/narrow_0"
#define ART_ARROW_FOCUS				"menu/art/narrow_1"
#define ART_MAP_UNKNOWN				"menu/art/unknownmap"
#define ART_MAP_COMPLETE1			"menu/art/level_complete1"
#define ART_MAP_COMPLETE2			"menu/art/level_complete2"
#define ART_MAP_COMPLETE3			"menu/art/level_complete3"
#define ART_MAP_COMPLETE4			"menu/art/level_complete4"
#define ART_MAP_COMPLETE5			"menu/art/level_complete5"
#define ART_BACK0					"menu/art/back_0"
#define ART_BACK1					"menu/art/back_1"
#define ART_FIGHT0					"menu/art/fight_0"
#define ART_FIGHT1					"menu/art/fight_1"

#define ART_NEXT0		"menu/art/next_0"
#define ART_NEXT1		"menu/art/next_1"
#define ART_RESET0					"menu/art/reset_0"
#define ART_RESET1					"menu/art/reset_1"
#define ART_CUSTOM0					"menu/art/skirmish_0"
#define ART_CUSTOM1					"menu/art/skirmish_1"
#define ART_FRAMEL			"menu/art/frame2_l"
#define ART_FRAMER			"menu/art/frame1_r"

#define ID_LEFTARROW		10
#define ID_PICTURE0			11
#define ID_PICTURE1			12
#define ID_PICTURE2			13
#define ID_PICTURE3			14
#define ID_RIGHTARROW		15
#define ID_PLAYERPIC		16
#define ID_AWARD1			17
#define ID_AWARD2			18
#define ID_AWARD3			19
#define ID_AWARD4			20
#define ID_AWARD5			21
#define ID_AWARD6			22
#define ID_BACK				23
#define ID_RESET			24
#define ID_CUSTOM			25
#define ID_NEXT				26
#define ID_LIST				27

#define PLAYER_Y			314
#define AWARDS_Y			(PLAYER_Y + 26)

typedef struct {
	char id[64];
	char name[64];
	char levelshot[MAX_QPATH];
	qhandle_t shotHandle;
} episodeInfo_t;

typedef struct {
	int arenaIdx;
	qhandle_t levelshotHandle;
	char displayName[MAX_NAME_LENGTH];
	char bspName[MAX_NAME_LENGTH];
	qboolean skipSkillSelect;
	int order;
} episodeMapInfo_t;

typedef struct {
	menuframework_s	menu;
	menutext_s		banner;
	menubitmap_s	episode;
	menubitmap_s	map;
	menubitmap_s	back;
	menubitmap_s	next;
} singleMenuInfo_t;

typedef struct {
	menuframework_s menu;
	menutext_s		banner;
	menubitmap_s	back;
	menubitmap_s	next;
	menubitmap_s	framel;
	menubitmap_s	framer;
	menubitmap_s	preview;
	menulist_s		list;
} episodeMenuInfo_t;

typedef struct {
	menuframework_s menu;
	menutext_s		banner;
	menubitmap_s	back;
	menubitmap_s	next;
	menubitmap_s	framel;
	menubitmap_s	framer;
	menubitmap_s	preview;
	menulist_s		list;
} mapMenuInfo_t;

static singleMenuInfo_t singleMenuInfo;
static episodeMenuInfo_t episodeMenuInfo;
static mapMenuInfo_t mapMenuInfo;

static episodeInfo_t spEpisodes[MAX_SP_EPISODES];
static int spEpisodeCount;

static int selectedEpisodeIdx;
static qboolean episodeSelected;
static int selectedMapIdx;
static qboolean mapSelected;

static episodeMapInfo_t episodeMaps[MAX_ARENAS];
static int episodeMapCount;

static qhandle_t NO_SELECTION;

static void SPEpisode_BackEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	UI_PopMenu();
}

static qboolean shouldSwap(int j) {
	if (selectedEpisodeIdx == 0) return Q_stricmp(episodeMaps[j].bspName, episodeMaps[j+1].bspName) > 0;
	if (episodeMaps[j].order > episodeMaps[j+1].order) return qtrue;
	if (episodeMaps[j].order == episodeMaps[j+1].order && Q_stricmp(episodeMaps[j].bspName, episodeMaps[j+1].bspName) > 0) return qtrue;


	return qfalse;
}

static void SPEpisode_SelectEvent( void *ptr, int event) {

	const char *skipSkillSelectStr;
	int i, j, allMapCount;
	char *episodeId;
	const char	*arenaInfo;
	episodeMapInfo_t temp;

	if (event != QM_ACTIVATED) return;
	selectedEpisodeIdx = episodeMenuInfo.list.curvalue;
	episodeSelected = qtrue;

	episodeMapCount = 0;
	allMapCount = UI_GetNumArenas();
	for (i = 0; i < allMapCount; i++) {
		arenaInfo = UI_GetArenaInfoByNumber(i);

		if ( !strstr(Info_ValueForKey(arenaInfo, "type"), "q3sp")) {
			continue;
		}
		episodeId = Info_ValueForKey(arenaInfo, "episode");
		if (selectedEpisodeIdx == 0 && episodeId[0]) {
			continue;
		}
		if (selectedEpisodeIdx != 0 && Q_stricmp(spEpisodes[selectedEpisodeIdx].id, episodeId)) {
			continue;
		}
		// is q3sp and right episode
		episodeMaps[episodeMapCount].arenaIdx = i;
		episodeMaps[episodeMapCount].levelshotHandle = trap_R_RegisterShaderNoMip(va( "levelshots/%s.tga",  Info_ValueForKey(arenaInfo, "map") ));
		Q_strncpyz(episodeMaps[episodeMapCount].bspName, Info_ValueForKey(arenaInfo, "map"), sizeof( episodeMaps[episodeMapCount].bspName));
		if (!episodeMaps[episodeMapCount].levelshotHandle) episodeMaps[episodeMapCount].levelshotHandle = trap_R_RegisterShaderNoMip(ART_MAP_UNKNOWN);
		skipSkillSelectStr = Info_ValueForKey(arenaInfo, "skipSkillSelect");
		if (!Q_stricmp(skipSkillSelectStr, "y") || !Q_stricmp(skipSkillSelectStr, "true") || !strcmp(skipSkillSelectStr, "1")) {
			episodeMaps[episodeMapCount].skipSkillSelect = qtrue;
		} else {
			episodeMaps[episodeMapCount].skipSkillSelect = qfalse;
		}
		Q_strncpyz(episodeMaps[episodeMapCount].displayName, Info_ValueForKey(arenaInfo, "longname"), sizeof( episodeMaps[episodeMapCount].displayName));
		if (!episodeMaps[episodeMapCount].displayName[0]) {
			Q_strncpyz(episodeMaps[episodeMapCount].displayName, episodeMaps[episodeMapCount].bspName, sizeof( episodeMaps[episodeMapCount].displayName));
		}
		episodeMaps[episodeMapCount].order = atoi(Info_ValueForKey(arenaInfo, "episodeorder"));
		episodeMapCount++;
	}

	for (i = 0; i < episodeMapCount; i++) {
		for (j = 0; j < episodeMapCount -i-1; j++) {
			if (shouldSwap(j)) {
				temp = episodeMaps[j];
				episodeMaps[j] = episodeMaps[j+1];
				episodeMaps[j+1] = temp;
			}
		}
	}

	singleMenuInfo.map.generic.flags &= ~QMF_GRAYED;

	UI_PopMenu();
}

static void SPEpisode_LoadList() {
	int i;

	episodeMenuInfo.list.numitems = spEpisodeCount;
	for (i = 0; i<spEpisodeCount; i++) {
		episodeMenuInfo.list.itemnames[i] = spEpisodes[i].name;
	}
	if (episodeSelected) episodeMenuInfo.list.curvalue = selectedEpisodeIdx;
}
static void SPEpisode_PreviewDraw(void *self) {
	menubitmap_s *b;
	b = (menubitmap_s *)self;
	UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, spEpisodes[episodeMenuInfo.list.curvalue].shotHandle);
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, spEpisodes[episodeMenuInfo.list.curvalue].name, UI_CENTER|UI_SMALLFONT, color_white);

}
static void SPEpisode_Init() {
	episodeSelected = qfalse;
	selectedMapIdx = 0;
	mapSelected = qfalse;

	singleMenuInfo.next.generic.flags |= QMF_GRAYED;
	memset( &episodeMenuInfo, 0, sizeof(episodeMenuInfo) );
	episodeMenuInfo.menu.fullscreen = qtrue;
	episodeMenuInfo.menu.wrapAround = qtrue;

	episodeMenuInfo.banner.generic.type			= MTYPE_BTEXT;
	episodeMenuInfo.banner.generic.x				= 320;
	episodeMenuInfo.banner.generic.y				= 16;
	episodeMenuInfo.banner.string				= "CHOOSE EPISODE";
	episodeMenuInfo.banner.color					= color_red;
	episodeMenuInfo.banner.style					= UI_CENTER;

	episodeMenuInfo.back.generic.type			= MTYPE_BITMAP;
	episodeMenuInfo.back.generic.name			= ART_BACK0;
	episodeMenuInfo.back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	episodeMenuInfo.back.generic.x				= 0;
	episodeMenuInfo.back.generic.y				= 480-64;
	episodeMenuInfo.back.generic.callback		= SPEpisode_BackEvent;
	episodeMenuInfo.back.generic.id				= ID_BACK;
	episodeMenuInfo.back.width					= 128;
	episodeMenuInfo.back.height					= 64;
	episodeMenuInfo.back.focuspic				= ART_BACK1;

	episodeMenuInfo.next.generic.type			= MTYPE_BITMAP;
	episodeMenuInfo.next.generic.name			= ART_NEXT0;
	episodeMenuInfo.next.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	episodeMenuInfo.next.generic.x				= 640;
	episodeMenuInfo.next.generic.y				= 480-64;
	episodeMenuInfo.next.generic.callback		= SPEpisode_SelectEvent;
	episodeMenuInfo.next.generic.id				= ID_NEXT;
	episodeMenuInfo.next.width					= 128;
	episodeMenuInfo.next.height					= 64;
	episodeMenuInfo.next.focuspic				= ART_NEXT1;

	episodeMenuInfo.preview.generic.type		= MTYPE_BITMAP;
	episodeMenuInfo.preview.generic.flags		= QMF_LEFT_JUSTIFY | QMF_OWNERDRAW;
	episodeMenuInfo.preview.generic.id			= ID_PICTURE0;
	episodeMenuInfo.preview.generic.ownerdraw	= SPEpisode_PreviewDraw;
	episodeMenuInfo.preview.generic.x			= 400;
	episodeMenuInfo.preview.generic.y			= 168;
	episodeMenuInfo.preview.width				= 128;
	episodeMenuInfo.preview.height				= 128;

	episodeMenuInfo.framel.generic.type		= MTYPE_BITMAP;
	episodeMenuInfo.framel.generic.name		= ART_FRAMEL;
	episodeMenuInfo.framel.generic.flags		= QMF_INACTIVE;
	episodeMenuInfo.framel.generic.x			= 0;
	episodeMenuInfo.framel.generic.y			= 78;
	episodeMenuInfo.framel.width				= 256;
	episodeMenuInfo.framel.height			= 329;

	episodeMenuInfo.framer.generic.type		= MTYPE_BITMAP;
	episodeMenuInfo.framer.generic.name		= ART_FRAMER;
	episodeMenuInfo.framer.generic.flags		= QMF_INACTIVE;
	episodeMenuInfo.framer.generic.x			= 376;
	episodeMenuInfo.framer.generic.y			= 76;
	episodeMenuInfo.framer.width				= 256;
	episodeMenuInfo.framer.height			= 334;

	episodeMenuInfo.list.generic.type		= MTYPE_SCROLLLIST;
	episodeMenuInfo.list.generic.flags		= QMF_PULSEIFFOCUS|QMF_CENTER_JUSTIFY;
	episodeMenuInfo.list.generic.callback	= SPEpisode_SelectEvent;
	episodeMenuInfo.list.generic.id			= ID_LIST;
	episodeMenuInfo.list.generic.x			= 240;
	episodeMenuInfo.list.generic.y			= 130;
	episodeMenuInfo.list.width				= 28;
	episodeMenuInfo.list.height				= 14;

	SPEpisode_LoadList();

	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.banner );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.framel );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.framer );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.preview );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.list );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.back );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.next );
}

static void SPEpisode_Menu() {
	SPEpisode_Init();
	UI_PushMenu(&episodeMenuInfo.menu);
}

static void SPMap_BackEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	UI_PopMenu();
}

static void SPMap_SelectEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	selectedMapIdx = mapMenuInfo.list.curvalue;
	singleMenuInfo.next.generic.flags &= ~QMF_GRAYED;
	mapSelected = qtrue;
	UI_PopMenu();
}

static void SPMap_LoadList() {
	int i;

	mapMenuInfo.list.numitems = episodeMapCount;
	for (i = 0; i<episodeMapCount; i++) {
		mapMenuInfo.list.itemnames[i] = episodeMaps[i].bspName;
	}
	if (selectedMapIdx >= 0) mapMenuInfo.list.curvalue = selectedMapIdx;
}

static void SPMap_PreviewDraw(void *self) {
	menubitmap_s *b;
	b = (menubitmap_s *)self;
		UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, episodeMaps[mapMenuInfo.list.curvalue].levelshotHandle);
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, episodeMaps[mapMenuInfo.list.curvalue].displayName, UI_CENTER|UI_SMALLFONT, color_white);

}

static void SPMap_Init() {
	memset( &mapMenuInfo, 0, sizeof(mapMenuInfo) );
	mapMenuInfo.menu.fullscreen = qtrue;
	mapMenuInfo.menu.wrapAround = qtrue;

	mapMenuInfo.banner.generic.type			= MTYPE_BTEXT;
	mapMenuInfo.banner.generic.x				= 320;
	mapMenuInfo.banner.generic.y				= 16;
	mapMenuInfo.banner.string				= "CHOOSE MAP";
	mapMenuInfo.banner.color					= color_red;
	mapMenuInfo.banner.style					= UI_CENTER;

	mapMenuInfo.back.generic.type			= MTYPE_BITMAP;
	mapMenuInfo.back.generic.name			= ART_BACK0;
	mapMenuInfo.back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	mapMenuInfo.back.generic.x				= 0;
	mapMenuInfo.back.generic.y				= 480-64;
	mapMenuInfo.back.generic.callback		= SPMap_BackEvent;
	mapMenuInfo.back.generic.id				= ID_BACK;
	mapMenuInfo.back.width					= 128;
	mapMenuInfo.back.height					= 64;
	mapMenuInfo.back.focuspic				= ART_BACK1;

	mapMenuInfo.next.generic.type			= MTYPE_BITMAP;
	mapMenuInfo.next.generic.name			= ART_NEXT0;
	mapMenuInfo.next.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	mapMenuInfo.next.generic.x				= 640;
	mapMenuInfo.next.generic.y				= 480-64;
	mapMenuInfo.next.generic.callback		= SPMap_SelectEvent;
	mapMenuInfo.next.generic.id				= ID_NEXT;
	mapMenuInfo.next.width					= 128;
	mapMenuInfo.next.height					= 64;
	mapMenuInfo.next.focuspic				= ART_NEXT1;

	mapMenuInfo.preview.generic.type		= MTYPE_BITMAP;
	mapMenuInfo.preview.generic.flags		= QMF_LEFT_JUSTIFY | QMF_OWNERDRAW;
	mapMenuInfo.preview.generic.id			= ID_PICTURE0;
	mapMenuInfo.preview.generic.ownerdraw	= SPMap_PreviewDraw;
	mapMenuInfo.preview.generic.x			= 400;
	mapMenuInfo.preview.generic.y			= 168;
	mapMenuInfo.preview.width				= 128;
	mapMenuInfo.preview.height				= 128;

	mapMenuInfo.framel.generic.type		= MTYPE_BITMAP;
	mapMenuInfo.framel.generic.name		= ART_FRAMEL;
	mapMenuInfo.framel.generic.flags		= QMF_INACTIVE;
	mapMenuInfo.framel.generic.x			= 0;
	mapMenuInfo.framel.generic.y			= 78;
	mapMenuInfo.framel.width				= 256;
	mapMenuInfo.framel.height			= 329;

	mapMenuInfo.framer.generic.type		= MTYPE_BITMAP;
	mapMenuInfo.framer.generic.name		= ART_FRAMER;
	mapMenuInfo.framer.generic.flags		= QMF_INACTIVE;
	mapMenuInfo.framer.generic.x			= 376;
	mapMenuInfo.framer.generic.y			= 76;
	mapMenuInfo.framer.width				= 256;
	mapMenuInfo.framer.height			= 334;

	mapMenuInfo.list.generic.type		= MTYPE_SCROLLLIST;
	mapMenuInfo.list.generic.flags		= QMF_PULSEIFFOCUS|QMF_CENTER_JUSTIFY;
	mapMenuInfo.list.generic.callback	= SPMap_SelectEvent;
	mapMenuInfo.list.generic.id			= ID_LIST;
	mapMenuInfo.list.generic.x			= 240;
	mapMenuInfo.list.generic.y			= 130;
	mapMenuInfo.list.width				= 28;
	mapMenuInfo.list.height				= 14;

	SPMap_LoadList();

	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.banner );
	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.framel );
	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.framer );
	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.list );
	Menu_AddItem(&mapMenuInfo.menu, &mapMenuInfo.preview);
	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.back );
	Menu_AddItem( &mapMenuInfo.menu, &mapMenuInfo.next );
}

static void SPMap_Menu() {
	SPMap_Init();
	UI_PushMenu(&mapMenuInfo.menu);
}



/*
=================
UI_SPLevelMenu_NextEvent
=================
*/
static void UI_SPLevelMenu_NextEvent( void* ptr, int notification ) {
	if (notification != QM_ACTIVATED) {
		return;
	}
	if (!mapSelected) return;
	if (episodeMaps[selectedMapIdx].skipSkillSelect) {
		UI_SPLevel_Start(UI_GetArenaInfoByNumber(episodeMaps[selectedMapIdx].arenaIdx));
	} else {
		UI_SPSkillMenu(UI_GetArenaInfoByNumber(episodeMaps[selectedMapIdx].arenaIdx), qfalse);
	}
}


/*
=================
UI_SPLevelMenu_BackEvent
=================
*/
static void UI_SPLevelMenu_BackEvent( void* ptr, int notification ) {
	if (notification != QM_ACTIVATED) {
		return;
	}

	UI_PopMenu();
}





/*
=================
UI_SPLevelMenu_Cache
=================
*/
void UI_SPLevelMenu_Cache( void ) {

}

static void SPLevel_EpisodeDraw(void *self) {
	menubitmap_s *b = (menubitmap_s *)self;
	if (b->generic.parent->cursor == b->generic.menuPosition) {
		UI_FillRect(b->generic.x-3, b->generic.y-3, b->width+6, b->height+6, color_orange);
	}
	if (episodeSelected) {
		UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, spEpisodes[selectedEpisodeIdx].shotHandle);
	} else {

		UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, NO_SELECTION);
	}
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, episodeSelected ? spEpisodes[selectedEpisodeIdx].name : "No episode selected", UI_CENTER|UI_SMALLFONT, color_white);
}

static void SPLevel_EpisodeEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	SPEpisode_Menu();
}

static void SPLevel_MapDraw(void *self) {
	menubitmap_s *b;
	b = (menubitmap_s *)self;
	if (b->generic.parent->cursor == b->generic.menuPosition) {
		UI_FillRect(b->generic.x-3, b->generic.y-3, b->width+6, b->height+6, color_orange);
	}
	if (mapSelected) {
		UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, episodeMaps[selectedMapIdx].levelshotHandle);
	} else {
		UI_DrawHandlePic(b->generic.x, b->generic.y, b->width, b->height, NO_SELECTION);

		if (b->generic.flags & QMF_GRAYED) {
			vec4_t darkDim = {0.00f, 0.00f, 0.00f, 0.95f};
			UI_FillRect(b->generic.x, b->generic.y, b->width, b->height, darkDim);

		}

	}
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, mapSelected ? episodeMaps[selectedEpisodeIdx].displayName : "No map selected", UI_CENTER|UI_SMALLFONT, color_white);
}

static void SPLevel_MapEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	SPMap_Menu();
}

static void SPMenu_LoadEpFile(char *id, char *buf) {
	int				len;
	fileHandle_t	f;
	char			filename[MAX_QPATH];


	Com_sprintf(filename, sizeof(filename), "scripts/%s.q3ep", id);
	buf[0] = '\0';
	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
		return;
	}
	if ( len >= MAX_ARENAS_TEXT ) {
		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
		trap_FS_FCloseFile( f );
		return;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

}

static void SPMenu_ParseEp( char *buf,  char *info) {
	char	*token;
	char	key[MAX_TOKEN_CHARS];

	token = COM_Parse( &buf );

	if ( !token[0] ) {
		return;
	}
	if ( strcmp( token, "{" ) ) {
		Com_Printf( "Missing { in info file\n" );
		return ;
	}
	info[0] = '\0';
	while ( 1 ) {
		token = COM_ParseExt( &buf, qtrue );
		if ( !token[0] ) {
			Com_Printf( "Unexpected end of info file\n" );
			break;
		}
		if ( !strcmp( token, "}" ) ) {
			break;
		}
		Q_strncpyz( key, token, sizeof( key ) );

		token = COM_ParseExt( &buf, qfalse );
		if ( !token[0] ) {
			strcpy( token, "<NULL>" );
		}
		Info_SetValueForKey( info, key, token );
	}
}

static void SPMenu_LoadData() {
	int			i,j;
	int			count;
	const char	*arenaInfo;
	qboolean foundEpisode;
	char *arenaEpisode;
	episodeInfo_t *episode;
	char			buf[MAX_ARENAS_TEXT];
	char	info[MAX_INFO_STRING];

	memset(spEpisodes, 0, sizeof(spEpisodes));

	episode = &spEpisodes[0];
	Q_strncpyz(episode->id, "zzznoep", sizeof(episode->id));
	Q_strncpyz(episode->name, "Standalone maps", sizeof(episode->name));
	if (!episode->shotHandle) episode->shotHandle = trap_R_RegisterShaderNoMip(ART_MAP_UNKNOWN);

	spEpisodeCount = 1;
	count = UI_GetNumArenas();
	for (i = 0; i < count; i++) {
		arenaInfo = UI_GetArenaInfoByNumber(i);

		if ( !strstr(Info_ValueForKey(arenaInfo, "type"), "q3sp")) {
			continue;
		}

		arenaEpisode = Info_ValueForKey(arenaInfo, "episode");
		if (arenaEpisode[0]) {
			foundEpisode = qfalse;
			for (j = 1; j < spEpisodeCount; j++) {
				if (!Q_stricmp (spEpisodes[j].id, arenaEpisode)) {
					episode = &spEpisodes[j];
					foundEpisode = qtrue;
					break;
				}
			}
			if (!foundEpisode) {
				if (spEpisodeCount < MAX_SP_EPISODES){
					episode = &spEpisodes[spEpisodeCount];
					Q_strncpyz(episode->id, arenaEpisode, sizeof(episode->id));
					SPMenu_LoadEpFile(episode->id, buf);
					if (buf[0]) {
						SPMenu_ParseEp(buf, info);

						Q_strncpyz(episode->name, Info_ValueForKey(info, "name"), sizeof(episode->name));
						Q_strncpyz(episode->levelshot, Info_ValueForKey(info, "levelshot"), sizeof(episode->levelshot));
						episode->shotHandle = trap_R_RegisterShaderNoMip(va( "levelshots/%s.tga", episode->levelshot ) );


					} else {
						Q_strncpyz(episode->name, episode->id, sizeof(episode->name));
					}
					if (!episode->shotHandle) episode->shotHandle = trap_R_RegisterShaderNoMip(ART_MAP_UNKNOWN);
					spEpisodeCount++;
				}
			}
		}

	}
}

/*
=================
UI_SPLevelMenu_Init
=================
*/
static void UI_SPLevelMenu_Init( void ) {
	int		skill;
	int		n;
	int		x, y;
	int		count;
	char	buf[MAX_QPATH];

	if (!NO_SELECTION)	NO_SELECTION = trap_R_RegisterShaderNoMip(ART_MAP_UNKNOWN);

	skill = (int)trap_Cvar_VariableValue( "g_spSkill" );
	if( skill < 1 || skill > 5 ) {
		trap_Cvar_Set( "g_spSkill", "3" );
		skill = 3;
	}
	selectedEpisodeIdx = -1;
	episodeSelected = qfalse;
	selectedMapIdx = -1;
	mapSelected = qfalse;
	SPMenu_LoadData();

	memset( &singleMenuInfo, 0, sizeof(singleMenuInfo) );
	singleMenuInfo.menu.fullscreen = qtrue;
	singleMenuInfo.menu.wrapAround = qtrue;

	singleMenuInfo.banner.generic.type			= MTYPE_BTEXT;
	singleMenuInfo.banner.generic.x				= 320;
	singleMenuInfo.banner.generic.y				= 16;
	singleMenuInfo.banner.string				= "SINGLE PLAYER";
	singleMenuInfo.banner.color					= color_red;
	singleMenuInfo.banner.style					= UI_CENTER;

	singleMenuInfo.episode.generic.type		= MTYPE_BITMAP;
	singleMenuInfo.episode.generic.flags		= QMF_LEFT_JUSTIFY | QMF_PULSEIFFOCUS | QMF_OWNERDRAW;
	singleMenuInfo.episode.generic.ownerdraw	= SPLevel_EpisodeDraw;
	singleMenuInfo.episode.generic.callback	= SPLevel_EpisodeEvent;
	singleMenuInfo.episode.generic.id			= ID_PICTURE0;
	singleMenuInfo.episode.generic.x			= 64;
	singleMenuInfo.episode.generic.y			= 100;
	singleMenuInfo.episode.width				= 240;
	singleMenuInfo.episode.height				= 240;


	singleMenuInfo.map.generic.type		= MTYPE_BITMAP;
	singleMenuInfo.map.generic.flags		= QMF_LEFT_JUSTIFY | QMF_PULSEIFFOCUS | QMF_OWNERDRAW |QMF_GRAYED;
	singleMenuInfo.map.generic.ownerdraw	= SPLevel_MapDraw;
	singleMenuInfo.map.generic.callback	= SPLevel_MapEvent;
	singleMenuInfo.map.generic.id			= ID_PICTURE1;
	singleMenuInfo.map.generic.x			= 336;
	singleMenuInfo.map.generic.y			= 100;
	singleMenuInfo.map.width				= 240;
	singleMenuInfo.map.height				= 240;

	singleMenuInfo.back.generic.type			= MTYPE_BITMAP;
	singleMenuInfo.back.generic.name			= ART_BACK0;
	singleMenuInfo.back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	singleMenuInfo.back.generic.x				= 0;
	singleMenuInfo.back.generic.y				= 480-64;
	singleMenuInfo.back.generic.callback		= UI_SPLevelMenu_BackEvent;
	singleMenuInfo.back.generic.id				= ID_BACK;
	singleMenuInfo.back.width					= 128;
	singleMenuInfo.back.height					= 64;
	singleMenuInfo.back.focuspic				= ART_BACK1;

	singleMenuInfo.next.generic.type			= MTYPE_BITMAP;
	singleMenuInfo.next.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED;
	singleMenuInfo.next.generic.x				= 640;
	singleMenuInfo.next.generic.y				= 480-64;
	singleMenuInfo.next.generic.callback		= UI_SPLevelMenu_NextEvent;
	singleMenuInfo.next.generic.id				= ID_NEXT;
	singleMenuInfo.next.width					= 128;
	singleMenuInfo.next.height					= 64;
	singleMenuInfo.next.generic.name			= ART_FIGHT0;
	singleMenuInfo.next.focuspic				= ART_FIGHT1;

	Menu_AddItem( &singleMenuInfo.menu, &singleMenuInfo.banner );
	Menu_AddItem( &singleMenuInfo.menu, &singleMenuInfo.back );
	Menu_AddItem(&singleMenuInfo.menu, &singleMenuInfo.episode);
	Menu_AddItem(&singleMenuInfo.menu, &singleMenuInfo.map);
	Menu_AddItem( &singleMenuInfo.menu, &singleMenuInfo.next );
}


/*
=================
UI_SPLevelMenu
=================
*/
void UI_SPLevelMenu( void ) {
	UI_SPLevelMenu_Init();
	UI_PushMenu(&singleMenuInfo.menu);
	// Menu_SetCursorToItem(&singleMenuInfo.menu, &singleMenuInfo.back);
}


/*
=================
UI_SPLevelMenu_f
=================
*/
void UI_SPLevelMenu_f( void ) {
	trap_Key_SetCatcher( KEYCATCH_UI );
	uis.menusp = 0;
	UI_SPLevelMenu();
}


/*
=================
UI_SPLevelMenu_ReInit
=================
*/
void UI_SPLevelMenu_ReInit( void ) {
}

void UI_SPLevel_Start() {
	char	*map;


	trap_Cvar_SetValue( "sv_maxclients", 1 );

	trap_Cvar_SetValue( "g_gametype", GT_SINGLE_PLAYER );

	trap_Cmd_ExecuteText( EXEC_APPEND, va( "map %s\n", episodeMaps[selectedMapIdx].bspName ) );
}