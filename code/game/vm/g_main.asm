data
align 4
LABELV gameCvarTable
address g_cheats
address $54
address $55
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
address $56
address $57
byte 4 68
byte 4 0
byte 4 0
skip 4
byte 4 0
address $58
address $59
byte 4 64
byte 4 0
byte 4 0
skip 4
address g_restarted
address $60
address $61
byte 4 64
byte 4 0
byte 4 0
skip 4
byte 4 0
address $62
address $55
byte 4 68
byte 4 0
byte 4 0
skip 4
address g_gametype
address $63
address $61
byte 4 38
byte 4 0
byte 4 0
skip 4
address g_maxclients
address $64
address $65
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_maxGameClients
address $66
address $61
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_dmflags
address $67
address $61
byte 4 5
byte 4 0
byte 4 1
skip 4
address g_fraglimit
address $68
address $69
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_timelimit
address $70
address $61
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_capturelimit
address $71
address $65
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_synchronousClients
address $72
address $61
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_friendlyFire
address $73
address $61
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_teamAutoJoin
address $74
address $61
byte 4 1
skip 12
address g_teamForceBalance
address $75
address $61
byte 4 1
skip 12
address g_warmup
address $76
address $69
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_doWarmup
address $77
address $61
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_log
address $78
address $79
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_logSync
address $80
address $61
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_password
address $81
address $55
byte 4 2
byte 4 0
byte 4 0
skip 4
address g_banIPs
address $82
address $55
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_filterBan
address $83
address $84
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_needpass
address $85
address $61
byte 4 68
byte 4 0
byte 4 0
skip 4
address g_dedicated
address $86
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_speed
address $87
address $88
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_gravity
address $89
address $90
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_knockback
address $91
address $92
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_quadfactor
address $93
address $94
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponRespawn
address $95
address $96
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponTeamRespawn
address $97
address $98
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_forcerespawn
address $99
address $69
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_inactivity
address $100
address $61
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_debugMove
address $101
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugDamage
address $102
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugAlloc
address $103
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_motd
address $104
address $55
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_blood
address $105
address $84
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDist
address $106
address $107
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDrop
address $108
address $109
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_allowVote
address $110
address $84
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_listEntity
address $111
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_smoothClients
address $112
address $84
byte 4 0
byte 4 0
byte 4 0
skip 4
address pmove_fixed
address $113
address $61
byte 4 8
byte 4 0
byte 4 0
skip 4
address pmove_msec
address $114
address $65
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_rankings
address $115
address $61
byte 4 0
byte 4 0
byte 4 0
skip 4
align 4
LABELV gameCvarTableSize
byte 4 46
export vmMain
code
proc vmMain 16 12
file "game/g_main.c"
line 203
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Quake III Arena source code.
;6:
;7:Quake III Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Quake III Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Foobar; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22://
;23:
;24:#include "g_local.h"
;25:
;26:level_locals_t	level;
;27:
;28:typedef struct {
;29:	vmCvar_t	*vmCvar;
;30:	char		*cvarName;
;31:	char		*defaultString;
;32:	int			cvarFlags;
;33:	int			modificationCount;  // for tracking changes
;34:	qboolean	trackChange;	    // track this variable, and announce if changed
;35:  qboolean teamShader;        // track and if changed, update shader state
;36:} cvarTable_t;
;37:
;38:gentity_t		g_entities[MAX_GENTITIES];
;39:gclient_t		g_clients[MAX_CLIENTS];
;40:
;41:vmCvar_t	g_gametype;
;42:vmCvar_t	g_dmflags;
;43:vmCvar_t	g_fraglimit;
;44:vmCvar_t	g_timelimit;
;45:vmCvar_t	g_capturelimit;
;46:vmCvar_t	g_friendlyFire;
;47:vmCvar_t	g_password;
;48:vmCvar_t	g_needpass;
;49:vmCvar_t	g_maxclients;
;50:vmCvar_t	g_maxGameClients;
;51:vmCvar_t	g_dedicated;
;52:vmCvar_t	g_speed;
;53:vmCvar_t	g_gravity;
;54:vmCvar_t	g_cheats;
;55:vmCvar_t	g_knockback;
;56:vmCvar_t	g_quadfactor;
;57:vmCvar_t	g_forcerespawn;
;58:vmCvar_t	g_inactivity;
;59:vmCvar_t	g_debugMove;
;60:vmCvar_t	g_debugDamage;
;61:vmCvar_t	g_debugAlloc;
;62:vmCvar_t	g_weaponRespawn;
;63:vmCvar_t	g_weaponTeamRespawn;
;64:vmCvar_t	g_motd;
;65:vmCvar_t	g_synchronousClients;
;66:vmCvar_t	g_warmup;
;67:vmCvar_t	g_doWarmup;
;68:vmCvar_t	g_restarted;
;69:vmCvar_t	g_log;
;70:vmCvar_t	g_logSync;
;71:vmCvar_t	g_blood;
;72:vmCvar_t	g_podiumDist;
;73:vmCvar_t	g_podiumDrop;
;74:vmCvar_t	g_allowVote;
;75:vmCvar_t	g_teamAutoJoin;
;76:vmCvar_t	g_teamForceBalance;
;77:vmCvar_t	g_banIPs;
;78:vmCvar_t	g_filterBan;
;79:vmCvar_t	g_smoothClients;
;80:vmCvar_t	pmove_fixed;
;81:vmCvar_t	pmove_msec;
;82:vmCvar_t	g_rankings;
;83:vmCvar_t	g_listEntity;
;84:#ifdef MISSIONPACK
;85:vmCvar_t	g_obeliskHealth;
;86:vmCvar_t	g_obeliskRegenPeriod;
;87:vmCvar_t	g_obeliskRegenAmount;
;88:vmCvar_t	g_obeliskRespawnDelay;
;89:vmCvar_t	g_cubeTimeout;
;90:vmCvar_t	g_redteam;
;91:vmCvar_t	g_blueteam;
;92:vmCvar_t	g_singlePlayer;
;93:vmCvar_t	g_enableDust;
;94:vmCvar_t	g_enableBreath;
;95:vmCvar_t	g_proxMineTimeout;
;96:#endif
;97:
;98:// bk001129 - made static to avoid aliasing
;99:static cvarTable_t		gameCvarTable[] = {
;100:	// don't override the cheat state set by the system
;101:	{ &g_cheats, "sv_cheats", "", 0, 0, qfalse },
;102:
;103:	// noset vars
;104:	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;105:	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },
;106:	{ &g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse  },
;107:	{ NULL, "sv_mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;108:
;109:	// latched vars
;110:	{ &g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse  },
;111:
;112:	{ &g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;113:	{ &g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;114:
;115:	// change anytime vars
;116:	{ &g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue  },
;117:	{ &g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;118:	{ &g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;119:	{ &g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;120:
;121:	{ &g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse  },
;122:
;123:	{ &g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue  },
;124:
;125:	{ &g_teamAutoJoin, "g_teamAutoJoin", "0", CVAR_ARCHIVE  },
;126:	{ &g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE  },
;127:
;128:	{ &g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue  },
;129:	{ &g_doWarmup, "g_doWarmup", "0", 0, 0, qtrue  },
;130:	{ &g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse  },
;131:	{ &g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse  },
;132:
;133:	{ &g_password, "g_password", "", CVAR_USERINFO, 0, qfalse  },
;134:
;135:	{ &g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse  },
;136:	{ &g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse  },
;137:
;138:	{ &g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },
;139:
;140:	{ &g_dedicated, "dedicated", "0", 0, 0, qfalse  },
;141:
;142:	{ &g_speed, "g_speed", "320", 0, 0, qtrue  },
;143:	{ &g_gravity, "g_gravity", "800", 0, 0, qtrue  },
;144:	{ &g_knockback, "g_knockback", "1000", 0, 0, qtrue  },
;145:	{ &g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue  },
;146:	{ &g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue  },
;147:	{ &g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue },
;148:	{ &g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue },
;149:	{ &g_inactivity, "g_inactivity", "0", 0, 0, qtrue },
;150:	{ &g_debugMove, "g_debugMove", "0", 0, 0, qfalse },
;151:	{ &g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse },
;152:	{ &g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse },
;153:	{ &g_motd, "g_motd", "", 0, 0, qfalse },
;154:	{ &g_blood, "com_blood", "1", 0, 0, qfalse },
;155:
;156:	{ &g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse },
;157:	{ &g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse },
;158:
;159:	{ &g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse },
;160:	{ &g_listEntity, "g_listEntity", "0", 0, 0, qfalse },
;161:
;162:#ifdef MISSIONPACK
;163:	{ &g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse },
;164:	{ &g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse },
;165:	{ &g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse },
;166:	{ &g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse },
;167:
;168:	{ &g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse },
;169:	{ &g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue },
;170:	{ &g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue  },
;171:	{ &g_singlePlayer, "ui_singlePlayerActive", "", 0, 0, qfalse, qfalse  },
;172:
;173:	{ &g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;174:	{ &g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;175:	{ &g_proxMineTimeout, "g_proxMineTimeout", "20000", 0, 0, qfalse },
;176:#endif
;177:	{ &g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse},
;178:	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse},
;179:	{ &pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse},
;180:
;181:	{ &g_rankings, "g_rankings", "0", 0, 0, qfalse}
;182:
;183:};
;184:
;185:// bk001129 - made static to avoid aliasing
;186:static int gameCvarTableSize = sizeof( gameCvarTable ) / sizeof( gameCvarTable[0] );
;187:
;188:
;189:void G_InitGame( int levelTime, int randomSeed, int restart );
;190:void G_RunFrame( int levelTime );
;191:void G_ShutdownGame( int restart );
;192:void CheckExitRules( void );
;193:
;194:
;195:/*
;196:================
;197:vmMain
;198:
;199:This is the only way control passes into the module.
;200:This must be the very first function compiled into the .q3vm file
;201:================
;202:*/
;203:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 204
;204:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $117
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $117
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $130
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $130
address $119
address $120
address $121
address $125
address $123
address $124
address $126
address $122
address $127
address $128
address $129
code
LABELV $119
line 206
;205:	case GAME_INIT:
;206:		G_InitGame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 G_InitGame
CALLV
pop
line 207
;207:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $120
line 209
;208:	case GAME_SHUTDOWN:
;209:		G_ShutdownGame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_ShutdownGame
CALLV
pop
line 210
;210:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $121
line 212
;211:	case GAME_CLIENT_CONNECT:
;212:		return (int)ClientConnect( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CVUI4 4
RETI4
ADDRGP4 $116
JUMPV
LABELV $122
line 214
;213:	case GAME_CLIENT_THINK:
;214:		ClientThink( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientThink
CALLV
pop
line 215
;215:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $123
line 217
;216:	case GAME_CLIENT_USERINFO_CHANGED:
;217:		ClientUserinfoChanged( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 218
;218:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $124
line 220
;219:	case GAME_CLIENT_DISCONNECT:
;220:		ClientDisconnect( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientDisconnect
CALLV
pop
line 221
;221:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $125
line 223
;222:	case GAME_CLIENT_BEGIN:
;223:		ClientBegin( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 224
;224:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $126
line 226
;225:	case GAME_CLIENT_COMMAND:
;226:		ClientCommand( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientCommand
CALLV
pop
line 227
;227:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $127
line 229
;228:	case GAME_RUN_FRAME:
;229:		G_RunFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_RunFrame
CALLV
pop
line 230
;230:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $116
JUMPV
LABELV $128
line 232
;231:	case GAME_CONSOLE_COMMAND:
;232:		return ConsoleCommand();
ADDRLP4 8
ADDRGP4 ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $116
JUMPV
LABELV $129
line 234
;233:	case BOTAI_START_FRAME:
;234:		return BotAIStartFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 BotAIStartFrame
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $116
JUMPV
LABELV $117
line 237
;235:	}
;236:
;237:	return -1;
CNSTI4 -1
RETI4
LABELV $116
endproc vmMain 16 12
export G_Printf
proc G_Printf 1028 12
line 241
;238:}
;239:
;240:
;241:void QDECL G_Printf( const char *fmt, ... ) {
line 245
;242:	va_list		argptr;
;243:	char		text[1024];
;244:
;245:	va_start (argptr, fmt);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 246
;246:	vsprintf (text, fmt, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 247
;247:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 249
;248:
;249:	trap_Printf( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 250
;250:}
LABELV $131
endproc G_Printf 1028 12
export G_Error
proc G_Error 1028 12
line 252
;251:
;252:void QDECL G_Error( const char *fmt, ... ) {
line 256
;253:	va_list		argptr;
;254:	char		text[1024];
;255:
;256:	va_start (argptr, fmt);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 257
;257:	vsprintf (text, fmt, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 258
;258:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 260
;259:
;260:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 261
;261:}
LABELV $133
endproc G_Error 1028 12
export G_FindTeams
proc G_FindTeams 48 12
line 274
;262:
;263:/*
;264:================
;265:G_FindTeams
;266:
;267:Chain together all entities with a matching team field.
;268:Entity teams are used for item groups and multi-entity mover groups.
;269:
;270:All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
;271:All but the last will have the teamchain field set to the next one
;272:================
;273:*/
;274:void G_FindTeams( void ) {
line 279
;275:	gentity_t	*e, *e2;
;276:	int		i, j;
;277:	int		c, c2;
;278:
;279:	c = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 280
;280:	c2 = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 281
;281:	for ( i=1, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
CNSTI4 820
ADDRLP4 16
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
ADDRGP4 $139
JUMPV
LABELV $136
line 282
;282:		if (!e->inuse)
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $141
line 283
;283:			continue;
ADDRGP4 $137
JUMPV
LABELV $141
line 284
;284:		if (!e->team)
ADDRLP4 4
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $143
line 285
;285:			continue;
ADDRGP4 $137
JUMPV
LABELV $143
line 286
;286:		if (e->flags & FL_TEAMSLAVE)
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $145
line 287
;287:			continue;
ADDRGP4 $137
JUMPV
LABELV $145
line 288
;288:		e->teammaster = e;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 289
;289:		c++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 290
;290:		c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 291
;291:		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
ADDRGP4 $150
JUMPV
LABELV $147
line 292
;292:		{
line 293
;293:			if (!e2->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $152
line 294
;294:				continue;
ADDRGP4 $148
JUMPV
LABELV $152
line 295
;295:			if (!e2->team)
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $154
line 296
;296:				continue;
ADDRGP4 $148
JUMPV
LABELV $154
line 297
;297:			if (e2->flags & FL_TEAMSLAVE)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $156
line 298
;298:				continue;
ADDRGP4 $148
JUMPV
LABELV $156
line 299
;299:			if (!strcmp(e->team, e2->team))
ADDRLP4 28
CNSTI4 656
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $158
line 300
;300:			{
line 301
;301:				c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 302
;302:				e2->teamchain = e->teamchain;
ADDRLP4 36
CNSTI4 780
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 303
;303:				e->teamchain = e2;
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 304
;304:				e2->teammaster = e;
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 305
;305:				e2->flags |= FL_TEAMSLAVE;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 308
;306:
;307:				// make sure that targets only point at the master
;308:				if ( e2->targetname ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $160
line 309
;309:					e->targetname = e2->targetname;
ADDRLP4 44
CNSTI4 652
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 310
;310:					e2->targetname = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTP4 0
ASGNP4
line 311
;311:				}
LABELV $160
line 312
;312:			}
LABELV $158
line 313
;313:		}
LABELV $148
line 291
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
LABELV $150
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $147
line 314
;314:	}
LABELV $137
line 281
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
LABELV $139
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $136
line 316
;315:
;316:	G_Printf ("%i teams with %i entities\n", c, c2);
ADDRGP4 $162
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 317
;317:}
LABELV $135
endproc G_FindTeams 48 12
export G_RemapTeamShaders
proc G_RemapTeamShaders 0 0
line 319
;318:
;319:void G_RemapTeamShaders() {
line 331
;320:#ifdef MISSIONPACK
;321:	char string[1024];
;322:	float f = level.time * 0.001;
;323:	Com_sprintf( string, sizeof(string), "team_icon/%s_red", g_redteam.string );
;324:	AddRemap("textures/ctf2/redteam01", string, f); 
;325:	AddRemap("textures/ctf2/redteam02", string, f); 
;326:	Com_sprintf( string, sizeof(string), "team_icon/%s_blue", g_blueteam.string );
;327:	AddRemap("textures/ctf2/blueteam01", string, f); 
;328:	AddRemap("textures/ctf2/blueteam02", string, f); 
;329:	trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
;330:#endif
;331:}
LABELV $163
endproc G_RemapTeamShaders 0 0
export G_RegisterCvars
proc G_RegisterCvars 20 16
line 339
;332:
;333:
;334:/*
;335:=================
;336:G_RegisterCvars
;337:=================
;338:*/
;339:void G_RegisterCvars( void ) {
line 342
;340:	int			i;
;341:	cvarTable_t	*cv;
;342:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 344
;343:
;344:	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $168
JUMPV
LABELV $165
line 345
;345:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 347
;346:			cv->defaultString, cv->cvarFlags );
;347:		if ( cv->vmCvar )
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $169
line 348
;348:			cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
LABELV $169
line 350
;349:
;350:		if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $171
line 351
;351:			remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 352
;352:		}
LABELV $171
line 353
;353:	}
LABELV $166
line 344
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $168
ADDRLP4 4
INDIRI4
ADDRGP4 gameCvarTableSize
INDIRI4
LTI4 $165
line 355
;354:
;355:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $173
line 356
;356:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 357
;357:	}
LABELV $173
line 360
;358:
;359:	// check some things
;360:	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $179
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $175
LABELV $179
line 361
;361:		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
ADDRGP4 $180
ARGP4
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 362
;362:		trap_Cvar_Set( "g_gametype", "0" );
ADDRGP4 $63
ARGP4
ADDRGP4 $61
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 363
;363:	}
LABELV $175
line 365
;364:
;365:	level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 366
;366:}
LABELV $164
endproc G_RegisterCvars 20 16
export G_UpdateCvars
proc G_UpdateCvars 28 12
line 373
;367:
;368:/*
;369:=================
;370:G_UpdateCvars
;371:=================
;372:*/
;373:void G_UpdateCvars( void ) {
line 376
;374:	int			i;
;375:	cvarTable_t	*cv;
;376:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 378
;377:
;378:	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $185
line 379
;379:		if ( cv->vmCvar ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $189
line 380
;380:			trap_Cvar_Update( cv->vmCvar );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 382
;381:
;382:			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
EQI4 $191
line 383
;383:				cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 385
;384:
;385:				if ( cv->trackChange ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $193
line 386
;386:					trap_SendServerCommand( -1, va("print \"Server: %s changed to %s\n\"", 
ADDRGP4 $195
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 388
;387:						cv->cvarName, cv->vmCvar->string ) );
;388:				}
LABELV $193
line 390
;389:
;390:				if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $196
line 391
;391:					remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 392
;392:				}
LABELV $196
line 393
;393:			}
LABELV $191
line 394
;394:		}
LABELV $189
line 395
;395:	}
LABELV $186
line 378
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $188
ADDRLP4 4
INDIRI4
ADDRGP4 gameCvarTableSize
INDIRI4
LTI4 $185
line 397
;396:
;397:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $198
line 398
;398:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 399
;399:	}
LABELV $198
line 400
;400:}
LABELV $184
endproc G_UpdateCvars 28 12
export G_InitGame
proc G_InitGame 1032 20
line 408
;401:
;402:/*
;403:============
;404:G_InitGame
;405:
;406:============
;407:*/
;408:void G_InitGame( int levelTime, int randomSeed, int restart ) {
line 411
;409:	int					i;
;410:
;411:	G_Printf ("------- Game Initialization -------\n");
ADDRGP4 $201
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 412
;412:	G_Printf ("gamename: %s\n", GAMEVERSION);
ADDRGP4 $202
ARGP4
ADDRGP4 $57
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 413
;413:	G_Printf ("gamedate: %s\n", __DATE__);
ADDRGP4 $203
ARGP4
ADDRGP4 $59
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 414
;414:	G_Printf("=== G_InitGame called: levelTime=%d restart=%d ===\n", levelTime, restart);
ADDRGP4 $204
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 416
;415:
;416:	srand( randomSeed );
ADDRFP4 4
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 srand
CALLV
pop
line 418
;417:
;418:	G_RegisterCvars();
ADDRGP4 G_RegisterCvars
CALLV
pop
line 420
;419:
;420:	G_ProcessIPBans();
ADDRGP4 G_ProcessIPBans
CALLV
pop
line 422
;421:
;422:	G_InitMemory();
ADDRGP4 G_InitMemory
CALLV
pop
line 425
;423:
;424:	// set some level globals
;425:	memset( &level, 0, sizeof( level ) );
ADDRGP4 level
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9220
ARGI4
ADDRGP4 memset
CALLP4
pop
line 426
;426:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 427
;427:	level.startTime = levelTime;
ADDRGP4 level+40
ADDRFP4 0
INDIRI4
ASGNI4
line 429
;428:
;429:	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime
ADDRGP4 $208
ARGP4
ADDRLP4 4
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRGP4 level+348
ADDRLP4 4
INDIRI4
ASGNI4
line 431
;430:
;431:	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $209
ADDRGP4 g_log+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $209
line 432
;432:		if ( g_logSync.integer ) {
ADDRGP4 g_logSync+12
INDIRI4
CNSTI4 0
EQI4 $213
line 433
;433:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 434
;434:		} else {
ADDRGP4 $214
JUMPV
LABELV $213
line 435
;435:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 436
;436:		}
LABELV $214
line 437
;437:		if ( !level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $220
line 438
;438:			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
ADDRGP4 $223
ARGP4
ADDRGP4 g_log+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 439
;439:		} else {
ADDRGP4 $210
JUMPV
LABELV $220
line 442
;440:			char	serverinfo[MAX_INFO_STRING];
;441:
;442:			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 444
;443:
;444:			G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $225
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 445
;445:			G_LogPrintf("InitGame: %s\n", serverinfo );
ADDRGP4 $226
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 446
;446:		}
line 447
;447:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 448
;448:		G_Printf( "Not logging to disk.\n" );
ADDRGP4 $227
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 449
;449:	}
LABELV $210
line 451
;450:
;451:	G_InitWorldSession();
ADDRGP4 G_InitWorldSession
CALLV
pop
line 454
;452:
;453:	// initialize all entities for this game
;454:	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
ADDRGP4 g_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 839680
ARGI4
ADDRGP4 memset
CALLP4
pop
line 455
;455:	level.gentities = g_entities;
ADDRGP4 level+4
ADDRGP4 g_entities
ASGNP4
line 458
;456:
;457:	// initialize all clients for this game
;458:	level.maxclients = g_maxclients.integer;
ADDRGP4 level+24
ADDRGP4 g_maxclients+12
INDIRI4
ASGNI4
line 459
;459:	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
ADDRGP4 g_clients
ARGP4
CNSTI4 0
ARGI4
CNSTI4 49664
ARGI4
ADDRGP4 memset
CALLP4
pop
line 460
;460:	level.clients = g_clients;
ADDRGP4 level
ADDRGP4 g_clients
ASGNP4
line 463
;461:
;462:	// set client fields on player ents
;463:	for ( i=0 ; i<level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $234
JUMPV
LABELV $231
line 464
;464:		g_entities[i].client = level.clients + i;
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 465
;465:	}
LABELV $232
line 463
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $234
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $231
line 470
;466:
;467:	// always leave room for the max number of clients,
;468:	// even if they aren't all used, so numbers inside that
;469:	// range are NEVER anything but clients
;470:	level.num_entities = MAX_CLIENTS;
ADDRGP4 level+12
CNSTI4 64
ASGNI4
line 473
;471:
;472:	// let the server system know where the entites are
;473:	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ), 
ADDRGP4 level+4
INDIRP4
ARGP4
ADDRGP4 level+12
INDIRI4
ARGI4
CNSTI4 820
ARGI4
ADDRGP4 level
INDIRP4
ARGP4
CNSTI4 776
ARGI4
ADDRGP4 trap_LocateGameData
CALLV
pop
line 477
;474:		&level.clients[0].ps, sizeof( level.clients[0] ) );
;475:
;476:	// reserve some spots for dead player bodies
;477:	InitBodyQue();
ADDRGP4 InitBodyQue
CALLV
pop
line 479
;478:
;479:	ClearRegisteredItems();
ADDRGP4 ClearRegisteredItems
CALLV
pop
line 482
;480:
;481:	// parse the key/value pairs and spawn gentities
;482:	G_SpawnEntitiesFromString();
ADDRGP4 G_SpawnEntitiesFromString
CALLV
pop
line 485
;483:
;484:	// general initialization
;485:	G_FindTeams();
ADDRGP4 G_FindTeams
CALLV
pop
line 488
;486:
;487:	// make sure we have flags for CTF, etc
;488:	if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $240
line 489
;489:		G_CheckTeamItems();
ADDRGP4 G_CheckTeamItems
CALLV
pop
line 490
;490:	}
LABELV $240
line 492
;491:
;492:	SaveRegisteredItems();
ADDRGP4 SaveRegisteredItems
CALLV
pop
line 494
;493:
;494:	G_Printf ("-----------------------------------\n");
ADDRGP4 $243
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 496
;495:
;496:	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $248
ADDRGP4 $247
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $244
LABELV $248
line 497
;497:		G_ModelIndex( SP_PODIUM_MODEL );
ADDRGP4 $249
ARGP4
ADDRGP4 G_ModelIndex
CALLI4
pop
line 498
;498:		G_SoundIndex( "sound/player/gurp1.wav" );
ADDRGP4 $250
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 499
;499:		G_SoundIndex( "sound/player/gurp2.wav" );
ADDRGP4 $251
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 500
;500:	}
LABELV $244
line 502
;501:
;502:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $254
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $252
line 503
;503:		BotAISetup( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAISetup
CALLI4
pop
line 504
;504:		BotAILoadMap( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAILoadMap
CALLI4
pop
line 505
;505:		G_InitBots( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_InitBots
CALLV
pop
line 506
;506:	}
LABELV $252
line 508
;507:
;508:	G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 510
;509:
;510:}
LABELV $200
endproc G_InitGame 1032 20
export G_ShutdownGame
proc G_ShutdownGame 4 4
line 519
;511:
;512:
;513:
;514:/*
;515:=================
;516:G_ShutdownGame
;517:=================
;518:*/
;519:void G_ShutdownGame( int restart ) {
line 520
;520:	G_Printf ("==== ShutdownGame ====\n");
ADDRGP4 $256
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 522
;521:
;522:	if ( level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
EQI4 $257
line 523
;523:		G_LogPrintf("ShutdownGame:\n" );
ADDRGP4 $260
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 524
;524:		G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $225
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 525
;525:		trap_FS_FCloseFile( level.logFile );
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 526
;526:	}
LABELV $257
line 529
;527:
;528:	// write all the client session data so we can get it back
;529:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 531
;530:
;531:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $254
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $262
line 532
;532:		BotAIShutdown( restart );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdown
CALLI4
pop
line 533
;533:	}
LABELV $262
line 534
;534:}
LABELV $255
endproc G_ShutdownGame 4 4
export Com_Error
proc Com_Error 1028 12
line 543
;535:
;536:
;537:
;538://===================================================================
;539:
;540:#ifndef GAME_HARD_LINKED
;541:// this is only here so the functions in q_shared.c and bg_*.c can link
;542:
;543:void QDECL Com_Error ( int level, const char *error, ... ) {
line 547
;544:	va_list		argptr;
;545:	char		text[1024];
;546:
;547:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 548
;548:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 549
;549:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 551
;550:
;551:	G_Error( "%s", text);
ADDRGP4 $266
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 552
;552:}
LABELV $264
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 554
;553:
;554:void QDECL Com_Printf( const char *msg, ... ) {
line 558
;555:	va_list		argptr;
;556:	char		text[1024];
;557:
;558:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 559
;559:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 560
;560:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 562
;561:
;562:	G_Printf ("%s", text);
ADDRGP4 $266
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 563
;563:}
LABELV $267
endproc Com_Printf 1028 12
export AddTournamentPlayer
proc AddTournamentPlayer 24 8
line 583
;564:
;565:#endif
;566:
;567:/*
;568:========================================================================
;569:
;570:PLAYER COUNTING / SCORE SORTING
;571:
;572:========================================================================
;573:*/
;574:
;575:/*
;576:=============
;577:AddTournamentPlayer
;578:
;579:If there are less than two tournament players, put a
;580:spectator in the game and restart
;581:=============
;582:*/
;583:void AddTournamentPlayer( void ) {
line 588
;584:	int			i;
;585:	gclient_t	*client;
;586:	gclient_t	*nextInLine;
;587:
;588:	if ( level.numPlayingClients >= 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
LTI4 $270
line 589
;589:		return;
ADDRGP4 $269
JUMPV
LABELV $270
line 593
;590:	}
;591:
;592:	// never change during intermission
;593:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $273
line 594
;594:		return;
ADDRGP4 $269
JUMPV
LABELV $273
line 597
;595:	}
;596:
;597:	nextInLine = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 599
;598:
;599:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $276
line 600
;600:		client = &level.clients[i];
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 601
;601:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $281
line 602
;602:			continue;
ADDRGP4 $277
JUMPV
LABELV $281
line 604
;603:		}
;604:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $283
line 605
;605:			continue;
ADDRGP4 $277
JUMPV
LABELV $283
line 608
;606:		}
;607:		// never select the dedicated follow or scoreboard clients
;608:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD || 
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $287
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $285
LABELV $287
line 609
;609:			client->sess.spectatorClient < 0  ) {
line 610
;610:			continue;
ADDRGP4 $277
JUMPV
LABELV $285
line 613
;611:		}
;612:
;613:		if ( !nextInLine || client->sess.spectatorTime < nextInLine->sess.spectatorTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $290
ADDRLP4 20
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
GEI4 $288
LABELV $290
line 614
;614:			nextInLine = client;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 615
;615:		}
LABELV $288
line 616
;616:	}
LABELV $277
line 599
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $279
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $276
line 618
;617:
;618:	if ( !nextInLine ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $291
line 619
;619:		return;
ADDRGP4 $269
JUMPV
LABELV $291
line 622
;620:	}
;621:
;622:	level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 625
;623:
;624:	// set them to free-for-all team
;625:	SetTeam( &g_entities[ nextInLine - level.clients ], "f" );
CNSTI4 820
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 776
DIVI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $294
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 626
;626:}
LABELV $269
endproc AddTournamentPlayer 24 8
export RemoveTournamentLoser
proc RemoveTournamentLoser 4 8
line 635
;627:
;628:/*
;629:=======================
;630:RemoveTournamentLoser
;631:
;632:Make the loser a spectator at the back of the line
;633:=======================
;634:*/
;635:void RemoveTournamentLoser( void ) {
line 638
;636:	int			clientNum;
;637:
;638:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $296
line 639
;639:		return;
ADDRGP4 $295
JUMPV
LABELV $296
line 642
;640:	}
;641:
;642:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+84+4
INDIRI4
ASGNI4
line 644
;643:
;644:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $301
line 645
;645:		return;
ADDRGP4 $295
JUMPV
LABELV $301
line 649
;646:	}
;647:
;648:	// make them a spectator
;649:	SetTeam( &g_entities[ clientNum ], "s" );
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 650
;650:}
LABELV $295
endproc RemoveTournamentLoser 4 8
export RemoveTournamentWinner
proc RemoveTournamentWinner 4 8
line 657
;651:
;652:/*
;653:=======================
;654:RemoveTournamentWinner
;655:=======================
;656:*/
;657:void RemoveTournamentWinner( void ) {
line 660
;658:	int			clientNum;
;659:
;660:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $305
line 661
;661:		return;
ADDRGP4 $304
JUMPV
LABELV $305
line 664
;662:	}
;663:
;664:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+84
INDIRI4
ASGNI4
line 666
;665:
;666:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $309
line 667
;667:		return;
ADDRGP4 $304
JUMPV
LABELV $309
line 671
;668:	}
;669:
;670:	// make them a spectator
;671:	SetTeam( &g_entities[ clientNum ], "s" );
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 672
;672:}
LABELV $304
endproc RemoveTournamentWinner 4 8
export AdjustTournamentScores
proc AdjustTournamentScores 8 4
line 679
;673:
;674:/*
;675:=======================
;676:AdjustTournamentScores
;677:=======================
;678:*/
;679:void AdjustTournamentScores( void ) {
line 682
;680:	int			clientNum;
;681:
;682:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+84
INDIRI4
ASGNI4
line 683
;683:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $313
line 684
;684:		level.clients[ clientNum ].sess.wins++;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 632
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 685
;685:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 686
;686:	}
LABELV $313
line 688
;687:
;688:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+84+4
INDIRI4
ASGNI4
line 689
;689:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $317
line 690
;690:		level.clients[ clientNum ].sess.losses++;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 636
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 691
;691:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 692
;692:	}
LABELV $317
line 694
;693:
;694:}
LABELV $311
endproc AdjustTournamentScores 8 4
export SortRanks
proc SortRanks 32 0
line 702
;695:
;696:/*
;697:=============
;698:SortRanks
;699:
;700:=============
;701:*/
;702:int QDECL SortRanks( const void *a, const void *b ) {
line 705
;703:	gclient_t	*ca, *cb;
;704:
;705:	ca = &level.clients[*(int *)a];
ADDRLP4 0
CNSTI4 776
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 706
;706:	cb = &level.clients[*(int *)b];
ADDRLP4 4
CNSTI4 776
ADDRFP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 709
;707:
;708:	// sort special clients last
;709:	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $322
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $320
LABELV $322
line 710
;710:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $319
JUMPV
LABELV $320
line 712
;711:	}
;712:	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $325
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $323
LABELV $325
line 713
;713:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $319
JUMPV
LABELV $323
line 717
;714:	}
;715:
;716:	// then connecting clients
;717:	if ( ca->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $326
line 718
;718:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $319
JUMPV
LABELV $326
line 720
;719:	}
;720:	if ( cb->pers.connected == CON_CONNECTING ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $328
line 721
;721:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $319
JUMPV
LABELV $328
line 726
;722:	}
;723:
;724:
;725:	// then spectators
;726:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 16
CNSTI4 616
ASGNI4
ADDRLP4 20
CNSTI4 3
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $330
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $330
line 727
;727:		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
ADDRLP4 24
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GEI4 $332
line 728
;728:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $319
JUMPV
LABELV $332
line 730
;729:		}
;730:		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
ADDRLP4 28
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
LEI4 $334
line 731
;731:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $319
JUMPV
LABELV $334
line 733
;732:		}
;733:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $319
JUMPV
LABELV $330
line 735
;734:	}
;735:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $336
line 736
;736:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $319
JUMPV
LABELV $336
line 738
;737:	}
;738:	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $338
line 739
;739:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $319
JUMPV
LABELV $338
line 743
;740:	}
;741:
;742:	// then sort by score
;743:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 24
CNSTI4 248
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
LEI4 $340
line 744
;744:		> cb->ps.persistant[PERS_SCORE] ) {
line 745
;745:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $319
JUMPV
LABELV $340
line 747
;746:	}
;747:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 28
CNSTI4 248
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
GEI4 $342
line 748
;748:		< cb->ps.persistant[PERS_SCORE] ) {
line 749
;749:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $319
JUMPV
LABELV $342
line 751
;750:	}
;751:	return 0;
CNSTI4 0
RETI4
LABELV $319
endproc SortRanks 32 0
export CalculateRanks
proc CalculateRanks 44 16
line 763
;752:}
;753:
;754:/*
;755:============
;756:CalculateRanks
;757:
;758:Recalculates the score ranks of all players
;759:This will be called on every client connect, begin, disconnect, death,
;760:and team change.
;761:============
;762:*/
;763:void CalculateRanks( void ) {
line 770
;764:	int		i;
;765:	int		rank;
;766:	int		score;
;767:	int		newScore;
;768:	gclient_t	*cl;
;769:
;770:	level.follow1 = -1;
ADDRGP4 level+340
CNSTI4 -1
ASGNI4
line 771
;771:	level.follow2 = -1;
ADDRGP4 level+344
CNSTI4 -1
ASGNI4
line 772
;772:	level.numConnectedClients = 0;
ADDRGP4 level+72
CNSTI4 0
ASGNI4
line 773
;773:	level.numNonSpectatorClients = 0;
ADDRGP4 level+76
CNSTI4 0
ASGNI4
line 774
;774:	level.numPlayingClients = 0;
ADDRGP4 level+80
CNSTI4 0
ASGNI4
line 775
;775:	level.numVotingClients = 0;		// don't count bots
ADDRGP4 level+2420
CNSTI4 0
ASGNI4
line 776
;776:	for ( i = 0; i < TEAM_NUM_TEAMS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $351
line 777
;777:		level.numteamVotingClients[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
CNSTI4 0
ASGNI4
line 778
;778:	}
LABELV $352
line 776
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $351
line 779
;779:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $359
JUMPV
LABELV $356
line 780
;780:		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $361
line 781
;781:			level.sortedClients[level.numConnectedClients] = i;
ADDRGP4 level+72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 782
;782:			level.numConnectedClients++;
ADDRLP4 20
ADDRGP4 level+72
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 784
;783:
;784:			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $366
line 785
;785:				level.numNonSpectatorClients++;
ADDRLP4 24
ADDRGP4 level+76
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 788
;786:			
;787:				// decide if this should be auto-followed
;788:				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $369
line 789
;789:					level.numPlayingClients++;
ADDRLP4 28
ADDRGP4 level+80
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 790
;790:					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $372
line 791
;791:						level.numVotingClients++;
ADDRLP4 32
ADDRGP4 level+2420
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 792
;792:						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 1
NEI4 $377
line 793
;793:							level.numteamVotingClients[0]++;
ADDRLP4 36
ADDRGP4 level+4496
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $378
JUMPV
LABELV $377
line 794
;794:						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 2
NEI4 $380
line 795
;795:							level.numteamVotingClients[1]++;
ADDRLP4 40
ADDRGP4 level+4496+4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $380
LABELV $378
line 796
;796:					}
LABELV $372
line 797
;797:					if ( level.follow1 == -1 ) {
ADDRGP4 level+340
INDIRI4
CNSTI4 -1
NEI4 $384
line 798
;798:						level.follow1 = i;
ADDRGP4 level+340
ADDRLP4 0
INDIRI4
ASGNI4
line 799
;799:					} else if ( level.follow2 == -1 ) {
ADDRGP4 $385
JUMPV
LABELV $384
ADDRGP4 level+344
INDIRI4
CNSTI4 -1
NEI4 $388
line 800
;800:						level.follow2 = i;
ADDRGP4 level+344
ADDRLP4 0
INDIRI4
ASGNI4
line 801
;801:					}
LABELV $388
LABELV $385
line 802
;802:				}
LABELV $369
line 803
;803:			}
LABELV $366
line 804
;804:		}
LABELV $361
line 805
;805:	}
LABELV $357
line 779
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $359
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $356
line 807
;806:
;807:	qsort( level.sortedClients, level.numConnectedClients, 
ADDRGP4 level+84
ARGP4
ADDRGP4 level+72
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 SortRanks
ARGP4
ADDRGP4 qsort
CALLV
pop
line 811
;808:		sizeof(level.sortedClients[0]), SortRanks );
;809:
;810:	// set the rank value for all clients that are connected and not spectators
;811:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $395
line 813
;812:		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
;813:		for ( i = 0;  i < level.numConnectedClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $398
line 814
;814:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 815
;815:			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
NEI4 $404
line 816
;816:				cl->ps.persistant[PERS_RANK] = 2;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 2
ASGNI4
line 817
;817:			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
ADDRGP4 $405
JUMPV
LABELV $404
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
LEI4 $410
line 818
;818:				cl->ps.persistant[PERS_RANK] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 0
ASGNI4
line 819
;819:			} else {
ADDRGP4 $411
JUMPV
LABELV $410
line 820
;820:				cl->ps.persistant[PERS_RANK] = 1;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 1
ASGNI4
line 821
;821:			}
LABELV $411
LABELV $405
line 822
;822:		}
LABELV $399
line 813
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $401
ADDRLP4 0
INDIRI4
ADDRGP4 level+72
INDIRI4
LTI4 $398
line 823
;823:	} else {	
ADDRGP4 $396
JUMPV
LABELV $395
line 824
;824:		rank = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 825
;825:		score = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 826
;826:		for ( i = 0;  i < level.numPlayingClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $419
JUMPV
LABELV $416
line 827
;827:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 828
;828:			newScore = cl->ps.persistant[PERS_SCORE];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 829
;829:			if ( i == 0 || newScore != score ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $424
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $422
LABELV $424
line 830
;830:				rank = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 832
;831:				// assume we aren't tied until the next client is checked
;832:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 833
;833:			} else {
ADDRGP4 $423
JUMPV
LABELV $422
line 835
;834:				// we are tied with the previous client
;835:				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84-4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 836
;836:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 837
;837:			}
LABELV $423
line 838
;838:			score = newScore;
ADDRLP4 16
ADDRLP4 8
INDIRI4
ASGNI4
line 839
;839:			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $429
ADDRGP4 level+80
INDIRI4
CNSTI4 1
NEI4 $429
line 840
;840:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 841
;841:			}
LABELV $429
line 842
;842:		}
LABELV $417
line 826
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $419
ADDRLP4 0
INDIRI4
ADDRGP4 level+80
INDIRI4
LTI4 $416
line 843
;843:	}
LABELV $396
line 846
;844:
;845:	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
;846:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $434
line 847
;847:		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 848
;848:		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 849
;849:	} else {
ADDRGP4 $435
JUMPV
LABELV $434
line 850
;850:		if ( level.numConnectedClients == 0 ) {
ADDRGP4 level+72
INDIRI4
CNSTI4 0
NEI4 $442
line 851
;851:			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $437
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 852
;852:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $437
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 853
;853:		} else if ( level.numConnectedClients == 1 ) {
ADDRGP4 $443
JUMPV
LABELV $442
ADDRGP4 level+72
INDIRI4
CNSTI4 1
NEI4 $445
line 854
;854:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $437
ARGP4
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 855
;855:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $437
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 856
;856:		} else {
ADDRGP4 $446
JUMPV
LABELV $445
line 857
;857:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $437
ARGP4
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 858
;858:			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $437
ARGP4
CNSTI4 776
ADDRGP4 level+84+4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 859
;859:		}
LABELV $446
LABELV $443
line 860
;860:	}
LABELV $435
line 863
;861:
;862:	// see if it is time to end the level
;863:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 866
;864:
;865:	// if we are at the intermission, send the new info to everyone
;866:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $452
line 867
;867:		SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 868
;868:	}
LABELV $452
line 869
;869:}
LABELV $344
endproc CalculateRanks 44 16
export SendScoreboardMessageToAllClients
proc SendScoreboardMessageToAllClients 4 4
line 888
;870:
;871:
;872:/*
;873:========================================================================
;874:
;875:MAP CHANGING
;876:
;877:========================================================================
;878:*/
;879:
;880:/*
;881:========================
;882:SendScoreboardMessageToAllClients
;883:
;884:Do this at BeginIntermission time and whenever ranks are recalculated
;885:due to enters/exits/forced team changes
;886:========================
;887:*/
;888:void SendScoreboardMessageToAllClients( void ) {
line 891
;889:	int		i;
;890:
;891:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $459
JUMPV
LABELV $456
line 892
;892:		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $461
line 893
;893:			DeathmatchScoreboardMessage( g_entities + i );
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 894
;894:		}
LABELV $461
line 895
;895:	}
LABELV $457
line 891
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $459
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $456
line 896
;896:}
LABELV $455
endproc SendScoreboardMessageToAllClients 4 4
export MoveClientToIntermission
proc MoveClientToIntermission 0 12
line 906
;897:
;898:/*
;899:========================
;900:MoveClientToIntermission
;901:
;902:When the intermission starts, this will be called for all players.
;903:If a new client connects, this will be called after the spawn function.
;904:========================
;905:*/
;906:void MoveClientToIntermission( gentity_t *ent ) {
line 908
;907:	// take out of follow mode if needed
;908:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $464
line 909
;909:		StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 910
;910:	}
LABELV $464
line 914
;911:
;912:
;913:	// move to the spot
;914:	VectorCopy( level.intermission_origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 level+9144
INDIRB
ASGNB 12
line 915
;915:	VectorCopy( level.intermission_origin, ent->client->ps.origin );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+9144
INDIRB
ASGNB 12
line 916
;916:	VectorCopy (level.intermission_angle, ent->client->ps.viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 level+9156
INDIRB
ASGNB 12
line 917
;917:	ent->client->ps.pm_type = PM_INTERMISSION;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 920
;918:
;919:	// clean up powerup info
;920:	memset( ent->client->ps.powerups, 0, sizeof(ent->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 922
;921:
;922:	ent->client->ps.eFlags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
CNSTI4 0
ASGNI4
line 923
;923:	ent->s.eFlags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 924
;924:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 925
;925:	ent->s.modelindex = 0;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 926
;926:	ent->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 927
;927:	ent->s.event = 0;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 928
;928:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 929
;929:}
LABELV $463
endproc MoveClientToIntermission 0 12
export FindIntermissionPoint
proc FindIntermissionPoint 32 12
line 938
;930:
;931:/*
;932:==================
;933:FindIntermissionPoint
;934:
;935:This is also used for spectator spawns
;936:==================
;937:*/
;938:void FindIntermissionPoint( void ) {
line 943
;939:	gentity_t	*ent, *target;
;940:	vec3_t		dir;
;941:
;942:	// find the intermission spot
;943:	ent = G_Find (NULL, FOFS(classname), "info_player_intermission");
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $470
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 944
;944:	if ( !ent ) {	// the map creator forgot to put in an intermission point...
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $471
line 945
;945:		SelectSpawnPoint ( vec3_origin, level.intermission_origin, level.intermission_angle );
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 level+9144
ARGP4
ADDRGP4 level+9156
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 946
;946:	} else {
ADDRGP4 $472
JUMPV
LABELV $471
line 947
;947:		VectorCopy (ent->s.origin, level.intermission_origin);
ADDRGP4 level+9144
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 948
;948:		VectorCopy (ent->s.angles, level.intermission_angle);
ADDRGP4 level+9156
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 950
;949:		// if it has a target, look towards it
;950:		if ( ent->target ) {
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $477
line 951
;951:			target = G_PickTarget( ent->target );
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 952
;952:			if ( target ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $479
line 953
;953:				VectorSubtract( target->s.origin, level.intermission_origin, dir );
ADDRLP4 28
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 level+9144
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 level+9144+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 level+9144+8
INDIRF4
SUBF4
ASGNF4
line 954
;954:				vectoangles( dir, level.intermission_angle );
ADDRLP4 8
ARGP4
ADDRGP4 level+9156
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 955
;955:			}
LABELV $479
line 956
;956:		}
LABELV $477
line 957
;957:	}
LABELV $472
line 959
;958:
;959:}
LABELV $469
endproc FindIntermissionPoint 32 12
export BeginIntermission
proc BeginIntermission 8 4
line 966
;960:
;961:/*
;962:==================
;963:BeginIntermission
;964:==================
;965:*/
;966:void BeginIntermission( void ) {
line 970
;967:	int			i;
;968:	gentity_t	*client;
;969:
;970:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $490
line 971
;971:		return;		// already active
ADDRGP4 $489
JUMPV
LABELV $490
line 975
;972:	}
;973:
;974:	// if in tournement mode, change the wins / losses
;975:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $493
line 976
;976:		AdjustTournamentScores();
ADDRGP4 AdjustTournamentScores
CALLV
pop
line 977
;977:	}
LABELV $493
line 979
;978:
;979:	level.intermissiontime = level.time;
ADDRGP4 level+9128
ADDRGP4 level+32
INDIRI4
ASGNI4
line 980
;980:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 989
;981:
;982:#ifdef MISSIONPACK
;983:	if (g_singlePlayer.integer) {
;984:		trap_Cvar_Set("ui_singlePlayerActive", "0");
;985:		UpdateTournamentInfo();
;986:	}
;987:#else
;988:	// if single player game
;989:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $498
line 990
;990:		UpdateTournamentInfo();
ADDRGP4 UpdateTournamentInfo
CALLV
pop
line 991
;991:		SpawnModelsOnVictoryPads();
ADDRGP4 SpawnModelsOnVictoryPads
CALLV
pop
line 992
;992:	}
LABELV $498
line 996
;993:#endif
;994:
;995:	// move all clients to the intermission point
;996:	for (i=0 ; i< level.maxclients ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $504
JUMPV
LABELV $501
line 997
;997:		client = g_entities + i;
ADDRLP4 0
CNSTI4 820
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 998
;998:		if (!client->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $506
line 999
;999:			continue;
ADDRGP4 $502
JUMPV
LABELV $506
line 1001
;1000:		// respawn if dead
;1001:		if (client->health <= 0) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $508
line 1002
;1002:			respawn(client);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 1003
;1003:		}
LABELV $508
line 1004
;1004:		MoveClientToIntermission( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 1005
;1005:	}
LABELV $502
line 996
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $504
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $501
line 1008
;1006:
;1007:	// send the current scoring to all clients
;1008:	SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 1010
;1009:
;1010:}
LABELV $489
endproc BeginIntermission 8 4
export ExitLevel
proc ExitLevel 8 8
line 1022
;1011:
;1012:
;1013:/*
;1014:=============
;1015:ExitLevel
;1016:
;1017:When the intermission has been exited, the server is either killed
;1018:or moved to a new level based on the "nextmap" cvar 
;1019:
;1020:=============
;1021:*/
;1022:void ExitLevel (void) {
line 1027
;1023:	int		i;
;1024:	gclient_t *cl;
;1025:
;1026:	//bot interbreeding
;1027:	BotInterbreedEndMatch();
ADDRGP4 BotInterbreedEndMatch
CALLV
pop
line 1031
;1028:
;1029:	// if we are running a tournement map, kick the loser to spectator status,
;1030:	// which will automatically grab the next spectator and restart
;1031:	if ( g_gametype.integer == GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $511
line 1032
;1032:		if ( !level.restarted ) {
ADDRGP4 level+68
INDIRI4
CNSTI4 0
NEI4 $510
line 1033
;1033:			RemoveTournamentLoser();
ADDRGP4 RemoveTournamentLoser
CALLV
pop
line 1034
;1034:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $517
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1035
;1035:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1036
;1036:			level.changemap = NULL;
ADDRGP4 level+9132
CNSTP4 0
ASGNP4
line 1037
;1037:			level.intermissiontime = 0;
ADDRGP4 level+9128
CNSTI4 0
ASGNI4
line 1038
;1038:		}
line 1039
;1039:		return;	
ADDRGP4 $510
JUMPV
LABELV $511
line 1043
;1040:	}
;1041:
;1042:
;1043:	trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
CNSTI4 2
ARGI4
ADDRGP4 $521
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1044
;1044:	level.changemap = NULL;
ADDRGP4 level+9132
CNSTP4 0
ASGNP4
line 1045
;1045:	level.intermissiontime = 0;
ADDRGP4 level+9128
CNSTI4 0
ASGNI4
line 1048
;1046:
;1047:	// reset all the scores so we don't enter the intermission again
;1048:	level.teamScores[TEAM_RED] = 0;
ADDRGP4 level+44+4
CNSTI4 0
ASGNI4
line 1049
;1049:	level.teamScores[TEAM_BLUE] = 0;
ADDRGP4 level+44+8
CNSTI4 0
ASGNI4
line 1050
;1050:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $531
JUMPV
LABELV $528
line 1051
;1051:		cl = level.clients + i;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1052
;1052:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $533
line 1053
;1053:			continue;
ADDRGP4 $529
JUMPV
LABELV $533
line 1055
;1054:		}
;1055:		cl->ps.persistant[PERS_SCORE] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 0
ASGNI4
line 1056
;1056:	}
LABELV $529
line 1050
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $531
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $528
line 1059
;1057:
;1058:	// we need to do this here before chaning to CON_CONNECTING
;1059:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 1063
;1060:
;1061:	// change all client states to connecting, so the early players into the
;1062:	// next level will know the others aren't done reconnecting
;1063:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $538
JUMPV
LABELV $535
line 1064
;1064:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $540
line 1065
;1065:			level.clients[i].pers.connected = CON_CONNECTING;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1066
;1066:		}
LABELV $540
line 1067
;1067:	}
LABELV $536
line 1063
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $538
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $535
line 1069
;1068:
;1069:}
LABELV $510
endproc ExitLevel 8 8
export G_LogPrintf
proc G_LogPrintf 1044 24
line 1078
;1070:
;1071:/*
;1072:=================
;1073:G_LogPrintf
;1074:
;1075:Print to the logfile with a time stamp if it is open
;1076:=================
;1077:*/
;1078:void QDECL G_LogPrintf( const char *fmt, ... ) {
line 1083
;1079:	va_list		argptr;
;1080:	char		string[1024];
;1081:	int			min, tens, sec;
;1082:
;1083:	sec = level.time / 1000;
ADDRLP4 0
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1085
;1084:
;1085:	min = sec / 60;
ADDRLP4 1032
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1086
;1086:	sec -= min * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 1032
INDIRI4
MULI4
SUBI4
ASGNI4
line 1087
;1087:	tens = sec / 10;
ADDRLP4 1036
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1088
;1088:	sec -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 1036
INDIRI4
MULI4
SUBI4
ASGNI4
line 1090
;1089:
;1090:	Com_sprintf( string, sizeof(string), "%3i:%i%i ", min, tens, sec );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $544
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1092
;1091:
;1092:	va_start( argptr, fmt );
ADDRLP4 1028
ADDRFP4 0+4
ASGNP4
line 1093
;1093:	vsprintf( string +7 , fmt,argptr );
ADDRLP4 4+7
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 1094
;1094:	va_end( argptr );
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 1096
;1095:
;1096:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $547
line 1097
;1097:		G_Printf( "%s", string + 7 );
ADDRGP4 $266
ARGP4
ADDRLP4 4+7
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1098
;1098:	}
LABELV $547
line 1100
;1099:
;1100:	if ( !level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $551
line 1101
;1101:		return;
ADDRGP4 $542
JUMPV
LABELV $551
line 1104
;1102:	}
;1103:
;1104:	trap_FS_Write( string, strlen( string ), level.logFile );
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 1105
;1105:}
LABELV $542
endproc G_LogPrintf 1044 24
export LogExit
proc LogExit 24 20
line 1114
;1106:
;1107:/*
;1108:================
;1109:LogExit
;1110:
;1111:Append information about this game to the log file
;1112:================
;1113:*/
;1114:void LogExit( const char *string ) {
line 1120
;1115:	int				i, numSorted;
;1116:	gclient_t		*cl;
;1117:#ifdef MISSIONPACK // bk001205
;1118:	qboolean won = qtrue;
;1119:#endif
;1120:	G_LogPrintf( "Exit: %s\n", string );
ADDRGP4 $556
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1122
;1121:
;1122:	level.intermissionQueued = level.time;
ADDRGP4 level+9124
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1126
;1123:
;1124:	// this will keep the clients from playing any voice sounds
;1125:	// that will get cut off when the queued intermission starts
;1126:	trap_SetConfigstring( CS_INTERMISSION, "1" );
CNSTI4 22
ARGI4
ADDRGP4 $84
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1129
;1127:
;1128:	// don't send more than 32 scores (FIXME?)
;1129:	numSorted = level.numConnectedClients;
ADDRLP4 8
ADDRGP4 level+72
INDIRI4
ASGNI4
line 1130
;1130:	if ( numSorted > 32 ) {
ADDRLP4 8
INDIRI4
CNSTI4 32
LEI4 $560
line 1131
;1131:		numSorted = 32;
ADDRLP4 8
CNSTI4 32
ASGNI4
line 1132
;1132:	}
LABELV $560
line 1134
;1133:
;1134:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $562
line 1135
;1135:		G_LogPrintf( "red:%i  blue:%i\n",
ADDRGP4 $565
ARGP4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1137
;1136:			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
;1137:	}
LABELV $562
line 1139
;1138:
;1139:	for (i=0 ; i < numSorted ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $573
JUMPV
LABELV $570
line 1142
;1140:		int		ping;
;1141:
;1142:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1144
;1143:
;1144:		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $575
line 1145
;1145:			continue;
ADDRGP4 $571
JUMPV
LABELV $575
line 1147
;1146:		}
;1147:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $577
line 1148
;1148:			continue;
ADDRGP4 $571
JUMPV
LABELV $577
line 1151
;1149:		}
;1150:
;1151:		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
GEI4 $580
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $581
JUMPV
LABELV $580
ADDRLP4 16
CNSTI4 999
ASGNI4
LABELV $581
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 1153
;1152:
;1153:		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
ADDRGP4 $582
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1162
;1154:#ifdef MISSIONPACK
;1155:		if (g_singlePlayer.integer && g_gametype.integer == GT_TOURNAMENT) {
;1156:			if (g_entities[cl - level.clients].r.svFlags & SVF_BOT && cl->ps.persistant[PERS_RANK] == 0) {
;1157:				won = qfalse;
;1158:			}
;1159:		}
;1160:#endif
;1161:
;1162:	}
LABELV $571
line 1139
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $573
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $570
line 1174
;1163:
;1164:#ifdef MISSIONPACK
;1165:	if (g_singlePlayer.integer) {
;1166:		if (g_gametype.integer >= GT_CTF) {
;1167:			won = level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE];
;1168:		}
;1169:		trap_SendConsoleCommand( EXEC_APPEND, (won) ? "spWin\n" : "spLose\n" );
;1170:	}
;1171:#endif
;1172:
;1173:
;1174:}
LABELV $555
endproc LogExit 24 20
export CheckIntermissionExit
proc CheckIntermissionExit 20 0
line 1187
;1175:
;1176:
;1177:/*
;1178:=================
;1179:CheckIntermissionExit
;1180:
;1181:The level will stay at the intermission for a minimum of 5 seconds
;1182:If all players wish to continue, the level will then exit.
;1183:If one or more players have not acknowledged the continue, the game will
;1184:wait 10 seconds before going on.
;1185:=================
;1186:*/
;1187:void CheckIntermissionExit( void ) {
line 1193
;1188:	int			ready, notReady;
;1189:	int			i;
;1190:	gclient_t	*cl;
;1191:	int			readyMask;
;1192:
;1193:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $585
line 1194
;1194:		return;
ADDRGP4 $584
JUMPV
LABELV $585
line 1198
;1195:	}
;1196:
;1197:	// see which players are ready
;1198:	ready = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1199
;1199:	notReady = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1200
;1200:	readyMask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1201
;1201:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $591
JUMPV
LABELV $588
line 1202
;1202:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1203
;1203:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $593
line 1204
;1204:			continue;
ADDRGP4 $589
JUMPV
LABELV $593
line 1206
;1205:		}
;1206:		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
CNSTI4 820
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $595
line 1207
;1207:			continue;
ADDRGP4 $589
JUMPV
LABELV $595
line 1210
;1208:		}
;1209:
;1210:		if ( cl->readyToExit ) {
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
CNSTI4 0
EQI4 $599
line 1211
;1211:			ready++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1212
;1212:			if ( i < 16 ) {
ADDRLP4 4
INDIRI4
CNSTI4 16
GEI4 $600
line 1213
;1213:				readyMask |= 1 << i;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BORI4
ASGNI4
line 1214
;1214:			}
line 1215
;1215:		} else {
ADDRGP4 $600
JUMPV
LABELV $599
line 1216
;1216:			notReady++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1217
;1217:		}
LABELV $600
line 1218
;1218:	}
LABELV $589
line 1201
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $591
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $588
line 1222
;1219:
;1220:	// copy the readyMask to each player's stats so
;1221:	// it can be displayed on the scoreboard
;1222:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $606
JUMPV
LABELV $603
line 1223
;1223:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1224
;1224:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $608
line 1225
;1225:			continue;
ADDRGP4 $604
JUMPV
LABELV $608
line 1227
;1226:		}
;1227:		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1228
;1228:	}
LABELV $604
line 1222
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $606
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $603
line 1231
;1229:
;1230:	// never exit in less than five seconds
;1231:	if ( level.time < level.intermissiontime + 5000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9128
INDIRI4
CNSTI4 5000
ADDI4
GEI4 $610
line 1232
;1232:		return;
ADDRGP4 $584
JUMPV
LABELV $610
line 1236
;1233:	}
;1234:
;1235:	// if nobody wants to go, clear timer
;1236:	if ( !ready ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $614
line 1237
;1237:		level.readyToExit = qfalse;
ADDRGP4 level+9136
CNSTI4 0
ASGNI4
line 1238
;1238:		return;
ADDRGP4 $584
JUMPV
LABELV $614
line 1242
;1239:	}
;1240:
;1241:	// if everyone wants to go, go now
;1242:	if ( !notReady ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $617
line 1243
;1243:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1244
;1244:		return;
ADDRGP4 $584
JUMPV
LABELV $617
line 1248
;1245:	}
;1246:
;1247:	// the first person to ready starts the ten second timeout
;1248:	if ( !level.readyToExit ) {
ADDRGP4 level+9136
INDIRI4
CNSTI4 0
NEI4 $619
line 1249
;1249:		level.readyToExit = qtrue;
ADDRGP4 level+9136
CNSTI4 1
ASGNI4
line 1250
;1250:		level.exitTime = level.time;
ADDRGP4 level+9140
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1251
;1251:	}
LABELV $619
line 1255
;1252:
;1253:	// if we have waited ten seconds since at least one player
;1254:	// wanted to exit, go ahead
;1255:	if ( level.time < level.exitTime + 10000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9140
INDIRI4
CNSTI4 10000
ADDI4
GEI4 $625
line 1256
;1256:		return;
ADDRGP4 $584
JUMPV
LABELV $625
line 1259
;1257:	}
;1258:
;1259:	ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1260
;1260:}
LABELV $584
endproc CheckIntermissionExit 20 0
export ScoreIsTied
proc ScoreIsTied 12 0
line 1267
;1261:
;1262:/*
;1263:=============
;1264:ScoreIsTied
;1265:=============
;1266:*/
;1267:qboolean ScoreIsTied( void ) {
line 1270
;1268:	int		a, b;
;1269:
;1270:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $630
line 1271
;1271:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $629
JUMPV
LABELV $630
line 1274
;1272:	}
;1273:	
;1274:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $633
line 1275
;1275:		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
NEI4 $641
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $642
JUMPV
LABELV $641
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $642
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $629
JUMPV
LABELV $633
line 1278
;1276:	}
;1277:
;1278:	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
ADDRLP4 0
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1279
;1279:	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];
ADDRLP4 4
CNSTI4 776
ADDRGP4 level+84+4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1281
;1280:
;1281:	return a == b;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $647
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $648
JUMPV
LABELV $647
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $648
ADDRLP4 8
INDIRI4
RETI4
LABELV $629
endproc ScoreIsTied 12 0
export CheckExitRules
proc CheckExitRules 20 8
line 1293
;1282:}
;1283:
;1284:/*
;1285:=================
;1286:CheckExitRules
;1287:
;1288:There will be a delay between the time the exit is qualified for
;1289:and the time everyone is moved to the intermission spot, so you
;1290:can see the last frag.
;1291:=================
;1292:*/
;1293:void CheckExitRules( void ) {
line 1298
;1294: 	int			i;
;1295:	gclient_t	*cl;
;1296:	// if at the intermission, wait for all non-bots to
;1297:	// signal ready, then go to next level
;1298:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $650
line 1299
;1299:		CheckIntermissionExit ();
ADDRGP4 CheckIntermissionExit
CALLV
pop
line 1300
;1300:		return;
ADDRGP4 $649
JUMPV
LABELV $650
line 1303
;1301:	}
;1302:
;1303:	if ( level.intermissionQueued ) {
ADDRGP4 level+9124
INDIRI4
CNSTI4 0
EQI4 $653
line 1311
;1304:#ifdef MISSIONPACK
;1305:		int time = (g_singlePlayer.integer) ? SP_INTERMISSION_DELAY_TIME : INTERMISSION_DELAY_TIME;
;1306:		if ( level.time - level.intermissionQueued >= time ) {
;1307:			level.intermissionQueued = 0;
;1308:			BeginIntermission();
;1309:		}
;1310:#else
;1311:		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9124
INDIRI4
SUBI4
CNSTI4 1000
LTI4 $649
line 1312
;1312:			level.intermissionQueued = 0;
ADDRGP4 level+9124
CNSTI4 0
ASGNI4
line 1313
;1313:			BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 1314
;1314:		}
line 1316
;1315:#endif
;1316:		return;
ADDRGP4 $649
JUMPV
LABELV $653
line 1320
;1317:	}
;1318:
;1319:	// check for sudden death
;1320:	if ( ScoreIsTied() ) {
ADDRLP4 8
ADDRGP4 ScoreIsTied
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $661
line 1322
;1321:		// always wait for sudden death
;1322:		return;
ADDRGP4 $649
JUMPV
LABELV $661
line 1325
;1323:	}
;1324:
;1325:	if ( g_timelimit.integer && !level.warmupTime ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 g_timelimit+12
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $663
ADDRGP4 level+16
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $663
line 1326
;1326:		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 60000
ADDRGP4 g_timelimit+12
INDIRI4
MULI4
LTI4 $667
line 1327
;1327:			trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $672
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1328
;1328:			LogExit( "Timelimit hit." );
ADDRGP4 $673
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1329
;1329:			return;
ADDRGP4 $649
JUMPV
LABELV $667
line 1331
;1330:		}
;1331:	}
LABELV $663
line 1333
;1332:
;1333:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $674
line 1334
;1334:		return;
ADDRGP4 $649
JUMPV
LABELV $674
line 1337
;1335:	}
;1336:
;1337:	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GEI4 $677
ADDRGP4 g_fraglimit+12
INDIRI4
CNSTI4 0
EQI4 $677
line 1338
;1338:		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $681
line 1339
;1339:			trap_SendServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $686
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1340
;1340:			LogExit( "Fraglimit hit." );
ADDRGP4 $687
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1341
;1341:			return;
ADDRGP4 $649
JUMPV
LABELV $681
line 1344
;1342:		}
;1343:
;1344:		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $688
line 1345
;1345:			trap_SendServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $693
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1346
;1346:			LogExit( "Fraglimit hit." );
ADDRGP4 $687
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1347
;1347:			return;
ADDRGP4 $649
JUMPV
LABELV $688
line 1350
;1348:		}
;1349:
;1350:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $697
JUMPV
LABELV $694
line 1351
;1351:			cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1352
;1352:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $699
line 1353
;1353:				continue;
ADDRGP4 $695
JUMPV
LABELV $699
line 1355
;1354:			}
;1355:			if ( cl->sess.sessionTeam != TEAM_FREE ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $701
line 1356
;1356:				continue;
ADDRGP4 $695
JUMPV
LABELV $701
line 1359
;1357:			}
;1358:
;1359:			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $703
line 1360
;1360:				LogExit( "Fraglimit hit." );
ADDRGP4 $687
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1361
;1361:				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
ADDRGP4 $706
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1363
;1362:					cl->pers.netname ) );
;1363:				return;
ADDRGP4 $649
JUMPV
LABELV $703
line 1365
;1364:			}
;1365:		}
LABELV $695
line 1350
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $697
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $694
line 1366
;1366:	}
LABELV $677
line 1368
;1367:
;1368:	if ( g_gametype.integer >= GT_CTF && g_capturelimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
LTI4 $707
ADDRGP4 g_capturelimit+12
INDIRI4
CNSTI4 0
EQI4 $707
line 1370
;1369:
;1370:		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $711
line 1371
;1371:			trap_SendServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $716
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1372
;1372:			LogExit( "Capturelimit hit." );
ADDRGP4 $717
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1373
;1373:			return;
ADDRGP4 $649
JUMPV
LABELV $711
line 1376
;1374:		}
;1375:
;1376:		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $718
line 1377
;1377:			trap_SendServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $723
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1378
;1378:			LogExit( "Capturelimit hit." );
ADDRGP4 $717
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1379
;1379:			return;
LABELV $718
line 1381
;1380:		}
;1381:	}
LABELV $707
line 1382
;1382:}
LABELV $649
endproc CheckExitRules 20 8
export CheckTournament
proc CheckTournament 32 8
line 1402
;1383:
;1384:
;1385:
;1386:/*
;1387:========================================================================
;1388:
;1389:FUNCTIONS CALLED EVERY FRAME
;1390:
;1391:========================================================================
;1392:*/
;1393:
;1394:
;1395:/*
;1396:=============
;1397:CheckTournament
;1398:
;1399:Once a frame, check for changes in tournement player state
;1400:=============
;1401:*/
;1402:void CheckTournament( void ) {
line 1405
;1403:	// check because we run 3 game frames before calling Connect and/or ClientBegin
;1404:	// for clients on a map_restart
;1405:	if ( level.numPlayingClients == 0 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 0
NEI4 $725
line 1406
;1406:		return;
ADDRGP4 $724
JUMPV
LABELV $725
line 1409
;1407:	}
;1408:
;1409:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $728
line 1412
;1410:
;1411:		// pull in a spectator if needed
;1412:		if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $731
line 1413
;1413:			AddTournamentPlayer();
ADDRGP4 AddTournamentPlayer
CALLV
pop
line 1414
;1414:		}
LABELV $731
line 1417
;1415:
;1416:		// if we don't have two players, go back to "waiting for players"
;1417:		if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $734
line 1418
;1418:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $724
line 1419
;1419:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1420
;1420:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1421
;1421:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $742
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1422
;1422:			}
line 1423
;1423:			return;
ADDRGP4 $724
JUMPV
LABELV $734
line 1426
;1424:		}
;1425:
;1426:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $743
line 1427
;1427:			return;
ADDRGP4 $724
JUMPV
LABELV $743
line 1431
;1428:		}
;1429:
;1430:		// if the warmup is changed at the console, restart it
;1431:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+352
INDIRI4
EQI4 $746
line 1432
;1432:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1433
;1433:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1434
;1434:		}
LABELV $746
line 1437
;1435:
;1436:		// if all players have arrived, start the countdown
;1437:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $753
line 1438
;1438:			if ( level.numPlayingClients == 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
NEI4 $724
line 1440
;1439:				// fudge by -1 to account for extra delays
;1440:				level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1441
;1441:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1442
;1442:			}
line 1443
;1443:			return;
ADDRGP4 $724
JUMPV
LABELV $753
line 1447
;1444:		}
;1445:
;1446:		// if the warmup time has counted down, restart
;1447:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $729
line 1448
;1448:			level.warmupTime += 10000;
ADDRLP4 0
ADDRGP4 level+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1449
;1449:			trap_Cvar_Set( "g_restarted", "1" );
ADDRGP4 $60
ARGP4
ADDRGP4 $84
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1450
;1450:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $517
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1451
;1451:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1452
;1452:			return;
ADDRGP4 $724
JUMPV
line 1454
;1453:		}
;1454:	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
LABELV $728
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $769
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $769
line 1456
;1455:		int		counts[TEAM_NUM_TEAMS];
;1456:		qboolean	notEnough = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1458
;1457:
;1458:		if ( g_gametype.integer > GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LEI4 $773
line 1459
;1459:			counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+8
ADDRLP4 20
INDIRI4
ASGNI4
line 1460
;1460:			counts[TEAM_RED] = TeamCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 24
INDIRI4
ASGNI4
line 1462
;1461:
;1462:			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 4+4
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $782
ADDRLP4 4+8
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $774
LABELV $782
line 1463
;1463:				notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1464
;1464:			}
line 1465
;1465:		} else if ( level.numPlayingClients < 2 ) {
ADDRGP4 $774
JUMPV
LABELV $773
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $783
line 1466
;1466:			notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1467
;1467:		}
LABELV $783
LABELV $774
line 1469
;1468:
;1469:		if ( notEnough ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $786
line 1470
;1470:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $724
line 1471
;1471:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1472
;1472:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1473
;1473:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $742
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1474
;1474:			}
line 1475
;1475:			return; // still waiting for team members
ADDRGP4 $724
JUMPV
LABELV $786
line 1478
;1476:		}
;1477:
;1478:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $793
line 1479
;1479:			return;
ADDRGP4 $724
JUMPV
LABELV $793
line 1483
;1480:		}
;1481:
;1482:		// if the warmup is changed at the console, restart it
;1483:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+352
INDIRI4
EQI4 $796
line 1484
;1484:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1485
;1485:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1486
;1486:		}
LABELV $796
line 1489
;1487:
;1488:		// if all players have arrived, start the countdown
;1489:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $803
line 1491
;1490:			// fudge by -1 to account for extra delays
;1491:			level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
ADDRLP4 20
CNSTI4 1000
ASGNI4
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
MULI4
ADDRLP4 20
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1492
;1492:			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $437
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1493
;1493:			return;
ADDRGP4 $724
JUMPV
LABELV $803
line 1497
;1494:		}
;1495:
;1496:		// if the warmup time has counted down, restart
;1497:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $810
line 1498
;1498:			level.warmupTime += 10000;
ADDRLP4 20
ADDRGP4 level+16
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1499
;1499:			trap_Cvar_Set( "g_restarted", "1" );
ADDRGP4 $60
ARGP4
ADDRGP4 $84
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1500
;1500:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $517
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1501
;1501:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1502
;1502:			return;
LABELV $810
line 1504
;1503:		}
;1504:	}
LABELV $769
LABELV $729
line 1505
;1505:}
LABELV $724
endproc CheckTournament 32 8
export CheckVote
proc CheckVote 4 8
line 1513
;1506:
;1507:
;1508:/*
;1509:==================
;1510:CheckVote
;1511:==================
;1512:*/
;1513:void CheckVote( void ) {
line 1514
;1514:	if ( level.voteExecuteTime && level.voteExecuteTime < level.time ) {
ADDRGP4 level+2408
INDIRI4
CNSTI4 0
EQI4 $817
ADDRGP4 level+2408
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $817
line 1515
;1515:		level.voteExecuteTime = 0;
ADDRGP4 level+2408
CNSTI4 0
ASGNI4
line 1516
;1516:		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
ADDRGP4 $823
ARGP4
ADDRGP4 level+356
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1517
;1517:	}
LABELV $817
line 1518
;1518:	if ( !level.voteTime ) {
ADDRGP4 level+2404
INDIRI4
CNSTI4 0
NEI4 $825
line 1519
;1519:		return;
ADDRGP4 $816
JUMPV
LABELV $825
line 1521
;1520:	}
;1521:	if ( level.time - level.voteTime >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+2404
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $828
line 1522
;1522:		trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $832
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1523
;1523:	} else {
ADDRGP4 $829
JUMPV
LABELV $828
line 1525
;1524:		// ATVI Q3 1.32 Patch #9, WNF
;1525:		if ( level.voteYes > level.numVotingClients/2 ) {
ADDRGP4 level+2412
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LEI4 $833
line 1527
;1526:			// execute the command, then remove the vote
;1527:			trap_SendServerCommand( -1, "print \"Vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $837
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1528
;1528:			level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+2408
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1529
;1529:		} else if ( level.voteNo >= level.numVotingClients/2 ) {
ADDRGP4 $834
JUMPV
LABELV $833
ADDRGP4 level+2416
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LTI4 $816
line 1531
;1530:			// same behavior as a timeout
;1531:			trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $832
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1532
;1532:		} else {
line 1534
;1533:			// still waiting for a majority
;1534:			return;
LABELV $841
LABELV $834
line 1536
;1535:		}
;1536:	}
LABELV $829
line 1537
;1537:	level.voteTime = 0;
ADDRGP4 level+2404
CNSTI4 0
ASGNI4
line 1538
;1538:	trap_SetConfigstring( CS_VOTE_TIME, "" );
CNSTI4 8
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1540
;1539:
;1540:}
LABELV $816
endproc CheckVote 4 8
export PrintTeam
proc PrintTeam 4 8
line 1547
;1541:
;1542:/*
;1543:==================
;1544:PrintTeam
;1545:==================
;1546:*/
;1547:void PrintTeam(int team, char *message) {
line 1550
;1548:	int i;
;1549:
;1550:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $849
JUMPV
LABELV $846
line 1551
;1551:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $851
line 1552
;1552:			continue;
ADDRGP4 $847
JUMPV
LABELV $851
line 1553
;1553:		trap_SendServerCommand( i, message );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1554
;1554:	}
LABELV $847
line 1550
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $849
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $846
line 1555
;1555:}
LABELV $845
endproc PrintTeam 4 8
export SetLeader
proc SetLeader 8 8
line 1562
;1556:
;1557:/*
;1558:==================
;1559:SetLeader
;1560:==================
;1561:*/
;1562:void SetLeader(int team, int client) {
line 1565
;1563:	int i;
;1564:
;1565:	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $854
line 1566
;1566:		PrintTeam(team, va("print \"%s is not connected\n\"", level.clients[client].pers.netname) );
ADDRGP4 $856
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1567
;1567:		return;
ADDRGP4 $853
JUMPV
LABELV $854
line 1569
;1568:	}
;1569:	if (level.clients[client].sess.sessionTeam != team) {
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $857
line 1570
;1570:		PrintTeam(team, va("print \"%s is not on the team anymore\n\"", level.clients[client].pers.netname) );
ADDRGP4 $859
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1571
;1571:		return;
ADDRGP4 $853
JUMPV
LABELV $857
line 1573
;1572:	}
;1573:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $863
JUMPV
LABELV $860
line 1574
;1574:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $865
line 1575
;1575:			continue;
ADDRGP4 $861
JUMPV
LABELV $865
line 1576
;1576:		if (level.clients[i].sess.teamLeader) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $867
line 1577
;1577:			level.clients[i].sess.teamLeader = qfalse;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 0
ASGNI4
line 1578
;1578:			ClientUserinfoChanged(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1579
;1579:		}
LABELV $867
line 1580
;1580:	}
LABELV $861
line 1573
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $863
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $860
line 1581
;1581:	level.clients[client].sess.teamLeader = qtrue;
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1582
;1582:	ClientUserinfoChanged( client );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1583
;1583:	PrintTeam(team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
ADDRGP4 $869
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1584
;1584:}
LABELV $853
endproc SetLeader 8 8
export CheckTeamLeader
proc CheckTeamLeader 4 0
line 1591
;1585:
;1586:/*
;1587:==================
;1588:CheckTeamLeader
;1589:==================
;1590:*/
;1591:void CheckTeamLeader( int team ) {
line 1594
;1592:	int i;
;1593:
;1594:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $874
JUMPV
LABELV $871
line 1595
;1595:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $876
line 1596
;1596:			continue;
ADDRGP4 $872
JUMPV
LABELV $876
line 1597
;1597:		if (level.clients[i].sess.teamLeader)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $878
line 1598
;1598:			break;
ADDRGP4 $873
JUMPV
LABELV $878
line 1599
;1599:	}
LABELV $872
line 1594
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $874
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $871
LABELV $873
line 1600
;1600:	if (i >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $880
line 1601
;1601:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $886
JUMPV
LABELV $883
line 1602
;1602:			if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $888
line 1603
;1603:				continue;
ADDRGP4 $884
JUMPV
LABELV $888
line 1604
;1604:			if (!(g_entities[i].r.svFlags & SVF_BOT)) {
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $890
line 1605
;1605:				level.clients[i].sess.teamLeader = qtrue;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1606
;1606:				break;
ADDRGP4 $885
JUMPV
LABELV $890
line 1608
;1607:			}
;1608:		}
LABELV $884
line 1601
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $886
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $883
LABELV $885
line 1609
;1609:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $897
JUMPV
LABELV $894
line 1610
;1610:			if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $899
line 1611
;1611:				continue;
ADDRGP4 $895
JUMPV
LABELV $899
line 1612
;1612:			level.clients[i].sess.teamLeader = qtrue;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1613
;1613:			break;
ADDRGP4 $896
JUMPV
LABELV $895
line 1609
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $897
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $894
LABELV $896
line 1615
;1614:		}
;1615:	}
LABELV $880
line 1616
;1616:}
LABELV $870
endproc CheckTeamLeader 4 0
export CheckTeamVote
proc CheckTeamVote 20 12
line 1623
;1617:
;1618:/*
;1619:==================
;1620:CheckTeamVote
;1621:==================
;1622:*/
;1623:void CheckTeamVote( int team ) {
line 1626
;1624:	int cs_offset;
;1625:
;1626:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $902
line 1627
;1627:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $903
JUMPV
LABELV $902
line 1628
;1628:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $901
line 1629
;1629:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1631
;1630:	else
;1631:		return;
LABELV $905
LABELV $903
line 1633
;1632:
;1633:	if ( !level.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $906
line 1634
;1634:		return;
ADDRGP4 $901
JUMPV
LABELV $906
line 1636
;1635:	}
;1636:	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $909
line 1637
;1637:		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $913
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1638
;1638:	} else {
ADDRGP4 $910
JUMPV
LABELV $909
line 1639
;1639:		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 level+4480
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
DIVI4
LEI4 $914
line 1641
;1640:			// execute the command, then remove the vote
;1641:			trap_SendServerCommand( -1, "print \"Team vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $918
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1643
;1642:			//
;1643:			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
ADDRGP4 $921
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $919
line 1645
;1644:				//set the team leader
;1645:				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424+7
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1646
;1646:			}
ADDRGP4 $915
JUMPV
LABELV $919
line 1647
;1647:			else {
line 1648
;1648:				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
ADDRGP4 $823
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1649
;1649:			}
line 1650
;1650:		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
ADDRGP4 $915
JUMPV
LABELV $914
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 level+4488
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
DIVI4
LTI4 $901
line 1652
;1651:			// same behavior as a timeout
;1652:			trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $913
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1653
;1653:		} else {
line 1655
;1654:			// still waiting for a majority
;1655:			return;
LABELV $927
LABELV $915
line 1657
;1656:		}
;1657:	}
LABELV $910
line 1658
;1658:	level.teamVoteTime[cs_offset] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
CNSTI4 0
ASGNI4
line 1659
;1659:	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );
ADDRLP4 0
INDIRI4
CNSTI4 12
ADDI4
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1661
;1660:
;1661:}
LABELV $901
endproc CheckTeamVote 20 12
data
align 4
LABELV $932
byte 4 -1
export CheckCvars
code
proc CheckCvars 4 8
line 1669
;1662:
;1663:
;1664:/*
;1665:==================
;1666:CheckCvars
;1667:==================
;1668:*/
;1669:void CheckCvars( void ) {
line 1672
;1670:	static int lastMod = -1;
;1671:
;1672:	if ( g_password.modificationCount != lastMod ) {
ADDRGP4 g_password+4
INDIRI4
ADDRGP4 $932
INDIRI4
EQI4 $933
line 1673
;1673:		lastMod = g_password.modificationCount;
ADDRGP4 $932
ADDRGP4 g_password+4
INDIRI4
ASGNI4
line 1674
;1674:		if ( *g_password.string && Q_stricmp( g_password.string, "none" ) ) {
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $937
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $941
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $937
line 1675
;1675:			trap_Cvar_Set( "g_needpass", "1" );
ADDRGP4 $85
ARGP4
ADDRGP4 $84
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1676
;1676:		} else {
ADDRGP4 $938
JUMPV
LABELV $937
line 1677
;1677:			trap_Cvar_Set( "g_needpass", "0" );
ADDRGP4 $85
ARGP4
ADDRGP4 $61
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1678
;1678:		}
LABELV $938
line 1679
;1679:	}
LABELV $933
line 1680
;1680:}
LABELV $931
endproc CheckCvars 4 8
export G_RunThink
proc G_RunThink 8 4
line 1689
;1681:
;1682:/*
;1683:=============
;1684:G_RunThink
;1685:
;1686:Runs thinking code for this frame if necessary
;1687:=============
;1688:*/
;1689:void G_RunThink (gentity_t *ent) {
line 1692
;1690:	float	thinktime;
;1691:
;1692:	thinktime = ent->nextthink;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1693
;1693:	if (thinktime <= 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $943
line 1694
;1694:		return;
ADDRGP4 $942
JUMPV
LABELV $943
line 1696
;1695:	}
;1696:	if (thinktime > level.time) {
ADDRLP4 0
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $945
line 1697
;1697:		return;
ADDRGP4 $942
JUMPV
LABELV $945
line 1700
;1698:	}
;1699:	
;1700:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 1701
;1701:	if (!ent->think) {
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $948
line 1702
;1702:		G_Error ( "NULL ent->think");
ADDRGP4 $950
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1703
;1703:	}
LABELV $948
line 1704
;1704:	ent->think (ent);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CALLV
pop
line 1705
;1705:}
LABELV $942
endproc G_RunThink 8 4
export G_RunFrame
proc G_RunFrame 44 12
line 1714
;1706:
;1707:/*
;1708:================
;1709:G_RunFrame
;1710:
;1711:Advances the non-player objects in the world
;1712:================
;1713:*/
;1714:void G_RunFrame( int levelTime ) {
line 1721
;1715:	int			i;
;1716:	gentity_t	*ent;
;1717:	int			msec;
;1718:int start, end;
;1719:
;1720:	// if we are waiting for the level to restart, do nothing
;1721:	if ( level.restarted ) {
ADDRGP4 level+68
INDIRI4
CNSTI4 0
EQI4 $952
line 1722
;1722:		return;
ADDRGP4 $951
JUMPV
LABELV $952
line 1725
;1723:	}
;1724:
;1725:	level.framenum++;
ADDRLP4 20
ADDRGP4 level+28
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1726
;1726:	level.previousTime = level.time;
ADDRGP4 level+36
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1727
;1727:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 1728
;1728:	msec = level.time - level.previousTime;
ADDRLP4 16
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
ASGNI4
line 1731
;1729:
;1730:	// get any cvar changes
;1731:	G_UpdateCvars();
ADDRGP4 G_UpdateCvars
CALLV
pop
line 1736
;1732:
;1733:	//
;1734:	// go through all allocated objects
;1735:	//
;1736:	start = trap_Milliseconds();
ADDRLP4 24
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 1737
;1737:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 1738
;1738:	for (i=0 ; i<level.num_entities ; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $964
JUMPV
LABELV $961
line 1739
;1739:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $966
line 1740
;1740:			continue;
ADDRGP4 $962
JUMPV
LABELV $966
line 1744
;1741:		}
;1742:
;1743:		// clear events that are too old
;1744:		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 300
LEI4 $968
line 1745
;1745:			if ( ent->s.event ) {
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $971
line 1746
;1746:				ent->s.event = 0;	// &= EV_EVENT_BITS;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 1747
;1747:				if ( ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $973
line 1748
;1748:					ent->client->ps.externalEvent = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 1752
;1749:					// predicted events should never be set to zero
;1750:					//ent->client->ps.events[0] = 0;
;1751:					//ent->client->ps.events[1] = 0;
;1752:				}
LABELV $973
line 1753
;1753:			}
LABELV $971
line 1754
;1754:			if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $975
line 1756
;1755:				// tempEntities or dropped items completely go away after their event
;1756:				G_FreeEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1757
;1757:				continue;
ADDRGP4 $962
JUMPV
LABELV $975
line 1758
;1758:			} else if ( ent->unlinkAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $977
line 1760
;1759:				// items that will respawn will hide themselves after their pickup event
;1760:				ent->unlinkAfterEvent = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1761
;1761:				trap_UnlinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1762
;1762:			}
LABELV $977
line 1763
;1763:		}
LABELV $968
line 1766
;1764:
;1765:		// temporary entities don't think
;1766:		if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $979
line 1767
;1767:			continue;
ADDRGP4 $962
JUMPV
LABELV $979
line 1770
;1768:		}
;1769:
;1770:		if ( !ent->r.linked && ent->neverFree ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $981
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $981
line 1771
;1771:			continue;
ADDRGP4 $962
JUMPV
LABELV $981
line 1774
;1772:		}
;1773:
;1774:		if ( ent->s.eType == ET_MISSILE ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $983
line 1775
;1775:			G_RunMissile( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunMissile
CALLV
pop
line 1776
;1776:			continue;
ADDRGP4 $962
JUMPV
LABELV $983
line 1779
;1777:		}
;1778:
;1779:		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $987
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $985
LABELV $987
line 1780
;1780:			G_RunItem( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunItem
CALLV
pop
line 1781
;1781:			continue;
ADDRGP4 $962
JUMPV
LABELV $985
line 1784
;1782:		}
;1783:
;1784:		if ( ent->s.eType == ET_MOVER ) {
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $988
line 1785
;1785:			G_RunMover( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunMover
CALLV
pop
line 1786
;1786:			continue;
ADDRGP4 $962
JUMPV
LABELV $988
line 1789
;1787:		}
;1788:
;1789:		if ( i < MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $990
line 1790
;1790:			G_RunClient( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunClient
CALLV
pop
line 1791
;1791:			continue;
ADDRGP4 $962
JUMPV
LABELV $990
line 1794
;1792:		}
;1793:
;1794:		G_RunThink( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1795
;1795:	}
LABELV $962
line 1738
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
LABELV $964
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $961
line 1796
;1796:end = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1798
;1797:
;1798:start = trap_Milliseconds();
ADDRLP4 32
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
ASGNI4
line 1800
;1799:	// perform final fixups on the players
;1800:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 1801
;1801:	for (i=0 ; i < level.maxclients ; i++, ent++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $995
JUMPV
LABELV $992
line 1802
;1802:		if ( ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $997
line 1803
;1803:			ClientEndFrame( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 1804
;1804:		}
LABELV $997
line 1805
;1805:	}
LABELV $993
line 1801
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
LABELV $995
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $992
line 1806
;1806:end = trap_Milliseconds();
ADDRLP4 36
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1809
;1807:
;1808:	// see if it is time to do a tournement restart
;1809:	CheckTournament();
ADDRGP4 CheckTournament
CALLV
pop
line 1812
;1810:
;1811:	// see if it is time to end the level
;1812:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 1815
;1813:
;1814:	// update to team status?
;1815:	CheckTeamStatus();
ADDRGP4 CheckTeamStatus
CALLV
pop
line 1818
;1816:
;1817:	// cancel vote if timed out
;1818:	CheckVote();
ADDRGP4 CheckVote
CALLV
pop
line 1821
;1819:
;1820:	// check team votes
;1821:	CheckTeamVote( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 1822
;1822:	CheckTeamVote( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 1825
;1823:
;1824:	// for tracking changes
;1825:	CheckCvars();
ADDRGP4 CheckCvars
CALLV
pop
line 1827
;1826:
;1827:	if (g_listEntity.integer) {
ADDRGP4 g_listEntity+12
INDIRI4
CNSTI4 0
EQI4 $999
line 1828
;1828:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1002
line 1829
;1829:			G_Printf("%4i: %s\n", i, g_entities[i].classname);
ADDRGP4 $1006
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 820
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1830
;1830:		}
LABELV $1003
line 1828
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $1002
line 1831
;1831:		trap_Cvar_Set("g_listEntity", "0");
ADDRGP4 $111
ARGP4
ADDRGP4 $61
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1832
;1832:	}
LABELV $999
line 1833
;1833:}
LABELV $951
endproc G_RunFrame 44 12
bss
export g_listEntity
align 4
LABELV g_listEntity
skip 272
export g_podiumDrop
align 4
LABELV g_podiumDrop
skip 272
export g_podiumDist
align 4
LABELV g_podiumDist
skip 272
export g_logSync
align 4
LABELV g_logSync
skip 272
export g_log
align 4
LABELV g_log
skip 272
export g_clients
align 4
LABELV g_clients
skip 49664
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
export g_rankings
align 4
LABELV g_rankings
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export g_smoothClients
align 4
LABELV g_smoothClients
skip 272
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
export g_filterBan
align 4
LABELV g_filterBan
skip 272
export g_banIPs
align 4
LABELV g_banIPs
skip 272
export g_teamForceBalance
align 4
LABELV g_teamForceBalance
skip 272
export g_teamAutoJoin
align 4
LABELV g_teamAutoJoin
skip 272
export g_allowVote
align 4
LABELV g_allowVote
skip 272
export g_blood
align 4
LABELV g_blood
skip 272
export g_doWarmup
align 4
LABELV g_doWarmup
skip 272
export g_warmup
align 4
LABELV g_warmup
skip 272
export g_motd
align 4
LABELV g_motd
skip 272
export g_synchronousClients
align 4
LABELV g_synchronousClients
skip 272
export g_weaponTeamRespawn
align 4
LABELV g_weaponTeamRespawn
skip 272
export g_weaponRespawn
align 4
LABELV g_weaponRespawn
skip 272
export g_debugDamage
align 4
LABELV g_debugDamage
skip 272
export g_debugAlloc
align 4
LABELV g_debugAlloc
skip 272
export g_debugMove
align 4
LABELV g_debugMove
skip 272
export g_inactivity
align 4
LABELV g_inactivity
skip 272
export g_forcerespawn
align 4
LABELV g_forcerespawn
skip 272
export g_quadfactor
align 4
LABELV g_quadfactor
skip 272
export g_knockback
align 4
LABELV g_knockback
skip 272
export g_speed
align 4
LABELV g_speed
skip 272
export g_gravity
align 4
LABELV g_gravity
skip 272
export g_needpass
align 4
LABELV g_needpass
skip 272
export g_password
align 4
LABELV g_password
skip 272
export g_friendlyFire
align 4
LABELV g_friendlyFire
skip 272
export g_capturelimit
align 4
LABELV g_capturelimit
skip 272
export g_timelimit
align 4
LABELV g_timelimit
skip 272
export g_fraglimit
align 4
LABELV g_fraglimit
skip 272
export g_dmflags
align 4
LABELV g_dmflags
skip 272
export g_restarted
align 4
LABELV g_restarted
skip 272
export g_maxGameClients
align 4
LABELV g_maxGameClients
skip 272
export g_maxclients
align 4
LABELV g_maxclients
skip 272
export g_cheats
align 4
LABELV g_cheats
skip 272
export g_dedicated
align 4
LABELV g_dedicated
skip 272
export g_gametype
align 4
LABELV g_gametype
skip 272
export g_entities
align 4
LABELV g_entities
skip 839680
export level
align 4
LABELV level
skip 9220
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import DeathmatchScoreboardMessage
import G_SetStats
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1006
byte 1 37
byte 1 52
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $950
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 45
byte 1 62
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $941
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $921
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $918
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $913
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $869
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $859
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $856
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $837
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $832
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $823
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $742
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $723
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $717
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $716
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $706
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $693
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $687
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $686
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $673
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $672
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $582
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $565
byte 1 114
byte 1 101
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $556
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $544
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $521
byte 1 118
byte 1 115
byte 1 116
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $517
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $470
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $437
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $303
byte 1 115
byte 1 0
align 1
LABELV $294
byte 1 102
byte 1 0
align 1
LABELV $266
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $260
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $254
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $251
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $250
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $249
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 47
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 52
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $247
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $243
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $227
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $226
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $225
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $223
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $208
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $204
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 71
byte 1 95
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 61
byte 1 37
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 61
byte 1 37
byte 1 100
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $202
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $201
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $180
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 44
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $162
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $115
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $113
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $112
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $110
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $109
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $108
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $107
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $106
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $105
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $104
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 0
align 1
LABELV $102
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $101
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 77
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $98
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $97
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $96
byte 1 53
byte 1 0
align 1
LABELV $95
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $94
byte 1 51
byte 1 0
align 1
LABELV $93
byte 1 103
byte 1 95
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $92
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $91
byte 1 103
byte 1 95
byte 1 107
byte 1 110
byte 1 111
byte 1 99
byte 1 107
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $90
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $89
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $88
byte 1 51
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $87
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $86
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $85
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $84
byte 1 49
byte 1 0
align 1
LABELV $83
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $82
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 0
align 1
LABELV $81
byte 1 103
byte 1 95
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $80
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 83
byte 1 121
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $79
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $78
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $77
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $76
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $75
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 66
byte 1 97
byte 1 108
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $74
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $73
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $72
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $71
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $70
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $69
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $68
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $67
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $66
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $65
byte 1 56
byte 1 0
align 1
LABELV $64
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $63
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $62
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $61
byte 1 48
byte 1 0
align 1
LABELV $60
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $59
byte 1 65
byte 1 117
byte 1 103
byte 1 32
byte 1 50
byte 1 53
byte 1 32
byte 1 50
byte 1 48
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $58
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $57
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 0
align 1
LABELV $56
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $55
byte 1 0
align 1
LABELV $54
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
