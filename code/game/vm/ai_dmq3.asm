export BotSetUserInfo
code
proc BotSetUserInfo 1024 12
file "game/ai_dmq3.c"
line 116
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
;24:/*****************************************************************************
;25: * name:		ai_dmq3.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;30: *
;31: *****************************************************************************/
;32:
;33:
;34:#include "g_local.h"
;35:#include "botlib.h"
;36:#include "be_aas.h"
;37:#include "be_ea.h"
;38:#include "be_ai_char.h"
;39:#include "be_ai_chat.h"
;40:#include "be_ai_gen.h"
;41:#include "be_ai_goal.h"
;42:#include "be_ai_move.h"
;43:#include "be_ai_weap.h"
;44://
;45:#include "ai_main.h"
;46:#include "ai_dmq3.h"
;47:#include "ai_chat.h"
;48:#include "ai_cmd.h"
;49:#include "ai_dmnet.h"
;50:#include "ai_team.h"
;51://
;52:#include "chars.h"				//characteristics
;53:#include "inv.h"				//indexes into the inventory
;54:#include "syn.h"				//synonyms
;55:#include "match.h"				//string matching types and vars
;56:
;57:// for the voice chats
;58:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;59:
;60:// from aasfile.h
;61:#define AREACONTENTS_MOVER				1024
;62:#define AREACONTENTS_MODELNUMSHIFT		24
;63:#define AREACONTENTS_MAXMODELNUM		0xFF
;64:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;65:
;66:#define IDEAL_ATTACKDIST			140
;67:
;68:#define MAX_WAYPOINTS		128
;69://
;70:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;71:bot_waypoint_t *botai_freewaypoints;
;72:
;73://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;74:int gametype;		//game type
;75:int maxclients;		//maximum number of clients
;76:
;77:vmCvar_t bot_grapple;
;78:vmCvar_t bot_rocketjump;
;79:vmCvar_t bot_fastchat;
;80:vmCvar_t bot_nochat;
;81:vmCvar_t bot_testrchat;
;82:vmCvar_t bot_challenge;
;83:vmCvar_t bot_predictobstacles;
;84:vmCvar_t g_spSkill;
;85:
;86:extern vmCvar_t bot_developer;
;87:
;88:vec3_t lastteleport_origin;		//last teleport event origin
;89:float lastteleport_time;		//last teleport event time
;90:int max_bspmodelindex;			//maximum BSP model index
;91:
;92://CTF flag goals
;93:bot_goal_t ctf_redflag;
;94:bot_goal_t ctf_blueflag;
;95:#ifdef MISSIONPACK
;96:bot_goal_t ctf_neutralflag;
;97:bot_goal_t redobelisk;
;98:bot_goal_t blueobelisk;
;99:bot_goal_t neutralobelisk;
;100:#endif
;101:
;102:#define MAX_ALTROUTEGOALS		32
;103:
;104:int altroutegoals_setup;
;105:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;106:int red_numaltroutegoals;
;107:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;108:int blue_numaltroutegoals;
;109:
;110:
;111:/*
;112:==================
;113:BotSetUserInfo
;114:==================
;115:*/
;116:void BotSetUserInfo(bot_state_t *bs, char *key, char *value) {
line 119
;117:	char userinfo[MAX_INFO_STRING];
;118:
;119:	trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 120
;120:	Info_SetValueForKey(userinfo, key, value);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 121
;121:	trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 122
;122:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 123
;123:}
LABELV $54
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 130
;124:
;125:/*
;126:==================
;127:BotCTFCarryingFlag
;128:==================
;129:*/
;130:int BotCTFCarryingFlag(bot_state_t *bs) {
line 131
;131:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $56
CNSTI4 0
RETI4
ADDRGP4 $55
JUMPV
LABELV $56
line 133
;132:
;133:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5132
ADDP4
INDIRI4
CNSTI4 0
LEI4 $58
CNSTI4 1
RETI4
ADDRGP4 $55
JUMPV
LABELV $58
line 134
;134:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5136
ADDP4
INDIRI4
CNSTI4 0
LEI4 $60
CNSTI4 2
RETI4
ADDRGP4 $55
JUMPV
LABELV $60
line 135
;135:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $55
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 143
;136:}
;137:
;138:/*
;139:==================
;140:BotTeam
;141:==================
;142:*/
;143:int BotTeam(bot_state_t *bs) {
line 146
;144:	char info[1024];
;145:
;146:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $65
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $63
LABELV $65
line 148
;147:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;148:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $62
JUMPV
LABELV $63
line 150
;149:	}
;150:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 152
;151:	//
;152:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $66
CNSTI4 1
RETI4
ADDRGP4 $62
JUMPV
LABELV $66
line 153
;153:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $69
CNSTI4 2
RETI4
ADDRGP4 $62
JUMPV
LABELV $69
line 154
;154:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $62
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 162
;155:}
;156:
;157:/*
;158:==================
;159:BotOppositeTeam
;160:==================
;161:*/
;162:int BotOppositeTeam(bot_state_t *bs) {
line 163
;163:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $75
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $76
ADDRGP4 $72
JUMPV
LABELV $75
line 164
;164:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $71
JUMPV
LABELV $76
line 165
;165:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $71
JUMPV
LABELV $72
line 166
;166:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $71
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 175
;167:	}
;168:}
;169:
;170:/*
;171:==================
;172:BotEnemyFlag
;173:==================
;174:*/
;175:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 176
;176:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $78
line 177
;177:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $77
JUMPV
LABELV $78
line 179
;178:	}
;179:	else {
line 180
;180:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $77
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 189
;181:	}
;182:}
;183:
;184:/*
;185:==================
;186:BotTeamFlag
;187:==================
;188:*/
;189:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 190
;190:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $81
line 191
;191:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $80
JUMPV
LABELV $81
line 193
;192:	}
;193:	else {
line 194
;194:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $80
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 472 8
line 204
;195:	}
;196:}
;197:
;198:
;199:/*
;200:==================
;201:EntityIsDead
;202:==================
;203:*/
;204:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 207
;205:	playerState_t ps;
;206:
;207:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
LTI4 $84
ADDRLP4 468
INDIRI4
CNSTI4 64
GEI4 $84
line 209
;208:		//retrieve the current client state
;209:		BotAI_GetClientState( entinfo->number, &ps );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 210
;210:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $86
CNSTI4 1
RETI4
ADDRGP4 $83
JUMPV
LABELV $86
line 211
;211:	}
LABELV $84
line 212
;212:	return qfalse;
CNSTI4 0
RETI4
LABELV $83
endproc EntityIsDead 472 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 220
;213:}
;214:
;215:/*
;216:==================
;217:EntityCarriesFlag
;218:==================
;219:*/
;220:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 221
;221:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $90
line 222
;222:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $89
JUMPV
LABELV $90
line 223
;223:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $92
line 224
;224:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $89
JUMPV
LABELV $92
line 229
;225:#ifdef MISSIONPACK
;226:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
;227:		return qtrue;
;228:#endif
;229:	return qfalse;
CNSTI4 0
RETI4
LABELV $89
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 237
;230:}
;231:
;232:/*
;233:==================
;234:EntityIsInvisible
;235:==================
;236:*/
;237:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 239
;238:	// the flag is always visible
;239:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $95
line 240
;240:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $94
JUMPV
LABELV $95
line 242
;241:	}
;242:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $97
line 243
;243:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $97
line 245
;244:	}
;245:	return qfalse;
CNSTI4 0
RETI4
LABELV $94
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 253
;246:}
;247:
;248:/*
;249:==================
;250:EntityIsShooting
;251:==================
;252:*/
;253:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 254
;254:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $100
line 255
;255:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $99
JUMPV
LABELV $100
line 257
;256:	}
;257:	return qfalse;
CNSTI4 0
RETI4
LABELV $99
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 265
;258:}
;259:
;260:/*
;261:==================
;262:EntityIsChatting
;263:==================
;264:*/
;265:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 266
;266:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $103
line 267
;267:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 269
;268:	}
;269:	return qfalse;
CNSTI4 0
RETI4
LABELV $102
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 277
;270:}
;271:
;272:/*
;273:==================
;274:EntityHasQuad
;275:==================
;276:*/
;277:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 278
;278:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $106
line 279
;279:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $105
JUMPV
LABELV $106
line 281
;280:	}
;281:	return qfalse;
CNSTI4 0
RETI4
LABELV $105
endproc EntityHasQuad 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 345
;282:}
;283:
;284:#ifdef MISSIONPACK
;285:/*
;286:==================
;287:EntityHasKamikze
;288:==================
;289:*/
;290:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
;291:	if (entinfo->flags & EF_KAMIKAZE) {
;292:		return qtrue;
;293:	}
;294:	return qfalse;
;295:}
;296:
;297:/*
;298:==================
;299:EntityCarriesCubes
;300:==================
;301:*/
;302:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
;303:	entityState_t state;
;304:
;305:	if (gametype != GT_HARVESTER)
;306:		return qfalse;
;307:	//FIXME: get this info from the aas_entityinfo_t ?
;308:	BotAI_GetEntityState(entinfo->number, &state);
;309:	if (state.generic1 > 0)
;310:		return qtrue;
;311:	return qfalse;
;312:}
;313:
;314:/*
;315:==================
;316:Bot1FCTFCarryingFlag
;317:==================
;318:*/
;319:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
;320:	if (gametype != GT_1FCTF) return qfalse;
;321:
;322:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
;323:	return qfalse;
;324:}
;325:
;326:/*
;327:==================
;328:BotHarvesterCarryingCubes
;329:==================
;330:*/
;331:int BotHarvesterCarryingCubes(bot_state_t *bs) {
;332:	if (gametype != GT_HARVESTER) return qfalse;
;333:
;334:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
;335:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
;336:	return qfalse;
;337:}
;338:#endif
;339:
;340:/*
;341:==================
;342:BotRememberLastOrderedTask
;343:==================
;344:*/
;345:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 346
;346:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $109
line 347
;347:		return;
ADDRGP4 $108
JUMPV
LABELV $109
line 349
;348:	}
;349:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ASGNI4
line 350
;350:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
line 351
;351:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 352
;352:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ASGNI4
line 353
;353:}
LABELV $108
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 0 0
line 360
;354:
;355:/*
;356:==================
;357:BotSetTeamStatus
;358:==================
;359:*/
;360:void BotSetTeamStatus(bot_state_t *bs) {
line 417
;361:#ifdef MISSIONPACK
;362:	int teamtask;
;363:	aas_entityinfo_t entinfo;
;364:
;365:	teamtask = TEAMTASK_PATROL;
;366:
;367:	switch(bs->ltgtype) {
;368:		case LTG_TEAMHELP:
;369:			break;
;370:		case LTG_TEAMACCOMPANY:
;371:			BotEntityInfo(bs->teammate, &entinfo);
;372:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
;373:				|| ( gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo)) ) {
;374:				teamtask = TEAMTASK_ESCORT;
;375:			}
;376:			else {
;377:				teamtask = TEAMTASK_FOLLOW;
;378:			}
;379:			break;
;380:		case LTG_DEFENDKEYAREA:
;381:			teamtask = TEAMTASK_DEFENSE;
;382:			break;
;383:		case LTG_GETFLAG:
;384:			teamtask = TEAMTASK_OFFENSE;
;385:			break;
;386:		case LTG_RUSHBASE:
;387:			teamtask = TEAMTASK_DEFENSE;
;388:			break;
;389:		case LTG_RETURNFLAG:
;390:			teamtask = TEAMTASK_RETRIEVE;
;391:			break;
;392:		case LTG_CAMP:
;393:		case LTG_CAMPORDER:
;394:			teamtask = TEAMTASK_CAMP;
;395:			break;
;396:		case LTG_PATROL:
;397:			teamtask = TEAMTASK_PATROL;
;398:			break;
;399:		case LTG_GETITEM:
;400:			teamtask = TEAMTASK_PATROL;
;401:			break;
;402:		case LTG_KILL:
;403:			teamtask = TEAMTASK_PATROL;
;404:			break;
;405:		case LTG_HARVEST:
;406:			teamtask = TEAMTASK_OFFENSE;
;407:			break;
;408:		case LTG_ATTACKENEMYBASE:
;409:			teamtask = TEAMTASK_OFFENSE;
;410:			break;
;411:		default:
;412:			teamtask = TEAMTASK_PATROL;
;413:			break;
;414:	}
;415:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
;416:#endif
;417:}
LABELV $111
endproc BotSetTeamStatus 0 0
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 60 16
line 424
;418:
;419:/*
;420:==================
;421:BotSetLastOrderedTask
;422:==================
;423:*/
;424:int BotSetLastOrderedTask(bot_state_t *bs) {
line 426
;425:
;426:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $113
line 428
;427:		// don't go back to returning the flag if it's at the base
;428:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 6
NEI4 $115
line 429
;429:			if ( BotTeam(bs) == TEAM_RED ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $117
line 430
;430:				if ( bs->redflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 0
NEI4 $118
line 431
;431:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 432
;432:				}
line 433
;433:			}
ADDRGP4 $118
JUMPV
LABELV $117
line 434
;434:			else {
line 435
;435:				if ( bs->blueflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $121
line 436
;436:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 437
;437:				}
LABELV $121
line 438
;438:			}
LABELV $118
line 439
;439:		}
LABELV $115
line 440
;440:	}
LABELV $113
line 442
;441:
;442:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $123
line 443
;443:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ASGNI4
line 444
;444:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 445
;445:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ASGNI4
line 446
;446:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 447
;447:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ASGNI4
line 448
;448:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 449
;449:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 451
;450:		//
;451:		if ( gametype == GT_CTF ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $125
line 452
;452:			if ( bs->ltgtype == LTG_GETFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $127
line 456
;453:				bot_goal_t *tb, *eb;
;454:				int tt, et;
;455:
;456:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 457
;457:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 458
;458:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 44
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 459
;459:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
ASGNI4
line 461
;460:				// if the travel time towards the enemy base is larger than towards our base
;461:				if (et > tt) {
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $129
line 463
;462:					//get an alternative route goal towards the enemy base
;463:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 464
;464:				}
LABELV $129
line 465
;465:			}
LABELV $127
line 466
;466:		}
LABELV $125
line 467
;467:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $112
JUMPV
LABELV $123
line 469
;468:	}
;469:	return qfalse;
CNSTI4 0
RETI4
LABELV $112
endproc BotSetLastOrderedTask 60 16
export BotRefuseOrder
proc BotRefuseOrder 8 12
line 477
;470:}
;471:
;472:/*
;473:==================
;474:BotRefuseOrder
;475:==================
;476:*/
;477:void BotRefuseOrder(bot_state_t *bs) {
line 478
;478:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $132
line 479
;479:		return;
ADDRGP4 $131
JUMPV
LABELV $132
line 481
;480:	// if the bot was ordered to do something
;481:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $134
ADDRLP4 0
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $134
line 482
;482:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 483
;483:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ARGI4
ADDRGP4 $136
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 484
;484:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 485
;485:	}
LABELV $134
line 486
;486:}
LABELV $131
endproc BotRefuseOrder 8 12
export BotCTFSeekGoals
proc BotCTFSeekGoals 240 12
line 493
;487:
;488:/*
;489:==================
;490:BotCTFSeekGoals
;491:==================
;492:*/
;493:void BotCTFSeekGoals(bot_state_t *bs) {
line 500
;494:	float rnd, l1, l2;
;495:	int flagstatus, c;
;496:	vec3_t dir;
;497:	aas_entityinfo_t entinfo;
;498:
;499:	//when carrying a flag in ctf the bot should rush to the base
;500:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $138
line 502
;501:		//if not already rushing to the base
;502:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $140
line 503
;503:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 504
;504:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 505
;505:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 506
;506:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 507
;507:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 508
;508:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 510
;509:			//
;510:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $145
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $150
ADDRGP4 $142
JUMPV
LABELV $145
line 511
;511:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $143
JUMPV
LABELV $150
line 512
;512:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $143
JUMPV
LABELV $142
line 513
;513:				default: VectorSet(dir, 999, 999, 999); break;
ADDRLP4 200
CNSTF4 1148829696
ASGNF4
ADDRLP4 160
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
LABELV $143
line 516
;514:			}
;515:			// if the bot picked up the flag very close to the enemy base
;516:			if ( VectorLength(dir) < 128 ) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $157
line 518
;517:				// get an alternative route goal through the enemy base
;518:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 519
;519:			} else {
ADDRGP4 $158
JUMPV
LABELV $157
line 521
;520:				// don't use any alt route goal, just get the hell out of the base
;521:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
CNSTI4 0
ASGNI4
line 522
;522:			}
LABELV $158
line 523
;523:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $160
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 524
;524:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $161
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 525
;525:		}
ADDRGP4 $137
JUMPV
LABELV $140
line 526
;526:		else if (bs->rushbaseaway_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $137
line 527
;527:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $164
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $165
JUMPV
LABELV $164
line 528
;528:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ASGNI4
LABELV $165
line 530
;529:			//if the flag is back
;530:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $137
line 531
;531:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 532
;532:			}
line 533
;533:		}
line 534
;534:		return;
ADDRGP4 $137
JUMPV
LABELV $138
line 537
;535:	}
;536:	// if the bot decided to follow someone
;537:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $168
ADDRLP4 176
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $168
line 539
;538:		// if the team mate being accompanied no longer carries the flag
;539:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 540
;540:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $170
line 541
;541:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 542
;542:		}
LABELV $170
line 543
;543:	}
LABELV $168
line 545
;544:	//
;545:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $172
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $173
JUMPV
LABELV $172
line 546
;546:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $173
line 548
;547:	//if our team has the enemy flag and our flag is at the base
;548:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $174
line 550
;549:		//
;550:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $137
line 552
;551:			//if Not defending the base already
;552:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
NEI4 $182
ADDRLP4 196
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $137
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $137
LABELV $182
line 554
;553:					(bs->teamgoal.number == ctf_redflag.number ||
;554:					bs->teamgoal.number == ctf_blueflag.number))) {
line 556
;555:				//if there is a visible team mate flag carrier
;556:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 200
INDIRI4
ASGNI4
line 557
;557:				if (c >= 0 &&
ADDRLP4 204
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
LTI4 $137
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $185
ADDRLP4 208
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ADDRLP4 204
INDIRI4
EQI4 $137
LABELV $185
line 559
;558:						// and not already following the team mate flag carrier
;559:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 561
;560:					//
;561:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 563
;562:					//follow the flag carrier
;563:					bs->decisionmaker = bs->client;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 564
;564:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 566
;565:					//the team mate
;566:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 568
;567:					//last time the team mate was visible
;568:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 570
;569:					//no message
;570:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 572
;571:					//no arrive message
;572:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 574
;573:					//
;574:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $186
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 576
;575:					//get the team goal time
;576:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 577
;577:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 578
;578:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7012
ADDP4
CNSTF4 1121976320
ASGNF4
line 579
;579:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 580
;580:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 581
;581:				}
line 582
;582:			}
line 583
;583:		}
line 584
;584:		return;
ADDRGP4 $137
JUMPV
LABELV $174
line 587
;585:	}
;586:	//if the enemy has our flag
;587:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $187
line 589
;588:		//
;589:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $137
line 591
;590:			//if enemy flag carrier is visible
;591:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 592
;592:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $191
line 594
;593:				//FIXME: fight enemy flag carrier
;594:			}
LABELV $191
line 596
;595:			//if not already doing something important
;596:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 4
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 6
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 1
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 2
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 8
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 9
EQI4 $137
ADDRLP4 196
INDIRI4
CNSTI4 10
EQI4 $137
line 602
;597:				bs->ltgtype != LTG_RETURNFLAG &&
;598:				bs->ltgtype != LTG_TEAMHELP &&
;599:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;600:				bs->ltgtype != LTG_CAMPORDER &&
;601:				bs->ltgtype != LTG_PATROL &&
;602:				bs->ltgtype != LTG_GETITEM) {
line 604
;603:
;604:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 605
;605:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 606
;606:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 608
;607:				//
;608:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $195
line 610
;609:					//go for the enemy flag
;610:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 611
;611:				}
ADDRGP4 $196
JUMPV
LABELV $195
line 612
;612:				else {
line 613
;613:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 614
;614:				}
LABELV $196
line 616
;615:				//no team message
;616:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 618
;617:				//set the time the bot will stop getting the flag
;618:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 620
;619:				//get an alternative route goal towards the enemy base
;620:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 622
;621:				//
;622:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 623
;623:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 624
;624:			}
line 625
;625:		}
line 626
;626:		return;
ADDRGP4 $137
JUMPV
LABELV $187
line 629
;627:	}
;628:	//if both flags Not at their bases
;629:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $197
line 631
;630:		//
;631:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $137
line 633
;632:			// if not trying to return the flag and not following the team flag carrier
;633:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 6
EQI4 $137
ADDRLP4 192
INDIRI4
CNSTI4 2
EQI4 $137
line 635
;634:				//
;635:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 637
;636:				// if there is a visible team mate flag carrier
;637:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $203
line 638
;638:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 640
;639:					//follow the flag carrier
;640:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 641
;641:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 643
;642:					//the team mate
;643:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 645
;644:					//last time the team mate was visible
;645:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 647
;646:					//no message
;647:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 649
;648:					//no arrive message
;649:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 651
;650:					//
;651:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $186
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 653
;652:					//get the team goal time
;653:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 654
;654:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 655
;655:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7012
ADDP4
CNSTF4 1121976320
ASGNF4
line 657
;656:					//
;657:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 658
;658:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 659
;659:				}
ADDRGP4 $137
JUMPV
LABELV $203
line 660
;660:				else {
line 661
;661:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 662
;662:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 663
;663:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 665
;664:					//get the enemy flag
;665:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 667
;666:					//get the flag
;667:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 669
;668:					//set the time the bot will stop getting the flag
;669:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 671
;670:					//get an alternative route goal towards the enemy base
;671:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 673
;672:					//
;673:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 674
;674:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 675
;675:				}
line 676
;676:			}
line 677
;677:		}
line 678
;678:		return;
ADDRGP4 $137
JUMPV
LABELV $197
line 681
;679:	}
;680:	// don't just do something wait for the bot team leader to give orders
;681:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $205
line 682
;682:		return;
ADDRGP4 $137
JUMPV
LABELV $205
line 685
;683:	}
;684:	// if the bot is ordered to do something
;685:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $207
line 686
;686:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 687
;687:	}
LABELV $207
line 689
;688:	// if the bot decided to do something on it's own and has a last ordered goal
;689:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
CNSTI4 0
ASGNI4
ADDRLP4 196
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
NEI4 $209
ADDRLP4 196
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $209
line 690
;690:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 691
;691:	}
LABELV $209
line 693
;692:	//if already a CTF or team goal
;693:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 1
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 2
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 3
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 4
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 5
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 6
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 8
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 9
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 10
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 14
EQI4 $222
ADDRLP4 204
INDIRI4
CNSTI4 15
NEI4 $211
LABELV $222
line 703
;694:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;695:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;696:			bs->ltgtype == LTG_GETFLAG ||
;697:			bs->ltgtype == LTG_RUSHBASE ||
;698:			bs->ltgtype == LTG_RETURNFLAG ||
;699:			bs->ltgtype == LTG_CAMPORDER ||
;700:			bs->ltgtype == LTG_PATROL ||
;701:			bs->ltgtype == LTG_GETITEM ||
;702:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;703:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 704
;704:		return;
ADDRGP4 $137
JUMPV
LABELV $211
line 707
;705:	}
;706:	//
;707:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $223
line 708
;708:		return;
ADDRGP4 $137
JUMPV
LABELV $223
line 710
;709:	//
;710:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $225
line 711
;711:		return;;
ADDRGP4 $137
JUMPV
LABELV $225
line 713
;712:	//if the bot is roaming
;713:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $227
line 714
;714:		return;
ADDRGP4 $137
JUMPV
LABELV $227
line 716
;715:	//if the bot has anough aggression to decide what to do
;716:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 212
INDIRF4
CNSTF4 1112014848
GEF4 $229
line 717
;717:		return;
ADDRGP4 $137
JUMPV
LABELV $229
line 719
;718:	//set the time to send a message to the team mates
;719:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 216
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 721
;720:	//
;721:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $231
line 722
;722:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $233
line 723
;723:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 724
;724:		}
ADDRGP4 $234
JUMPV
LABELV $233
line 725
;725:		else {
line 726
;726:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 727
;727:		}
LABELV $234
line 728
;728:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 729
;729:	}
ADDRGP4 $232
JUMPV
LABELV $231
line 730
;730:	else {
line 731
;731:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 732
;732:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 733
;733:	}
LABELV $232
line 735
;734:	//get the flag or defend the base
;735:	rnd = random();
ADDRLP4 220
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 220
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 736
;736:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $235
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $235
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $235
line 737
;737:		bs->decisionmaker = bs->client;
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 228
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 738
;738:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 739
;739:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 741
;740:		//set the time the bot will stop getting the flag
;741:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 743
;742:		//get an alternative route goal towards the enemy base
;743:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 744
;744:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 745
;745:	}
ADDRGP4 $236
JUMPV
LABELV $235
line 746
;746:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $239
ADDRLP4 228
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $239
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $239
line 747
;747:		bs->decisionmaker = bs->client;
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 232
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 748
;748:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 750
;749:		//
;750:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 236
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 1
NEI4 $243
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $244
JUMPV
LABELV $243
line 751
;751:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $244
line 753
;752:		//set the ltg type
;753:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 755
;754:		//set the time the bot stops defending the base
;755:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 756
;756:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 757
;757:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 758
;758:	}
ADDRGP4 $240
JUMPV
LABELV $239
line 759
;759:	else {
line 760
;760:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 762
;761:		//set the time the bot will stop roaming
;762:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 763
;763:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 764
;764:	}
LABELV $240
LABELV $236
line 765
;765:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 769
;766:#ifdef DEBUG
;767:	BotPrintTeamGoal(bs);
;768:#endif //DEBUG
;769:}
LABELV $137
endproc BotCTFSeekGoals 240 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 776
;770:
;771:/*
;772:==================
;773:BotCTFRetreatGoals
;774:==================
;775:*/
;776:void BotCTFRetreatGoals(bot_state_t *bs) {
line 778
;777:	//when carrying a flag in ctf the bot should rush to the base
;778:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $246
line 780
;779:		//if not already rushing to the base
;780:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $248
line 781
;781:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 782
;782:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 783
;783:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 784
;784:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 785
;785:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 786
;786:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 787
;787:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 788
;788:		}
LABELV $248
line 789
;789:	}
LABELV $246
line 790
;790:}
LABELV $245
endproc BotCTFRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 0 4
line 1326
;791:
;792:#ifdef MISSIONPACK
;793:/*
;794:==================
;795:Bot1FCTFSeekGoals
;796:==================
;797:*/
;798:void Bot1FCTFSeekGoals(bot_state_t *bs) {
;799:	aas_entityinfo_t entinfo;
;800:	float rnd, l1, l2;
;801:	int c;
;802:
;803:	//when carrying a flag in ctf the bot should rush to the base
;804:	if (Bot1FCTFCarryingFlag(bs)) {
;805:		//if not already rushing to the base
;806:		if (bs->ltgtype != LTG_RUSHBASE) {
;807:			BotRefuseOrder(bs);
;808:			bs->ltgtype = LTG_RUSHBASE;
;809:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;810:			bs->rushbaseaway_time = 0;
;811:			bs->decisionmaker = bs->client;
;812:			bs->ordered = qfalse;
;813:			//get an alternative route goal towards the enemy base
;814:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;815:			//
;816:			BotSetTeamStatus(bs);
;817:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;818:		}
;819:		return;
;820:	}
;821:	// if the bot decided to follow someone
;822:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;823:		// if the team mate being accompanied no longer carries the flag
;824:		BotEntityInfo(bs->teammate, &entinfo);
;825:		if (!EntityCarriesFlag(&entinfo)) {
;826:			bs->ltgtype = 0;
;827:		}
;828:	}
;829:	//our team has the flag
;830:	if (bs->neutralflagstatus == 1) {
;831:		if (bs->owndecision_time < FloatTime()) {
;832:			// if not already following someone
;833:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;834:				//if there is a visible team mate flag carrier
;835:				c = BotTeamFlagCarrierVisible(bs);
;836:				if (c >= 0) {
;837:					BotRefuseOrder(bs);
;838:					//follow the flag carrier
;839:					bs->decisionmaker = bs->client;
;840:					bs->ordered = qfalse;
;841:					//the team mate
;842:					bs->teammate = c;
;843:					//last time the team mate was visible
;844:					bs->teammatevisible_time = FloatTime();
;845:					//no message
;846:					bs->teammessage_time = 0;
;847:					//no arrive message
;848:					bs->arrive_time = 1;
;849:					//
;850:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;851:					//get the team goal time
;852:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;853:					bs->ltgtype = LTG_TEAMACCOMPANY;
;854:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;855:					BotSetTeamStatus(bs);
;856:					bs->owndecision_time = FloatTime() + 5;
;857:					return;
;858:				}
;859:			}
;860:			//if already a CTF or team goal
;861:			if (bs->ltgtype == LTG_TEAMHELP ||
;862:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;863:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;864:					bs->ltgtype == LTG_GETFLAG ||
;865:					bs->ltgtype == LTG_RUSHBASE ||
;866:					bs->ltgtype == LTG_CAMPORDER ||
;867:					bs->ltgtype == LTG_PATROL ||
;868:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;869:					bs->ltgtype == LTG_GETITEM ||
;870:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;871:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;872:				return;
;873:			}
;874:			//if not already attacking the enemy base
;875:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
;876:				BotRefuseOrder(bs);
;877:				bs->decisionmaker = bs->client;
;878:				bs->ordered = qfalse;
;879:				//
;880:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;881:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;882:				//set the ltg type
;883:				bs->ltgtype = LTG_ATTACKENEMYBASE;
;884:				//set the time the bot will stop getting the flag
;885:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;886:				BotSetTeamStatus(bs);
;887:				bs->owndecision_time = FloatTime() + 5;
;888:			}
;889:		}
;890:		return;
;891:	}
;892:	//enemy team has the flag
;893:	else if (bs->neutralflagstatus == 2) {
;894:		if (bs->owndecision_time < FloatTime()) {
;895:			c = BotEnemyFlagCarrierVisible(bs);
;896:			if (c >= 0) {
;897:				//FIXME: attack enemy flag carrier
;898:			}
;899:			//if already a CTF or team goal
;900:			if (bs->ltgtype == LTG_TEAMHELP ||
;901:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;902:					bs->ltgtype == LTG_CAMPORDER ||
;903:					bs->ltgtype == LTG_PATROL ||
;904:					bs->ltgtype == LTG_GETITEM) {
;905:				return;
;906:			}
;907:			// if not already defending the base
;908:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
;909:				BotRefuseOrder(bs);
;910:				bs->decisionmaker = bs->client;
;911:				bs->ordered = qfalse;
;912:				//
;913:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;914:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;915:				//set the ltg type
;916:				bs->ltgtype = LTG_DEFENDKEYAREA;
;917:				//set the time the bot stops defending the base
;918:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;919:				bs->defendaway_time = 0;
;920:				BotSetTeamStatus(bs);
;921:				bs->owndecision_time = FloatTime() + 5;
;922:			}
;923:		}
;924:		return;
;925:	}
;926:	// don't just do something wait for the bot team leader to give orders
;927:	if (BotTeamLeader(bs)) {
;928:		return;
;929:	}
;930:	// if the bot is ordered to do something
;931:	if ( bs->lastgoal_ltgtype ) {
;932:		bs->teamgoal_time += 60;
;933:	}
;934:	// if the bot decided to do something on it's own and has a last ordered goal
;935:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
;936:		bs->ltgtype = 0;
;937:	}
;938:	//if already a CTF or team goal
;939:	if (bs->ltgtype == LTG_TEAMHELP ||
;940:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;941:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;942:			bs->ltgtype == LTG_GETFLAG ||
;943:			bs->ltgtype == LTG_RUSHBASE ||
;944:			bs->ltgtype == LTG_RETURNFLAG ||
;945:			bs->ltgtype == LTG_CAMPORDER ||
;946:			bs->ltgtype == LTG_PATROL ||
;947:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;948:			bs->ltgtype == LTG_GETITEM ||
;949:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;950:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;951:		return;
;952:	}
;953:	//
;954:	if (BotSetLastOrderedTask(bs))
;955:		return;
;956:	//
;957:	if (bs->owndecision_time > FloatTime())
;958:		return;;
;959:	//if the bot is roaming
;960:	if (bs->ctfroam_time > FloatTime())
;961:		return;
;962:	//if the bot has anough aggression to decide what to do
;963:	if (BotAggression(bs) < 50)
;964:		return;
;965:	//set the time to send a message to the team mates
;966:	bs->teammessage_time = FloatTime() + 2 * random();
;967:	//
;968:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;969:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;970:			l1 = 0.7f;
;971:		}
;972:		else {
;973:			l1 = 0.2f;
;974:		}
;975:		l2 = 0.9f;
;976:	}
;977:	else {
;978:		l1 = 0.4f;
;979:		l2 = 0.7f;
;980:	}
;981:	//get the flag or defend the base
;982:	rnd = random();
;983:	if (rnd < l1 && ctf_neutralflag.areanum) {
;984:		bs->decisionmaker = bs->client;
;985:		bs->ordered = qfalse;
;986:		bs->ltgtype = LTG_GETFLAG;
;987:		//set the time the bot will stop getting the flag
;988:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;989:		BotSetTeamStatus(bs);
;990:	}
;991:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;992:		bs->decisionmaker = bs->client;
;993:		bs->ordered = qfalse;
;994:		//
;995:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;996:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;997:		//set the ltg type
;998:		bs->ltgtype = LTG_DEFENDKEYAREA;
;999:		//set the time the bot stops defending the base
;1000:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1001:		bs->defendaway_time = 0;
;1002:		BotSetTeamStatus(bs);
;1003:	}
;1004:	else {
;1005:		bs->ltgtype = 0;
;1006:		//set the time the bot will stop roaming
;1007:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1008:		BotSetTeamStatus(bs);
;1009:	}
;1010:	bs->owndecision_time = FloatTime() + 5;
;1011:#ifdef DEBUG
;1012:	BotPrintTeamGoal(bs);
;1013:#endif //DEBUG
;1014:}
;1015:
;1016:/*
;1017:==================
;1018:Bot1FCTFRetreatGoals
;1019:==================
;1020:*/
;1021:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
;1022:	//when carrying a flag in ctf the bot should rush to the enemy base
;1023:	if (Bot1FCTFCarryingFlag(bs)) {
;1024:		//if not already rushing to the base
;1025:		if (bs->ltgtype != LTG_RUSHBASE) {
;1026:			BotRefuseOrder(bs);
;1027:			bs->ltgtype = LTG_RUSHBASE;
;1028:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1029:			bs->rushbaseaway_time = 0;
;1030:			bs->decisionmaker = bs->client;
;1031:			bs->ordered = qfalse;
;1032:			//get an alternative route goal towards the enemy base
;1033:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1034:			BotSetTeamStatus(bs);
;1035:		}
;1036:	}
;1037:}
;1038:
;1039:/*
;1040:==================
;1041:BotObeliskSeekGoals
;1042:==================
;1043:*/
;1044:void BotObeliskSeekGoals(bot_state_t *bs) {
;1045:	float rnd, l1, l2;
;1046:
;1047:	// don't just do something wait for the bot team leader to give orders
;1048:	if (BotTeamLeader(bs)) {
;1049:		return;
;1050:	}
;1051:	// if the bot is ordered to do something
;1052:	if ( bs->lastgoal_ltgtype ) {
;1053:		bs->teamgoal_time += 60;
;1054:	}
;1055:	//if already a team goal
;1056:	if (bs->ltgtype == LTG_TEAMHELP ||
;1057:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1058:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1059:			bs->ltgtype == LTG_GETFLAG ||
;1060:			bs->ltgtype == LTG_RUSHBASE ||
;1061:			bs->ltgtype == LTG_RETURNFLAG ||
;1062:			bs->ltgtype == LTG_CAMPORDER ||
;1063:			bs->ltgtype == LTG_PATROL ||
;1064:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1065:			bs->ltgtype == LTG_GETITEM ||
;1066:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1067:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1068:		return;
;1069:	}
;1070:	//
;1071:	if (BotSetLastOrderedTask(bs))
;1072:		return;
;1073:	//if the bot is roaming
;1074:	if (bs->ctfroam_time > FloatTime())
;1075:		return;
;1076:	//if the bot has anough aggression to decide what to do
;1077:	if (BotAggression(bs) < 50)
;1078:		return;
;1079:	//set the time to send a message to the team mates
;1080:	bs->teammessage_time = FloatTime() + 2 * random();
;1081:	//
;1082:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1083:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1084:			l1 = 0.7f;
;1085:		}
;1086:		else {
;1087:			l1 = 0.2f;
;1088:		}
;1089:		l2 = 0.9f;
;1090:	}
;1091:	else {
;1092:		l1 = 0.4f;
;1093:		l2 = 0.7f;
;1094:	}
;1095:	//get the flag or defend the base
;1096:	rnd = random();
;1097:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1098:		bs->decisionmaker = bs->client;
;1099:		bs->ordered = qfalse;
;1100:		//
;1101:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1102:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1103:		//set the ltg type
;1104:		bs->ltgtype = LTG_ATTACKENEMYBASE;
;1105:		//set the time the bot will stop attacking the enemy base
;1106:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;1107:		//get an alternate route goal towards the enemy base
;1108:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1109:		BotSetTeamStatus(bs);
;1110:	}
;1111:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1112:		bs->decisionmaker = bs->client;
;1113:		bs->ordered = qfalse;
;1114:		//
;1115:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1116:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1117:		//set the ltg type
;1118:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1119:		//set the time the bot stops defending the base
;1120:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1121:		bs->defendaway_time = 0;
;1122:		BotSetTeamStatus(bs);
;1123:	}
;1124:	else {
;1125:		bs->ltgtype = 0;
;1126:		//set the time the bot will stop roaming
;1127:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1128:		BotSetTeamStatus(bs);
;1129:	}
;1130:}
;1131:
;1132:/*
;1133:==================
;1134:BotGoHarvest
;1135:==================
;1136:*/
;1137:void BotGoHarvest(bot_state_t *bs) {
;1138:	//
;1139:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1140:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1141:	//set the ltg type
;1142:	bs->ltgtype = LTG_HARVEST;
;1143:	//set the time the bot will stop harvesting
;1144:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
;1145:	bs->harvestaway_time = 0;
;1146:	BotSetTeamStatus(bs);
;1147:}
;1148:
;1149:/*
;1150:==================
;1151:BotObeliskRetreatGoals
;1152:==================
;1153:*/
;1154:void BotObeliskRetreatGoals(bot_state_t *bs) {
;1155:	//nothing special
;1156:}
;1157:
;1158:/*
;1159:==================
;1160:BotHarvesterSeekGoals
;1161:==================
;1162:*/
;1163:void BotHarvesterSeekGoals(bot_state_t *bs) {
;1164:	aas_entityinfo_t entinfo;
;1165:	float rnd, l1, l2;
;1166:	int c;
;1167:
;1168:	//when carrying cubes in harvester the bot should rush to the base
;1169:	if (BotHarvesterCarryingCubes(bs)) {
;1170:		//if not already rushing to the base
;1171:		if (bs->ltgtype != LTG_RUSHBASE) {
;1172:			BotRefuseOrder(bs);
;1173:			bs->ltgtype = LTG_RUSHBASE;
;1174:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1175:			bs->rushbaseaway_time = 0;
;1176:			bs->decisionmaker = bs->client;
;1177:			bs->ordered = qfalse;
;1178:			//get an alternative route goal towards the enemy base
;1179:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1180:			//
;1181:			BotSetTeamStatus(bs);
;1182:		}
;1183:		return;
;1184:	}
;1185:	// don't just do something wait for the bot team leader to give orders
;1186:	if (BotTeamLeader(bs)) {
;1187:		return;
;1188:	}
;1189:	// if the bot decided to follow someone
;1190:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;1191:		// if the team mate being accompanied no longer carries the flag
;1192:		BotEntityInfo(bs->teammate, &entinfo);
;1193:		if (!EntityCarriesCubes(&entinfo)) {
;1194:			bs->ltgtype = 0;
;1195:		}
;1196:	}
;1197:	// if the bot is ordered to do something
;1198:	if ( bs->lastgoal_ltgtype ) {
;1199:		bs->teamgoal_time += 60;
;1200:	}
;1201:	//if not yet doing something
;1202:	if (bs->ltgtype == LTG_TEAMHELP ||
;1203:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1204:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1205:			bs->ltgtype == LTG_GETFLAG ||
;1206:			bs->ltgtype == LTG_CAMPORDER ||
;1207:			bs->ltgtype == LTG_PATROL ||
;1208:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1209:			bs->ltgtype == LTG_HARVEST ||
;1210:			bs->ltgtype == LTG_GETITEM ||
;1211:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1212:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1213:		return;
;1214:	}
;1215:	//
;1216:	if (BotSetLastOrderedTask(bs))
;1217:		return;
;1218:	//if the bot is roaming
;1219:	if (bs->ctfroam_time > FloatTime())
;1220:		return;
;1221:	//if the bot has anough aggression to decide what to do
;1222:	if (BotAggression(bs) < 50)
;1223:		return;
;1224:	//set the time to send a message to the team mates
;1225:	bs->teammessage_time = FloatTime() + 2 * random();
;1226:	//
;1227:	c = BotEnemyCubeCarrierVisible(bs);
;1228:	if (c >= 0) {
;1229:		//FIXME: attack enemy cube carrier
;1230:	}
;1231:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;1232:		//if there is a visible team mate carrying cubes
;1233:		c = BotTeamCubeCarrierVisible(bs);
;1234:		if (c >= 0) {
;1235:			//follow the team mate carrying cubes
;1236:			bs->decisionmaker = bs->client;
;1237:			bs->ordered = qfalse;
;1238:			//the team mate
;1239:			bs->teammate = c;
;1240:			//last time the team mate was visible
;1241:			bs->teammatevisible_time = FloatTime();
;1242:			//no message
;1243:			bs->teammessage_time = 0;
;1244:			//no arrive message
;1245:			bs->arrive_time = 1;
;1246:			//
;1247:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;1248:			//get the team goal time
;1249:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;1250:			bs->ltgtype = LTG_TEAMACCOMPANY;
;1251:			bs->formation_dist = 3.5 * 32;		//3.5 meter
;1252:			BotSetTeamStatus(bs);
;1253:			return;
;1254:		}
;1255:	}
;1256:	//
;1257:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1258:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1259:			l1 = 0.7f;
;1260:		}
;1261:		else {
;1262:			l1 = 0.2f;
;1263:		}
;1264:		l2 = 0.9f;
;1265:	}
;1266:	else {
;1267:		l1 = 0.4f;
;1268:		l2 = 0.7f;
;1269:	}
;1270:	//
;1271:	rnd = random();
;1272:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1273:		bs->decisionmaker = bs->client;
;1274:		bs->ordered = qfalse;
;1275:		BotGoHarvest(bs);
;1276:	}
;1277:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1278:		bs->decisionmaker = bs->client;
;1279:		bs->ordered = qfalse;
;1280:		//
;1281:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1282:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1283:		//set the ltg type
;1284:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1285:		//set the time the bot stops defending the base
;1286:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1287:		bs->defendaway_time = 0;
;1288:		BotSetTeamStatus(bs);
;1289:	}
;1290:	else {
;1291:		bs->ltgtype = 0;
;1292:		//set the time the bot will stop roaming
;1293:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1294:		BotSetTeamStatus(bs);
;1295:	}
;1296:}
;1297:
;1298:/*
;1299:==================
;1300:BotHarvesterRetreatGoals
;1301:==================
;1302:*/
;1303:void BotHarvesterRetreatGoals(bot_state_t *bs) {
;1304:	//when carrying cubes in harvester the bot should rush to the base
;1305:	if (BotHarvesterCarryingCubes(bs)) {
;1306:		//if not already rushing to the base
;1307:		if (bs->ltgtype != LTG_RUSHBASE) {
;1308:			BotRefuseOrder(bs);
;1309:			bs->ltgtype = LTG_RUSHBASE;
;1310:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1311:			bs->rushbaseaway_time = 0;
;1312:			bs->decisionmaker = bs->client;
;1313:			bs->ordered = qfalse;
;1314:			BotSetTeamStatus(bs);
;1315:		}
;1316:		return;
;1317:	}
;1318:}
;1319:#endif
;1320:
;1321:/*
;1322:==================
;1323:BotTeamGoals
;1324:==================
;1325:*/
;1326:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1328
;1327:
;1328:	if ( retreat ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $251
line 1329
;1329:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $252
line 1330
;1330:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1331
;1331:		}
line 1343
;1332:#ifdef MISSIONPACK
;1333:		else if (gametype == GT_1FCTF) {
;1334:			Bot1FCTFRetreatGoals(bs);
;1335:		}
;1336:		else if (gametype == GT_OBELISK) {
;1337:			BotObeliskRetreatGoals(bs);
;1338:		}
;1339:		else if (gametype == GT_HARVESTER) {
;1340:			BotHarvesterRetreatGoals(bs);
;1341:		}
;1342:#endif
;1343:	}
ADDRGP4 $252
JUMPV
LABELV $251
line 1344
;1344:	else {
line 1345
;1345:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $255
line 1347
;1346:			//decide what to do in CTF mode
;1347:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1348
;1348:		}
LABELV $255
line 1360
;1349:#ifdef MISSIONPACK
;1350:		else if (gametype == GT_1FCTF) {
;1351:			Bot1FCTFSeekGoals(bs);
;1352:		}
;1353:		else if (gametype == GT_OBELISK) {
;1354:			BotObeliskSeekGoals(bs);
;1355:		}
;1356:		else if (gametype == GT_HARVESTER) {
;1357:			BotHarvesterSeekGoals(bs);
;1358:		}
;1359:#endif
;1360:	}
LABELV $252
line 1363
;1361:	// reset the order time which is used to see if
;1362:	// we decided to refuse an order
;1363:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 1364
;1364:}
LABELV $250
endproc BotTeamGoals 0 4
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1371
;1365:
;1366:/*
;1367:==================
;1368:BotPointAreaNum
;1369:==================
;1370:*/
;1371:int BotPointAreaNum(vec3_t origin) {
line 1375
;1372:	int areanum, numareas, areas[10];
;1373:	vec3_t end;
;1374:
;1375:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1376
;1376:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $258
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $257
JUMPV
LABELV $258
line 1377
;1377:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1378
;1378:	end[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1379
;1379:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1380
;1380:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $261
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $257
JUMPV
LABELV $261
line 1381
;1381:	return 0;
CNSTI4 0
RETI4
LABELV $257
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1032 12
line 1389
;1382:}
;1383:
;1384:/*
;1385:==================
;1386:ClientName
;1387:==================
;1388:*/
;1389:char *ClientName(int client, char *name, int size) {
line 1392
;1390:	char buf[MAX_INFO_STRING];
;1391:
;1392:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $266
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $264
LABELV $266
line 1393
;1393:		BotAI_Print(PRT_ERROR, "ClientName: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $267
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1394
;1394:		return "[client out of range]";
ADDRGP4 $268
RETP4
ADDRGP4 $263
JUMPV
LABELV $264
line 1396
;1395:	}
;1396:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1397
;1397:	strncpy(name, Info_ValueForKey(buf, "n"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1398
;1398:	name[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1399
;1399:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1400
;1400:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $263
endproc ClientName 1032 12
export ClientSkin
proc ClientSkin 1032 12
line 1408
;1401:}
;1402:
;1403:/*
;1404:==================
;1405:ClientSkin
;1406:==================
;1407:*/
;1408:char *ClientSkin(int client, char *skin, int size) {
line 1411
;1409:	char buf[MAX_INFO_STRING];
;1410:
;1411:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $273
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $271
LABELV $273
line 1412
;1412:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $274
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1413
;1413:		return "[client out of range]";
ADDRGP4 $268
RETP4
ADDRGP4 $270
JUMPV
LABELV $271
line 1415
;1414:	}
;1415:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1416
;1416:	strncpy(skin, Info_ValueForKey(buf, "model"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $275
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1417
;1417:	skin[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1418
;1418:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $270
endproc ClientSkin 1032 12
bss
align 4
LABELV $277
skip 4
export ClientFromName
code
proc ClientFromName 1040 12
line 1426
;1419:}
;1420:
;1421:/*
;1422:==================
;1423:ClientFromName
;1424:==================
;1425:*/
;1426:int ClientFromName(char *name) {
line 1431
;1427:	int i;
;1428:	char buf[MAX_INFO_STRING];
;1429:	static int maxclients;
;1430:
;1431:	if (!maxclients)
ADDRGP4 $277
INDIRI4
CNSTI4 0
NEI4 $278
line 1432
;1432:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $280
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $277
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $278
line 1433
;1433:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $284
JUMPV
LABELV $281
line 1434
;1434:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1435
;1435:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1436
;1436:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $285
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $276
JUMPV
LABELV $285
line 1437
;1437:	}
LABELV $282
line 1433
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $284
ADDRLP4 0
INDIRI4
ADDRGP4 $277
INDIRI4
GEI4 $287
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $281
LABELV $287
line 1438
;1438:	return -1;
CNSTI4 -1
RETI4
LABELV $276
endproc ClientFromName 1040 12
bss
align 4
LABELV $289
skip 4
export ClientOnSameTeamFromName
code
proc ClientOnSameTeamFromName 1044 12
line 1446
;1439:}
;1440:
;1441:/*
;1442:==================
;1443:ClientOnSameTeamFromName
;1444:==================
;1445:*/
;1446:int ClientOnSameTeamFromName(bot_state_t *bs, char *name) {
line 1451
;1447:	int i;
;1448:	char buf[MAX_INFO_STRING];
;1449:	static int maxclients;
;1450:
;1451:	if (!maxclients)
ADDRGP4 $289
INDIRI4
CNSTI4 0
NEI4 $290
line 1452
;1452:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $280
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $289
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $290
line 1453
;1453:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $295
JUMPV
LABELV $292
line 1454
;1454:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $296
line 1455
;1455:			continue;
ADDRGP4 $293
JUMPV
LABELV $296
line 1456
;1456:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1457
;1457:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1458
;1458:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $298
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $288
JUMPV
LABELV $298
line 1459
;1459:	}
LABELV $293
line 1453
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $295
ADDRLP4 0
INDIRI4
ADDRGP4 $289
INDIRI4
GEI4 $300
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $292
LABELV $300
line 1460
;1460:	return -1;
CNSTI4 -1
RETI4
LABELV $288
endproc ClientOnSameTeamFromName 1044 12
export stristr
proc stristr 12 4
line 1468
;1461:}
;1462:
;1463:/*
;1464:==================
;1465:stristr
;1466:==================
;1467:*/
;1468:char *stristr(char *str, char *charset) {
ADDRGP4 $303
JUMPV
LABELV $302
line 1471
;1469:	int i;
;1470:
;1471:	while(*str) {
line 1472
;1472:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $308
JUMPV
LABELV $305
line 1473
;1473:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $309
ADDRGP4 $307
JUMPV
LABELV $309
line 1474
;1474:		}
LABELV $306
line 1472
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $308
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $311
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
NEI4 $305
LABELV $311
LABELV $307
line 1475
;1475:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $312
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $301
JUMPV
LABELV $312
line 1476
;1476:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1477
;1477:	}
LABELV $303
line 1471
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $302
line 1478
;1478:	return NULL;
CNSTP4 0
RETP4
LABELV $301
endproc stristr 12 4
export EasyClientName
proc EasyClientName 204 12
line 1486
;1479:}
;1480:
;1481:/*
;1482:==================
;1483:EasyClientName
;1484:==================
;1485:*/
;1486:char *EasyClientName(int client, char *buf, int size) {
line 1491
;1487:	int i;
;1488:	char *str1, *str2, *ptr, c;
;1489:	char name[128];
;1490:
;1491:	strcpy(name, ClientName(client, name, sizeof(name)));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRLP4 5
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1492
;1492:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $318
JUMPV
LABELV $315
ADDRLP4 152
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $316
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $318
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $315
line 1494
;1493:	//remove all spaces
;1494:	for (ptr = strstr(name, " "); ptr; ptr = strstr(name, " ")) {
ADDRLP4 5
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 156
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $322
JUMPV
LABELV $319
line 1495
;1495:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 168
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ARGP4
ADDRLP4 160
INDIRI4
ADDRLP4 168
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1496
;1496:	}
LABELV $320
line 1494
ADDRLP4 5
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 160
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 160
INDIRP4
ASGNP4
LABELV $322
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $319
line 1498
;1497:	//check for [x] and ]x[ clan names
;1498:	str1 = strstr(name, "[");
ADDRLP4 5
ARGP4
ADDRGP4 $324
ARGP4
ADDRLP4 164
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 164
INDIRP4
ASGNP4
line 1499
;1499:	str2 = strstr(name, "]");
ADDRLP4 5
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 168
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 168
INDIRP4
ASGNP4
line 1500
;1500:	if (str1 && str2) {
ADDRLP4 172
CNSTU4 0
ASGNU4
ADDRLP4 140
INDIRP4
CVPU4 4
ADDRLP4 172
INDIRU4
EQU4 $326
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 172
INDIRU4
EQU4 $326
line 1501
;1501:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $328
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 180
CNSTI4 1
ASGNI4
ADDRLP4 144
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
ARGP4
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $329
JUMPV
LABELV $328
line 1502
;1502:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 188
CNSTI4 1
ASGNI4
ADDRLP4 140
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ARGP4
ADDRLP4 184
INDIRI4
ADDRLP4 188
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $329
line 1503
;1503:	}
LABELV $326
line 1505
;1504:	//remove Mr prefix
;1505:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 176
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 109
EQI4 $334
ADDRLP4 176
INDIRI4
CNSTI4 77
NEI4 $330
LABELV $334
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $335
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $330
LABELV $335
line 1506
;1506:			(name[1] == 'r' || name[1] == 'R')) {
line 1507
;1507:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 180
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1508
;1508:	}
LABELV $330
line 1510
;1509:	//only allow lower case alphabet characters
;1510:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $339
JUMPV
LABELV $338
line 1511
;1511:	while(*ptr) {
line 1512
;1512:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1513
;1513:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 97
LTI4 $344
ADDRLP4 180
INDIRI4
CNSTI4 122
LEI4 $345
LABELV $344
ADDRLP4 184
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 48
LTI4 $346
ADDRLP4 184
INDIRI4
CNSTI4 57
LEI4 $345
LABELV $346
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $341
LABELV $345
line 1514
;1514:				(c >= '0' && c <= '9') || c == '_') {
line 1515
;1515:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1516
;1516:		}
ADDRGP4 $342
JUMPV
LABELV $341
line 1517
;1517:		else if (c >= 'A' && c <= 'Z') {
ADDRLP4 188
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 65
LTI4 $347
ADDRLP4 188
INDIRI4
CNSTI4 90
GTI4 $347
line 1518
;1518:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1519
;1519:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1520
;1520:		}
ADDRGP4 $348
JUMPV
LABELV $347
line 1521
;1521:		else {
line 1522
;1522:			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 200
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
ARGP4
ADDRLP4 192
INDIRI4
ADDRLP4 200
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1523
;1523:		}
LABELV $348
LABELV $342
line 1524
;1524:	}
LABELV $339
line 1511
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $338
line 1525
;1525:	strncpy(buf, name, size-1);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1526
;1526:	buf[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1527
;1527:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $314
endproc EasyClientName 204 12
export BotSynonymContext
proc BotSynonymContext 8 4
line 1535
;1528:}
;1529:
;1530:/*
;1531:==================
;1532:BotSynonymContext
;1533:==================
;1534:*/
;1535:int BotSynonymContext(bot_state_t *bs) {
line 1538
;1536:	int context;
;1537:
;1538:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1540
;1539:	//
;1540:	if (gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $350
line 1544
;1541:#ifdef MISSIONPACK
;1542:		|| gametype == GT_1FCTF
;1543:#endif
;1544:		) {
line 1545
;1545:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $352
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $353
JUMPV
LABELV $352
line 1546
;1546:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $353
line 1547
;1547:	}
LABELV $350
line 1558
;1548:#ifdef MISSIONPACK
;1549:	else if (gametype == GT_OBELISK) {
;1550:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
;1551:		else context |= CONTEXT_OBELISKBLUETEAM;
;1552:	}
;1553:	else if (gametype == GT_HARVESTER) {
;1554:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
;1555:		else context |= CONTEXT_HARVESTERBLUETEAM;
;1556:	}
;1557:#endif
;1558:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $349
endproc BotSynonymContext 8 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1566
;1559:}
;1560:
;1561:/*
;1562:==================
;1563:BotChooseWeapon
;1564:==================
;1565:*/
;1566:void BotChooseWeapon(bot_state_t *bs) {
line 1569
;1567:	int newweaponnum;
;1568:
;1569:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $357
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $355
LABELV $357
line 1570
;1570:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1571
;1571:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1572
;1572:	}
ADDRGP4 $356
JUMPV
LABELV $355
line 1573
;1573:	else {
line 1574
;1574:		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1575
;1575:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $358
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $358
line 1576
;1576:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1578
;1577:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1578:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1579
;1579:	}
LABELV $356
line 1580
;1580:}
LABELV $354
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 88 12
line 1587
;1581:
;1582:/*
;1583:==================
;1584:BotSetupForMovement
;1585:==================
;1586:*/
;1587:void BotSetupForMovement(bot_state_t *bs) {
line 1590
;1588:	bot_initmove_t initmove;
;1589:
;1590:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1591
;1591:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1592
;1592:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1593
;1593:	VectorClear(initmove.viewoffset);
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24
ADDRLP4 68
INDIRF4
ASGNF4
line 1594
;1594:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1595
;1595:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1596
;1596:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1597
;1597:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ASGNF4
line 1599
;1598:	//set the onground flag
;1599:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $372
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $372
line 1601
;1600:	//set the teleported flag
;1601:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $375
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $375
line 1602
;1602:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1603
;1603:	}
LABELV $375
line 1605
;1604:	//set the waterjump flag
;1605:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $378
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $378
line 1606
;1606:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1607
;1607:	}
LABELV $378
line 1609
;1608:	//set presence type
;1609:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $381
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $382
JUMPV
LABELV $381
line 1610
;1610:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $382
line 1612
;1611:	//
;1612:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $385
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $385
line 1614
;1613:	//
;1614:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRB
ASGNB 12
line 1616
;1615:	//
;1616:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1617
;1617:}
LABELV $360
endproc BotSetupForMovement 88 12
export BotCheckItemPickup
proc BotCheckItemPickup 0 0
line 1624
;1618:
;1619:/*
;1620:==================
;1621:BotCheckItemPickup
;1622:==================
;1623:*/
;1624:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1711
;1625:#ifdef MISSIONPACK
;1626:	int offence, leader;
;1627:
;1628:	if (gametype <= GT_TEAM)
;1629:		return;
;1630:
;1631:	offence = -1;
;1632:	// go into offence if picked up the kamikaze or invulnerability
;1633:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
;1634:		offence = qtrue;
;1635:	}
;1636:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
;1637:		offence = qtrue;
;1638:	}
;1639:	// if not already wearing the kamikaze or invulnerability
;1640:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
;1641:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
;1642:			offence = qtrue;
;1643:		}
;1644:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
;1645:			offence = qtrue;
;1646:		}
;1647:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
;1648:			offence = qfalse;
;1649:		}
;1650:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
;1651:			offence = qfalse;
;1652:		}
;1653:	}
;1654:
;1655:	if (offence >= 0) {
;1656:		leader = ClientFromName(bs->teamleader);
;1657:		if (offence) {
;1658:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
;1659:				// if we have a bot team leader
;1660:				if (BotTeamLeader(bs)) {
;1661:					// tell the leader we want to be on offence
;1662:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1663:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1664:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1665:				}
;1666:				else if (g_spSkill.integer <= 3) {
;1667:					if ( bs->ltgtype != LTG_GETFLAG &&
;1668:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;1669:						 bs->ltgtype != LTG_HARVEST ) {
;1670:						//
;1671:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1672:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1673:							// tell the leader we want to be on offence
;1674:							BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1675:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1676:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1677:						}
;1678:					}
;1679:					bs->teamtaskpreference |= TEAMTP_ATTACKER;
;1680:				}
;1681:			}
;1682:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
;1683:		}
;1684:		else {
;1685:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
;1686:				// if we have a bot team leader
;1687:				if (BotTeamLeader(bs)) {
;1688:					// tell the leader we want to be on defense
;1689:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1690:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1691:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1692:				}
;1693:				else if (g_spSkill.integer <= 3) {
;1694:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
;1695:						//
;1696:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1697:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1698:							// tell the leader we want to be on defense
;1699:							BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1700:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1701:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1702:						}
;1703:					}
;1704:				}
;1705:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
;1706:			}
;1707:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
;1708:		}
;1709:	}
;1710:#endif
;1711:}
LABELV $389
endproc BotCheckItemPickup 0 0
export BotUpdateInventory
proc BotUpdateInventory 1224 12
line 1718
;1712:
;1713:/*
;1714:==================
;1715:BotUpdateInventory
;1716:==================
;1717:*/
;1718:void BotUpdateInventory(bot_state_t *bs) {
line 1721
;1719:	int oldinventory[MAX_ITEMS];
;1720:
;1721:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1723
;1722:	//armor
;1723:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 1725
;1724:	//weapons
;1725:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $392
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $393
JUMPV
LABELV $392
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $393
ADDRLP4 1032
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1726
;1726:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $395
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $396
JUMPV
LABELV $395
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $396
ADDRLP4 1040
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1727
;1727:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $398
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $399
JUMPV
LABELV $398
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $399
ADDRLP4 1048
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1728
;1728:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $401
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $402
JUMPV
LABELV $401
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $402
ADDRLP4 1056
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1729
;1729:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $404
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $405
JUMPV
LABELV $404
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $405
ADDRLP4 1064
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1730
;1730:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $407
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $408
JUMPV
LABELV $407
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $408
ADDRLP4 1072
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1731
;1731:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $410
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $411
JUMPV
LABELV $410
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $411
ADDRLP4 1080
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1732
;1732:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $413
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $414
JUMPV
LABELV $413
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $414
ADDRLP4 1088
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1733
;1733:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $416
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $417
JUMPV
LABELV $416
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $417
ADDRLP4 1096
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1734
;1734:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $419
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $420
JUMPV
LABELV $419
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $420
ADDRLP4 1104
INDIRP4
CNSTI4 5008
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1741
;1735:#ifdef MISSIONPACK
;1736:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;;
;1737:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;;
;1738:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;;
;1739:#endif
;1740:	//ammo
;1741:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1108
INDIRP4
CNSTI4 5024
ADDP4
ADDRLP4 1108
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1742
;1742:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 5028
ADDP4
ADDRLP4 1112
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1743
;1743:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1116
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1744
;1744:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1120
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1745
;1745:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1124
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1746
;1746:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1128
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1747
;1747:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1748
;1748:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1755
;1749:#ifdef MISSIONPACK
;1750:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
;1751:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
;1752:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
;1753:#endif
;1754:	//powerups
;1755:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5068
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1756
;1756:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $422
ADDRLP4 1144
CNSTI4 1
ASGNI4
ADDRGP4 $423
JUMPV
LABELV $422
ADDRLP4 1144
CNSTI4 0
ASGNI4
LABELV $423
ADDRLP4 1148
INDIRP4
CNSTI4 5072
ADDP4
ADDRLP4 1144
INDIRI4
ASGNI4
line 1757
;1757:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $425
ADDRLP4 1152
CNSTI4 1
ASGNI4
ADDRGP4 $426
JUMPV
LABELV $425
ADDRLP4 1152
CNSTI4 0
ASGNI4
LABELV $426
ADDRLP4 1156
INDIRP4
CNSTI4 5076
ADDP4
ADDRLP4 1152
INDIRI4
ASGNI4
line 1763
;1758:#ifdef MISSIONPACK
;1759:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
;1760:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
;1761:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
;1762:#endif
;1763:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $428
ADDRLP4 1160
CNSTI4 1
ASGNI4
ADDRGP4 $429
JUMPV
LABELV $428
ADDRLP4 1160
CNSTI4 0
ASGNI4
LABELV $429
ADDRLP4 1164
INDIRP4
CNSTI4 5092
ADDP4
ADDRLP4 1160
INDIRI4
ASGNI4
line 1764
;1764:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $431
ADDRLP4 1168
CNSTI4 1
ASGNI4
ADDRGP4 $432
JUMPV
LABELV $431
ADDRLP4 1168
CNSTI4 0
ASGNI4
LABELV $432
ADDRLP4 1172
INDIRP4
CNSTI4 5096
ADDP4
ADDRLP4 1168
INDIRI4
ASGNI4
line 1765
;1765:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $434
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $435
JUMPV
LABELV $434
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $435
ADDRLP4 1180
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1176
INDIRI4
ASGNI4
line 1766
;1766:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1188
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $437
ADDRLP4 1184
CNSTI4 1
ASGNI4
ADDRGP4 $438
JUMPV
LABELV $437
ADDRLP4 1184
CNSTI4 0
ASGNI4
LABELV $438
ADDRLP4 1188
INDIRP4
CNSTI4 5104
ADDP4
ADDRLP4 1184
INDIRI4
ASGNI4
line 1767
;1767:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1196
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $440
ADDRLP4 1192
CNSTI4 1
ASGNI4
ADDRGP4 $441
JUMPV
LABELV $440
ADDRLP4 1192
CNSTI4 0
ASGNI4
LABELV $441
ADDRLP4 1196
INDIRP4
CNSTI4 5108
ADDP4
ADDRLP4 1192
INDIRI4
ASGNI4
line 1768
;1768:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1204
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $443
ADDRLP4 1200
CNSTI4 1
ASGNI4
ADDRGP4 $444
JUMPV
LABELV $443
ADDRLP4 1200
CNSTI4 0
ASGNI4
LABELV $444
ADDRLP4 1204
INDIRP4
CNSTI4 5112
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
line 1775
;1769:#ifdef MISSIONPACK
;1770:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
;1771:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
;1772:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
;1773:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
;1774:#endif
;1775:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $446
ADDRLP4 1208
CNSTI4 1
ASGNI4
ADDRGP4 $447
JUMPV
LABELV $446
ADDRLP4 1208
CNSTI4 0
ASGNI4
LABELV $447
ADDRLP4 1212
INDIRP4
CNSTI4 5132
ADDP4
ADDRLP4 1208
INDIRI4
ASGNI4
line 1776
;1776:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1220
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $449
ADDRLP4 1216
CNSTI4 1
ASGNI4
ADDRGP4 $450
JUMPV
LABELV $449
ADDRLP4 1216
CNSTI4 0
ASGNI4
LABELV $450
ADDRLP4 1220
INDIRP4
CNSTI4 5136
ADDP4
ADDRLP4 1216
INDIRI4
ASGNI4
line 1788
;1777:#ifdef MISSIONPACK
;1778:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
;1779:	if (BotTeam(bs) == TEAM_RED) {
;1780:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
;1781:		bs->inventory[INVENTORY_BLUECUBE] = 0;
;1782:	}
;1783:	else {
;1784:		bs->inventory[INVENTORY_REDCUBE] = 0;
;1785:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
;1786:	}
;1787:#endif
;1788:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1789
;1789:}
LABELV $390
endproc BotUpdateInventory 1224 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1796
;1790:
;1791:/*
;1792:==================
;1793:BotUpdateBattleInventory
;1794:==================
;1795:*/
;1796:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1800
;1797:	vec3_t dir;
;1798:	aas_entityinfo_t entinfo;
;1799:
;1800:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1801
;1801:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1802
;1802:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1803
;1803:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1804
;1804:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5752
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1806
;1805:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1806:}
LABELV $451
endproc BotUpdateBattleInventory 160 8
export BotBattleUseItems
proc BotBattleUseItems 4 4
line 2033
;1807:
;1808:#ifdef MISSIONPACK
;1809:/*
;1810:==================
;1811:BotUseKamikaze
;1812:==================
;1813:*/
;1814:#define KAMIKAZE_DIST		1024
;1815:
;1816:void BotUseKamikaze(bot_state_t *bs) {
;1817:	int c, teammates, enemies;
;1818:	aas_entityinfo_t entinfo;
;1819:	vec3_t dir, target;
;1820:	bot_goal_t *goal;
;1821:	bsp_trace_t trace;
;1822:
;1823:	//if the bot has no kamikaze
;1824:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
;1825:		return;
;1826:	if (bs->kamikaze_time > FloatTime())
;1827:		return;
;1828:	bs->kamikaze_time = FloatTime() + 0.2;
;1829:	if (gametype == GT_CTF) {
;1830:		//never use kamikaze if the team flag carrier is visible
;1831:		if (BotCTFCarryingFlag(bs))
;1832:			return;
;1833:		c = BotTeamFlagCarrierVisible(bs);
;1834:		if (c >= 0) {
;1835:			BotEntityInfo(c, &entinfo);
;1836:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1837:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1838:				return;
;1839:		}
;1840:		c = BotEnemyFlagCarrierVisible(bs);
;1841:		if (c >= 0) {
;1842:			BotEntityInfo(c, &entinfo);
;1843:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1844:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1845:				trap_EA_Use(bs->client);
;1846:				return;
;1847:			}
;1848:		}
;1849:	}
;1850:	else if (gametype == GT_1FCTF) {
;1851:		//never use kamikaze if the team flag carrier is visible
;1852:		if (Bot1FCTFCarryingFlag(bs))
;1853:			return;
;1854:		c = BotTeamFlagCarrierVisible(bs);
;1855:		if (c >= 0) {
;1856:			BotEntityInfo(c, &entinfo);
;1857:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1858:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1859:				return;
;1860:		}
;1861:		c = BotEnemyFlagCarrierVisible(bs);
;1862:		if (c >= 0) {
;1863:			BotEntityInfo(c, &entinfo);
;1864:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1865:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1866:				trap_EA_Use(bs->client);
;1867:				return;
;1868:			}
;1869:		}
;1870:	}
;1871:	else if (gametype == GT_OBELISK) {
;1872:		switch(BotTeam(bs)) {
;1873:			case TEAM_RED: goal = &blueobelisk; break;
;1874:			default: goal = &redobelisk; break;
;1875:		}
;1876:		//if the obelisk is visible
;1877:		VectorCopy(goal->origin, target);
;1878:		target[2] += 1;
;1879:		VectorSubtract(bs->origin, target, dir);
;1880:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
;1881:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1882:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1883:				trap_EA_Use(bs->client);
;1884:				return;
;1885:			}
;1886:		}
;1887:	}
;1888:	else if (gametype == GT_HARVESTER) {
;1889:		//
;1890:		if (BotHarvesterCarryingCubes(bs))
;1891:			return;
;1892:		//never use kamikaze if a team mate carrying cubes is visible
;1893:		c = BotTeamCubeCarrierVisible(bs);
;1894:		if (c >= 0) {
;1895:			BotEntityInfo(c, &entinfo);
;1896:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1897:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1898:				return;
;1899:		}
;1900:		c = BotEnemyCubeCarrierVisible(bs);
;1901:		if (c >= 0) {
;1902:			BotEntityInfo(c, &entinfo);
;1903:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1904:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1905:				trap_EA_Use(bs->client);
;1906:				return;
;1907:			}
;1908:		}
;1909:	}
;1910:	//
;1911:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
;1912:	//
;1913:	if (enemies > 2 && enemies > teammates+1) {
;1914:		trap_EA_Use(bs->client);
;1915:		return;
;1916:	}
;1917:}
;1918:
;1919:/*
;1920:==================
;1921:BotUseInvulnerability
;1922:==================
;1923:*/
;1924:void BotUseInvulnerability(bot_state_t *bs) {
;1925:	int c;
;1926:	vec3_t dir, target;
;1927:	bot_goal_t *goal;
;1928:	bsp_trace_t trace;
;1929:
;1930:	//if the bot has no invulnerability
;1931:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
;1932:		return;
;1933:	if (bs->invulnerability_time > FloatTime())
;1934:		return;
;1935:	bs->invulnerability_time = FloatTime() + 0.2;
;1936:	if (gametype == GT_CTF) {
;1937:		//never use kamikaze if the team flag carrier is visible
;1938:		if (BotCTFCarryingFlag(bs))
;1939:			return;
;1940:		c = BotEnemyFlagCarrierVisible(bs);
;1941:		if (c >= 0)
;1942:			return;
;1943:		//if near enemy flag and the flag is visible
;1944:		switch(BotTeam(bs)) {
;1945:			case TEAM_RED: goal = &ctf_blueflag; break;
;1946:			default: goal = &ctf_redflag; break;
;1947:		}
;1948:		//if the obelisk is visible
;1949:		VectorCopy(goal->origin, target);
;1950:		target[2] += 1;
;1951:		VectorSubtract(bs->origin, target, dir);
;1952:		if (VectorLengthSquared(dir) < Square(200)) {
;1953:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1954:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1955:				trap_EA_Use(bs->client);
;1956:				return;
;1957:			}
;1958:		}
;1959:	}
;1960:	else if (gametype == GT_1FCTF) {
;1961:		//never use kamikaze if the team flag carrier is visible
;1962:		if (Bot1FCTFCarryingFlag(bs))
;1963:			return;
;1964:		c = BotEnemyFlagCarrierVisible(bs);
;1965:		if (c >= 0)
;1966:			return;
;1967:		//if near enemy flag and the flag is visible
;1968:		switch(BotTeam(bs)) {
;1969:			case TEAM_RED: goal = &ctf_blueflag; break;
;1970:			default: goal = &ctf_redflag; break;
;1971:		}
;1972:		//if the obelisk is visible
;1973:		VectorCopy(goal->origin, target);
;1974:		target[2] += 1;
;1975:		VectorSubtract(bs->origin, target, dir);
;1976:		if (VectorLengthSquared(dir) < Square(200)) {
;1977:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1978:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1979:				trap_EA_Use(bs->client);
;1980:				return;
;1981:			}
;1982:		}
;1983:	}
;1984:	else if (gametype == GT_OBELISK) {
;1985:		switch(BotTeam(bs)) {
;1986:			case TEAM_RED: goal = &blueobelisk; break;
;1987:			default: goal = &redobelisk; break;
;1988:		}
;1989:		//if the obelisk is visible
;1990:		VectorCopy(goal->origin, target);
;1991:		target[2] += 1;
;1992:		VectorSubtract(bs->origin, target, dir);
;1993:		if (VectorLengthSquared(dir) < Square(300)) {
;1994:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1995:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1996:				trap_EA_Use(bs->client);
;1997:				return;
;1998:			}
;1999:		}
;2000:	}
;2001:	else if (gametype == GT_HARVESTER) {
;2002:		//
;2003:		if (BotHarvesterCarryingCubes(bs))
;2004:			return;
;2005:		c = BotEnemyCubeCarrierVisible(bs);
;2006:		if (c >= 0)
;2007:			return;
;2008:		//if near enemy base and enemy base is visible
;2009:		switch(BotTeam(bs)) {
;2010:			case TEAM_RED: goal = &blueobelisk; break;
;2011:			default: goal = &redobelisk; break;
;2012:		}
;2013:		//if the obelisk is visible
;2014:		VectorCopy(goal->origin, target);
;2015:		target[2] += 1;
;2016:		VectorSubtract(bs->origin, target, dir);
;2017:		if (VectorLengthSquared(dir) < Square(200)) {
;2018:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2019:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2020:				trap_EA_Use(bs->client);
;2021:				return;
;2022:			}
;2023:		}
;2024:	}
;2025:}
;2026:#endif
;2027:
;2028:/*
;2029:==================
;2030:BotBattleUseItems
;2031:==================
;2032:*/
;2033:void BotBattleUseItems(bot_state_t *bs) {
line 2034
;2034:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $462
line 2035
;2035:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $464
line 2036
;2036:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $466
line 2041
;2037:#ifdef MISSIONPACK
;2038:				&& !Bot1FCTFCarryingFlag(bs)
;2039:				&& !BotHarvesterCarryingCubes(bs)
;2040:#endif
;2041:				) {
line 2042
;2042:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2043
;2043:			}
LABELV $466
line 2044
;2044:		}
LABELV $464
line 2045
;2045:	}
LABELV $462
line 2046
;2046:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $468
line 2047
;2047:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 0
LEI4 $470
line 2048
;2048:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2049
;2049:		}
LABELV $470
line 2050
;2050:	}
LABELV $468
line 2055
;2051:#ifdef MISSIONPACK
;2052:	BotUseKamikaze(bs);
;2053:	BotUseInvulnerability(bs);
;2054:#endif
;2055:}
LABELV $461
endproc BotBattleUseItems 4 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 2062
;2056:
;2057:/*
;2058:==================
;2059:BotSetTeleportTime
;2060:==================
;2061:*/
;2062:void BotSetTeleportTime(bot_state_t *bs) {
line 2063
;2063:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $473
line 2064
;2064:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2065
;2065:	}
LABELV $473
line 2066
;2066:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 2067
;2067:}
LABELV $472
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2074
;2068:
;2069:/*
;2070:==================
;2071:BotIsDead
;2072:==================
;2073:*/
;2074:qboolean BotIsDead(bot_state_t *bs) {
line 2075
;2075:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $477
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $478
JUMPV
LABELV $477
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $478
ADDRLP4 0
INDIRI4
RETI4
LABELV $475
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2083
;2076:}
;2077:
;2078:/*
;2079:==================
;2080:BotIsObserver
;2081:==================
;2082:*/
;2083:qboolean BotIsObserver(bot_state_t *bs) {
line 2085
;2084:	char buf[MAX_INFO_STRING];
;2085:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $480
CNSTI4 1
RETI4
ADDRGP4 $479
JUMPV
LABELV $480
line 2086
;2086:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2087
;2087:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $482
CNSTI4 1
RETI4
ADDRGP4 $479
JUMPV
LABELV $482
line 2088
;2088:	return qfalse;
CNSTI4 0
RETI4
LABELV $479
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2096
;2089:}
;2090:
;2091:/*
;2092:==================
;2093:BotIntermission
;2094:==================
;2095:*/
;2096:qboolean BotIntermission(bot_state_t *bs) {
line 2098
;2097:	//NOTE: we shouldn't be looking at the game code...
;2098:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $485
CNSTI4 1
RETI4
ADDRGP4 $484
JUMPV
LABELV $485
line 2099
;2099:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $491
ADDRLP4 4
INDIRI4
CNSTI4 5
NEI4 $489
LABELV $491
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $490
JUMPV
LABELV $489
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $490
ADDRLP4 0
INDIRI4
RETI4
LABELV $484
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2107
;2100:}
;2101:
;2102:/*
;2103:==================
;2104:BotInLavaOrSlime
;2105:==================
;2106:*/
;2107:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2110
;2108:	vec3_t feet;
;2109:
;2110:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2111
;2111:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2112
;2112:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $492
endproc BotInLavaOrSlime 16 4
lit
align 4
LABELV $495
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $496
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2120
;2113:}
;2114:
;2115:/*
;2116:==================
;2117:BotCreateWayPoint
;2118:==================
;2119:*/
;2120:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2122
;2121:	bot_waypoint_t *wp;
;2122:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $495
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $496
INDIRB
ASGNB 12
line 2124
;2123:
;2124:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2125
;2125:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $497
line 2126
;2126:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $499
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2127
;2127:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $494
JUMPV
LABELV $497
line 2129
;2128:	}
;2129:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2131
;2130:
;2131:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2132
;2132:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2133
;2133:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2134
;2134:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2135
;2135:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2136
;2136:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2137
;2137:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2138
;2138:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $494
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2146
;2139:}
;2140:
;2141:/*
;2142:==================
;2143:BotFindWayPoint
;2144:==================
;2145:*/
;2146:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2149
;2147:	bot_waypoint_t *wp;
;2148:
;2149:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $504
JUMPV
LABELV $501
line 2150
;2150:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $505
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $500
JUMPV
LABELV $505
line 2151
;2151:	}
LABELV $502
line 2149
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $504
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $501
line 2152
;2152:	return NULL;
CNSTP4 0
RETP4
LABELV $500
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2160
;2153:}
;2154:
;2155:/*
;2156:==================
;2157:BotFreeWaypoints
;2158:==================
;2159:*/
;2160:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2163
;2161:	bot_waypoint_t *nextwp;
;2162:
;2163:	for (; wp; wp = nextwp) {
ADDRGP4 $511
JUMPV
LABELV $508
line 2164
;2164:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2165
;2165:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2166
;2166:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2167
;2167:	}
LABELV $509
line 2163
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $511
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $508
line 2168
;2168:}
LABELV $507
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2175
;2169:
;2170:/*
;2171:==================
;2172:BotInitWaypoints
;2173:==================
;2174:*/
;2175:void BotInitWaypoints(void) {
line 2178
;2176:	int i;
;2177:
;2178:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2179
;2179:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $513
line 2180
;2180:		botai_waypoints[i].next = botai_freewaypoints;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2181
;2181:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2182
;2182:	}
LABELV $514
line 2179
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $513
line 2183
;2183:}
LABELV $512
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 2190
;2184:
;2185:/*
;2186:==================
;2187:TeamPlayIsOn
;2188:==================
;2189:*/
;2190:int TeamPlayIsOn(void) {
line 2191
;2191:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $520
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $521
JUMPV
LABELV $520
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $521
ADDRLP4 0
INDIRI4
RETI4
LABELV $518
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 28 0
line 2199
;2192:}
;2193:
;2194:/*
;2195:==================
;2196:BotAggression
;2197:==================
;2198:*/
;2199:float BotAggression(bot_state_t *bs) {
line 2201
;2200:	//if the bot has quad
;2201:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $523
line 2203
;2202:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2203:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $527
ADDRLP4 0
INDIRP4
CNSTI4 5752
ADDP4
INDIRI4
CNSTI4 80
GEI4 $525
LABELV $527
line 2204
;2204:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2205
;2205:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $522
JUMPV
LABELV $525
line 2207
;2206:		}
;2207:	}
LABELV $523
line 2209
;2208:	//if the enemy is located way higher than the bot
;2209:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
INDIRI4
CNSTI4 200
LEI4 $528
CNSTF4 0
RETF4
ADDRGP4 $522
JUMPV
LABELV $528
line 2211
;2210:	//if the bot is very low on health
;2211:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $530
CNSTF4 0
RETF4
ADDRGP4 $522
JUMPV
LABELV $530
line 2213
;2212:	//if the bot is low on health
;2213:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $532
line 2215
;2214:		//if the bot has insufficient armor
;2215:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $534
CNSTF4 0
RETF4
ADDRGP4 $522
JUMPV
LABELV $534
line 2216
;2216:	}
LABELV $532
line 2218
;2217:	//if the bot can use the bfg
;2218:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $536
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $536
line 2219
;2219:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $522
JUMPV
LABELV $536
line 2221
;2220:	//if the bot can use the railgun
;2221:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $538
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $538
line 2222
;2222:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $522
JUMPV
LABELV $538
line 2224
;2223:	//if the bot can use the lightning gun
;2224:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $540
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $540
line 2225
;2225:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $522
JUMPV
LABELV $540
line 2227
;2226:	//if the bot can use the rocketlauncher
;2227:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $542
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $542
line 2228
;2228:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $522
JUMPV
LABELV $542
line 2230
;2229:	//if the bot can use the plasmagun
;2230:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $544
ADDRLP4 16
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 40
LEI4 $544
line 2231
;2231:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $522
JUMPV
LABELV $544
line 2233
;2232:	//if the bot can use the grenade launcher
;2233:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $546
ADDRLP4 20
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 10
LEI4 $546
line 2234
;2234:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $522
JUMPV
LABELV $546
line 2236
;2235:	//if the bot can use the shotgun
;2236:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 0
LEI4 $548
ADDRLP4 24
INDIRP4
CNSTI4 5024
ADDP4
INDIRI4
CNSTI4 10
LEI4 $548
line 2237
;2237:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $522
JUMPV
LABELV $548
line 2239
;2238:	//otherwise the bot is not feeling too good
;2239:	return 0;
CNSTF4 0
RETF4
LABELV $522
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2247
;2240:}
;2241:
;2242:/*
;2243:==================
;2244:BotFeelingBad
;2245:==================
;2246:*/
;2247:float BotFeelingBad(bot_state_t *bs) {
line 2248
;2248:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $551
line 2249
;2249:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $550
JUMPV
LABELV $551
line 2251
;2250:	}
;2251:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $553
line 2252
;2252:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $550
JUMPV
LABELV $553
line 2254
;2253:	}
;2254:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 2
NEI4 $555
line 2255
;2255:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $550
JUMPV
LABELV $555
line 2257
;2256:	}
;2257:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $557
line 2258
;2258:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $550
JUMPV
LABELV $557
line 2260
;2259:	}
;2260:	return 0;
CNSTF4 0
RETF4
LABELV $550
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 144 8
line 2268
;2261:}
;2262:
;2263:/*
;2264:==================
;2265:BotWantsToRetreat
;2266:==================
;2267:*/
;2268:int BotWantsToRetreat(bot_state_t *bs) {
line 2271
;2269:	aas_entityinfo_t entinfo;
;2270:
;2271:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $560
line 2273
;2272:		//always retreat when carrying a CTF flag
;2273:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $562
line 2274
;2274:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $562
line 2275
;2275:	}
LABELV $560
line 2301
;2276:#ifdef MISSIONPACK
;2277:	else if (gametype == GT_1FCTF) {
;2278:		//if carrying the flag then always retreat
;2279:		if (Bot1FCTFCarryingFlag(bs))
;2280:			return qtrue;
;2281:	}
;2282:	else if (gametype == GT_OBELISK) {
;2283:		//the bots should be dedicated to attacking the enemy obelisk
;2284:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2285:			if (bs->enemy != redobelisk.entitynum ||
;2286:						bs->enemy != blueobelisk.entitynum) {
;2287:				return qtrue;
;2288:			}
;2289:		}
;2290:		if (BotFeelingBad(bs) > 50) {
;2291:			return qtrue;
;2292:		}
;2293:		return qfalse;
;2294:	}
;2295:	else if (gametype == GT_HARVESTER) {
;2296:		//if carrying cubes then always retreat
;2297:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
;2298:	}
;2299:#endif
;2300:	//
;2301:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $564
line 2303
;2302:		//if the enemy is carrying a flag
;2303:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2304
;2304:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $566
line 2305
;2305:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $559
JUMPV
LABELV $566
line 2306
;2306:	}
LABELV $564
line 2308
;2307:	//if the bot is getting the flag
;2308:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $568
line 2309
;2309:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $568
line 2311
;2310:	//
;2311:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $570
line 2312
;2312:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $570
line 2313
;2313:	return qfalse;
CNSTI4 0
RETI4
LABELV $559
endproc BotWantsToRetreat 144 8
export BotWantsToChase
proc BotWantsToChase 148 8
line 2321
;2314:}
;2315:
;2316:/*
;2317:==================
;2318:BotWantsToChase
;2319:==================
;2320:*/
;2321:int BotWantsToChase(bot_state_t *bs) {
line 2324
;2322:	aas_entityinfo_t entinfo;
;2323:
;2324:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $573
line 2326
;2325:		//never chase when carrying a CTF flag
;2326:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $575
line 2327
;2327:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $572
JUMPV
LABELV $575
line 2329
;2328:		//always chase if the enemy is carrying a flag
;2329:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2330
;2330:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $577
line 2331
;2331:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $577
line 2332
;2332:	}
LABELV $573
line 2359
;2333:#ifdef MISSIONPACK
;2334:	else if (gametype == GT_1FCTF) {
;2335:		//never chase if carrying the flag
;2336:		if (Bot1FCTFCarryingFlag(bs))
;2337:			return qfalse;
;2338:		//always chase if the enemy is carrying a flag
;2339:		BotEntityInfo(bs->enemy, &entinfo);
;2340:		if (EntityCarriesFlag(&entinfo))
;2341:			return qtrue;
;2342:	}
;2343:	else if (gametype == GT_OBELISK) {
;2344:		//the bots should be dedicated to attacking the enemy obelisk
;2345:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2346:			if (bs->enemy != redobelisk.entitynum ||
;2347:						bs->enemy != blueobelisk.entitynum) {
;2348:				return qfalse;
;2349:			}
;2350:		}
;2351:	}
;2352:	else if (gametype == GT_HARVESTER) {
;2353:		//never chase if carrying cubes
;2354:		if (BotHarvesterCarryingCubes(bs))
;2355:			return qfalse;
;2356:	}
;2357:#endif
;2358:	//if the bot is getting the flag
;2359:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $579
line 2360
;2360:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $572
JUMPV
LABELV $579
line 2362
;2361:	//
;2362:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $581
line 2363
;2363:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $581
line 2364
;2364:	return qfalse;
CNSTI4 0
RETI4
LABELV $572
endproc BotWantsToChase 148 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2372
;2365:}
;2366:
;2367:/*
;2368:==================
;2369:BotWantsToHelp
;2370:==================
;2371:*/
;2372:int BotWantsToHelp(bot_state_t *bs) {
line 2373
;2373:	return qtrue;
CNSTI4 1
RETI4
LABELV $583
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 8 16
line 2381
;2374:}
;2375:
;2376:/*
;2377:==================
;2378:BotCanAndWantsToRocketJump
;2379:==================
;2380:*/
;2381:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2385
;2382:	float rocketjumper;
;2383:
;2384:	//if rocket jumping is disabled
;2385:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $585
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $585
line 2387
;2386:	//if no rocket launcher
;2387:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
GTI4 $588
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $588
line 2389
;2388:	//if low on rockets
;2389:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 3
GEI4 $590
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $590
line 2391
;2390:	//never rocket jump with the Quad
;2391:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $592
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $592
line 2393
;2392:	//if low on health
;2393:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $594
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $594
line 2395
;2394:	//if not full health
;2395:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 90
GEI4 $596
line 2397
;2396:		//if the bot has insufficient armor
;2397:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $598
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $598
line 2398
;2398:	}
LABELV $596
line 2399
;2399:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2400
;2400:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $600
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $600
line 2401
;2401:	return qtrue;
CNSTI4 1
RETI4
LABELV $584
endproc BotCanAndWantsToRocketJump 8 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 32 0
line 2409
;2402:}
;2403:
;2404:/*
;2405:==================
;2406:BotHasPersistantPowerupAndWeapon
;2407:==================
;2408:*/
;2409:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2420
;2410:#ifdef MISSIONPACK
;2411:	// if the bot does not have a persistant powerup
;2412:	if (!bs->inventory[INVENTORY_SCOUT] &&
;2413:		!bs->inventory[INVENTORY_GUARD] &&
;2414:		!bs->inventory[INVENTORY_DOUBLER] &&
;2415:		!bs->inventory[INVENTORY_AMMOREGEN] ) {
;2416:		return qfalse;
;2417:	}
;2418:#endif
;2419:	//if the bot is very low on health
;2420:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $603
CNSTI4 0
RETI4
ADDRGP4 $602
JUMPV
LABELV $603
line 2422
;2421:	//if the bot is low on health
;2422:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $605
line 2424
;2423:		//if the bot has insufficient armor
;2424:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $607
CNSTI4 0
RETI4
ADDRGP4 $602
JUMPV
LABELV $607
line 2425
;2425:	}
LABELV $605
line 2427
;2426:	//if the bot can use the bfg
;2427:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $609
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $609
line 2428
;2428:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $609
line 2430
;2429:	//if the bot can use the railgun
;2430:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $611
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $611
line 2431
;2431:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $611
line 2433
;2432:	//if the bot can use the lightning gun
;2433:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $613
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $613
line 2434
;2434:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $613
line 2436
;2435:	//if the bot can use the rocketlauncher
;2436:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $615
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $615
line 2437
;2437:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $615
line 2439
;2438:	//
;2439:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $617
ADDRLP4 16
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 5
LEI4 $617
line 2440
;2440:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $617
line 2442
;2441:	//
;2442:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 5016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $619
ADDRLP4 20
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 5
LEI4 $619
line 2443
;2443:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $619
line 2445
;2444:	//
;2445:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $621
ADDRLP4 24
INDIRP4
CNSTI4 5064
ADDP4
INDIRI4
CNSTI4 40
LEI4 $621
line 2446
;2446:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $621
line 2448
;2447:	//if the bot can use the plasmagun
;2448:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $623
ADDRLP4 28
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 20
LEI4 $623
line 2449
;2449:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $602
JUMPV
LABELV $623
line 2450
;2450:	return qfalse;
CNSTI4 0
RETI4
LABELV $602
endproc BotHasPersistantPowerupAndWeapon 32 0
export BotGoCamp
proc BotGoCamp 16 16
line 2458
;2451:}
;2452:
;2453:/*
;2454:==================
;2455:BotGoCamp
;2456:==================
;2457:*/
;2458:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2461
;2459:	float camper;
;2460:
;2461:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2463
;2462:	//set message time to zero so bot will NOT show any message
;2463:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 2465
;2464:	//set the ltg type
;2465:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 7
ASGNI4
line 2467
;2466:	//set the team goal
;2467:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2469
;2468:	//get the team goal time
;2469:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2470
;2470:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $626
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $627
JUMPV
LABELV $626
line 2471
;2471:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
CNSTF4 1127481344
ADDRLP4 0
INDIRF4
MULF4
ADDF4
CNSTF4 1097859072
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
LABELV $627
line 2473
;2472:	//set the last time the bot started camping
;2473:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2475
;2474:	//the teammate that requested the camping
;2475:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
CNSTI4 0
ASGNI4
line 2477
;2476:	//do NOT type arrive message
;2477:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 2478
;2478:}
LABELV $625
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 176 16
line 2485
;2479:
;2480:/*
;2481:==================
;2482:BotWantsToCamp
;2483:==================
;2484:*/
;2485:int BotWantsToCamp(bot_state_t *bs) {
line 2490
;2486:	float camper;
;2487:	int cs, traveltime, besttraveltime;
;2488:	bot_goal_t goal, bestgoal;
;2489:
;2490:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2491
;2491:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $629
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $629
line 2493
;2492:	//if the bot has a team goal
;2493:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 2
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 3
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 4
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 5
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 7
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 8
EQI4 $639
ADDRLP4 132
INDIRI4
CNSTI4 9
NEI4 $631
LABELV $639
line 2500
;2494:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2495:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2496:			bs->ltgtype == LTG_GETFLAG ||
;2497:			bs->ltgtype == LTG_RUSHBASE ||
;2498:			bs->ltgtype == LTG_CAMP ||
;2499:			bs->ltgtype == LTG_CAMPORDER ||
;2500:			bs->ltgtype == LTG_PATROL) {
line 2501
;2501:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $631
line 2504
;2502:	}
;2503:	//if camped recently
;2504:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1133903872
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
MULF4
ADDF4
LEF4 $640
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $640
line 2506
;2505:	//
;2506:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 124
INDIRF4
LEF4 $642
line 2507
;2507:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2508
;2508:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $642
line 2511
;2509:	}
;2510:	//if the bot isn't healthy anough
;2511:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $644
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $644
line 2513
;2512:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2513:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS < 10]) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
ADDRLP4 148
INDIRI4
LEI4 $648
ADDRLP4 144
INDIRP4
CNSTI4 4952
ADDP4
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $646
LABELV $648
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $649
ADDRLP4 152
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 10
GEI4 $646
LABELV $649
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $650
ADDRLP4 156
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 10
GEI4 $646
LABELV $650
line 2515
;2514:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2515:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2516
;2516:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $646
line 2519
;2517:	}
;2518:	//find the closest camp spot
;2519:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2520
;2520:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
ADDRGP4 $654
JUMPV
LABELV $651
line 2521
;2521:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 168
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 168
INDIRI4
ASGNI4
line 2522
;2522:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $656
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $656
line 2523
;2523:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2524
;2524:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2525
;2525:		}
LABELV $656
line 2526
;2526:	}
LABELV $652
line 2520
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 164
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 164
INDIRI4
ASGNI4
LABELV $654
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $651
line 2527
;2527:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $658
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $658
line 2529
;2528:	//ok found a camp spot, go camp there
;2529:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2530
;2530:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 2532
;2531:	//
;2532:	return qtrue;
CNSTI4 1
RETI4
LABELV $628
endproc BotWantsToCamp 176 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2540
;2533:}
;2534:
;2535:/*
;2536:==================
;2537:BotDontAvoid
;2538:==================
;2539:*/
;2540:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2544
;2541:	bot_goal_t goal;
;2542:	int num;
;2543:
;2544:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $661
line 2545
;2545:	while(num >= 0) {
line 2546
;2546:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2547
;2547:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2548
;2548:	}
LABELV $662
line 2545
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $661
line 2549
;2549:}
LABELV $660
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2556
;2550:
;2551:/*
;2552:==================
;2553:BotGoForPowerups
;2554:==================
;2555:*/
;2556:void BotGoForPowerups(bot_state_t *bs) {
line 2559
;2557:
;2558:	//don't avoid any of the powerups anymore
;2559:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $666
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2560
;2560:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $667
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2561
;2561:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $668
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2562
;2562:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $669
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2563
;2563:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $670
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2567
;2564:	//BotDontAvoid(bs, "Flight");
;2565:	//reset the long term goal time so the bot will go for the powerup
;2566:	//NOTE: the long term goal type doesn't change
;2567:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
line 2568
;2568:}
LABELV $665
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 180 28
line 2575
;2569:
;2570:/*
;2571:==================
;2572:BotRoamGoal
;2573:==================
;2574:*/
;2575:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2581
;2576:	int pc, i;
;2577:	float len, rnd;
;2578:	vec3_t dir, bestorg, belowbestorg;
;2579:	bsp_trace_t trace;
;2580:
;2581:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $672
line 2583
;2582:		//start at the bot origin
;2583:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2584
;2584:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 2585
;2585:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $676
line 2587
;2586:			//add a random value to the x-coordinate
;2587:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $678
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $679
JUMPV
LABELV $678
line 2588
;2588:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $679
line 2589
;2589:		}
LABELV $676
line 2590
;2590:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $680
line 2592
;2591:			//add a random value to the y-coordinate
;2592:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $682
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $683
JUMPV
LABELV $682
line 2593
;2593:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $683
line 2594
;2594:		}
LABELV $680
line 2596
;2595:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2596:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1119879168
CNSTF4 1073741824
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
line 2598
;2597:		//trace a line from the origin to the roam target
;2598:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 148
CNSTP4 0
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2600
;2599:		//direction and length towards the roam target
;2600:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2601
;2601:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 156
INDIRF4
ASGNF4
line 2603
;2602:		//if the roam target is far away anough
;2603:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $694
line 2605
;2604:			//the roam target is in the given direction before walls
;2605:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 164
CNSTF4 1109393408
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2606
;2606:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 168
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 168
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2608
;2607:			//get the coordinates of the floor below the roam target
;2608:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2609
;2609:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2610
;2610:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2611
;2611:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 172
CNSTP4 0
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2613
;2612:			//
;2613:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $711
line 2614
;2614:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2615
;2615:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 176
INDIRI4
ASGNI4
line 2616
;2616:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $717
line 2617
;2617:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2618
;2618:					return;
ADDRGP4 $671
JUMPV
LABELV $717
line 2620
;2619:				}
;2620:			}
LABELV $711
line 2621
;2621:		}
LABELV $694
line 2622
;2622:	}
LABELV $673
line 2581
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $672
line 2623
;2623:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2624
;2624:}
LABELV $671
endproc BotRoamGoal 180 28
lit
align 4
LABELV $721
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2631
;2625:
;2626:/*
;2627:==================
;2628:BotAttackMove
;2629:==================
;2630:*/
;2631:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2635
;2632:	int movetype, i, attackentity;
;2633:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2634:	float attack_dist, attack_range;
;2635:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $721
INDIRB
ASGNB 12
line 2640
;2636:	aas_entityinfo_t entinfo;
;2637:	bot_moveresult_t moveresult;
;2638:	bot_goal_t goal;
;2639:
;2640:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 2642
;2641:	//
;2642:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6124
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $722
line 2644
;2643:		//create the chase goal
;2644:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2645
;2645:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ASGNI4
line 2646
;2646:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 2647
;2647:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2648
;2648:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2650
;2649:		//initialize the movement state
;2650:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2652
;2651:		//move towards the goal
;2652:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2653
;2653:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $722
line 2656
;2654:	}
;2655:	//
;2656:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2658
;2657:	//
;2658:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2659
;2659:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2660
;2660:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2662
;2661:	//if the bot is really stupid
;2662:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $736
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $736
line 2664
;2663:	//initialize the movement state
;2664:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2666
;2665:	//get the enemy entity info
;2666:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2668
;2667:	//direction towards the enemy
;2668:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2670
;2669:	//the distance towards the enemy
;2670:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2671
;2671:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2673
;2672:	//walk, crouch or jump
;2673:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2675
;2674:	//
;2675:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $749
line 2676
;2676:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 340
INDIRF4
GEF4 $751
line 2677
;2677:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2678
;2678:		}
ADDRGP4 $752
JUMPV
LABELV $751
line 2680
;2679:		//wait at least one second before crouching again
;2680:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $753
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 344
INDIRF4
GEF4 $753
line 2681
;2681:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDRLP4 344
INDIRF4
MULF4
ADDF4
ASGNF4
line 2682
;2682:		}
LABELV $753
LABELV $752
line 2683
;2683:	}
LABELV $749
line 2684
;2684:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $755
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $755
line 2686
;2685:	//if the bot should jump
;2686:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $757
line 2688
;2687:		//if jumped last frame
;2688:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $759
line 2689
;2689:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2690
;2690:		}
ADDRGP4 $760
JUMPV
LABELV $759
line 2691
;2691:		else {
line 2692
;2692:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2693
;2693:		}
LABELV $760
line 2694
;2694:	}
LABELV $757
line 2695
;2695:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $761
line 2696
;2696:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2697
;2697:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2698
;2698:	}
ADDRGP4 $762
JUMPV
LABELV $761
line 2699
;2699:	else {
line 2700
;2700:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2701
;2701:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2702
;2702:	}
LABELV $762
line 2704
;2703:	//if the bot is stupid
;2704:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $763
line 2706
;2705:		//just walk to or away from the enemy
;2706:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $765
line 2707
;2707:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $767
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $767
line 2708
;2708:		}
LABELV $765
line 2709
;2709:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $769
line 2710
;2710:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $771
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $771
line 2711
;2711:		}
LABELV $769
line 2712
;2712:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $763
line 2715
;2713:	}
;2714:	//increase the strafe time
;2715:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 6116
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2717
;2716:	//get the strafe change time
;2717:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1045220557
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2718
;2718:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $773
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
LABELV $773
line 2720
;2719:	//if the strafe direction should be changed
;2720:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $775
line 2722
;2721:		//some magic number :)
;2722:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1064262697
LEF4 $777
line 2724
;2723:			//flip the strafe direction
;2724:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2725
;2725:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2726
;2726:		}
LABELV $777
line 2727
;2727:	}
LABELV $775
line 2729
;2728:	//
;2729:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $779
line 2730
;2730:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2731
;2731:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2732
;2732:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2733
;2733:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2735
;2734:		//get the sideward vector
;2735:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2737
;2736:		//reverse the vector depending on the strafe direction
;2737:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $786
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $786
line 2739
;2738:		//randomly go back a little
;2739:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1063675494
LEF4 $792
line 2740
;2740:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2741
;2741:		}
ADDRGP4 $793
JUMPV
LABELV $792
line 2742
;2742:		else {
line 2744
;2743:			//walk forward or backward to get at the ideal attack distance
;2744:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $800
line 2745
;2745:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2746
;2746:			}
ADDRGP4 $801
JUMPV
LABELV $800
line 2747
;2747:			else if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $808
line 2748
;2748:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2749
;2749:			}
LABELV $808
LABELV $801
line 2750
;2750:		}
LABELV $793
line 2752
;2751:		//perform the movement
;2752:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $816
line 2753
;2753:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $719
JUMPV
LABELV $816
line 2755
;2754:		//movement failed, flip the strafe direction
;2755:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2756
;2756:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2757
;2757:	}
LABELV $780
line 2729
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $779
line 2760
;2758:	//bot couldn't do any usefull movement
;2759://	bs->attackchase_time = AAS_Time() + 6;
;2760:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $719
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 2072 12
line 2768
;2761:}
;2762:
;2763:/*
;2764:==================
;2765:BotSameTeam
;2766:==================
;2767:*/
;2768:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2771
;2769:	char info1[1024], info2[1024];
;2770:
;2771:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 2048
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
LTI4 $821
ADDRLP4 2048
INDIRI4
CNSTI4 64
LTI4 $819
LABELV $821
line 2773
;2772:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $818
JUMPV
LABELV $819
line 2775
;2774:	}
;2775:	if (entnum < 0 || entnum >= MAX_CLIENTS) {
ADDRLP4 2052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
LTI4 $824
ADDRLP4 2052
INDIRI4
CNSTI4 64
LTI4 $822
LABELV $824
line 2777
;2776:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2777:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $818
JUMPV
LABELV $822
line 2779
;2778:	}
;2779:	if ( gametype >= GT_TEAM ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $825
line 2780
;2780:		trap_GetConfigstring(CS_PLAYERS+bs->client, info1, sizeof(info1));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2781
;2781:		trap_GetConfigstring(CS_PLAYERS+entnum, info2, sizeof(info2));
ADDRFP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2783
;2782:		//
;2783:		if (atoi(Info_ValueForKey(info1, "t")) == atoi(Info_ValueForKey(info2, "t"))) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 2056
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 2064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $827
CNSTI4 1
RETI4
ADDRGP4 $818
JUMPV
LABELV $827
line 2784
;2784:	}
LABELV $825
line 2785
;2785:	return qfalse;
CNSTI4 0
RETI4
LABELV $818
endproc BotSameTeam 2072 12
export InFieldOfVision
proc InFieldOfVision 24 4
line 2794
;2786:}
;2787:
;2788:/*
;2789:==================
;2790:InFieldOfVision
;2791:==================
;2792:*/
;2793:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;2794:{
line 2798
;2795:	int i;
;2796:	float diff, angle;
;2797:
;2798:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $830
line 2799
;2799:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2800
;2800:		angles[i] = AngleMod(angles[i]);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
line 2801
;2801:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2802
;2802:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $834
line 2803
;2803:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $835
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2804
;2804:		}
ADDRGP4 $835
JUMPV
LABELV $834
line 2805
;2805:		else {
line 2806
;2806:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $838
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $838
line 2807
;2807:		}
LABELV $835
line 2808
;2808:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $840
line 2809
;2809:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
LEF4 $841
CNSTI4 0
RETI4
ADDRGP4 $829
JUMPV
line 2810
;2810:		}
LABELV $840
line 2811
;2811:		else {
line 2812
;2812:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
NEGF4
MULF4
GEF4 $844
CNSTI4 0
RETI4
ADDRGP4 $829
JUMPV
LABELV $844
line 2813
;2813:		}
LABELV $841
line 2814
;2814:	}
LABELV $831
line 2798
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $830
line 2815
;2815:	return qtrue;
CNSTI4 1
RETI4
LABELV $829
endproc InFieldOfVision 24 4
export BotEntityVisible
proc BotEntityVisible 376 28
line 2825
;2816:}
;2817:
;2818:/*
;2819:==================
;2820:BotEntityVisible
;2821:
;2822:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2823:==================
;2824:*/
;2825:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2833
;2826:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2827:	float squaredfogdist, waterfactor, vis, bestvis;
;2828:	bsp_trace_t trace;
;2829:	aas_entityinfo_t entinfo;
;2830:	vec3_t dir, entangles, start, end, middle;
;2831:
;2832:	//calculate middle of bounding box
;2833:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2834
;2834:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2835
;2835:	VectorScale(middle, 0.5, middle);
ADDRLP4 332
CNSTF4 1056964608
ASGNF4
ADDRLP4 84
ADDRLP4 332
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 332
INDIRF4
ADDRLP4 84+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+8
CNSTF4 1056964608
ADDRLP4 84+8
INDIRF4
MULF4
ASGNF4
line 2836
;2836:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2838
;2837:	//check if entity is within field of vision
;2838:	VectorSubtract(middle, eye, dir);
ADDRLP4 336
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 336
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 336
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2839
;2839:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2840
;2840:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 340
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
NEI4 $876
CNSTF4 0
RETF4
ADDRGP4 $846
JUMPV
LABELV $876
line 2842
;2841:	//
;2842:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 344
INDIRI4
ASGNI4
line 2843
;2843:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2844
;2844:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2846
;2845:	//
;2846:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2847
;2847:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $878
line 2851
;2848:		//if the point is not in potential visible sight
;2849:		//if (!AAS_inPVS(eye, middle)) continue;
;2850:		//
;2851:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2852
;2852:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2853
;2853:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2854
;2854:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2855
;2855:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2857
;2856:		//if the entity is in water, lava or slime
;2857:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $882
line 2858
;2858:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2859
;2859:		}
LABELV $882
line 2861
;2860:		//if eye is in water, lava or slime
;2861:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $884
line 2862
;2862:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $886
line 2863
;2863:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2864
;2864:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2865
;2865:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2866
;2866:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2867
;2867:			}
LABELV $886
line 2868
;2868:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2869
;2869:		}
LABELV $884
line 2871
;2870:		//trace from start to end
;2871:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 352
CNSTP4 0
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2873
;2872:		//if water was hit
;2873:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2874
;2874:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $888
line 2876
;2875:			//if the water surface is translucent
;2876:			if (1) {
line 2878
;2877:				//trace through the water
;2878:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2879
;2879:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 356
CNSTP4 0
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2880
;2880:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2881
;2881:			}
LABELV $891
line 2882
;2882:		}
LABELV $888
line 2884
;2883:		//if a full trace or the hitent was hit
;2884:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $898
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $894
LABELV $898
line 2887
;2885:			//check for fog, assuming there's only one fog brush where
;2886:			//either the viewer or the entity is in or both are in
;2887:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 356
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 356
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2888
;2888:			if (infog && otherinfog) {
ADDRLP4 360
CNSTI4 0
ASGNI4
ADDRLP4 312
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $899
ADDRLP4 304
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $899
line 2889
;2889:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 364
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 364
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2890
;2890:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 2891
;2891:			}
ADDRGP4 $900
JUMPV
LABELV $899
line 2892
;2892:			else if (infog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $908
line 2893
;2893:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2894
;2894:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2895
;2895:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 368
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 368
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2896
;2896:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 372
INDIRF4
ASGNF4
line 2897
;2897:			}
ADDRGP4 $909
JUMPV
LABELV $908
line 2898
;2898:			else if (otherinfog) {
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $918
line 2899
;2899:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2900
;2900:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2901
;2901:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2902
;2902:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 2903
;2903:			}
ADDRGP4 $919
JUMPV
LABELV $918
line 2904
;2904:			else {
line 2906
;2905:				//if the entity and the viewer are not in fog assume there's no fog in between
;2906:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 2907
;2907:			}
LABELV $919
LABELV $909
LABELV $900
line 2909
;2908:			//decrease visibility with the view distance through fog
;2909:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 368
CNSTF4 1065353216
ASGNF4
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ADDRLP4 368
INDIRF4
GEF4 $931
ADDRLP4 364
CNSTF4 1065353216
ASGNF4
ADDRGP4 $932
JUMPV
LABELV $931
ADDRLP4 364
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ASGNF4
LABELV $932
ADDRLP4 292
ADDRLP4 368
INDIRF4
ADDRLP4 364
INDIRF4
DIVF4
ASGNF4
line 2911
;2910:			//if entering water visibility is reduced
;2911:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 2913
;2912:			//
;2913:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $933
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $933
line 2915
;2914:			//if pretty much no fog
;2915:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $935
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $846
JUMPV
LABELV $935
line 2916
;2916:		}
LABELV $894
line 2918
;2917:		//check bottom and top of bounding box as well
;2918:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $937
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $938
JUMPV
LABELV $937
line 2919
;2919:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $942
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $942
LABELV $938
line 2920
;2920:	}
LABELV $879
line 2847
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $878
line 2921
;2921:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $846
endproc BotEntityVisible 376 28
export BotFindEnemy
proc BotFindEnemy 432 20
line 2929
;2922:}
;2923:
;2924:/*
;2925:==================
;2926:BotFindEnemy
;2927:==================
;2928:*/
;2929:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 2936
;2930:	int i, healthdecrease;
;2931:	float f, alertness, easyfragger, vis;
;2932:	float squaredist, cursquaredist;
;2933:	aas_entityinfo_t entinfo, curenemyinfo;
;2934:	vec3_t dir, angles;
;2935:
;2936:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 336
INDIRF4
ASGNF4
line 2937
;2937:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 340
INDIRF4
ASGNF4
line 2939
;2938:	//check if the health decreased
;2939:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 5988
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
LEI4 $951
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $952
JUMPV
LABELV $951
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $952
ADDRLP4 160
ADDRLP4 344
INDIRI4
ASGNI4
line 2941
;2940:	//remember the current health value
;2941:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 5988
ADDP4
ADDRLP4 352
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 2943
;2942:	//
;2943:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $953
line 2944
;2944:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 196
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2945
;2945:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 196
ARGP4
ADDRLP4 356
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $955
CNSTI4 0
RETI4
ADDRGP4 $949
JUMPV
LABELV $955
line 2946
;2946:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 196+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 196+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 196+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2947
;2947:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 364
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 364
INDIRF4
ASGNF4
line 2948
;2948:	}
ADDRGP4 $954
JUMPV
LABELV $953
line 2949
;2949:	else {
line 2950
;2950:		cursquaredist = 0;
ADDRLP4 192
CNSTF4 0
ASGNF4
line 2951
;2951:	}
LABELV $954
line 2980
;2952:#ifdef MISSIONPACK
;2953:	if (gametype == GT_OBELISK) {
;2954:		vec3_t target;
;2955:		bot_goal_t *goal;
;2956:		bsp_trace_t trace;
;2957:
;2958:		if (BotTeam(bs) == TEAM_RED)
;2959:			goal = &blueobelisk;
;2960:		else
;2961:			goal = &redobelisk;
;2962:		//if the obelisk is visible
;2963:		VectorCopy(goal->origin, target);
;2964:		target[2] += 1;
;2965:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2966:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2967:			if (goal->entitynum == bs->enemy) {
;2968:				return qfalse;
;2969:			}
;2970:			bs->enemy = goal->entitynum;
;2971:			bs->enemysight_time = FloatTime();
;2972:			bs->enemysuicide = qfalse;
;2973:			bs->enemydeath_time = 0;
;2974:			bs->enemyvisible_time = FloatTime();
;2975:			return qtrue;
;2976:		}
;2977:	}
;2978:#endif
;2979:	//
;2980:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $967
JUMPV
LABELV $964
line 2982
;2981:
;2982:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $968
ADDRGP4 $965
JUMPV
LABELV $968
line 2984
;2983:		//if it's the current enemy
;2984:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $970
ADDRGP4 $965
JUMPV
LABELV $970
line 2986
;2985:		//
;2986:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2988
;2987:		//
;2988:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $972
ADDRGP4 $965
JUMPV
LABELV $972
line 2990
;2989:		//if the enemy isn't dead and the enemy isn't the bot self
;2990:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 356
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
NEI4 $977
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $974
LABELV $977
ADDRGP4 $965
JUMPV
LABELV $974
line 2992
;2991:		//if the enemy is invisible and not shooting
;2992:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $978
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $978
line 2993
;2993:			continue;
ADDRGP4 $965
JUMPV
LABELV $978
line 2996
;2994:		}
;2995:		//if not an easy fragger don't shoot at chatting players
;2996:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
GEF4 $980
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $980
ADDRGP4 $965
JUMPV
LABELV $980
line 2998
;2997:		//
;2998:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $982
line 2999
;2999:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3000
;3000:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 372
INDIRF4
CNSTF4 1167663104
GEF4 $993
ADDRGP4 $965
JUMPV
LABELV $993
line 3001
;3001:		}
LABELV $982
line 3003
;3002:		//calculate the distance towards the enemy
;3003:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3004
;3004:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 376
INDIRF4
ASGNF4
line 3006
;3005:		//if this entity is not carrying a flag
;3006:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1002
line 3007
;3007:		{
line 3009
;3008:			//if this enemy is further away than the current one
;3009:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1004
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
LEF4 $1004
ADDRGP4 $965
JUMPV
LABELV $1004
line 3010
;3010:		} //end if
LABELV $1002
line 3012
;3011:		//if the bot has no
;3012:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 384
CNSTF4 1165623296
ADDRLP4 164
INDIRF4
MULF4
CNSTF4 1147207680
ADDF4
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 384
INDIRF4
ADDRLP4 384
INDIRF4
MULF4
LEF4 $1006
ADDRGP4 $965
JUMPV
LABELV $1006
line 3014
;3013:		//if on the same team
;3014:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1008
ADDRGP4 $965
JUMPV
LABELV $1008
line 3016
;3015:		//if the bot's health decreased or the enemy is shooting
;3016:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRLP4 392
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 392
INDIRI4
GEI4 $1010
ADDRLP4 160
INDIRI4
ADDRLP4 392
INDIRI4
NEI4 $1012
ADDRLP4 0
ARGP4
ADDRLP4 396
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 396
INDIRI4
CNSTI4 0
EQI4 $1010
LABELV $1012
line 3017
;3017:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1011
JUMPV
LABELV $1010
line 3019
;3018:		else
;3019:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1014
ADDRLP4 400
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1015
JUMPV
LABELV $1014
ADDRLP4 400
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1015
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 400
INDIRF4
CNSTF4 1172557824
DIVF4
SUBF4
SUBF4
ASGNF4
LABELV $1011
line 3021
;3020:		//check if the enemy is visible
;3021:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 404
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 404
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 404
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 408
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 408
INDIRF4
ASGNF4
line 3022
;3022:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1016
ADDRGP4 $965
JUMPV
LABELV $1016
line 3024
;3023:		//if the enemy is quite far away, not shooting and the bot is not damaged
;3024:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRLP4 412
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 412
INDIRI4
GEI4 $1018
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1018
ADDRLP4 160
INDIRI4
ADDRLP4 412
INDIRI4
NEI4 $1018
ADDRLP4 0
ARGP4
ADDRLP4 416
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
NEI4 $1018
line 3025
;3025:		{
line 3027
;3026:			//check if we can avoid this enemy
;3027:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 420
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 420
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3028
;3028:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3030
;3029:			//if the bot isn't in the fov of the enemy
;3030:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 180
ARGP4
ADDRLP4 424
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 424
INDIRI4
CNSTI4 0
NEI4 $1027
line 3032
;3031:				//update some stuff for this enemy
;3032:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3034
;3033:				//if the bot doesn't really want to fight
;3034:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 428
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
EQI4 $1030
ADDRGP4 $965
JUMPV
LABELV $1030
line 3035
;3035:			}
LABELV $1027
line 3036
;3036:		}
LABELV $1018
line 3038
;3037:		//found an enemy
;3038:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3039
;3039:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1033
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1034
JUMPV
LABELV $1033
line 3040
;3040:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1034
line 3041
;3041:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 3042
;3042:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 3043
;3043:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3044
;3044:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $949
JUMPV
LABELV $965
line 2980
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $967
ADDRLP4 140
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1035
ADDRLP4 140
INDIRI4
CNSTI4 64
LTI4 $964
LABELV $1035
line 3046
;3045:	}
;3046:	return qfalse;
CNSTI4 0
RETI4
LABELV $949
endproc BotFindEnemy 432 20
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 3054
;3047:}
;3048:
;3049:/*
;3050:==================
;3051:BotTeamFlagCarrierVisible
;3052:==================
;3053:*/
;3054:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 3059
;3055:	int i;
;3056:	float vis;
;3057:	aas_entityinfo_t entinfo;
;3058:
;3059:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1040
JUMPV
LABELV $1037
line 3060
;3060:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1041
line 3061
;3061:			continue;
ADDRGP4 $1038
JUMPV
LABELV $1041
line 3063
;3062:		//
;3063:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3065
;3064:		//if this player is active
;3065:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1043
line 3066
;3066:			continue;
ADDRGP4 $1038
JUMPV
LABELV $1043
line 3068
;3067:		//if this player is carrying a flag
;3068:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1045
line 3069
;3069:			continue;
ADDRGP4 $1038
JUMPV
LABELV $1045
line 3071
;3070:		//if the flag carrier is not on the same team
;3071:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1047
line 3072
;3072:			continue;
ADDRGP4 $1038
JUMPV
LABELV $1047
line 3074
;3073:		//if the flag carrier is not visible
;3074:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3075
;3075:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1049
line 3076
;3076:			continue;
ADDRGP4 $1038
JUMPV
LABELV $1049
line 3078
;3077:		//
;3078:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1036
JUMPV
LABELV $1038
line 3059
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1040
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1051
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1037
LABELV $1051
line 3080
;3079:	}
;3080:	return -1;
CNSTI4 -1
RETI4
LABELV $1036
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3088
;3081:}
;3082:
;3083:/*
;3084:==================
;3085:BotTeamFlagCarrier
;3086:==================
;3087:*/
;3088:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3092
;3089:	int i;
;3090:	aas_entityinfo_t entinfo;
;3091:
;3092:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1056
JUMPV
LABELV $1053
line 3093
;3093:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1057
line 3094
;3094:			continue;
ADDRGP4 $1054
JUMPV
LABELV $1057
line 3096
;3095:		//
;3096:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3098
;3097:		//if this player is active
;3098:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1059
line 3099
;3099:			continue;
ADDRGP4 $1054
JUMPV
LABELV $1059
line 3101
;3100:		//if this player is carrying a flag
;3101:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1061
line 3102
;3102:			continue;
ADDRGP4 $1054
JUMPV
LABELV $1061
line 3104
;3103:		//if the flag carrier is not on the same team
;3104:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1063
line 3105
;3105:			continue;
ADDRGP4 $1054
JUMPV
LABELV $1063
line 3107
;3106:		//
;3107:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1052
JUMPV
LABELV $1054
line 3092
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1056
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1065
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1053
LABELV $1065
line 3109
;3108:	}
;3109:	return -1;
CNSTI4 -1
RETI4
LABELV $1052
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3117
;3110:}
;3111:
;3112:/*
;3113:==================
;3114:BotEnemyFlagCarrierVisible
;3115:==================
;3116:*/
;3117:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3122
;3118:	int i;
;3119:	float vis;
;3120:	aas_entityinfo_t entinfo;
;3121:
;3122:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1070
JUMPV
LABELV $1067
line 3123
;3123:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1071
line 3124
;3124:			continue;
ADDRGP4 $1068
JUMPV
LABELV $1071
line 3126
;3125:		//
;3126:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3128
;3127:		//if this player is active
;3128:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1073
line 3129
;3129:			continue;
ADDRGP4 $1068
JUMPV
LABELV $1073
line 3131
;3130:		//if this player is carrying a flag
;3131:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1075
line 3132
;3132:			continue;
ADDRGP4 $1068
JUMPV
LABELV $1075
line 3134
;3133:		//if the flag carrier is on the same team
;3134:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1077
line 3135
;3135:			continue;
ADDRGP4 $1068
JUMPV
LABELV $1077
line 3137
;3136:		//if the flag carrier is not visible
;3137:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3138
;3138:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1079
line 3139
;3139:			continue;
ADDRGP4 $1068
JUMPV
LABELV $1079
line 3141
;3140:		//
;3141:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1066
JUMPV
LABELV $1068
line 3122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1070
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1081
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1067
LABELV $1081
line 3143
;3142:	}
;3143:	return -1;
CNSTI4 -1
RETI4
LABELV $1066
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3151
;3144:}
;3145:
;3146:/*
;3147:==================
;3148:BotVisibleTeamMatesAndEnemies
;3149:==================
;3150:*/
;3151:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3157
;3152:	int i;
;3153:	float vis;
;3154:	aas_entityinfo_t entinfo;
;3155:	vec3_t dir;
;3156:
;3157:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1083
line 3158
;3158:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1083
line 3159
;3159:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1085
line 3160
;3160:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1085
line 3161
;3161:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1090
JUMPV
LABELV $1087
line 3162
;3162:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1091
line 3163
;3163:			continue;
ADDRGP4 $1088
JUMPV
LABELV $1091
line 3165
;3164:		//
;3165:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3167
;3166:		//if this player is active
;3167:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1093
line 3168
;3168:			continue;
ADDRGP4 $1088
JUMPV
LABELV $1093
line 3170
;3169:		//if this player is carrying a flag
;3170:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1095
line 3171
;3171:			continue;
ADDRGP4 $1088
JUMPV
LABELV $1095
line 3173
;3172:		//if not within range
;3173:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3174
;3174:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1104
line 3175
;3175:			continue;
ADDRGP4 $1088
JUMPV
LABELV $1104
line 3177
;3176:		//if the flag carrier is not visible
;3177:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3178
;3178:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1106
line 3179
;3179:			continue;
ADDRGP4 $1088
JUMPV
LABELV $1106
line 3181
;3180:		//if the flag carrier is on the same team
;3181:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1108
line 3182
;3182:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1109
line 3183
;3183:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3184
;3184:		}
ADDRGP4 $1109
JUMPV
LABELV $1108
line 3185
;3185:		else {
line 3186
;3186:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1112
line 3187
;3187:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1112
line 3188
;3188:		}
LABELV $1109
line 3189
;3189:	}
LABELV $1088
line 3161
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1090
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1114
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1087
LABELV $1114
line 3190
;3190:}
LABELV $1082
endproc BotVisibleTeamMatesAndEnemies 192 20
lit
align 4
LABELV $1116
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1117
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1144 52
line 3261
;3191:
;3192:#ifdef MISSIONPACK
;3193:/*
;3194:==================
;3195:BotTeamCubeCarrierVisible
;3196:==================
;3197:*/
;3198:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
;3199:	int i;
;3200:	float vis;
;3201:	aas_entityinfo_t entinfo;
;3202:
;3203:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;3204:		if (i == bs->client) continue;
;3205:		//
;3206:		BotEntityInfo(i, &entinfo);
;3207:		//if this player is active
;3208:		if (!entinfo.valid) continue;
;3209:		//if this player is carrying a flag
;3210:		if (!EntityCarriesCubes(&entinfo)) continue;
;3211:		//if the flag carrier is not on the same team
;3212:		if (!BotSameTeam(bs, i)) continue;
;3213:		//if the flag carrier is not visible
;3214:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3215:		if (vis <= 0) continue;
;3216:		//
;3217:		return i;
;3218:	}
;3219:	return -1;
;3220:}
;3221:
;3222:/*
;3223:==================
;3224:BotEnemyCubeCarrierVisible
;3225:==================
;3226:*/
;3227:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
;3228:	int i;
;3229:	float vis;
;3230:	aas_entityinfo_t entinfo;
;3231:
;3232:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;3233:		if (i == bs->client)
;3234:			continue;
;3235:		//
;3236:		BotEntityInfo(i, &entinfo);
;3237:		//if this player is active
;3238:		if (!entinfo.valid)
;3239:			continue;
;3240:		//if this player is carrying a flag
;3241:		if (!EntityCarriesCubes(&entinfo)) continue;
;3242:		//if the flag carrier is on the same team
;3243:		if (BotSameTeam(bs, i))
;3244:			continue;
;3245:		//if the flag carrier is not visible
;3246:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3247:		if (vis <= 0)
;3248:			continue;
;3249:		//
;3250:		return i;
;3251:	}
;3252:	return -1;
;3253:}
;3254:#endif
;3255:
;3256:/*
;3257:==================
;3258:BotAimAtEnemy
;3259:==================
;3260:*/
;3261:void BotAimAtEnemy(bot_state_t *bs) {
line 3265
;3262:	int i, enemyvisible;
;3263:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3264:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3265:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1116
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1117
INDIRB
ASGNB 12
line 3273
;3266:	weaponinfo_t wi;
;3267:	aas_entityinfo_t entinfo;
;3268:	bot_goal_t goal;
;3269:	bsp_trace_t trace;
;3270:	vec3_t target;
;3271:
;3272:	//if the bot has no enemy
;3273:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1118
line 3274
;3274:		return;
ADDRGP4 $1115
JUMPV
LABELV $1118
line 3277
;3275:	}
;3276:	//get the enemy entity information
;3277:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3279
;3278:	//if this is not a player (should be an obelisk)
;3279:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1120
line 3281
;3280:		//if the obelisk is visible
;3281:		VectorCopy(entinfo.origin, target);
ADDRLP4 828
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3290
;3282:#ifdef MISSIONPACK
;3283:		// if attacking an obelisk
;3284:		if ( bs->enemy == redobelisk.entitynum ||
;3285:			bs->enemy == blueobelisk.entitynum ) {
;3286:			target[2] += 32;
;3287:		}
;3288:#endif
;3289:		//aim at the obelisk
;3290:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3291
;3291:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3293
;3292:		//set the aim target before trying to attack
;3293:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 828
INDIRB
ASGNB 12
line 3294
;3294:		return;
ADDRGP4 $1115
JUMPV
LABELV $1120
line 3299
;3295:	}
;3296:	//
;3297:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3298:	//
;3299:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3300
;3300:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3302
;3301:	//
;3302:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1127
line 3304
;3303:		//don't aim too early
;3304:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
CNSTF4 1056964608
ADDRLP4 992
INDIRF4
MULF4
ASGNF4
line 3305
;3305:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1129
ADDRGP4 $1115
JUMPV
LABELV $1129
line 3306
;3306:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1131
ADDRGP4 $1115
JUMPV
LABELV $1131
line 3307
;3307:	}
LABELV $1127
line 3310
;3308:
;3309:	//get the weapon information
;3310:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3312
;3311:	//get the weapon specific aim accuracy and or aim skill
;3312:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1133
line 3313
;3313:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3314
;3314:	}
ADDRGP4 $1134
JUMPV
LABELV $1133
line 3315
;3315:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1136
line 3316
;3316:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3317
;3317:	}
ADDRGP4 $1137
JUMPV
LABELV $1136
line 3318
;3318:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1139
line 3319
;3319:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3320
;3320:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3321
;3321:	}
ADDRGP4 $1140
JUMPV
LABELV $1139
line 3322
;3322:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1142
line 3323
;3323:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3324
;3324:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3325
;3325:	}
ADDRGP4 $1143
JUMPV
LABELV $1142
line 3326
;3326:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1145
line 3327
;3327:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3328
;3328:	}
ADDRGP4 $1146
JUMPV
LABELV $1145
line 3329
;3329:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1148
line 3330
;3330:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3331
;3331:	}
ADDRGP4 $1149
JUMPV
LABELV $1148
line 3332
;3332:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1151
line 3333
;3333:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3334
;3334:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3335
;3335:	}
ADDRGP4 $1152
JUMPV
LABELV $1151
line 3336
;3336:	else if (wi.number == WP_BFG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1154
line 3337
;3337:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3338
;3338:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3339
;3339:	}
LABELV $1154
LABELV $1152
LABELV $1149
LABELV $1146
LABELV $1143
LABELV $1140
LABELV $1137
LABELV $1134
line 3341
;3340:	//
;3341:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1157
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1157
line 3343
;3342:	//get the enemy entity information
;3343:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3345
;3344:	//if the enemy is invisible then shoot crappy most of the time
;3345:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1159
line 3346
;3346:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1036831949
LEF4 $1161
ADDRLP4 156
CNSTF4 1053609165
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
LABELV $1161
line 3347
;3347:	}
LABELV $1159
line 3349
;3348:	//
;3349:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3350
;3350:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 1000
CNSTF4 1065353216
ASGNF4
ADDRLP4 712
ADDRLP4 712
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3352
;3351:	//enemy origin and velocity is remembered every 0.5 seconds
;3352:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1182
line 3354
;3353:		//
;3354:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3355
;3355:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6232
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3356
;3356:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6244
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3357
;3357:	}
LABELV $1182
line 3359
;3358:	//if not extremely skilled
;3359:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1185
line 3360
;3360:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3362
;3361:		//if the enemy moved a bit
;3362:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1158676480
LEF4 $1194
line 3364
;3363:			//if the enemy changed direction
;3364:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6232
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1012
INDIRP4
CNSTI4 6236
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1012
INDIRP4
CNSTI4 6240
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1196
line 3366
;3365:				//aim accuracy should be worse now
;3366:				aim_accuracy *= 0.7f;
ADDRLP4 156
CNSTF4 1060320051
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
line 3367
;3367:			}
LABELV $1196
line 3368
;3368:		}
LABELV $1194
line 3369
;3369:	}
LABELV $1185
line 3371
;3370:	//check visibility of enemy
;3371:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1004
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 824
ADDRLP4 1008
INDIRF4
CVFI4 4
ASGNI4
line 3373
;3372:	//if the enemy is visible
;3373:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1200
line 3375
;3374:		//
;3375:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3376
;3376:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3379
;3377:		//get the start point shooting from
;3378:		//NOTE: the x and y projectile start offsets are ignored
;3379:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3380
;3380:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3381
;3381:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3383
;3382:		//
;3383:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3385
;3384:		//if the enemy is NOT hit
;3385:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1208
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1208
line 3386
;3386:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3387
;3387:		}
LABELV $1208
line 3389
;3388:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3389:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1214
line 3391
;3390:			//
;3391:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3392
;3392:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3393
;3393:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3395
;3394:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3395:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1230
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1149239296
LTF4 $1228
LABELV $1230
line 3397
;3396:				//if skilled anough do exact prediction
;3397:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1231
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1231
line 3399
;3398:						//if the weapon is ready to fire
;3399:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3403
;3400:					aas_clientmove_t move;
;3401:					vec3_t origin;
;3402:
;3403:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3405
;3404:					//distance towards the enemy
;3405:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1128
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1128
INDIRF4
ASGNF4
line 3407
;3406:					//direction the enemy is moving in
;3407:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3409
;3408:					//
;3409:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 1132
CNSTF4 1065353216
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3411
;3410:					//
;3411:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1028
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3412
;3412:					origin[2] += 1;
ADDRLP4 1028+8
ADDRLP4 1028+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3414
;3413:					//
;3414:					VectorClear(cmdmove);
ADDRLP4 1136
CNSTF4 0
ASGNF4
ADDRLP4 968+8
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968+4
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968
ADDRLP4 1136
INDIRF4
ASGNF4
line 3416
;3415:					//AAS_ClearShownDebugLines();
;3416:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1040
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1140
CNSTI4 0
ASGNI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
ADDRLP4 1140
INDIRI4
ARGI4
CNSTF4 1092616192
ADDRLP4 840
INDIRF4
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3420
;3417:														PRESENCE_CROUCH, qfalse,
;3418:														dir, cmdmove, 0,
;3419:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3420:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1040
INDIRB
ASGNB 12
line 3422
;3421:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3422:				}
ADDRGP4 $1232
JUMPV
LABELV $1231
line 3424
;3423:				//if not that skilled do linear prediction
;3424:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1264
line 3425
;3425:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3427
;3426:					//distance towards the enemy
;3427:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1032
INDIRF4
ASGNF4
line 3429
;3428:					//direction the enemy is moving in
;3429:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3430
;3430:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3432
;3431:					//
;3432:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1036
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1036
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3435
;3433:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3434:					//best spot to aim at
;3435:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1040
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1044
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3436
;3436:				}
LABELV $1264
LABELV $1232
line 3437
;3437:			}
LABELV $1228
line 3438
;3438:		}
LABELV $1214
line 3440
;3439:		//if the projectile does radial damage
;3440:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1299
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1299
line 3442
;3441:			//if the enemy isn't standing significantly higher than the bot
;3442:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1303
line 3444
;3443:				//try to aim at the ground in front of the enemy
;3444:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3445
;3445:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3446
;3446:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 1012
CNSTP4 0
ASGNP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3448
;3447:				//
;3448:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3449
;3449:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $1311
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $1312
JUMPV
LABELV $1311
line 3450
;3450:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $1312
line 3452
;3451:				//trace a line from projectile start to ground target
;3452:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3454
;3453:				//if hitpoint is not vertically too far from the ground target
;3454:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1020
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1112014848
GEF4 $1320
line 3455
;3455:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3457
;3456:					//if the hitpoint is near anough the ground target
;3457:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1163984896
GEF4 $1334
line 3458
;3458:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3460
;3459:						//if the hitpoint is far anough from the bot
;3460:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1028
INDIRF4
CNSTF4 1176256512
LEF4 $1345
line 3462
;3461:							//check if the bot is visible from the ground target
;3462:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3463
;3463:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
ADDRLP4 1032
CNSTP4 0
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3464
;3464:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $1352
line 3466
;3465:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3466:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3467
;3467:							}
LABELV $1352
line 3468
;3468:						}
LABELV $1345
line 3469
;3469:					}
LABELV $1334
line 3470
;3470:				}
LABELV $1320
line 3471
;3471:			}
LABELV $1303
line 3472
;3472:		}
LABELV $1299
line 3473
;3473:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3474
;3474:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3475
;3475:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1020
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 1020
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3476
;3476:	}
ADDRGP4 $1201
JUMPV
LABELV $1200
line 3477
;3477:	else {
line 3479
;3478:		//
;3479:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 3480
;3480:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3482
;3481:		//if the bot is skilled anough
;3482:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $1358
line 3484
;3483:			//do prediction shots around corners
;3484:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $1366
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $1366
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1360
LABELV $1366
line 3486
;3485:				wi.number == WP_ROCKET_LAUNCHER ||
;3486:				wi.number == WP_GRENADE_LAUNCHER) {
line 3488
;3487:				//create the chase goal
;3488:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3489
;3489:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3490
;3490:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRB
ASGNB 12
line 3491
;3491:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3492
;3492:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3494
;3493:				//
;3494:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6548
ADDP4
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 828
ARGP4
ADDRLP4 1016
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1016
INDIRI4
CNSTI4 0
EQI4 $1379
line 3495
;3495:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3496
;3496:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1170735104
LEF4 $1385
line 3497
;3497:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 828
INDIRB
ASGNB 12
line 3498
;3498:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3499
;3499:					}
LABELV $1385
line 3500
;3500:				}
LABELV $1379
line 3501
;3501:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3502
;3502:			}
LABELV $1360
line 3503
;3503:		}
LABELV $1358
line 3504
;3504:	}
LABELV $1201
line 3506
;3505:	//
;3506:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1388
line 3507
;3507:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3508
;3508:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3509
;3509:	}
ADDRGP4 $1389
JUMPV
LABELV $1388
line 3510
;3510:	else {
line 3511
;3511:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3512
;3512:	}
LABELV $1389
line 3514
;3513:	//get aim direction
;3514:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3516
;3515:	//
;3516:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $1403
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $1403
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $1403
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1395
LABELV $1403
line 3519
;3517:		wi.number == WP_SHOTGUN ||
;3518:		wi.number == WP_LIGHTNING ||
;3519:		wi.number == WP_RAILGUN) {
line 3521
;3520:		//distance towards the enemy
;3521:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3522
;3522:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $1404
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $1404
line 3523
;3523:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
CNSTF4 1053609165
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
DIVF4
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3524
;3524:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3525
;3525:	}
LABELV $1395
line 3527
;3526:	//add some random stuff to the aim direction depending on the aim accuracy
;3527:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $1406
line 3528
;3528:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3529
;3529:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $1408
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1050253722
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $1409
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $1408
line 3530
;3530:	}
LABELV $1406
line 3532
;3531:	//set the ideal view angles
;3532:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3534
;3533:	//take the weapon spread into account for lower skilled bots
;3534:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+268
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3535
;3535:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1028
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1024
INDIRP4
ADDRLP4 1028
INDIRF4
ASGNF4
line 3536
;3536:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1032
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+264
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1032
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3537
;3537:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1044
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1040
INDIRP4
ADDRLP4 1044
INDIRF4
ASGNF4
line 3539
;3538:	//if the bots should be really challenging
;3539:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $1414
line 3541
;3540:		//if the bot is really accurate and has the enemy in view for some time
;3541:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $1417
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1417
line 3543
;3542:			//set the view angles directly
;3543:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $1419
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1419
line 3544
;3544:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 6564
ADDP4
ADDRLP4 1052
INDIRP4
CNSTI4 6576
ADDP4
INDIRB
ASGNB 12
line 3545
;3545:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3546
;3546:		}
LABELV $1417
line 3547
;3547:	}
LABELV $1414
line 3548
;3548:}
LABELV $1115
endproc BotAimAtEnemy 1144 52
lit
align 4
LABELV $1422
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1423
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1028 28
line 3555
;3549:
;3550:/*
;3551:==================
;3552:BotCheckAttack
;3553:==================
;3554:*/
;3555:void BotCheckAttack(bot_state_t *bs) {
line 3564
;3556:	float points, reactiontime, fov, firethrottle;
;3557:	int attackentity;
;3558:	bsp_trace_t bsptrace;
;3559:	//float selfpreservation;
;3560:	vec3_t forward, right, start, end, dir, angles;
;3561:	weaponinfo_t wi;
;3562:	bsp_trace_t trace;
;3563:	aas_entityinfo_t entinfo;
;3564:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 808
ADDRGP4 $1422
INDIRB
ASGNB 12
ADDRLP4 820
ADDRGP4 $1423
INDIRB
ASGNB 12
line 3566
;3565:
;3566:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 3568
;3567:	//
;3568:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 832
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3570
;3569:	// if not attacking a player
;3570:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1424
line 3582
;3571:#ifdef MISSIONPACK
;3572:		// if attacking an obelisk
;3573:		if ( entinfo.number == redobelisk.entitynum ||
;3574:			entinfo.number == blueobelisk.entitynum ) {
;3575:			// if obelisk is respawning return
;3576:			if ( g_entities[entinfo.number].activator &&
;3577:				g_entities[entinfo.number].activator->s.frame == 2 ) {
;3578:				return;
;3579:			}
;3580:		}
;3581:#endif
;3582:	}
LABELV $1424
line 3584
;3583:	//
;3584:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 976
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 700
ADDRLP4 976
INDIRF4
ASGNF4
line 3585
;3585:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $1426
ADDRGP4 $1421
JUMPV
LABELV $1426
line 3586
;3586:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $1428
ADDRGP4 $1421
JUMPV
LABELV $1428
line 3588
;3587:	//if changing weapons
;3588:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $1430
ADDRGP4 $1421
JUMPV
LABELV $1430
line 3590
;3589:	//check fire throttle characteristic
;3590:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1432
ADDRGP4 $1421
JUMPV
LABELV $1432
line 3591
;3591:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 792
ADDRLP4 980
INDIRF4
ASGNF4
line 3592
;3592:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1434
line 3593
;3593:		if (random() > firethrottle) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 792
INDIRF4
LEF4 $1436
line 3594
;3594:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 792
INDIRF4
ADDF4
ASGNF4
line 3595
;3595:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
CNSTF4 0
ASGNF4
line 3596
;3596:		}
ADDRGP4 $1437
JUMPV
LABELV $1436
line 3597
;3597:		else {
line 3598
;3598:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 792
INDIRF4
SUBF4
ASGNF4
line 3599
;3599:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
CNSTF4 0
ASGNF4
line 3600
;3600:		}
LABELV $1437
line 3601
;3601:	}
LABELV $1434
line 3604
;3602:	//
;3603:	//
;3604:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 984
INDIRP4
CNSTI4 6220
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 984
INDIRP4
CNSTI4 6224
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 988
INDIRP4
CNSTI4 6228
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3606
;3605:	//
;3606:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1440
line 3607
;3607:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1163984896
LEF4 $1442
line 3608
;3608:			return;
ADDRGP4 $1421
JUMPV
LABELV $1442
line 3610
;3609:		}
;3610:	}
LABELV $1440
line 3611
;3611:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1176256512
GEF4 $1444
line 3612
;3612:		fov = 120;
ADDRLP4 788
CNSTF4 1123024896
ASGNF4
ADDRGP4 $1445
JUMPV
LABELV $1444
line 3614
;3613:	else
;3614:		fov = 50;
ADDRLP4 788
CNSTF4 1112014848
ASGNF4
LABELV $1445
line 3616
;3615:	//
;3616:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 796
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3617
;3617:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 788
INDIRF4
ARGF4
ADDRLP4 796
ARGP4
ADDRLP4 996
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
NEI4 $1446
line 3618
;3618:		return;
ADDRGP4 $1421
JUMPV
LABELV $1446
line 3619
;3619:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 704
ARGP4
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1004
CNSTP4 0
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6220
ADDP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3620
;3620:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 704+8
INDIRF4
CNSTF4 1065353216
GEF4 $1448
ADDRLP4 704+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1448
line 3621
;3621:		return;
ADDRGP4 $1421
JUMPV
LABELV $1448
line 3624
;3622:
;3623:	//get the weapon info
;3624:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3626
;3625:	//get the start point shooting from
;3626:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3627
;3627:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3628
;3628:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3629
;3629:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3630
;3630:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3631
;3631:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3633
;3632:	//end point aiming at
;3633:	VectorMA(start, 1000, forward, end);
ADDRLP4 1012
CNSTF4 1148846080
ASGNF4
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1148846080
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3635
;3634:	//a little back to make sure not inside a very close enemy
;3635:	VectorMA(start, -12, forward, start);
ADDRLP4 1016
CNSTF4 3242196992
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3242196992
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3636
;3636:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 808
ARGP4
ADDRLP4 820
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3638
;3637:	//if the entity is a client
;3638:	if (trace.ent > 0 && trace.ent <= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LEI4 $1482
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GTI4 $1482
line 3639
;3639:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1486
line 3641
;3640:			//if a teammate is hit
;3641:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1020
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1020
INDIRI4
CNSTI4 0
EQI4 $1489
line 3642
;3642:				return;
ADDRGP4 $1421
JUMPV
LABELV $1489
line 3643
;3643:		}
LABELV $1486
line 3644
;3644:	}
LABELV $1482
line 3646
;3645:	//if won't hit the enemy or not attacking a player (obelisk)
;3646:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $1495
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1492
LABELV $1495
line 3648
;3647:		//if the projectile does radial damage
;3648:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1496
line 3649
;3649:			if (trace.fraction * 1000 < wi.proj.radius) {
CNSTF4 1148846080
ADDRLP4 592+8
INDIRF4
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $1500
line 3650
;3650:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 1024
CNSTF4 1056964608
ASGNF4
ADDRLP4 972
ADDRLP4 1024
INDIRF4
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 1024
INDIRF4
ADDRLP4 592+8
INDIRF4
MULF4
MULF4
SUBF4
MULF4
ASGNF4
line 3651
;3651:				if (points > 0) {
ADDRLP4 972
INDIRF4
CNSTF4 0
LEF4 $1508
line 3652
;3652:					return;
ADDRGP4 $1421
JUMPV
LABELV $1508
line 3654
;3653:				}
;3654:			}
LABELV $1500
line 3656
;3655:			//FIXME: check if a teammate gets radial damage
;3656:		}
LABELV $1496
line 3657
;3657:	}
LABELV $1492
line 3659
;3658:	//if fire has to be release to activate weapon
;3659:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1510
line 3660
;3660:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1511
line 3661
;3661:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3662
;3662:		}
line 3663
;3663:	}
ADDRGP4 $1511
JUMPV
LABELV $1510
line 3664
;3664:	else {
line 3665
;3665:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3666
;3666:	}
LABELV $1511
line 3667
;3667:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
ADDRLP4 1024
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3668
;3668:}
LABELV $1421
endproc BotCheckAttack 1028 28
lit
align 4
LABELV $1521
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $1522
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $1523
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 1424 16
line 3675
;3669:
;3670:/*
;3671:==================
;3672:BotMapScripts
;3673:==================
;3674:*/
;3675:void BotMapScripts(bot_state_t *bs) {
line 3683
;3676:	char info[1024];
;3677:	char mapname[128];
;3678:	int i, shootbutton;
;3679:	float aim_accuracy;
;3680:	aas_entityinfo_t entinfo;
;3681:	vec3_t dir;
;3682:
;3683:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 3685
;3684:
;3685:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 272
ARGP4
ADDRGP4 $1516
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 144
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 3686
;3686:	mapname[sizeof(mapname)-1] = '\0';
ADDRLP4 144+127
CNSTI1 0
ASGNI1
line 3688
;3687:
;3688:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $1520
ARGP4
ADDRLP4 1320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $1518
line 3689
;3689:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 1324
ADDRGP4 $1521
INDIRB
ASGNB 12
ADDRLP4 1336
ADDRGP4 $1522
INDIRB
ASGNB 12
line 3690
;3690:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 1348
ADDRGP4 $1523
INDIRB
ASGNB 12
line 3692
;3691:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3692:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1360
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 1360
INDIRP4
ADDRLP4 1360
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3694
;3693:		//if the bot is below the bounding box
;3694:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 1364
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1364
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $1524
ADDRLP4 1364
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $1524
line 3695
;3695:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 1368
ADDRFP4 0
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1368
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $1526
ADDRLP4 1368
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $1526
line 3696
;3696:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $1530
line 3697
;3697:					return;
ADDRGP4 $1515
JUMPV
LABELV $1530
line 3699
;3698:				}
;3699:			}
LABELV $1526
line 3700
;3700:		}
LABELV $1524
line 3701
;3701:		shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3703
;3702:		//if an enemy is below this bounding box then shoot the button
;3703:		for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1536
JUMPV
LABELV $1533
line 3705
;3704:
;3705:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1537
ADDRGP4 $1534
JUMPV
LABELV $1537
line 3707
;3706:			//
;3707:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3709
;3708:			//
;3709:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1539
ADDRGP4 $1534
JUMPV
LABELV $1539
line 3711
;3710:			//if the enemy isn't dead and the enemy isn't the bot self
;3711:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1368
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 1368
INDIRI4
CNSTI4 0
NEI4 $1544
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1541
LABELV $1544
ADDRGP4 $1534
JUMPV
LABELV $1541
line 3713
;3712:			//
;3713:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $1545
ADDRLP4 0+24
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $1545
line 3714
;3714:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $1549
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $1549
line 3715
;3715:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $1557
line 3717
;3716:						//if there's a team mate below the crusher
;3717:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 1372
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1372
INDIRI4
CNSTI4 0
EQI4 $1562
line 3718
;3718:							shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3719
;3719:							break;
ADDRGP4 $1535
JUMPV
LABELV $1562
line 3721
;3720:						}
;3721:						else {
line 3722
;3722:							shootbutton = qtrue;
ADDRLP4 1296
CNSTI4 1
ASGNI4
line 3723
;3723:						}
line 3724
;3724:					}
LABELV $1557
line 3725
;3725:				}
LABELV $1549
line 3726
;3726:			}
LABELV $1545
line 3727
;3727:		}
LABELV $1534
line 3703
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1536
ADDRLP4 140
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1564
ADDRLP4 140
INDIRI4
CNSTI4 64
LTI4 $1533
LABELV $1564
LABELV $1535
line 3728
;3728:		if (shootbutton) {
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $1519
line 3729
;3729:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 1372
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1372
INDIRP4
ADDRLP4 1372
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3730
;3730:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 1376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
ADDRLP4 1348
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+4
ADDRLP4 1348+4
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+8
ADDRLP4 1348+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3731
;3731:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 1300
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3732
;3732:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1380
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 1312
ADDRLP4 1380
INDIRF4
ASGNF4
line 3733
;3733:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1384
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1388
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1388
INDIRP4
ADDRLP4 1388
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1384
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3734
;3734:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1392
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1392
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1396
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1392
INDIRP4
ADDRLP4 1396
INDIRF4
ASGNF4
line 3735
;3735:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1400
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1404
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1404
INDIRP4
ADDRLP4 1404
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1400
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3736
;3736:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1408
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1408
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1412
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1408
INDIRP4
ADDRLP4 1412
INDIRF4
ASGNF4
line 3738
;3737:			//
;3738:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 1416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1416
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 1416
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRLP4 1420
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1420
INDIRI4
CNSTI4 0
EQI4 $1519
line 3739
;3739:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3740
;3740:			}
line 3741
;3741:		}
line 3742
;3742:	}
ADDRGP4 $1519
JUMPV
LABELV $1518
line 3743
;3743:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $1575
ARGP4
ADDRLP4 1324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
NEI4 $1573
line 3745
;3744:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;3745:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 1328
INDIRP4
ADDRLP4 1328
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3746
;3746:	}
LABELV $1573
LABELV $1519
line 3747
;3747:}
LABELV $1515
endproc BotMapScripts 1424 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 12 16
line 3760
;3748:
;3749:/*
;3750:==================
;3751:BotSetMovedir
;3752:==================
;3753:*/
;3754:// bk001205 - made these static
;3755:static vec3_t VEC_UP		= {0, -1,  0};
;3756:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;3757:static vec3_t VEC_DOWN		= {0, -2,  0};
;3758:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;3759:
;3760:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3761
;3761:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1577
line 3762
;3762:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3763
;3763:	}
ADDRGP4 $1578
JUMPV
LABELV $1577
line 3764
;3764:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1579
line 3765
;3765:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3766
;3766:	}
ADDRGP4 $1580
JUMPV
LABELV $1579
line 3767
;3767:	else {
line 3768
;3768:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3769
;3769:	}
LABELV $1580
LABELV $1578
line 3770
;3770:}
LABELV $1576
endproc BotSetMovedir 12 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 3779
;3771:
;3772:/*
;3773:==================
;3774:BotModelMinsMaxs
;3775:
;3776:this is ugly
;3777:==================
;3778:*/
;3779:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 3783
;3780:	gentity_t *ent;
;3781:	int i;
;3782:
;3783:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 3784
;3784:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1585
JUMPV
LABELV $1582
line 3785
;3785:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1587
line 3786
;3786:			continue;
ADDRGP4 $1583
JUMPV
LABELV $1587
line 3788
;3787:		}
;3788:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1589
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1589
line 3789
;3789:			continue;
ADDRGP4 $1583
JUMPV
LABELV $1589
line 3791
;3790:		}
;3791:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1591
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1591
line 3792
;3792:			continue;
ADDRGP4 $1583
JUMPV
LABELV $1591
line 3794
;3793:		}
;3794:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1593
line 3795
;3795:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1595
line 3796
;3796:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1595
line 3797
;3797:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1597
line 3798
;3798:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1597
line 3799
;3799:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $1581
JUMPV
LABELV $1593
line 3801
;3800:		}
;3801:	}
LABELV $1583
line 3784
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
LABELV $1585
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1582
line 3802
;3802:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1599
line 3803
;3803:		VectorClear(mins);
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
LABELV $1599
line 3804
;3804:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1601
line 3805
;3805:		VectorClear(maxs);
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
LABELV $1601
line 3806
;3806:	return 0;
CNSTI4 0
RETI4
LABELV $1581
endproc BotModelMinsMaxs 40 0
lit
align 4
LABELV $1604
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $1605
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 648 28
line 3814
;3807:}
;3808:
;3809:/*
;3810:==================
;3811:BotFuncButtonGoal
;3812:==================
;3813:*/
;3814:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3820
;3815:	int i, areas[10], numareas, modelindex, entitynum;
;3816:	char model[128];
;3817:	float lip, dist, health, angle;
;3818:	vec3_t size, start, end, mins, maxs, angles, points[10];
;3819:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;3820:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $1604
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $1605
INDIRB
ASGNB 12
line 3823
;3821:	bsp_trace_t bsptrace;
;3822:
;3823:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3824
;3824:	VectorClear(activategoal->target);
ADDRLP4 560
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 564
CNSTF4 0
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
line 3826
;3825:	//create a bot goal towards the button
;3826:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3827
;3827:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1606
line 3828
;3828:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1606
line 3829
;3829:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 568
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 568
INDIRI4
ASGNI4
line 3830
;3830:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $1609
line 3831
;3831:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1609
line 3832
;3832:	VectorClear(angles);
ADDRLP4 572
CNSTF4 0
ASGNF4
ADDRLP4 96+8
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96
ADDRLP4 572
INDIRF4
ASGNF4
line 3833
;3833:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 576
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 576
INDIRI4
ASGNI4
line 3835
;3834:	//get the lip of the button
;3835:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1613
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3836
;3836:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $1614
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $1614
line 3838
;3837:	//get the move direction from the angle
;3838:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1616
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3839
;3839:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3840
;3840:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 3842
;3841:	//button size
;3842:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3844
;3843:	//button origin
;3844:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 3845
;3845:	VectorScale(origin, 0.5, origin);
ADDRLP4 580
CNSTF4 1056964608
ASGNF4
ADDRLP4 16
ADDRLP4 580
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 580
INDIRF4
ADDRLP4 16+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1056964608
ADDRLP4 16+8
INDIRF4
MULF4
ASGNF4
line 3847
;3846:	//touch distance of the button
;3847:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 584
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 588
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 592
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3848
;3848:	dist *= 0.5;
ADDRLP4 28
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 3850
;3849:	//
;3850:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1639
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3852
;3851:	//if the button is shootable
;3852:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $1640
line 3854
;3853:		//calculate the shoot target
;3854:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 596
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3856
;3855:		//
;3856:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 3857
;3857:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3859
;3858:		//
;3859:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 600
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 600
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 604
CNSTP4 0
ASGNP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 600
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3861
;3860:		// if the button is visible from the current position
;3861:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $1652
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $1648
LABELV $1652
line 3863
;3862:			//
;3863:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3864
;3864:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3865
;3865:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3866
;3866:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3867
;3867:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3868
;3868:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3869
;3869:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3871
;3870:			//
;3871:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1648
line 3873
;3872:		}
;3873:		else {
line 3876
;3874:			//create a goal from where the button is visible and shoot at the button from there
;3875:			//add bounding box size to the dist
;3876:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3877
;3877:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1653
line 3878
;3878:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1657
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1658
JUMPV
LABELV $1657
line 3879
;3879:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1658
line 3880
;3880:			}
LABELV $1654
line 3877
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1653
line 3882
;3881:			//calculate the goal origin
;3882:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 608
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3884
;3883:			//
;3884:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3885
;3885:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3886
;3886:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3887
;3887:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 3888
;3888:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 612
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 612
INDIRI4
ASGNI4
line 3890
;3889:			//
;3890:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1670
JUMPV
LABELV $1667
line 3891
;3891:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 616
INDIRI4
CNSTI4 0
EQI4 $1671
line 3892
;3892:					break;
ADDRGP4 $1669
JUMPV
LABELV $1671
line 3894
;3893:				}
;3894:			}
LABELV $1668
line 3890
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1670
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1667
LABELV $1669
line 3895
;3895:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1673
line 3897
;3896:				// FIXME: trace forward and maybe in other directions to find a valid area
;3897:			}
LABELV $1673
line 3898
;3898:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1675
line 3900
;3899:				//
;3900:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 3901
;3901:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3902
;3902:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 3903
;3903:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 3905
;3904:				//
;3905:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1677
line 3906
;3906:				{
line 3907
;3907:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1681
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 616
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 628
ADDRLP4 616
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 628
INDIRP4
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 620
INDIRF4
ADDRLP4 624
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1682
JUMPV
LABELV $1681
line 3908
;3908:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 632
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 632
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 636
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 640
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 644
ADDRLP4 632
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 644
INDIRP4
ADDRLP4 644
INDIRP4
INDIRF4
ADDRLP4 636
INDIRF4
ADDRLP4 640
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1682
line 3909
;3909:				} //end for
LABELV $1678
line 3905
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1677
line 3911
;3910:				//
;3911:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3912
;3912:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3913
;3913:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3914
;3914:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1675
line 3916
;3915:			}
;3916:		}
line 3917
;3917:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1640
line 3919
;3918:	}
;3919:	else {
line 3921
;3920:		//add bounding box size to the dist
;3921:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3922
;3922:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1683
line 3923
;3923:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1687
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1688
JUMPV
LABELV $1687
line 3924
;3924:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1688
line 3925
;3925:		}
LABELV $1684
line 3922
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1683
line 3927
;3926:		//calculate the goal origin
;3927:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 596
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3929
;3928:		//
;3929:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3930
;3930:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3931
;3931:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3932
;3932:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3933
;3933:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 600
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 600
INDIRI4
ASGNI4
line 3935
;3934:		//
;3935:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1700
JUMPV
LABELV $1697
line 3936
;3936:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 604
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 604
INDIRI4
CNSTI4 0
EQI4 $1701
line 3937
;3937:				break;
ADDRGP4 $1699
JUMPV
LABELV $1701
line 3939
;3938:			}
;3939:		}
LABELV $1698
line 3935
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1700
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $1697
LABELV $1699
line 3940
;3940:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $1703
line 3942
;3941:			//
;3942:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3943
;3943:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3944
;3944:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3945
;3945:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3947
;3946:			//
;3947:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1713
line 3948
;3948:			{
line 3949
;3949:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1717
ADDRLP4 604
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 604
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 616
ADDRLP4 604
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 616
INDIRP4
ADDRLP4 616
INDIRP4
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1718
JUMPV
LABELV $1717
line 3950
;3950:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 620
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 620
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 628
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 632
ADDRLP4 620
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 632
INDIRP4
ADDRLP4 632
INDIRP4
INDIRF4
ADDRLP4 624
INDIRF4
ADDRLP4 628
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1718
line 3951
;3951:			} //end for
LABELV $1714
line 3947
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1713
line 3953
;3952:			//
;3953:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3954
;3954:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3955
;3955:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3956
;3956:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1603
JUMPV
LABELV $1703
line 3958
;3957:		}
;3958:	}
line 3959
;3959:	return qfalse;
CNSTI4 0
RETI4
LABELV $1603
endproc BotFuncButtonActivateGoal 648 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1096 20
line 3967
;3960:}
;3961:
;3962:/*
;3963:==================
;3964:BotFuncDoorGoal
;3965:==================
;3966:*/
;3967:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3973
;3968:	int modelindex, entitynum;
;3969:	char model[MAX_INFO_STRING];
;3970:	vec3_t mins, maxs, origin, angles;
;3971:
;3972:	//shoot at the shootable door
;3973:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3974
;3974:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1720
line 3975
;3975:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1719
JUMPV
LABELV $1720
line 3976
;3976:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1080
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1080
INDIRI4
ASGNI4
line 3977
;3977:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1723
line 3978
;3978:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1719
JUMPV
LABELV $1723
line 3979
;3979:	VectorClear(angles);
ADDRLP4 1084
CNSTF4 0
ASGNF4
ADDRLP4 1064+8
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064+4
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064
ADDRLP4 1084
INDIRF4
ASGNF4
line 3980
;3980:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1088
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1076
ADDRLP4 1088
INDIRI4
ASGNI4
line 3982
;3981:	//door origin
;3982:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 3983
;3983:	VectorScale(origin, 0.5, origin);
ADDRLP4 1092
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 1092
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1092
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1056964608
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 3984
;3984:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 3985
;3985:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3987
;3986:	//
;3987:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 3988
;3988:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3989
;3989:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3990
;3990:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3991
;3991:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3992
;3992:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3993
;3993:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3994
;3994:	return qtrue;
CNSTI4 1
RETI4
LABELV $1719
endproc BotFuncDoorActivateGoal 1096 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 300 20
line 4002
;3995:}
;3996:
;3997:/*
;3998:==================
;3999:BotTriggerMultipleGoal
;4000:==================
;4001:*/
;4002:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4008
;4003:	int i, areas[10], numareas, modelindex, entitynum;
;4004:	char model[128];
;4005:	vec3_t start, end, mins, maxs, angles;
;4006:	vec3_t origin, goalorigin;
;4007:
;4008:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4009
;4009:	VectorClear(activategoal->target);
ADDRLP4 268
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
line 4011
;4010:	//create a bot goal towards the trigger
;4011:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4012
;4012:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1738
line 4013
;4013:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1737
JUMPV
LABELV $1738
line 4014
;4014:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 276
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 276
INDIRI4
ASGNI4
line 4015
;4015:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $1741
line 4016
;4016:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1737
JUMPV
LABELV $1741
line 4017
;4017:	VectorClear(angles);
ADDRLP4 280
CNSTF4 0
ASGNF4
ADDRLP4 240+8
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240+4
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240
ADDRLP4 280
INDIRF4
ASGNF4
line 4018
;4018:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 284
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 284
INDIRI4
ASGNI4
line 4020
;4019:	//trigger origin
;4020:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 4021
;4021:	VectorScale(origin, 0.5, origin);
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
ADDRLP4 4
ADDRLP4 288
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 288
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 1056964608
ADDRLP4 4+8
INDIRF4
MULF4
ASGNF4
line 4022
;4022:	VectorCopy(origin, goalorigin);
ADDRLP4 252
ADDRLP4 4
INDIRB
ASGNB 12
line 4024
;4023:	//
;4024:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 252
INDIRB
ASGNB 12
line 4025
;4025:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4026
;4026:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 4027
;4027:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4028
;4028:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 292
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 292
INDIRI4
ASGNI4
line 4030
;4029:	//
;4030:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1760
JUMPV
LABELV $1757
line 4031
;4031:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $1761
line 4032
;4032:			break;
ADDRGP4 $1759
JUMPV
LABELV $1761
line 4034
;4033:		}
;4034:	}
LABELV $1758
line 4030
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1760
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1757
LABELV $1759
line 4035
;4035:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $1763
line 4036
;4036:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4037
;4037:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 4038
;4038:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4039
;4039:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4041
;4040:		//
;4041:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 4042
;4042:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4043
;4043:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4044
;4044:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1737
JUMPV
LABELV $1763
line 4046
;4045:	}
;4046:	return qfalse;
CNSTI4 0
RETI4
LABELV $1737
endproc BotTriggerMultipleActivateGoal 300 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 4054
;4047:}
;4048:
;4049:/*
;4050:==================
;4051:BotPopFromActivateGoalStack
;4052:==================
;4053:*/
;4054:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 4055
;4055:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1774
line 4056
;4056:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1773
JUMPV
LABELV $1774
line 4057
;4057:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4058
;4058:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 4059
;4059:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4060
;4060:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4061
;4061:	return qtrue;
CNSTI4 1
RETI4
LABELV $1773
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 24 12
line 4069
;4062:}
;4063:
;4064:/*
;4065:==================
;4066:BotPushOntoActivateGoalStack
;4067:==================
;4068:*/
;4069:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4073
;4070:	int i, best;
;4071:	float besttime;
;4072:
;4073:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 4074
;4074:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 4076
;4075:	//
;4076:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1777
line 4077
;4077:		if (!bs->activategoalheap[i].inuse) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1781
line 4078
;4078:			if (bs->activategoalheap[i].justused_time < besttime) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $1783
line 4079
;4079:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 4080
;4080:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4081
;4081:			}
LABELV $1783
line 4082
;4082:		}
LABELV $1781
line 4083
;4083:	}
LABELV $1778
line 4076
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1777
line 4084
;4084:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1785
line 4085
;4085:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 12
CNSTI4 244
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4086
;4086:		bs->activategoalheap[best].inuse = qtrue;
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4087
;4087:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
line 4088
;4088:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 7116
ADDP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
ASGNP4
line 4089
;4089:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1776
JUMPV
LABELV $1785
line 4091
;4090:	}
;4091:	return qfalse;
CNSTI4 0
RETI4
LABELV $1776
endproc BotPushOntoActivateGoalStack 24 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4099
;4092:}
;4093:
;4094:/*
;4095:==================
;4096:BotClearActivateGoalStack
;4097:==================
;4098:*/
;4099:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $1789
JUMPV
LABELV $1788
line 4101
;4100:	while(bs->activatestack)
;4101:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $1789
line 4100
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1788
line 4102
;4102:}
LABELV $1787
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4109
;4103:
;4104:/*
;4105:==================
;4106:BotEnableActivateGoalAreas
;4107:==================
;4108:*/
;4109:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4112
;4110:	int i;
;4111:
;4112:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1795
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $1796
JUMPV
LABELV $1795
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1796
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1792
line 4113
;4113:		return;
ADDRGP4 $1791
JUMPV
LABELV $1792
line 4114
;4114:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1800
JUMPV
LABELV $1797
line 4115
;4115:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $1798
line 4114
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1800
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $1797
line 4116
;4116:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1802
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1803
JUMPV
LABELV $1802
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1803
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4117
;4117:}
LABELV $1791
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4124
;4118:
;4119:/*
;4120:==================
;4121:BotIsGoingToActivateEntity
;4122:==================
;4123:*/
;4124:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4128
;4125:	bot_activategoal_t *a;
;4126:	int i;
;4127:
;4128:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $1808
JUMPV
LABELV $1805
line 4129
;4129:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1809
line 4130
;4130:			continue;
ADDRGP4 $1806
JUMPV
LABELV $1809
line 4131
;4131:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1811
line 4132
;4132:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1804
JUMPV
LABELV $1811
line 4133
;4133:	}
LABELV $1806
line 4128
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $1808
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1805
line 4134
;4134:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1813
line 4135
;4135:		if (bs->activategoalheap[i].inuse)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1817
line 4136
;4136:			continue;
ADDRGP4 $1814
JUMPV
LABELV $1817
line 4138
;4137:		//
;4138:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1819
line 4140
;4139:			// if the bot went for this goal less than 2 seconds ago
;4140:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1821
line 4141
;4141:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1804
JUMPV
LABELV $1821
line 4142
;4142:		}
LABELV $1819
line 4143
;4143:	}
LABELV $1814
line 4134
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $1813
line 4144
;4144:	return qfalse;
CNSTI4 0
RETI4
LABELV $1804
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3320 20
line 4157
;4145:}
;4146:
;4147:/*
;4148:==================
;4149:BotGetActivateGoal
;4150:
;4151:  returns the number of the bsp entity to activate
;4152:  goal->entitynum will be set to the game entity to activate
;4153:==================
;4154:*/
;4155://#define OBSTACLEDEBUG
;4156:
;4157:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4167
;4158:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;4159:	char model[MAX_INFO_STRING], tmpmodel[128];
;4160:	char target[128], classname[128];
;4161:	float health;
;4162:	char targetname[10][128];
;4163:	aas_entityinfo_t entinfo;
;4164:	aas_areainfo_t areainfo;
;4165:	vec3_t origin, angles, absmins, absmaxs;
;4166:
;4167:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4168
;4168:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4169
;4169:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1824
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4170
;4170:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3252
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3252
INDIRI4
ASGNI4
ADDRGP4 $1829
JUMPV
LABELV $1826
line 4171
;4171:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $1830
ADDRGP4 $1827
JUMPV
LABELV $1830
line 4172
;4172:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $1832
ADDRGP4 $1828
JUMPV
LABELV $1832
line 4173
;4173:	}
LABELV $1827
line 4170
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3256
INDIRI4
ASGNI4
LABELV $1829
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1826
LABELV $1828
line 4174
;4174:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1834
line 4175
;4175:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1836
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4176
;4176:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1834
line 4178
;4177:	}
;4178:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1837
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4179
;4179:	if (!classname) {
ADDRLP4 1456
CVPU4 4
CNSTU4 0
NEU4 $1838
line 4180
;4180:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1840
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4181
;4181:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1838
line 4184
;4182:	}
;4183:	//if it is a door
;4184:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1843
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $1841
line 4185
;4185:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1639
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3264
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
EQI4 $1844
line 4187
;4186:			//if the door has health then the door must be shot to open
;4187:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $1846
line 4188
;4188:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4189
;4189:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1846
line 4191
;4190:			}
;4191:		}
LABELV $1844
line 4193
;4192:		//
;4193:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1848
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4195
;4194:		// if the door starts open then just wait for the door to return
;4195:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1849
line 4196
;4196:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1849
line 4198
;4197:		//get the door origin
;4198:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1853
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3268
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $1851
line 4199
;4199:			VectorClear(origin);
ADDRLP4 3272
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
ADDRLP4 3272
INDIRF4
ASGNF4
ADDRLP4 3192+4
ADDRLP4 3272
INDIRF4
ASGNF4
ADDRLP4 3192
ADDRLP4 3272
INDIRF4
ASGNF4
line 4200
;4200:		}
LABELV $1851
line 4202
;4201:		//if the door is open or opening already
;4202:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3272
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $1856
line 4203
;4203:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1856
line 4205
;4204:		// store all the areas the door is in
;4205:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4206
;4206:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1859
line 4207
;4207:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3276
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3276
INDIRI4
ASGNI4
line 4208
;4208:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $1862
line 4209
;4209:				VectorClear(angles);
ADDRLP4 3280
CNSTF4 0
ASGNF4
ADDRLP4 3216+8
ADDRLP4 3280
INDIRF4
ASGNF4
ADDRLP4 3216+4
ADDRLP4 3280
INDIRF4
ASGNF4
ADDRLP4 3216
ADDRLP4 3280
INDIRF4
ASGNF4
line 4210
;4210:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4212
;4211:				//
;4212:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3284
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3284
INDIRI4
ASGNI4
line 4214
;4213:				// store the areas with reachabilities first
;4214:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1869
JUMPV
LABELV $1866
line 4215
;4215:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1870
line 4216
;4216:						break;
ADDRGP4 $1868
JUMPV
LABELV $1870
line 4217
;4217:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $1872
line 4218
;4218:						continue;
ADDRGP4 $1867
JUMPV
LABELV $1872
line 4220
;4219:					}
;4220:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4221
;4221:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1874
line 4222
;4222:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3296
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3292
ADDRLP4 3296
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3300
CNSTI4 2
ASGNI4
ADDRLP4 3292
INDIRI4
ADDRLP4 3300
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3300
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4223
;4223:					}
LABELV $1874
line 4224
;4224:				}
LABELV $1867
line 4214
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1869
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $1866
LABELV $1868
line 4226
;4225:				// store any remaining areas
;4226:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1879
JUMPV
LABELV $1876
line 4227
;4227:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1880
line 4228
;4228:						break;
ADDRGP4 $1878
JUMPV
LABELV $1880
line 4229
;4229:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
EQI4 $1882
line 4230
;4230:						continue;
ADDRGP4 $1877
JUMPV
LABELV $1882
line 4232
;4231:					}
;4232:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4233
;4233:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1884
line 4234
;4234:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3296
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3292
ADDRLP4 3296
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3300
CNSTI4 2
ASGNI4
ADDRLP4 3292
INDIRI4
ADDRLP4 3300
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3300
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4235
;4235:					}
LABELV $1884
line 4236
;4236:				}
LABELV $1877
line 4226
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1879
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $1876
LABELV $1878
line 4237
;4237:			}
LABELV $1862
line 4238
;4238:		}
LABELV $1859
line 4239
;4239:	}
LABELV $1841
line 4241
;4240:	// if the bot is blocked by or standing on top of a button
;4241:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1888
ARGP4
ADDRLP4 3264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $1886
line 4242
;4242:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1886
line 4245
;4243:	}
;4244:	// get the targetname so we can find an entity with a matching target
;4245:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1891
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $1889
line 4246
;4246:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1892
line 4247
;4247:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1895
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4248
;4248:		}
LABELV $1892
line 4249
;4249:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1889
line 4252
;4250:	}
;4251:	// allow tree-like activation
;4252:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3272
INDIRI4
ASGNI4
line 4253
;4253:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1899
JUMPV
LABELV $1896
line 4254
;4254:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $1903
JUMPV
LABELV $1900
line 4255
;4255:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1906
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $1904
ADDRGP4 $1901
JUMPV
LABELV $1904
line 4256
;4256:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $1907
line 4257
;4257:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3284
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3284
INDIRI4
ASGNI4
line 4258
;4258:				break;
ADDRGP4 $1902
JUMPV
LABELV $1907
line 4260
;4259:			}
;4260:		}
LABELV $1901
line 4254
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3276
INDIRI4
ASGNI4
LABELV $1903
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1900
LABELV $1902
line 4261
;4261:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1909
line 4262
;4262:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1911
line 4263
;4263:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $1914
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4264
;4264:			}
LABELV $1911
line 4265
;4265:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4266
;4266:			continue;
ADDRGP4 $1897
JUMPV
LABELV $1909
line 4268
;4267:		}
;4268:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1837
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3280
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $1915
line 4269
;4269:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1897
line 4270
;4270:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $1920
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4271
;4271:			}
line 4272
;4272:			continue;
ADDRGP4 $1897
JUMPV
LABELV $1915
line 4275
;4273:		}
;4274:		// BSP button model
;4275:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1888
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
NEI4 $1921
line 4277
;4276:			//
;4277:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3288
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $1923
line 4278
;4278:				continue;
ADDRGP4 $1897
JUMPV
LABELV $1923
line 4280
;4279:			// if the bot tries to activate this button already
;4280:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3292
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1925
ADDRLP4 3292
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1925
ADDRLP4 3296
CNSTI4 44
ASGNI4
ADDRLP4 3292
INDIRP4
ADDRLP4 3296
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3296
INDIRI4
ADDP4
INDIRI4
NEI4 $1925
ADDRLP4 3300
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3292
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
LEF4 $1925
ADDRLP4 3292
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $1925
line 4284
;4281:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4282:				 bs->activatestack->time > FloatTime() &&
;4283:				 bs->activatestack->start_time < FloatTime() - 2)
;4284:				continue;
ADDRGP4 $1897
JUMPV
LABELV $1925
line 4286
;4285:			// if the bot is in a reachability area
;4286:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $1927
line 4288
;4287:				// disable all areas the blocking entity is in
;4288:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4290
;4289:				//
;4290:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3308
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3312
INDIRI4
ASGNI4
line 4292
;4291:				// if the button is not reachable
;4292:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $1929
line 4293
;4293:					continue;
ADDRGP4 $1897
JUMPV
LABELV $1929
line 4295
;4294:				}
;4295:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4296
;4296:			}
LABELV $1927
line 4297
;4297:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1921
line 4300
;4298:		}
;4299:		// invisible trigger multiple box
;4300:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1933
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $1931
line 4302
;4301:			//
;4302:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3292
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $1934
line 4303
;4303:				continue;
ADDRGP4 $1897
JUMPV
LABELV $1934
line 4305
;4304:			// if the bot tries to activate this trigger already
;4305:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3296
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1936
ADDRLP4 3296
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1936
ADDRLP4 3300
CNSTI4 44
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3300
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3300
INDIRI4
ADDP4
INDIRI4
NEI4 $1936
ADDRLP4 3304
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3296
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3304
INDIRF4
LEF4 $1936
ADDRLP4 3296
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3304
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $1936
line 4309
;4306:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4307:				 bs->activatestack->time > FloatTime() &&
;4308:				 bs->activatestack->start_time < FloatTime() - 2)
;4309:				continue;
ADDRGP4 $1897
JUMPV
LABELV $1936
line 4311
;4310:			// if the bot is in a reachability area
;4311:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3308
INDIRI4
CNSTI4 0
EQI4 $1938
line 4313
;4312:				// disable all areas the blocking entity is in
;4313:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4315
;4314:				//
;4315:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3312
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3316
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3316
INDIRI4
ASGNI4
line 4317
;4316:				// if the trigger is not reachable
;4317:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $1940
line 4318
;4318:					continue;
ADDRGP4 $1897
JUMPV
LABELV $1940
line 4320
;4319:				}
;4320:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4321
;4321:			}
LABELV $1938
line 4322
;4322:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1823
JUMPV
LABELV $1931
line 4324
;4323:		}
;4324:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1944
ARGP4
ADDRLP4 3292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $1942
line 4326
;4325:			// just skip the func_timer
;4326:			continue;
ADDRGP4 $1897
JUMPV
LABELV $1942
line 4329
;4327:		}
;4328:		// the actual button or trigger might be linked through a target_relay or target_delay
;4329:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1947
ARGP4
ADDRLP4 3296
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3296
INDIRI4
CNSTI4 0
EQI4 $1949
ADDRLP4 1456
ARGP4
ADDRGP4 $1948
ARGP4
ADDRLP4 3300
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3300
INDIRI4
CNSTI4 0
NEI4 $1945
LABELV $1949
line 4330
;4330:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1891
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $1950
line 4331
;4331:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4332
;4332:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3308
INDIRI4
ASGNI4
line 4333
;4333:			}
LABELV $1950
line 4334
;4334:		}
LABELV $1945
line 4335
;4335:	}
LABELV $1897
line 4253
LABELV $1899
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $1953
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $1896
LABELV $1953
line 4339
;4336:#ifdef OBSTACLEDEBUG
;4337:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4338:#endif
;4339:	return 0;
CNSTI4 0
RETI4
LABELV $1823
endproc BotGetActivateGoal 3320 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4347
;4340:}
;4341:
;4342:/*
;4343:==================
;4344:BotGoForActivateGoal
;4345:==================
;4346:*/
;4347:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4350
;4348:	aas_entityinfo_t activateinfo;
;4349:
;4350:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4351
;4351:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1955
line 4352
;4352:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $1955
line 4353
;4353:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4354
;4354:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4355
;4355:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4357
;4356:	//
;4357:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1958
line 4359
;4358:		// enter the activate entity AI node
;4359:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1960
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4360
;4360:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1954
JUMPV
LABELV $1958
line 4362
;4361:	}
;4362:	else {
line 4364
;4363:		// enable any routing areas that were disabled
;4364:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4365
;4365:		return qfalse;
CNSTI4 0
RETI4
LABELV $1954
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4374
;4366:	}
;4367:}
;4368:
;4369:/*
;4370:==================
;4371:BotPrintActivateGoalInfo
;4372:==================
;4373:*/
;4374:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4379
;4375:	char netname[MAX_NETNAME];
;4376:	char classname[128];
;4377:	char buf[128];
;4378:
;4379:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 4380
;4380:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1837
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4381
;4381:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1962
line 4382
;4382:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1964
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4388
;4383:						netname, classname,
;4384:						activategoal->goal.origin[0],
;4385:						activategoal->goal.origin[1],
;4386:						activategoal->goal.origin[2],
;4387:						activategoal->goal.areanum);
;4388:	}
ADDRGP4 $1963
JUMPV
LABELV $1962
line 4389
;4389:	else {
line 4390
;4390:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1965
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4396
;4391:						netname, classname,
;4392:						activategoal->goal.origin[0],
;4393:						activategoal->goal.origin[1],
;4394:						activategoal->goal.origin[2],
;4395:						activategoal->goal.areanum);
;4396:	}
LABELV $1963
line 4397
;4397:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4398
;4398:}
LABELV $1961
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 32 16
line 4405
;4399:
;4400:/*
;4401:==================
;4402:BotRandomMove
;4403:==================
;4404:*/
;4405:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4408
;4406:	vec3_t dir, angles;
;4407:
;4408:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4409
;4409:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1135869952
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 4410
;4410:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4411
;4411:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4413
;4412:
;4413:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4415
;4414:
;4415:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4416
;4416:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4417
;4417:}
LABELV $1966
endproc BotRandomMove 32 16
lit
align 4
LABELV $1970
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 528 16
line 4430
;4418:
;4419:/*
;4420:==================
;4421:BotAIBlocked
;4422:
;4423:Very basic handling of bots being blocked by other entities.
;4424:Check what kind of entity is blocking the bot and try to activate
;4425:it. If that's not an option then try to walk around or over the entity.
;4426:Before the bot ends in this part of the AI it should predict which doors to
;4427:open, which buttons to activate etc.
;4428:==================
;4429:*/
;4430:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4432
;4431:	int movetype, bspent;
;4432:	vec3_t hordir, start, end, mins, maxs, sideward, angles, up = {0, 0, 1};
ADDRLP4 228
ADDRGP4 $1970
INDIRB
ASGNB 12
line 4437
;4433:	aas_entityinfo_t entinfo;
;4434:	bot_activategoal_t activategoal;
;4435:
;4436:	// if the bot is not blocked by anything
;4437:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1971
line 4438
;4438:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4439
;4439:		return;
ADDRGP4 $1969
JUMPV
LABELV $1971
line 4442
;4440:	}
;4441:	// if stuck in a solid area
;4442:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1973
line 4444
;4443:		// move in a random direction in the hope to get out
;4444:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4446
;4445:		//
;4446:		return;
ADDRGP4 $1969
JUMPV
LABELV $1973
line 4449
;4447:	}
;4448:	// get info for the entity that is blocking the bot
;4449:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4455
;4450:#ifdef OBSTACLEDEBUG
;4451:	ClientName(bs->client, netname, sizeof(netname));
;4452:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4453:#endif // OBSTACLEDEBUG
;4454:	// if blocked by a bsp model and the bot wants to activate it
;4455:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRLP4 488
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 488
INDIRI4
EQI4 $1975
ADDRLP4 40+104
INDIRI4
ADDRLP4 488
INDIRI4
LEI4 $1975
ADDRLP4 40+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $1975
line 4457
;4456:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4457:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40+20
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 492
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 484
ADDRLP4 492
INDIRI4
ASGNI4
line 4458
;4458:		if (bspent) {
ADDRLP4 484
INDIRI4
CNSTI4 0
EQI4 $1980
line 4460
;4459:			//
;4460:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 496
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 496
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1982
ADDRLP4 496
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1982
line 4461
;4461:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
CNSTP4 0
ASGNP4
LABELV $1982
line 4463
;4462:			// if not already trying to activate this entity
;4463:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 240+4+40
INDIRI4
ARGI4
ADDRLP4 500
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
NEI4 $1984
line 4465
;4464:				//
;4465:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 240
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4466
;4466:			}
LABELV $1984
line 4470
;4467:			// if ontop of an obstacle or
;4468:			// if the bot is not in a reachability area it'll still
;4469:			// need some dynamic obstacle avoidance, otherwise return
;4470:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1981
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 504
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 0
EQI4 $1981
line 4472
;4471:				trap_AAS_AreaReachability(bs->areanum))
;4472:				return;
ADDRGP4 $1969
JUMPV
line 4473
;4473:		}
LABELV $1980
line 4474
;4474:		else {
line 4476
;4475:			// enable any routing areas that were disabled
;4476:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 240
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4477
;4477:		}
LABELV $1981
line 4478
;4478:	}
LABELV $1975
line 4480
;4479:	// just some basic dynamic obstacle avoidance code
;4480:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4481
;4481:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4482
;4482:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4484
;4483:	// if no direction just take a random direction
;4484:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 492
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 492
INDIRF4
CNSTF4 1036831949
GEF4 $1992
line 4485
;4485:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 216
CNSTF4 0
ASGNF4
ADDRLP4 496
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 216+4
CNSTF4 1135869952
ADDRLP4 496
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
ADDRLP4 216+8
CNSTF4 0
ASGNF4
line 4486
;4486:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 216
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 500
CNSTP4 0
ASGNP4
ADDRLP4 500
INDIRP4
ARGP4
ADDRLP4 500
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4487
;4487:	}
LABELV $1992
line 4491
;4488:	//
;4489:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4490:	//else
;4491:	movetype = MOVE_WALK;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 4494
;4492:	// if there's an obstacle at the bot's feet and head then
;4493:	// the bot might be able to crouch through
;4494:	VectorCopy(bs->origin, start);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4495
;4495:	start[2] += 18;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4496
;4496:	VectorMA(start, 5, hordir, end);
ADDRLP4 496
CNSTF4 1084227584
ASGNF4
ADDRLP4 180
ADDRLP4 24
INDIRF4
ADDRLP4 496
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 496
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1084227584
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4497
;4497:	VectorSet(mins, -16, -16, -24);
ADDRLP4 500
CNSTF4 3246391296
ASGNF4
ADDRLP4 192
ADDRLP4 500
INDIRF4
ASGNF4
ADDRLP4 192+4
ADDRLP4 500
INDIRF4
ASGNF4
ADDRLP4 192+8
CNSTF4 3250585600
ASGNF4
line 4498
;4498:	VectorSet(maxs, 16, 16, 4);
ADDRLP4 504
CNSTF4 1098907648
ASGNF4
ADDRLP4 204
ADDRLP4 504
INDIRF4
ASGNF4
ADDRLP4 204+4
ADDRLP4 504
INDIRF4
ASGNF4
ADDRLP4 204+8
CNSTF4 1082130432
ASGNF4
line 4503
;4499:	//
;4500:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4501:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4502:	// get the sideward vector
;4503:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4505
;4504:	//
;4505:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2007
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2007
line 4507
;4506:	// try to crouch straight forward?
;4507:	if (movetype != MOVE_CROUCH || !trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRLP4 36
INDIRI4
CNSTI4 2
NEI4 $2015
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 512
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 512
INDIRI4
CNSTI4 0
NEI4 $2013
LABELV $2015
line 4509
;4508:		// perform the movement
;4509:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $2016
line 4511
;4510:			// flip the avoid direction flag
;4511:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 520
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 520
INDIRP4
ADDRLP4 520
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4514
;4512:			// flip the direction
;4513:			// VectorNegate(sideward, sideward);
;4514:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 524
CNSTF4 3212836864
ASGNF4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 524
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 524
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4516
;4515:			// move in the other direction
;4516:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4517
;4517:		}
LABELV $2016
line 4518
;4518:	}
LABELV $2013
line 4520
;4519:	//
;4520:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2024
line 4523
;4521:		// just reset goals and hope the bot will go into another direction?
;4522:		// is this still needed??
;4523:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2026
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2027
JUMPV
LABELV $2026
line 4524
;4524:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2028
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
LABELV $2028
LABELV $2027
line 4525
;4525:	}
LABELV $2024
line 4526
;4526:}
LABELV $1969
endproc BotAIBlocked 528 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 324 44
line 4538
;4527:
;4528:/*
;4529:==================
;4530:BotAIPredictObstacles
;4531:
;4532:Predict the route towards the goal and check if the bot
;4533:will be blocked by certain obstacles. When the bot has obstacles
;4534:on it's path the bot should figure out if they can be removed
;4535:by activating certain entities.
;4536:==================
;4537:*/
;4538:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4543
;4539:	int modelnum, entitynum, bspent;
;4540:	bot_activategoal_t activategoal;
;4541:	aas_predictroute_t route;
;4542:
;4543:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2031
line 4544
;4544:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2030
JUMPV
LABELV $2031
line 4547
;4545:
;4546:	// always predict when the goal change or at regular intervals
;4547:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6216
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2034
ADDRLP4 292
INDIRP4
CNSTI4 6212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2034
line 4548
;4548:		bs->predictobstacles_time > FloatTime() - 6) {
line 4549
;4549:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2030
JUMPV
LABELV $2034
line 4551
;4550:	}
;4551:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6216
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4552
;4552:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6212
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4555
;4553:
;4554:	// predict at most 100 areas or 10 seconds ahead
;4555:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4560
;4556:							goal->areanum, bs->tfl, 100, 1000,
;4557:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;4558:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4559:	// if bot has to travel through an area with a mover
;4560:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2036
line 4562
;4561:		// if the bot will run into a mover
;4562:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2037
line 4564
;4563:			//NOTE: this only works with bspc 2.1 or higher
;4564:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 300
CNSTI4 24
ASGNI4
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
ADDRLP4 300
INDIRI4
LSHI4
BANDI4
ADDRLP4 300
INDIRI4
RSHI4
ASGNI4
line 4565
;4565:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2037
line 4567
;4566:				//
;4567:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 304
CNSTP4 0
ASGNP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 308
INDIRI4
ASGNI4
line 4568
;4568:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2037
line 4570
;4569:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4570:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 312
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 312
INDIRI4
ASGNI4
line 4571
;4571:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2037
line 4573
;4572:						//
;4573:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2049
ADDRLP4 316
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2049
line 4574
;4574:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
CNSTP4 0
ASGNP4
LABELV $2049
line 4576
;4575:						// if not already trying to activate this entity
;4576:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 320
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $2051
line 4580
;4577:							//
;4578:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4579:							//
;4580:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4581
;4581:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2030
JUMPV
LABELV $2051
line 4583
;4582:						}
;4583:						else {
line 4585
;4584:							// enable any routing areas that were disabled
;4585:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4586
;4586:						}
line 4587
;4587:					}
line 4588
;4588:				}
line 4589
;4589:			}
line 4590
;4590:		}
line 4591
;4591:	}
ADDRGP4 $2037
JUMPV
LABELV $2036
line 4592
;4592:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2055
line 4593
;4593:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2058
line 4595
;4594:			//FIXME: check if the bridge is available to travel over
;4595:		}
LABELV $2058
line 4596
;4596:	}
LABELV $2055
LABELV $2037
line 4597
;4597:	return qfalse;
CNSTI4 0
RETI4
LABELV $2030
endproc BotAIPredictObstacles 324 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1012 48
line 4605
;4598:}
;4599:
;4600:/*
;4601:==================
;4602:BotCheckConsoleMessages
;4603:==================
;4604:*/
;4605:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4613
;4606:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4607:	float chat_reply;
;4608:	int context, handle;
;4609:	bot_consolemessage_t m;
;4610:	bot_match_t match;
;4611:
;4612:	//the name of this bot
;4613:	ClientName(bs->client, botname, sizeof(botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2063
JUMPV
LABELV $2062
line 4615
;4614:	//
;4615:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4617
;4616:		//if the chat state is flooded with messages the bot will read them quickly
;4617:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2065
line 4619
;4618:			//if it is a chat message the bot needs some time to read it
;4619:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2067
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2067
ADDRGP4 $2064
JUMPV
LABELV $2067
line 4620
;4620:		}
LABELV $2065
line 4622
;4621:		//
;4622:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4625
;4623:		//if it is a chat message then don't unify white spaces and don't
;4624:		//replace synonyms in the netname
;4625:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2072
line 4627
;4626:			//
;4627:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2075
line 4628
;4628:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4629
;4629:			}
LABELV $2075
line 4630
;4630:		}
LABELV $2072
line 4632
;4631:		//unify the white spaces in the message
;4632:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4634
;4633:		//replace synonyms in the right context
;4634:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4635
;4635:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4637
;4636:		//if there's no match
;4637:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2081
line 4639
;4638:			//if it is a chat message
;4639:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2084
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2084
line 4641
;4640:				//
;4641:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2088
line 4642
;4642:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4643
;4643:					continue;
ADDRGP4 $2063
JUMPV
LABELV $2088
line 4646
;4644:				}
;4645:				//don't use eliza chats with team messages
;4646:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2091
line 4647
;4647:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4648
;4648:					continue;
ADDRGP4 $2063
JUMPV
LABELV $2091
line 4651
;4649:				}
;4650:				//
;4651:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4652
;4652:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4654
;4653:				//if this is a message from the bot self
;4654:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2094
line 4655
;4655:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4656
;4656:					continue;
ADDRGP4 $2063
JUMPV
LABELV $2094
line 4659
;4657:				}
;4658:				//unify the message
;4659:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4661
;4660:				//
;4661:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4662
;4662:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2096
line 4664
;4663:					//
;4664:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2099
ARGP4
ADDRGP4 $2100
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4666
;4665:					//if bot replies with a chat message
;4666:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 968
CNSTP4 0
ASGNP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 972
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2101
line 4670
;4667:															NULL, NULL,
;4668:															NULL, NULL,
;4669:															NULL, NULL,
;4670:															botname, netname)) {
line 4671
;4671:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2103
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4672
;4672:					}
ADDRGP4 $2097
JUMPV
LABELV $2101
line 4673
;4673:					else {
line 4674
;4674:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2104
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4675
;4675:					}
line 4676
;4676:				}
ADDRGP4 $2097
JUMPV
LABELV $2096
line 4678
;4677:				//if at a valid chat position and not chatting already and not in teamplay
;4678:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2105
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2105
ADDRLP4 976
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2105
line 4679
;4679:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4680
;4680:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2107
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 944
INDIRF4
GEF4 $2107
line 4682
;4681:						//if bot replies with a chat message
;4682:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 996
CNSTP4 0
ASGNP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 1000
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
EQI4 $2109
line 4686
;4683:																NULL, NULL,
;4684:																NULL, NULL,
;4685:																NULL, NULL,
;4686:																botname, netname)) {
line 4688
;4687:							//remove the console message
;4688:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4689
;4689:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1008
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1004
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1008
INDIRF4
ADDF4
ASGNF4
line 4690
;4690:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2111
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4692
;4691:							//EA_Say(bs->client, bs->cs.chatmessage);
;4692:							break;
ADDRGP4 $2064
JUMPV
LABELV $2109
line 4694
;4693:						}
;4694:					}
LABELV $2107
line 4695
;4695:				}
LABELV $2105
LABELV $2097
line 4696
;4696:			}
LABELV $2084
line 4697
;4697:		}
LABELV $2081
line 4699
;4698:		//remove the console message
;4699:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4700
;4700:	}
LABELV $2063
line 4615
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2062
LABELV $2064
line 4701
;4701:}
LABELV $2061
endproc BotCheckConsoleMessages 1012 48
export BotCheckForGrenades
proc BotCheckForGrenades 8 16
line 4708
;4702:
;4703:/*
;4704:==================
;4705:BotCheckEvents
;4706:==================
;4707:*/
;4708:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4710
;4709:	// if this is not a grenade
;4710:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2115
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2113
LABELV $2115
line 4711
;4711:		return;
ADDRGP4 $2112
JUMPV
LABELV $2113
line 4713
;4712:	// try to avoid the grenade
;4713:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4714
;4714:}
LABELV $2112
endproc BotCheckForGrenades 8 16
export BotCheckEvents
proc BotCheckEvents 164 12
line 4766
;4715:
;4716:#ifdef MISSIONPACK
;4717:/*
;4718:==================
;4719:BotCheckForProxMines
;4720:==================
;4721:*/
;4722:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
;4723:	// if this is not a prox mine
;4724:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
;4725:		return;
;4726:	// if this prox mine is from someone on our own team
;4727:	if (state->generic1 == BotTeam(bs))
;4728:		return;
;4729:	// if the bot doesn't have a weapon to deactivate the mine
;4730:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
;4731:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4732:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
;4733:		return;
;4734:	}
;4735:	// try to avoid the prox mine
;4736:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
;4737:	//
;4738:	if (bs->numproxmines >= MAX_PROXMINES)
;4739:		return;
;4740:	bs->proxmines[bs->numproxmines] = state->number;
;4741:	bs->numproxmines++;
;4742:}
;4743:
;4744:/*
;4745:==================
;4746:BotCheckForKamikazeBody
;4747:==================
;4748:*/
;4749:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
;4750:	// if this entity is not wearing the kamikaze
;4751:	if (!(state->eFlags & EF_KAMIKAZE))
;4752:		return;
;4753:	// if this entity isn't dead
;4754:	if (!(state->eFlags & EF_DEAD))
;4755:		return;
;4756:	//remember this kamikaze body
;4757:	bs->kamikazebody = state->number;
;4758:}
;4759:#endif
;4760:
;4761:/*
;4762:==================
;4763:BotCheckEvents
;4764:==================
;4765:*/
;4766:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 4775
;4767:	int event;
;4768:	char buf[128];
;4769:#ifdef MISSIONPACK
;4770:	aas_entityinfo_t entinfo;
;4771:#endif
;4772:
;4773:	//NOTE: this sucks, we're accessing the gentity_t directly
;4774:	//but there's no other fast way to do it right now
;4775:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 132
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
CNSTI4 820
ADDRLP4 132
INDIRI4
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
NEI4 $2117
line 4776
;4776:		return;
ADDRGP4 $2116
JUMPV
LABELV $2117
line 4778
;4777:	}
;4778:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 136
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
CNSTI4 820
ADDRLP4 136
INDIRI4
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
ASGNI4
line 4780
;4779:	//if it's an event only entity
;4780:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $2121
line 4781
;4781:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 4782
;4782:	}
ADDRGP4 $2122
JUMPV
LABELV $2121
line 4783
;4783:	else {
line 4784
;4784:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 4785
;4785:	}
LABELV $2122
line 4787
;4786:	//
;4787:	switch(event) {
ADDRLP4 140
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
LTI4 $2123
ADDRLP4 140
INDIRI4
CNSTI4 76
GTI4 $2123
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2172-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2172
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2124
address $2123
address $2123
address $2123
address $2157
address $2123
address $2123
address $2158
address $2136
address $2144
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2125
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2123
address $2124
code
LABELV $2125
line 4790
;4788:		//client obituary event
;4789:		case EV_OBITUARY:
;4790:		{
line 4793
;4791:			int target, attacker, mod;
;4792:
;4793:			target = state->otherEntityNum;
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4794
;4794:			attacker = state->otherEntityNum2;
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4795
;4795:			mod = state->eventParm;
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 4797
;4796:			//
;4797:			if (target == bs->client) {
ADDRLP4 144
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2126
line 4798
;4798:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 4799
;4799:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 4801
;4800:				//
;4801:				if (target == attacker ||
ADDRLP4 156
ADDRLP4 144
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $2131
ADDRLP4 156
INDIRI4
CNSTI4 1023
EQI4 $2131
ADDRLP4 156
INDIRI4
CNSTI4 1022
NEI4 $2128
LABELV $2131
line 4803
;4802:					target == ENTITYNUM_NONE ||
;4803:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2129
JUMPV
LABELV $2128
line 4804
;4804:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 0
ASGNI4
LABELV $2129
line 4806
;4805:				//
;4806:				bs->num_deaths++;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4807
;4807:			}
ADDRGP4 $2124
JUMPV
LABELV $2126
line 4809
;4808:			//else if this client was killed by the bot
;4809:			else if (attacker == bs->client) {
ADDRLP4 148
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2132
line 4810
;4810:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 4811
;4811:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 4812
;4812:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6168
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4814
;4813:				//
;4814:				bs->num_kills++;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4815
;4815:			}
ADDRGP4 $2124
JUMPV
LABELV $2132
line 4816
;4816:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 156
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $2124
ADDRLP4 144
INDIRI4
ADDRLP4 156
INDIRI4
NEI4 $2124
line 4817
;4817:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 1
ASGNI4
line 4818
;4818:			}
line 4832
;4819:			//
;4820:#ifdef MISSIONPACK			
;4821:			if (gametype == GT_1FCTF) {
;4822:				//
;4823:				BotEntityInfo(target, &entinfo);
;4824:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;4825:					if (!BotSameTeam(bs, target)) {
;4826:						bs->neutralflagstatus = 3;	//enemy dropped the flag
;4827:						bs->flagstatuschanged = qtrue;
;4828:					}
;4829:				}
;4830:			}
;4831:#endif
;4832:			break;
ADDRGP4 $2124
JUMPV
LABELV $2136
line 4835
;4833:		}
;4834:		case EV_GLOBAL_SOUND:
;4835:		{
line 4836
;4836:			if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2139
ADDRLP4 144
INDIRI4
CNSTI4 256
LEI4 $2137
LABELV $2139
line 4837
;4837:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2140
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4838
;4838:				break;
ADDRGP4 $2124
JUMPV
LABELV $2137
line 4840
;4839:			}
;4840:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4860
;4841:			/*
;4842:			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
;4843:				//red flag is returned
;4844:				bs->redflagstatus = 0;
;4845:				bs->flagstatuschanged = qtrue;
;4846:			}
;4847:			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
;4848:				//blue flag is returned
;4849:				bs->blueflagstatus = 0;
;4850:				bs->flagstatuschanged = qtrue;
;4851:			}
;4852:			else*/
;4853:#ifdef MISSIONPACK
;4854:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
;4855:				//the kamikaze respawned so dont avoid it
;4856:				BotDontAvoid(bs, "Kamikaze");
;4857:			}
;4858:			else
;4859:#endif
;4860:				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2143
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2124
line 4862
;4861:				//powerup respawned... go get it
;4862:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 4863
;4863:			}
line 4864
;4864:			break;
ADDRGP4 $2124
JUMPV
LABELV $2144
line 4867
;4865:		}
;4866:		case EV_GLOBAL_TEAM_SOUND:
;4867:		{
line 4868
;4868:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2124
line 4869
;4869:				switch(state->eventParm) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2124
ADDRLP4 144
INDIRI4
CNSTI4 5
GTI4 $2124
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2156
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2156
address $2150
address $2151
address $2152
address $2153
address $2154
address $2155
code
LABELV $2150
line 4871
;4870:					case GTS_RED_CAPTURE:
;4871:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4872
;4872:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 4873
;4873:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4874
;4874:						break; //see BotMatch_CTF
ADDRGP4 $2124
JUMPV
LABELV $2151
line 4876
;4875:					case GTS_BLUE_CAPTURE:
;4876:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4877
;4877:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 4878
;4878:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4879
;4879:						break; //see BotMatch_CTF
ADDRGP4 $2124
JUMPV
LABELV $2152
line 4882
;4880:					case GTS_RED_RETURN:
;4881:						//blue flag is returned
;4882:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4883
;4883:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4884
;4884:						break;
ADDRGP4 $2124
JUMPV
LABELV $2153
line 4887
;4885:					case GTS_BLUE_RETURN:
;4886:						//red flag is returned
;4887:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 4888
;4888:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4889
;4889:						break;
ADDRGP4 $2124
JUMPV
LABELV $2154
line 4892
;4890:					case GTS_RED_TAKEN:
;4891:						//blue flag is taken
;4892:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 4893
;4893:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4894
;4894:						break; //see BotMatch_CTF
ADDRGP4 $2124
JUMPV
LABELV $2155
line 4897
;4895:					case GTS_BLUE_TAKEN:
;4896:						//red flag is taken
;4897:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 1
ASGNI4
line 4898
;4898:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 4899
;4899:						break; //see BotMatch_CTF
line 4901
;4900:				}
;4901:			}
line 4934
;4902:#ifdef MISSIONPACK
;4903:			else if (gametype == GT_1FCTF) {
;4904:				switch(state->eventParm) {
;4905:					case GTS_RED_CAPTURE:
;4906:						bs->neutralflagstatus = 0;
;4907:						bs->flagstatuschanged = qtrue;
;4908:						break;
;4909:					case GTS_BLUE_CAPTURE:
;4910:						bs->neutralflagstatus = 0;
;4911:						bs->flagstatuschanged = qtrue;
;4912:						break;
;4913:					case GTS_RED_RETURN:
;4914:						//flag has returned
;4915:						bs->neutralflagstatus = 0;
;4916:						bs->flagstatuschanged = qtrue;
;4917:						break;
;4918:					case GTS_BLUE_RETURN:
;4919:						//flag has returned
;4920:						bs->neutralflagstatus = 0;
;4921:						bs->flagstatuschanged = qtrue;
;4922:						break;
;4923:					case GTS_RED_TAKEN:
;4924:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;4925:						bs->flagstatuschanged = qtrue;
;4926:						break;
;4927:					case GTS_BLUE_TAKEN:
;4928:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;4929:						bs->flagstatuschanged = qtrue;
;4930:						break;
;4931:				}
;4932:			}
;4933:#endif
;4934:			break;
ADDRGP4 $2124
JUMPV
LABELV $2157
line 4937
;4935:		}
;4936:		case EV_PLAYER_TELEPORT_IN:
;4937:		{
line 4938
;4938:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4939
;4939:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4940
;4940:			break;
ADDRGP4 $2124
JUMPV
LABELV $2158
line 4943
;4941:		}
;4942:		case EV_GENERAL_SOUND:
;4943:		{
line 4945
;4944:			//if this sound is played on the bot
;4945:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2124
line 4946
;4946:				if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2163
ADDRLP4 144
INDIRI4
CNSTI4 256
LEI4 $2161
LABELV $2163
line 4947
;4947:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2164
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4948
;4948:					break;
ADDRGP4 $2124
JUMPV
LABELV $2161
line 4951
;4949:				}
;4950:				//check out the sound
;4951:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4953
;4952:				//if falling into a death pit
;4953:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2167
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2124
line 4955
;4954:					//if the bot has a personal teleporter
;4955:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2124
line 4957
;4956:						//use the holdable item
;4957:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 4958
;4958:					}
line 4959
;4959:				}
line 4960
;4960:			}
line 4961
;4961:			break;
line 4988
;4962:		}
;4963:		case EV_FOOTSTEP:
;4964:		case EV_FOOTSTEP_METAL:
;4965:		case EV_FOOTSPLASH:
;4966:		case EV_FOOTWADE:
;4967:		case EV_SWIM:
;4968:		case EV_FALL_SHORT:
;4969:		case EV_FALL_MEDIUM:
;4970:		case EV_FALL_FAR:
;4971:		case EV_STEP_4:
;4972:		case EV_STEP_8:
;4973:		case EV_STEP_12:
;4974:		case EV_STEP_16:
;4975:		case EV_JUMP_PAD:
;4976:		case EV_JUMP:
;4977:		case EV_TAUNT:
;4978:		case EV_WATER_TOUCH:
;4979:		case EV_WATER_LEAVE:
;4980:		case EV_WATER_UNDER:
;4981:		case EV_WATER_CLEAR:
;4982:		case EV_ITEM_PICKUP:
;4983:		case EV_GLOBAL_ITEM_PICKUP:
;4984:		case EV_NOAMMO:
;4985:		case EV_CHANGE_WEAPON:
;4986:		case EV_FIRE_WEAPON:
;4987:			//FIXME: either add to sound queue or mark player as someone making noise
;4988:			break;
line 5004
;4989:		case EV_USE_ITEM0:
;4990:		case EV_USE_ITEM1:
;4991:		case EV_USE_ITEM2:
;4992:		case EV_USE_ITEM3:
;4993:		case EV_USE_ITEM4:
;4994:		case EV_USE_ITEM5:
;4995:		case EV_USE_ITEM6:
;4996:		case EV_USE_ITEM7:
;4997:		case EV_USE_ITEM8:
;4998:		case EV_USE_ITEM9:
;4999:		case EV_USE_ITEM10:
;5000:		case EV_USE_ITEM11:
;5001:		case EV_USE_ITEM12:
;5002:		case EV_USE_ITEM13:
;5003:		case EV_USE_ITEM14:
;5004:			break;
LABELV $2123
LABELV $2124
line 5006
;5005:	}
;5006:}
LABELV $2116
endproc BotCheckEvents 164 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 5013
;5007:
;5008:/*
;5009:==================
;5010:BotCheckSnapshot
;5011:==================
;5012:*/
;5013:void BotCheckSnapshot(bot_state_t *bs) {
line 5018
;5014:	int ent;
;5015:	entityState_t state;
;5016:
;5017:	//remove all avoid spots
;5018:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 5020
;5019:	//reset kamikaze body
;5020:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
CNSTI4 0
ASGNI4
line 5022
;5021:	//reset number of proxmines
;5022:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTI4 0
ASGNI4
line 5024
;5023:	//
;5024:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $2176
JUMPV
LABELV $2175
line 5025
;5025:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 5027
;5026:		//check the entity state for events
;5027:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5029
;5028:		//check for grenades the bot should avoid
;5029:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 5037
;5030:		//
;5031:#ifdef MISSIONPACK
;5032:		//check for proximity mines which the bot should deactivate
;5033:		BotCheckForProxMines(bs, &state);
;5034:		//check for dead bodies with the kamikaze effect which should be gibbed
;5035:		BotCheckForKamikazeBody(bs, &state);
;5036:#endif
;5037:	}
LABELV $2176
line 5025
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $2175
line 5039
;5038:	//check the player state for events
;5039:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 5041
;5040:	//copy the player state events to the entity state
;5041:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5042
;5042:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 5044
;5043:	//
;5044:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5045
;5045:}
LABELV $2174
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 5052
;5046:
;5047:/*
;5048:==================
;5049:BotCheckAir
;5050:==================
;5051:*/
;5052:void BotCheckAir(bot_state_t *bs) {
line 5053
;5053:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5096
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2181
line 5054
;5054:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2183
line 5055
;5055:			return;
ADDRGP4 $2180
JUMPV
LABELV $2183
line 5057
;5056:		}
;5057:	}
LABELV $2181
line 5058
;5058:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6176
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5059
;5059:}
LABELV $2180
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 5066
;5060:
;5061:/*
;5062:==================
;5063:BotAlternateRoute
;5064:==================
;5065:*/
;5066:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 5070
;5067:	int t;
;5068:
;5069:	// if the bot has an alternative route goal
;5070:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2186
line 5072
;5071:		//
;5072:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2188
line 5073
;5073:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2185
JUMPV
LABELV $2188
line 5075
;5074:		// travel time towards alternative route goal
;5075:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5076
;5076:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2190
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2190
line 5078
;5077:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;5078:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5079
;5079:		}
LABELV $2190
line 5080
;5080:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 5081
;5081:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
RETP4
ADDRGP4 $2185
JUMPV
LABELV $2186
line 5083
;5082:	}
;5083:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2185
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 24 0
line 5091
;5084:}
;5085:
;5086:/*
;5087:==================
;5088:BotGetAlternateRouteGoal
;5089:==================
;5090:*/
;5091:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 5096
;5092:	aas_altroutegoal_t *altroutegoals;
;5093:	bot_goal_t *goal;
;5094:	int numaltroutegoals, rnd;
;5095:
;5096:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2193
line 5097
;5097:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 5098
;5098:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 5099
;5099:	}
ADDRGP4 $2194
JUMPV
LABELV $2193
line 5100
;5100:	else {
line 5101
;5101:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 5102
;5102:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 5103
;5103:	}
LABELV $2194
line 5104
;5104:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2195
line 5105
;5105:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2192
JUMPV
LABELV $2195
line 5106
;5106:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5107
;5107:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2197
line 5108
;5108:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2197
line 5109
;5109:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ASGNP4
line 5110
;5110:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 20
CNSTI4 12
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 5111
;5111:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5112
;5112:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5113
;5113:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5114
;5114:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5115
;5115:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5116
;5116:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5117
;5117:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5119
;5118:	//
;5119:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
CNSTF4 0
ASGNF4
line 5120
;5120:	return qtrue;
CNSTI4 1
RETI4
LABELV $2192
endproc BotGetAlternateRouteGoal 24 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 0 0
line 5128
;5121:}
;5122:
;5123:/*
;5124:==================
;5125:BotSetupAlternateRouteGoals
;5126:==================
;5127:*/
;5128:void BotSetupAlternativeRouteGoals(void) {
line 5130
;5129:
;5130:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2200
line 5131
;5131:		return;
ADDRGP4 $2199
JUMPV
LABELV $2200
line 5200
;5132:#ifdef MISSIONPACK
;5133:	if (gametype == GT_CTF) {
;5134:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5135:			BotAI_Print(PRT_WARNING, "no alt routes without Neutral Flag\n");
;5136:		if (ctf_neutralflag.areanum) {
;5137:			//
;5138:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5139:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5140:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5141:										red_altroutegoals, MAX_ALTROUTEGOALS,
;5142:										ALTROUTEGOAL_CLUSTERPORTALS|
;5143:										ALTROUTEGOAL_VIEWPORTALS);
;5144:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5145:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5146:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5147:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;5148:										ALTROUTEGOAL_CLUSTERPORTALS|
;5149:										ALTROUTEGOAL_VIEWPORTALS);
;5150:		}
;5151:	}
;5152:	else if (gametype == GT_1FCTF) {
;5153:		//
;5154:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5155:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5156:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5157:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5158:									ALTROUTEGOAL_CLUSTERPORTALS|
;5159:									ALTROUTEGOAL_VIEWPORTALS);
;5160:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5161:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5162:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5163:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5164:									ALTROUTEGOAL_CLUSTERPORTALS|
;5165:									ALTROUTEGOAL_VIEWPORTALS);
;5166:	}
;5167:	else if (gametype == GT_OBELISK) {
;5168:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5169:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5170:		//
;5171:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5172:									neutralobelisk.origin, neutralobelisk.areanum,
;5173:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5174:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5175:									ALTROUTEGOAL_CLUSTERPORTALS|
;5176:									ALTROUTEGOAL_VIEWPORTALS);
;5177:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5178:									neutralobelisk.origin, neutralobelisk.areanum,
;5179:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5180:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5181:									ALTROUTEGOAL_CLUSTERPORTALS|
;5182:									ALTROUTEGOAL_VIEWPORTALS);
;5183:	}
;5184:	else if (gametype == GT_HARVESTER) {
;5185:		//
;5186:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5187:									neutralobelisk.origin, neutralobelisk.areanum,
;5188:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5189:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5190:									ALTROUTEGOAL_CLUSTERPORTALS|
;5191:									ALTROUTEGOAL_VIEWPORTALS);
;5192:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5193:									neutralobelisk.origin, neutralobelisk.areanum,
;5194:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5195:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5196:									ALTROUTEGOAL_CLUSTERPORTALS|
;5197:									ALTROUTEGOAL_VIEWPORTALS);
;5198:	}
;5199:#endif
;5200:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5201
;5201:}
LABELV $2199
endproc BotSetupAlternativeRouteGoals 0 0
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 5208
;5202:
;5203:/*
;5204:==================
;5205:BotDeathmatchAI
;5206:==================
;5207:*/
;5208:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5214
;5209:	char gender[144], name[144], buf[144];
;5210:	char userinfo[MAX_INFO_STRING];
;5211:	int i;
;5212:
;5213:	//if the bot has just been setup
;5214:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2203
line 5215
;5215:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5216
;5216:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2205
ADDRGP4 $2202
JUMPV
LABELV $2205
line 5218
;5217:		//get the gender characteristic
;5218:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5220
;5219:		//set the bot gender
;5220:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5221
;5221:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $2207
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 5222
;5222:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5224
;5223:		//set the team
;5224:		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2208
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $2208
line 5225
;5225:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $2211
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5226
;5226:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 5227
;5227:		}
LABELV $2208
line 5229
;5228:		//set the chat gender
;5229:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2212
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2213
JUMPV
LABELV $2212
line 5230
;5230:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2214
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2215
JUMPV
LABELV $2214
line 5231
;5231:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $2215
LABELV $2213
line 5233
;5232:		//set the chat name
;5233:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5234
;5234:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5236
;5235:		//
;5236:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5237
;5237:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5239
;5238:		//
;5239:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 0
ASGNI4
line 5241
;5240:		//
;5241:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5242
;5242:	}
LABELV $2203
line 5244
;5243:	//no ideal view set
;5244:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5246
;5245:	//
;5246:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2216
line 5248
;5247:		//set the teleport time
;5248:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5250
;5249:		//update some inventory values
;5250:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5252
;5251:		//check out the snapshot
;5252:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5254
;5253:		//check for air
;5254:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5255
;5255:	}
LABELV $2216
line 5257
;5256:	//check the console messages
;5257:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5259
;5258:	//if not in the intermission and not in observer mode
;5259:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2218
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $2218
line 5261
;5260:		//do team AI
;5261:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5262
;5262:	}
LABELV $2218
line 5264
;5263:	//if the bot has no ai node
;5264:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2220
line 5265
;5265:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2222
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5266
;5266:	}
LABELV $2220
line 5268
;5267:	//if the bot entered the game less than 8 seconds ago
;5268:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2223
ADDRLP4 1476
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $2223
line 5269
;5269:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $2225
line 5270
;5270:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 5271
;5271:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2227
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5272
;5272:		}
LABELV $2225
line 5273
;5273:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
CNSTI4 1
ASGNI4
line 5274
;5274:	}
LABELV $2223
line 5276
;5275:	//reset the node switches from the previous frame
;5276:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5278
;5277:	//execute AI nodes
;5278:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2228
line 5279
;5279:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $2232
ADDRGP4 $2230
JUMPV
LABELV $2232
line 5280
;5280:	}
LABELV $2229
line 5278
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2228
LABELV $2230
line 5282
;5281:	//if the bot removed itself :)
;5282:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2234
ADDRGP4 $2202
JUMPV
LABELV $2234
line 5284
;5283:	//if the bot executed too many AI nodes
;5284:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2236
line 5285
;5285:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 5286
;5286:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 5287
;5287:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 5288
;5288:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5289
;5289:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $2238
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5290
;5290:	}
LABELV $2236
line 5292
;5291:	//
;5292:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5293
;5293:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5294
;5294:}
LABELV $2202
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5301
;5295:
;5296:/*
;5297:==================
;5298:BotSetEntityNumForGoalWithModel
;5299:==================
;5300:*/
;5301:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5306
;5302:	gentity_t *ent;
;5303:	int i, modelindex;
;5304:	vec3_t dir;
;5305:
;5306:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5307
;5307:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5308
;5308:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2243
JUMPV
LABELV $2240
line 5309
;5309:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2245
line 5310
;5310:			continue;
ADDRGP4 $2241
JUMPV
LABELV $2245
line 5312
;5311:		}
;5312:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2247
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2247
line 5313
;5313:			continue;
ADDRGP4 $2241
JUMPV
LABELV $2247
line 5315
;5314:		}
;5315:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $2249
line 5316
;5316:			continue;
ADDRGP4 $2241
JUMPV
LABELV $2249
line 5318
;5317:		}
;5318:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5319
;5319:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $2253
line 5320
;5320:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5321
;5321:			return;
ADDRGP4 $2239
JUMPV
LABELV $2253
line 5323
;5322:		}
;5323:	}
LABELV $2241
line 5308
ADDRLP4 16
ADDRLP4 16
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
LABELV $2243
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2240
line 5324
;5324:}
LABELV $2239
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5331
;5325:
;5326:/*
;5327:==================
;5328:BotSetEntityNumForGoal
;5329:==================
;5330:*/
;5331:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5336
;5332:	gentity_t *ent;
;5333:	int i;
;5334:	vec3_t dir;
;5335:
;5336:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5337
;5337:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2259
JUMPV
LABELV $2256
line 5338
;5338:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2261
line 5339
;5339:			continue;
ADDRGP4 $2257
JUMPV
LABELV $2261
line 5341
;5340:		}
;5341:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2263
line 5342
;5342:			continue;
ADDRGP4 $2257
JUMPV
LABELV $2263
line 5344
;5343:		}
;5344:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5345
;5345:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $2267
line 5346
;5346:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5347
;5347:			return;
ADDRGP4 $2255
JUMPV
LABELV $2267
line 5349
;5348:		}
;5349:	}
LABELV $2257
line 5337
ADDRLP4 16
ADDRLP4 16
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
LABELV $2259
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2256
line 5350
;5350:}
LABELV $2255
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5357
;5351:
;5352:/*
;5353:==================
;5354:BotGoalForBSPEntity
;5355:==================
;5356:*/
;5357:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 5362
;5358:	char value[MAX_INFO_STRING];
;5359:	vec3_t origin, start, end;
;5360:	int ent, numareas, areas[10];
;5361:
;5362:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5363
;5363:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $2273
JUMPV
LABELV $2270
line 5364
;5364:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1837
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2274
line 5365
;5365:			continue;
ADDRGP4 $2271
JUMPV
LABELV $2274
line 5366
;5366:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2276
line 5367
;5367:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1853
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2278
line 5368
;5368:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2269
JUMPV
LABELV $2278
line 5369
;5369:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5370
;5370:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5371
;5371:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5372
;5372:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5373
;5373:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5374
;5374:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5375
;5375:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2282
line 5376
;5376:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2269
JUMPV
LABELV $2282
line 5377
;5377:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5378
;5378:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2269
JUMPV
LABELV $2276
line 5380
;5379:		}
;5380:	}
LABELV $2271
line 5363
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $2273
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2270
line 5381
;5381:	return qfalse;
CNSTI4 0
RETI4
LABELV $2269
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 156 16
line 5389
;5382:}
;5383:
;5384:/*
;5385:==================
;5386:BotSetupDeathmatchAI
;5387:==================
;5388:*/
;5389:void BotSetupDeathmatchAI(void) {
line 5393
;5390:	int ent, modelnum;
;5391:	char model[128];
;5392:
;5393:	gametype = trap_Cvar_VariableIntegerValue("g_gametype");
ADDRGP4 $2285
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 5394
;5394:	maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $280
ARGP4
ADDRLP4 140
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 maxclients
ADDRLP4 140
INDIRI4
ASGNI4
line 5396
;5395:
;5396:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $2286
ARGP4
ADDRGP4 $2100
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5397
;5397:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $2287
ARGP4
ADDRGP4 $2288
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5398
;5398:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $2289
ARGP4
ADDRGP4 $2288
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5399
;5399:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $2290
ARGP4
ADDRGP4 $2288
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5400
;5400:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2099
ARGP4
ADDRGP4 $2288
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5401
;5401:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $2291
ARGP4
ADDRGP4 $2288
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5402
;5402:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $2292
ARGP4
ADDRGP4 $2100
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5403
;5403:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $2293
ARGP4
ADDRGP4 $2294
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5405
;5404:	//
;5405:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2295
line 5406
;5406:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2299
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $2297
line 5407
;5407:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2300
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2297
line 5408
;5408:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2303
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $2301
line 5409
;5409:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2304
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2301
line 5410
;5410:	}
LABELV $2295
line 5441
;5411:#ifdef MISSIONPACK
;5412:	else if (gametype == GT_1FCTF) {
;5413:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5414:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
;5415:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
;5416:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
;5417:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
;5418:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
;5419:	}
;5420:	else if (gametype == GT_OBELISK) {
;5421:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5422:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
;5423:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5424:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5425:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
;5426:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5427:	}
;5428:	else if (gametype == GT_HARVESTER) {
;5429:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5430:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
;5431:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5432:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5433:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
;5434:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5435:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5436:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5437:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
;5438:	}
;5439:#endif
;5440:
;5441:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5442
;5442:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
ADDRGP4 $2308
JUMPV
LABELV $2305
line 5443
;5443:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2309
ADDRGP4 $2306
JUMPV
LABELV $2309
line 5444
;5444:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $2311
line 5445
;5445:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 152
INDIRI4
ASGNI4
line 5446
;5446:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $2314
line 5447
;5447:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $2314
line 5448
;5448:		}
LABELV $2311
line 5449
;5449:	}
LABELV $2306
line 5442
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 148
INDIRI4
ASGNI4
LABELV $2308
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2305
line 5451
;5450:	//initialize the waypoint heap
;5451:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5452
;5452:}
LABELV $2284
endproc BotSetupDeathmatchAI 156 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5459
;5453:
;5454:/*
;5455:==================
;5456:BotShutdownDeathmatchAI
;5457:==================
;5458:*/
;5459:void BotShutdownDeathmatchAI(void) {
line 5460
;5460:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5461
;5461:}
LABELV $2316
endproc BotShutdownDeathmatchAI 0 0
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotVoiceChat_Defend
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
export maxclients
align 4
LABELV maxclients
skip 4
export gametype
align 4
LABELV gametype
skip 4
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
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
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_entities
import level
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
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
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
import Com_Printf
import Com_Error
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
LABELV $2304
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2303
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2300
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2299
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2294
byte 1 50
byte 1 0
align 1
LABELV $2293
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2292
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2291
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2290
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2289
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2288
byte 1 48
byte 1 0
align 1
LABELV $2287
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2286
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2285
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
LABELV $2238
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2227
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2222
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2211
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2207
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2167
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2164
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2143
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2140
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2111
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2104
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2103
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
LABELV $2100
byte 1 49
byte 1 0
align 1
LABELV $2099
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1965
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1964
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1960
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1948
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1947
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1944
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1933
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1920
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1914
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $1906
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1895
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1891
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1888
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1853
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1848
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $1843
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1840
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1837
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1836
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1824
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1639
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $1616
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1613
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1575
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1520
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1516
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $670
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $669
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $668
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $667
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $666
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $499
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 93
byte 1 0
align 1
LABELV $324
byte 1 91
byte 1 0
align 1
LABELV $323
byte 1 32
byte 1 0
align 1
LABELV $280
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
LABELV $275
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $274
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
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
byte 1 10
byte 1 0
align 1
LABELV $269
byte 1 110
byte 1 0
align 1
LABELV $268
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
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
byte 1 93
byte 1 0
align 1
LABELV $267
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
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
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $161
byte 1 105
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $160
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $159
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $136
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $68
byte 1 116
byte 1 0
