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
#define MAX_NAMELENGTH	16
#define MAX_SP_EPISODES 128

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
	int arenaIdxs[MAX_ARENAS];
	int nummaps;
} episodeInfo_t;

typedef struct {
	menuframework_s	menu;
	menutext_s		item_banner;
	menubitmap_s	item_episode;
	menubitmap_s	item_map;
	menubitmap_s	item_back;

	int				currentmap;
	int				nummaps;
	int				page;
	int				maxpages;
	char			maplist[MAX_SERVERMAPS][MAX_NAMELENGTH];

} singleMenuInfo_t;

typedef struct {
	menuframework_s menu;
	menutext_s		banner;
	menubitmap_s	back;
	menubitmap_s	framel;
	menubitmap_s	framer;
	menulist_s		list;
} episodeMenuInfo_t;

static singleMenuInfo_t singleMenuInfo;
static episodeMenuInfo_t episodeMenuInfo;

static episodeInfo_t spEpisodes[MAX_SP_EPISODES];
static int spEpisodeCount;


static void SPEpisode_BackEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	UI_PopMenu();
}

static void SPEpisode_SelectEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	UI_PopMenu();
}

static void SPEpisode_LoadList() {
	int i;

	episodeMenuInfo.list.numitems = spEpisodeCount;
	for (i = 0; i<spEpisodeCount; i++) {
		episodeMenuInfo.list.itemnames[i] = spEpisodes[i].name;
	}
}

static void SPEpisode_Init() {
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
	episodeMenuInfo.list.generic.x			= 320;
	episodeMenuInfo.list.generic.y			= 130;
	episodeMenuInfo.list.width				= 48;
	episodeMenuInfo.list.height				= 14;

	SPEpisode_LoadList();

	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.banner );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.framel );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.framer );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.list );
	Menu_AddItem( &episodeMenuInfo.menu, &episodeMenuInfo.back );
}

static void SPEpisode_Menu() {
	SPEpisode_Init();
	UI_PushMenu(&episodeMenuInfo.menu);
}



/*
=================
UI_SPLevelMenu_SetMenuItems
=================
*/
static void UI_SPLevelMenu_SetMenuArena( int n, int level, const char *arenaInfo ) {

}

static void UI_SPLevelMenu_SetMenuItems( void ) {

}


/*
=================
UI_SPLevelMenu_NextEvent
=================
*/
static void UI_SPLevelMenu_NextEvent( void* ptr, int notification ) {

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
	UI_FillRect(b->generic.x, b->generic.y, b->width, b->height, color_orange);
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, "EPISODE", UI_CENTER|UI_SMALLFONT, color_white);
}

static void SPLevel_EpisodeEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
	SPEpisode_Menu();
}

static void SPLevel_MapDraw(void *self) {
	menubitmap_s *b = (menubitmap_s *)self;
	UI_FillRect(b->generic.x, b->generic.y, b->width, b->height, color_blue);
	UI_DrawString(b->generic.x + b->width / 2, b->generic.y + b->height + 8, "MAP", UI_CENTER|UI_SMALLFONT, color_white);
}

static void SPLevel_MapEvent( void *ptr, int event) {
	if (event != QM_ACTIVATED) return;
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
	Q_strncpyz(episode->name, "No episode defined", sizeof(episode->name));

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
					episode->arenaIdxs[episode->nummaps] = i;
					episode->nummaps++;
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
					} else {
						Q_strncpyz(episode->name, episode->id, sizeof(episode->name));
					}
					spEpisodeCount++;
					episode->arenaIdxs[episode->nummaps] = i;
					episode->nummaps++;
				} else {
					// overflow goes in unsorted
					trap_Print( va( S_COLOR_RED "maximum episodes hit, id: %s\n", episode->id ) );
					episode = &spEpisodes[0];
					episode->arenaIdxs[episode->nummaps] = i;
					episode->nummaps++;
				}
			}
		} else {
			episode = &spEpisodes[0];
			episode->arenaIdxs[episode->nummaps] = i;
			episode->nummaps++;
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

	skill = (int)trap_Cvar_VariableValue( "g_spSkill" );
	if( skill < 1 || skill > 5 ) {
		trap_Cvar_Set( "g_spSkill", "3" );
		skill = 3;
	}

	SPMenu_LoadData();

	memset( &singleMenuInfo, 0, sizeof(singleMenuInfo) );
	singleMenuInfo.menu.fullscreen = qtrue;
	singleMenuInfo.menu.wrapAround = qtrue;
	// singleMenuInfo.menu.draw = UI_SPLevelBotladderMenu_MenuDraw;
	singleMenuInfo.item_banner.generic.type			= MTYPE_BTEXT;
	singleMenuInfo.item_banner.generic.x				= 320;
	singleMenuInfo.item_banner.generic.y				= 16;
	singleMenuInfo.item_banner.string				= "CHOOSE LEVEL";
	singleMenuInfo.item_banner.color					= color_red;
	singleMenuInfo.item_banner.style					= UI_CENTER;

	singleMenuInfo.item_episode.generic.type		= MTYPE_BITMAP;
	singleMenuInfo.item_episode.generic.flags		= QMF_LEFT_JUSTIFY | QMF_PULSEIFFOCUS | QMF_OWNERDRAW;
	singleMenuInfo.item_episode.generic.ownerdraw	= SPLevel_EpisodeDraw;
	singleMenuInfo.item_episode.generic.callback	= SPLevel_EpisodeEvent;
	singleMenuInfo.item_episode.generic.id			= ID_PICTURE0;
	singleMenuInfo.item_episode.generic.x			= 64;
	singleMenuInfo.item_episode.generic.y			= 100;
	singleMenuInfo.item_episode.width				= 240;
	singleMenuInfo.item_episode.height				= 240;

	singleMenuInfo.item_map.generic.type		= MTYPE_BITMAP;
	singleMenuInfo.item_map.generic.flags		= QMF_LEFT_JUSTIFY | QMF_PULSEIFFOCUS | QMF_OWNERDRAW;
	singleMenuInfo.item_map.generic.ownerdraw	= SPLevel_MapDraw;
	singleMenuInfo.item_map.generic.callback	= SPLevel_MapEvent;
	singleMenuInfo.item_map.generic.id			= ID_PICTURE1;
	singleMenuInfo.item_map.generic.x			= 336;
	singleMenuInfo.item_map.generic.y			= 100;
	singleMenuInfo.item_map.width				= 240;
	singleMenuInfo.item_map.height				= 240;

	singleMenuInfo.item_back.generic.type			= MTYPE_BITMAP;
	singleMenuInfo.item_back.generic.name			= ART_BACK0;
	singleMenuInfo.item_back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	singleMenuInfo.item_back.generic.x				= 0;
	singleMenuInfo.item_back.generic.y				= 480-64;
	singleMenuInfo.item_back.generic.callback		= UI_SPLevelMenu_BackEvent;
	singleMenuInfo.item_back.generic.id				= ID_BACK;
	singleMenuInfo.item_back.width					= 128;
	singleMenuInfo.item_back.height					= 64;
	singleMenuInfo.item_back.focuspic				= ART_BACK1;

	Menu_AddItem( &singleMenuInfo.menu, &singleMenuInfo.item_banner );
	Menu_AddItem(&singleMenuInfo.menu, &singleMenuInfo.item_episode);
	Menu_AddItem(&singleMenuInfo.menu, &singleMenuInfo.item_map);
	Menu_AddItem( &singleMenuInfo.menu, &singleMenuInfo.item_back );
}


/*
=================
UI_SPLevelMenu
=================
*/
void UI_SPLevelMenu( void ) {
	UI_SPLevelMenu_Init();
	UI_PushMenu(&singleMenuInfo.menu);
	Menu_SetCursorToItem(&singleMenuInfo.menu, &singleMenuInfo.item_back);
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
