export BotValidTeamLeader
code
proc BotValidTeamLeader 8 4
file "game/ai_team.c"
line 71
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
;25: * name:		ai_team.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_team.c $
;30: *
;31: *****************************************************************************/
;32:
;33:#include "g_local.h"
;34:#include "botlib.h"
;35:#include "be_aas.h"
;36:#include "be_ea.h"
;37:#include "be_ai_char.h"
;38:#include "be_ai_chat.h"
;39:#include "be_ai_gen.h"
;40:#include "be_ai_goal.h"
;41:#include "be_ai_move.h"
;42:#include "be_ai_weap.h"
;43://
;44:#include "ai_main.h"
;45:#include "ai_dmq3.h"
;46:#include "ai_chat.h"
;47:#include "ai_cmd.h"
;48:#include "ai_dmnet.h"
;49:#include "ai_team.h"
;50:
;51:#include "match.h"
;52:
;53:// for the voice chats
;54:#include "../../ui/menudef.h"
;55:
;56://ctf task preferences for a client
;57:typedef struct bot_ctftaskpreference_s
;58:{
;59:	char		name[36];
;60:	int			preference;
;61:} bot_ctftaskpreference_t;
;62:
;63:bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];
;64:
;65:
;66:/*
;67:==================
;68:BotValidTeamLeader
;69:==================
;70:*/
;71:int BotValidTeamLeader(bot_state_t *bs) {
line 72
;72:	if (!strlen(bs->teamleader)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $55
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $55
line 73
;73:	if (ClientFromName(bs->teamleader) == -1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $57
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $57
line 74
;74:	return qtrue;
CNSTI4 1
RETI4
LABELV $54
endproc BotValidTeamLeader 8 4
bss
align 4
LABELV $60
skip 4
export BotNumTeamMates
code
proc BotNumTeamMates 1060 12
line 82
;75:}
;76:
;77:/*
;78:==================
;79:BotNumTeamMates
;80:==================
;81:*/
;82:int BotNumTeamMates(bot_state_t *bs) {
line 87
;83:	int i, numplayers;
;84:	char buf[MAX_INFO_STRING];
;85:	static int maxclients;
;86:
;87:	if (!maxclients)
ADDRGP4 $60
INDIRI4
CNSTI4 0
NEI4 $61
line 88
;88:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $63
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $60
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $61
line 90
;89:
;90:	numplayers = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 91
;91:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $67
JUMPV
LABELV $64
line 92
;92:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 94
;93:		//if no config string or no name
;94:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $71
ADDRLP4 4
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $68
LABELV $71
ADDRGP4 $65
JUMPV
LABELV $68
line 96
;95:		//skip spectators
;96:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 3
NEI4 $72
ADDRGP4 $65
JUMPV
LABELV $72
line 98
;97:		//
;98:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $75
line 99
;99:			numplayers++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 100
;100:		}
LABELV $75
line 101
;101:	}
LABELV $65
line 91
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $67
ADDRLP4 0
INDIRI4
ADDRGP4 $60
INDIRI4
GEI4 $77
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $64
LABELV $77
line 102
;102:	return numplayers;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $59
endproc BotNumTeamMates 1060 12
export BotClientTravelTimeToGoal
proc BotClientTravelTimeToGoal 480 16
line 110
;103:}
;104:
;105:/*
;106:==================
;107:BotClientTravelTimeToGoal
;108:==================
;109:*/
;110:int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
line 114
;111:	playerState_t ps;
;112:	int areanum;
;113:
;114:	BotAI_GetClientState(client, &ps);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 115
;115:	areanum = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 472
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 472
INDIRI4
ASGNI4
line 116
;116:	if (!areanum) return 1;
ADDRLP4 468
INDIRI4
CNSTI4 0
NEI4 $80
CNSTI4 1
RETI4
ADDRGP4 $78
JUMPV
LABELV $80
line 117
;117:	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
RETI4
LABELV $78
endproc BotClientTravelTimeToGoal 480 16
bss
align 4
LABELV $84
skip 4
export BotSortTeamMatesByBaseTravelTime
code
proc BotSortTeamMatesByBaseTravelTime 1352 12
line 125
;118:}
;119:
;120:/*
;121:==================
;122:BotSortTeamMatesByBaseTravelTime
;123:==================
;124:*/
;125:int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {
line 131
;126:
;127:	int i, j, k, numteammates, traveltime;
;128:	char buf[MAX_INFO_STRING];
;129:	static int maxclients;
;130:	int traveltimes[MAX_CLIENTS];
;131:	bot_goal_t *goal = NULL;
ADDRLP4 1300
CNSTP4 0
ASGNP4
line 133
;132:
;133:	if (gametype == GT_CTF || gametype == GT_1FCTF) {
ADDRLP4 1304
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 4
EQI4 $87
ADDRLP4 1304
INDIRI4
CNSTI4 5
NEI4 $85
LABELV $87
line 134
;134:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 1
NEI4 $88
line 135
;135:			goal = &ctf_redflag;
ADDRLP4 1300
ADDRGP4 ctf_redflag
ASGNP4
ADDRGP4 $89
JUMPV
LABELV $88
line 137
;136:		else
;137:			goal = &ctf_blueflag;
ADDRLP4 1300
ADDRGP4 ctf_blueflag
ASGNP4
LABELV $89
line 138
;138:	}
LABELV $85
line 147
;139:#ifdef MISSIONPACK
;140:	else {
;141:		if (BotTeam(bs) == TEAM_RED)
;142:			goal = &redobelisk;
;143:		else
;144:			goal = &blueobelisk;
;145:	}
;146:#endif
;147:	if (!maxclients)
ADDRGP4 $84
INDIRI4
CNSTI4 0
NEI4 $90
line 148
;148:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $63
ARGP4
ADDRLP4 1308
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $84
ADDRLP4 1308
INDIRI4
ASGNI4
LABELV $90
line 150
;149:
;150:	numteammates = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 151
;151:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 $95
JUMPV
LABELV $92
line 152
;152:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 268
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 154
;153:		//if no config string or no name
;154:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 276
ARGP4
ADDRLP4 1312
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 0
EQI4 $98
ADDRLP4 276
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1316
INDIRP4
ARGP4
ADDRLP4 1320
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $96
LABELV $98
ADDRGP4 $93
JUMPV
LABELV $96
line 156
;155:		//skip spectators
;156:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 276
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 1324
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1324
INDIRP4
ARGP4
ADDRLP4 1328
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 3
NEI4 $99
ADDRGP4 $93
JUMPV
LABELV $99
line 158
;157:		//
;158:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
INDIRI4
ARGI4
ADDRLP4 1332
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
EQI4 $101
line 160
;159:			//
;160:			traveltime = BotClientTravelTimeToGoal(i, goal);
ADDRLP4 268
INDIRI4
ARGI4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1336
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 1336
INDIRI4
ASGNI4
line 162
;161:			//
;162:			for (j = 0; j < numteammates; j++) {
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $103
line 163
;163:				if (traveltime < traveltimes[j]) {
ADDRLP4 272
INDIRI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
GEI4 $107
line 164
;164:					for (k = numteammates; k > j; k--) {
ADDRLP4 0
ADDRLP4 264
INDIRI4
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 165
;165:						traveltimes[k] = traveltimes[k-1];
ADDRLP4 1340
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1340
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 1340
INDIRI4
ADDRLP4 4-4
ADDP4
INDIRI4
ASGNI4
line 166
;166:						teammates[k] = teammates[k-1];
ADDRLP4 1344
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1348
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1344
INDIRI4
ADDRLP4 1348
INDIRP4
ADDP4
ADDRLP4 1344
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 1348
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 167
;167:					}
LABELV $110
line 164
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $112
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
GTI4 $109
line 168
;168:					break;
ADDRGP4 $105
JUMPV
LABELV $107
line 170
;169:				}
;170:			}
LABELV $104
line 162
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $106
ADDRLP4 260
INDIRI4
ADDRLP4 264
INDIRI4
LTI4 $103
LABELV $105
line 171
;171:			traveltimes[j] = traveltime;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 172
;172:			teammates[j] = i;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 173
;173:			numteammates++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 174
;174:			if (numteammates >= maxteammates) break;
ADDRLP4 264
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $114
ADDRGP4 $94
JUMPV
LABELV $114
line 175
;175:		}
LABELV $101
line 176
;176:	}
LABELV $93
line 151
ADDRLP4 268
ADDRLP4 268
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $95
ADDRLP4 268
INDIRI4
ADDRGP4 $84
INDIRI4
GEI4 $116
ADDRLP4 268
INDIRI4
CNSTI4 64
LTI4 $92
LABELV $116
LABELV $94
line 177
;177:	return numteammates;
ADDRLP4 264
INDIRI4
RETI4
LABELV $83
endproc BotSortTeamMatesByBaseTravelTime 1352 12
export BotSetTeamMateTaskPreference
proc BotSetTeamMateTaskPreference 36 12
line 185
;178:}
;179:
;180:/*
;181:==================
;182:BotSetTeamMateTaskPreference
;183:==================
;184:*/
;185:void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
line 188
;186:	char teammatename[MAX_NETNAME];
;187:
;188:	ctftaskpreferences[teammate].preference = preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 189
;189:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 190
;190:	strcpy(ctftaskpreferences[teammate].name, teammatename);
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 191
;191:}
LABELV $117
endproc BotSetTeamMateTaskPreference 36 12
export BotGetTeamMateTaskPreference
proc BotGetTeamMateTaskPreference 40 12
line 198
;192:
;193:/*
;194:==================
;195:BotGetTeamMateTaskPreference
;196:==================
;197:*/
;198:int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
line 201
;199:	char teammatename[MAX_NETNAME];
;200:
;201:	if (!ctftaskpreferences[teammate].preference) return 0;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $120
CNSTI4 0
RETI4
ADDRGP4 $119
JUMPV
LABELV $120
line 202
;202:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 203
;203:	if (Q_stricmp(teammatename, ctftaskpreferences[teammate].name)) return 0;
ADDRLP4 0
ARGP4
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $123
CNSTI4 0
RETI4
ADDRGP4 $119
JUMPV
LABELV $123
line 204
;204:	return ctftaskpreferences[teammate].preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
RETI4
LABELV $119
endproc BotGetTeamMateTaskPreference 40 12
export BotSortTeamMatesByTaskPreference
proc BotSortTeamMatesByTaskPreference 804 12
line 212
;205:}
;206:
;207:/*
;208:==================
;209:BotSortTeamMatesByTaskPreference
;210:==================
;211:*/
;212:int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
line 218
;213:	int defenders[MAX_CLIENTS], numdefenders;
;214:	int attackers[MAX_CLIENTS], numattackers;
;215:	int roamers[MAX_CLIENTS], numroamers;
;216:	int i, preference;
;217:
;218:	numdefenders = numattackers = numroamers = 0;
ADDRLP4 788
CNSTI4 0
ASGNI4
ADDRLP4 272
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 788
INDIRI4
ASGNI4
line 219
;219:	for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $127
line 220
;220:		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 792
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 792
INDIRI4
ASGNI4
line 221
;221:		if (preference & TEAMTP_DEFENDER) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $131
line 222
;222:			defenders[numdefenders++] = teammates[i];
ADDRLP4 796
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 223
;223:		}
ADDRGP4 $132
JUMPV
LABELV $131
line 224
;224:		else if (preference & TEAMTP_ATTACKER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $133
line 225
;225:			attackers[numattackers++] = teammates[i];
ADDRLP4 796
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 276
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 226
;226:		}
ADDRGP4 $134
JUMPV
LABELV $133
line 227
;227:		else {
line 228
;228:			roamers[numroamers++] = teammates[i];
ADDRLP4 796
ADDRLP4 272
INDIRI4
ASGNI4
ADDRLP4 272
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 532
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 229
;229:		}
LABELV $134
LABELV $132
line 230
;230:	}
LABELV $128
line 219
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $130
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $127
line 231
;231:	numteammates = 0;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 233
;232:	//defenders at the front of the list
;233:	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
ADDRLP4 792
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 792
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
CVIU4 4
ADDRLP4 792
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 234
;234:	numteammates += numdefenders;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 236
;235:	//roamers in the middle
;236:	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
ADDRLP4 796
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 796
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 532
ARGP4
ADDRLP4 272
INDIRI4
CVIU4 4
ADDRLP4 796
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 237
;237:	numteammates += numroamers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 272
INDIRI4
ADDI4
ASGNI4
line 239
;238:	//attacker in the back of the list
;239:	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 268
INDIRI4
CVIU4 4
ADDRLP4 800
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 240
;240:	numteammates += numattackers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 268
INDIRI4
ADDI4
ASGNI4
line 242
;241:
;242:	return numteammates;
ADDRFP4 8
INDIRI4
RETI4
LABELV $126
endproc BotSortTeamMatesByTaskPreference 804 12
export BotSayTeamOrderAlways
proc BotSayTeamOrderAlways 548 20
line 250
;243:}
;244:
;245:/*
;246:==================
;247:BotSayTeamOrders
;248:==================
;249:*/
;250:void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
line 256
;251:	char teamchat[MAX_MESSAGE_SIZE];
;252:	char buf[MAX_MESSAGE_SIZE];
;253:	char name[MAX_NETNAME];
;254:
;255:	//if the bot is talking to itself
;256:	if (bs->client == toclient) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $136
line 258
;257:		//don't show the message just put it in the console message queue
;258:		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGetChatMessage
CALLV
pop
line 259
;259:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 260
;260:		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $138
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 261
;261:		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 262
;262:	}
ADDRGP4 $137
JUMPV
LABELV $136
line 263
;263:	else {
line 264
;264:		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 265
;265:	}
LABELV $137
line 266
;266:}
LABELV $135
endproc BotSayTeamOrderAlways 548 20
export BotSayTeamOrder
proc BotSayTeamOrder 0 8
line 273
;267:
;268:/*
;269:==================
;270:BotSayTeamOrders
;271:==================
;272:*/
;273:void BotSayTeamOrder(bot_state_t *bs, int toclient) {
line 280
;274:#ifdef MISSIONPACK
;275:	// voice chats only
;276:	char buf[MAX_MESSAGE_SIZE];
;277:
;278:	trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
;279:#else
;280:	BotSayTeamOrderAlways(bs, toclient);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 282
;281:#endif
;282:}
LABELV $139
endproc BotSayTeamOrder 0 8
export BotVoiceChat
proc BotVoiceChat 0 0
line 289
;283:
;284:/*
;285:==================
;286:BotVoiceChat
;287:==================
;288:*/
;289:void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) {
line 298
;290:#ifdef MISSIONPACK
;291:	if (toclient == -1)
;292:		// voice only say team
;293:		trap_EA_Command(bs->client, va("vsay_team %s", voicechat));
;294:	else
;295:		// voice only tell single player
;296:		trap_EA_Command(bs->client, va("vtell %d %s", toclient, voicechat));
;297:#endif
;298:}
LABELV $140
endproc BotVoiceChat 0 0
export BotVoiceChatOnly
proc BotVoiceChatOnly 0 0
line 305
;299:
;300:/*
;301:==================
;302:BotVoiceChatOnly
;303:==================
;304:*/
;305:void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) {
line 314
;306:#ifdef MISSIONPACK
;307:	if (toclient == -1)
;308:		// voice only say team
;309:		trap_EA_Command(bs->client, va("vosay_team %s", voicechat));
;310:	else
;311:		// voice only tell single player
;312:		trap_EA_Command(bs->client, va("votell %d %s", toclient, voicechat));
;313:#endif
;314:}
LABELV $141
endproc BotVoiceChatOnly 0 0
export BotSayVoiceTeamOrder
proc BotSayVoiceTeamOrder 0 0
line 321
;315:
;316:/*
;317:==================
;318:BotSayVoiceTeamOrder
;319:==================
;320:*/
;321:void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) {
line 325
;322:#ifdef MISSIONPACK
;323:	BotVoiceChat(bs, toclient, voicechat);
;324:#endif
;325:}
LABELV $142
endproc BotSayVoiceTeamOrder 0 0
export BotCTFOrders_BothFlagsNotAtBase
proc BotCTFOrders_BothFlagsNotAtBase 368 20
line 332
;326:
;327:/*
;328:==================
;329:BotCTFOrders
;330:==================
;331:*/
;332:void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
line 337
;333:	int numteammates, defenders, attackers, i, other;
;334:	int teammates[MAX_CLIENTS];
;335:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;336:
;337:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 348
INDIRI4
ASGNI4
line 338
;338:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 340
;339:	//different orders based on the number of team mates
;340:	switch(bs->numteammates) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 1
EQI4 $145
ADDRLP4 352
INDIRI4
CNSTI4 2
EQI4 $148
ADDRLP4 352
INDIRI4
CNSTI4 3
EQI4 $154
ADDRGP4 $144
JUMPV
line 341
;341:		case 1: break;
LABELV $148
line 343
;342:		case 2:
;343:		{
line 345
;344:			//tell the one not carrying the flag to attack the enemy base
;345:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $149
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $149
line 346
;346:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $150
line 347
;347:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 348
;348:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 349
;349:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 350
;350:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 351
;351:			break;
ADDRGP4 $145
JUMPV
LABELV $154
line 354
;352:		}
;353:		case 3:
;354:		{
line 356
;355:			//tell the one closest to the base not carrying the flag to accompany the flag carrier
;356:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $155
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $156
JUMPV
LABELV $155
line 357
;357:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $156
line 358
;358:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 359
;359:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $158
line 360
;360:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 361
;361:				if (bs->flagcarrier == bs->client) {
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $160
line 362
;362:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 363
;363:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $163
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 364
;364:				}
ADDRGP4 $159
JUMPV
LABELV $160
line 365
;365:				else {
line 366
;366:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 367
;367:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $165
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 368
;368:				}
line 369
;369:			}
ADDRGP4 $159
JUMPV
LABELV $158
line 370
;370:			else {
line 372
;371:				//
;372:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 373
;373:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 374
;374:			}
LABELV $159
line 375
;375:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 377
;376:			//tell the one furthest from the the base not carrying the flag to get the enemy flag
;377:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $166
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $166
line 378
;378:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $167
line 379
;379:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 380
;380:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 381
;381:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 382
;382:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 383
;383:			break;
ADDRGP4 $145
JUMPV
LABELV $144
line 386
;384:		}
;385:		default:
;386:		{
line 387
;387:			defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 388
;388:			if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $172
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $172
line 389
;389:			attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 360
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 360
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 360
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 390
;390:			if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $174
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $174
line 391
;391:			if (bs->flagcarrier != -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $176
line 392
;392:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 393
;393:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $181
JUMPV
LABELV $178
line 395
;394:					//
;395:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $182
line 396
;396:						continue;
ADDRGP4 $179
JUMPV
LABELV $182
line 399
;397:					}
;398:					//
;399:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 400
;400:					if (bs->flagcarrier == bs->client) {
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 364
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 364
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $184
line 401
;401:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 402
;402:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $163
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 403
;403:					}
ADDRGP4 $185
JUMPV
LABELV $184
line 404
;404:					else {
line 405
;405:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 406
;406:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $165
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 407
;407:					}
LABELV $185
line 408
;408:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 409
;409:				}
LABELV $179
line 393
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $181
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $178
line 410
;410:			}
ADDRGP4 $177
JUMPV
LABELV $176
line 411
;411:			else {
line 412
;412:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $186
line 414
;413:					//
;414:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $190
line 415
;415:						continue;
ADDRGP4 $187
JUMPV
LABELV $190
line 418
;416:					}
;417:					//
;418:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 419
;419:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 420
;420:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 421
;421:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 422
;422:				}
LABELV $187
line 412
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $189
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $186
line 423
;423:			}
LABELV $177
line 424
;424:			for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $192
line 426
;425:				//
;426:				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $196
line 427
;427:					continue;
ADDRGP4 $193
JUMPV
LABELV $196
line 430
;428:				}
;429:				//
;430:				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 431
;431:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 432
;432:				BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 433
;433:				BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 434
;434:			}
LABELV $193
line 424
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $195
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $192
line 436
;435:			//
;436:			break;
LABELV $145
line 439
;437:		}
;438:	}
;439:}
LABELV $143
endproc BotCTFOrders_BothFlagsNotAtBase 368 20
export BotCTFOrders_FlagNotAtBase
proc BotCTFOrders_FlagNotAtBase 320 16
line 446
;440:
;441:/*
;442:==================
;443:BotCTFOrders
;444:==================
;445:*/
;446:void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
line 451
;447:	int numteammates, defenders, attackers, i;
;448:	int teammates[MAX_CLIENTS];
;449:	char name[MAX_NETNAME];
;450:
;451:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 452
;452:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 454
;453:	//passive strategy
;454:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $203
line 456
;455:		//different orders based on the number of team mates
;456:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $204
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $209
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $214
ADDRGP4 $205
JUMPV
line 457
;457:			case 1: break;
LABELV $209
line 459
;458:			case 2:
;459:			{
line 461
;460:				//both will go for the enemy flag
;461:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 462
;462:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 463
;463:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 464
;464:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 466
;465:				//
;466:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 467
;467:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 468
;468:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 469
;469:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 470
;470:				break;
ADDRGP4 $204
JUMPV
LABELV $214
line 473
;471:			}
;472:			case 3:
;473:			{
line 475
;474:				//keep one near the base for when the flag is returned
;475:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 476
;476:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 477
;477:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 478
;478:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 480
;479:				//the other two get the flag
;480:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 481
;481:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 482
;482:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 483
;483:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 485
;484:				//
;485:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 486
;486:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 487
;487:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 488
;488:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 489
;489:				break;
ADDRGP4 $204
JUMPV
LABELV $205
line 492
;490:			}
;491:			default:
;492:			{
line 494
;493:				//keep some people near the base for when the flag is returned
;494:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 495
;495:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $222
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $222
line 496
;496:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 497
;497:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $224
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $224
line 498
;498:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $229
JUMPV
LABELV $226
line 500
;499:					//
;500:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 501
;501:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 502
;502:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 503
;503:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 504
;504:				}
LABELV $227
line 498
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $229
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $226
line 505
;505:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $233
JUMPV
LABELV $230
line 507
;506:					//
;507:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 508
;508:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 509
;509:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 510
;510:					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 511
;511:				}
LABELV $231
line 505
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $233
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $230
line 513
;512:				//
;513:				break;
line 516
;514:			}
;515:		}
;516:	}
ADDRGP4 $204
JUMPV
LABELV $203
line 517
;517:	else {
line 519
;518:		//different orders based on the number of team mates
;519:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $237
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $240
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $244
ADDRGP4 $236
JUMPV
line 520
;520:			case 1: break;
LABELV $240
line 522
;521:			case 2:
;522:			{
line 524
;523:				//both will go for the enemy flag
;524:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 525
;525:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 526
;526:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 527
;527:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 529
;528:				//
;529:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 530
;530:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 531
;531:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 532
;532:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 533
;533:				break;
ADDRGP4 $237
JUMPV
LABELV $244
line 536
;534:			}
;535:			case 3:
;536:			{
line 538
;537:				//everyone go for the flag
;538:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 539
;539:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 540
;540:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 541
;541:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 543
;542:				//
;543:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 544
;544:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 545
;545:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 546
;546:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 548
;547:				//
;548:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 549
;549:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 550
;550:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 551
;551:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 552
;552:				break;
ADDRGP4 $237
JUMPV
LABELV $236
line 555
;553:			}
;554:			default:
;555:			{
line 557
;556:				//keep some people near the base for when the flag is returned
;557:				defenders = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 300
CNSTF4 1045220557
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 558
;558:				if (defenders > 2) defenders = 2;
ADDRLP4 300
INDIRI4
CNSTI4 2
LEI4 $251
ADDRLP4 300
CNSTI4 2
ASGNI4
LABELV $251
line 559
;559:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 560
;560:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $253
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $253
line 561
;561:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $258
JUMPV
LABELV $255
line 563
;562:					//
;563:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 564
;564:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 565
;565:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 566
;566:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 567
;567:				}
LABELV $256
line 561
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $258
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $255
line 568
;568:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $262
JUMPV
LABELV $259
line 570
;569:					//
;570:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 571
;571:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 572
;572:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 573
;573:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 574
;574:				}
LABELV $260
line 568
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $262
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $259
line 576
;575:				//
;576:				break;
LABELV $237
line 579
;577:			}
;578:		}
;579:	}
LABELV $204
line 580
;580:}
LABELV $202
endproc BotCTFOrders_FlagNotAtBase 320 16
export BotCTFOrders_EnemyFlagNotAtBase
proc BotCTFOrders_EnemyFlagNotAtBase 360 20
line 587
;581:
;582:/*
;583:==================
;584:BotCTFOrders
;585:==================
;586:*/
;587:void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
line 592
;588:	int numteammates, defenders, attackers, i, other;
;589:	int teammates[MAX_CLIENTS];
;590:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;591:
;592:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 348
INDIRI4
ASGNI4
line 593
;593:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 595
;594:	//different orders based on the number of team mates
;595:	switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $268
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $270
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $274
ADDRGP4 $267
JUMPV
line 596
;596:		case 1: break;
LABELV $270
line 598
;597:		case 2:
;598:		{
line 600
;599:			//tell the one not carrying the flag to defend the base
;600:			if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $271
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $271
line 601
;601:			else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $272
line 602
;602:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 603
;603:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 604
;604:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 605
;605:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 606
;606:			break;
ADDRGP4 $268
JUMPV
LABELV $274
line 609
;607:		}
;608:		case 3:
;609:		{
line 611
;610:			//tell the one closest to the base not carrying the flag to defend the base
;611:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $275
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $276
JUMPV
LABELV $275
line 612
;612:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $276
line 613
;613:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 614
;614:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 615
;615:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 616
;616:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 618
;617:			//tell the other also to defend the base
;618:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $278
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $278
line 619
;619:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $279
line 620
;620:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 621
;621:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 622
;622:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 623
;623:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 624
;624:			break;
ADDRGP4 $268
JUMPV
LABELV $267
line 627
;625:		}
;626:		default:
;627:		{
line 629
;628:			//60% will defend the base
;629:			defenders = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 300
CNSTF4 1058642330
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 630
;630:			if (defenders > 6) defenders = 6;
ADDRLP4 300
INDIRI4
CNSTI4 6
LEI4 $283
ADDRLP4 300
CNSTI4 6
ASGNI4
LABELV $283
line 632
;631:			//30% accompanies the flag carrier
;632:			attackers = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 304
CNSTF4 1050253722
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 633
;633:			if (attackers > 3) attackers = 3;
ADDRLP4 304
INDIRI4
CNSTI4 3
LEI4 $285
ADDRLP4 304
CNSTI4 3
ASGNI4
LABELV $285
line 634
;634:			for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $290
JUMPV
LABELV $287
line 636
;635:				//
;636:				if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $291
line 637
;637:					continue;
ADDRGP4 $288
JUMPV
LABELV $291
line 639
;638:				}
;639:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 640
;640:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 641
;641:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 642
;642:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 643
;643:			}
LABELV $288
line 634
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $290
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $287
line 645
;644:			// if we have a flag carrier
;645:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $293
line 646
;646:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 647
;647:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $298
JUMPV
LABELV $295
line 649
;648:					//
;649:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $299
line 650
;650:						continue;
ADDRGP4 $296
JUMPV
LABELV $299
line 653
;651:					}
;652:					//
;653:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 654
;654:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $303
line 655
;655:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 656
;656:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $163
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 657
;657:					}
ADDRGP4 $304
JUMPV
LABELV $303
line 658
;658:					else {
line 659
;659:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 660
;660:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $165
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 661
;661:					}
LABELV $304
line 662
;662:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 663
;663:				}
LABELV $296
line 647
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $298
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $295
line 664
;664:			}
ADDRGP4 $268
JUMPV
LABELV $293
line 665
;665:			else {
line 666
;666:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $308
line 668
;667:					//
;668:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $312
line 669
;669:						continue;
ADDRGP4 $309
JUMPV
LABELV $312
line 672
;670:					}
;671:					//
;672:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 673
;673:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 674
;674:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 675
;675:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 676
;676:				}
LABELV $309
line 666
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $311
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $308
line 677
;677:			}
line 679
;678:			//
;679:			break;
LABELV $268
line 682
;680:		}
;681:	}
;682:}
LABELV $266
endproc BotCTFOrders_EnemyFlagNotAtBase 360 20
export BotCTFOrders_BothFlagsAtBase
proc BotCTFOrders_BothFlagsAtBase 320 16
line 690
;683:
;684:
;685:/*
;686:==================
;687:BotCTFOrders
;688:==================
;689:*/
;690:void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
line 696
;691:	int numteammates, defenders, attackers, i;
;692:	int teammates[MAX_CLIENTS];
;693:	char name[MAX_NETNAME];
;694:
;695:	//sort team mates by travel time to base
;696:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 698
;697:	//sort team mates by CTF preference
;698:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 700
;699:	//passive strategy
;700:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $319
line 702
;701:		//different orders based on the number of team mates
;702:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $320
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $324
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $328
ADDRGP4 $321
JUMPV
line 703
;703:			case 1: break;
LABELV $324
line 705
;704:			case 2:
;705:			{
line 707
;706:				//the one closest to the base will defend the base
;707:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 708
;708:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 709
;709:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 710
;710:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 712
;711:				//the other will get the flag
;712:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 713
;713:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 714
;714:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 715
;715:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 716
;716:				break;
ADDRGP4 $320
JUMPV
LABELV $328
line 719
;717:			}
;718:			case 3:
;719:			{
line 721
;720:				//the one closest to the base will defend the base
;721:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 722
;722:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 723
;723:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 724
;724:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 726
;725:				//the second one closest to the base will defend the base
;726:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 727
;727:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 728
;728:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 729
;729:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 731
;730:				//the other will get the flag
;731:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 732
;732:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 733
;733:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 734
;734:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 735
;735:				break;
ADDRGP4 $320
JUMPV
LABELV $321
line 738
;736:			}
;737:			default:
;738:			{
line 739
;739:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 740
;740:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $335
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $335
line 741
;741:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 742
;742:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $337
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $337
line 743
;743:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $342
JUMPV
LABELV $339
line 745
;744:					//
;745:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 746
;746:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 747
;747:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 748
;748:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 749
;749:				}
LABELV $340
line 743
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $342
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $339
line 750
;750:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $346
JUMPV
LABELV $343
line 752
;751:					//
;752:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 753
;753:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 754
;754:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 755
;755:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 756
;756:				}
LABELV $344
line 750
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $346
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $343
line 758
;757:				//
;758:				break;
line 761
;759:			}
;760:		}
;761:	}
ADDRGP4 $320
JUMPV
LABELV $319
line 762
;762:	else {
line 764
;763:		//different orders based on the number of team mates
;764:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $351
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $353
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $357
ADDRGP4 $350
JUMPV
line 765
;765:			case 1: break;
LABELV $353
line 767
;766:			case 2:
;767:			{
line 769
;768:				//the one closest to the base will defend the base
;769:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 770
;770:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 771
;771:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 772
;772:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 774
;773:				//the other will get the flag
;774:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 775
;775:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 776
;776:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 777
;777:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 778
;778:				break;
ADDRGP4 $351
JUMPV
LABELV $357
line 781
;779:			}
;780:			case 3:
;781:			{
line 783
;782:				//the one closest to the base will defend the base
;783:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 784
;784:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 785
;785:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 786
;786:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 788
;787:				//the others should go for the enemy flag
;788:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 789
;789:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 790
;790:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 791
;791:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 793
;792:				//
;793:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 794
;794:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 795
;795:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 796
;796:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 797
;797:				break;
ADDRGP4 $351
JUMPV
LABELV $350
line 800
;798:			}
;799:			default:
;800:			{
line 801
;801:				defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 802
;802:				if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $364
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $364
line 803
;803:				attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 804
;804:				if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $366
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $366
line 805
;805:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $371
JUMPV
LABELV $368
line 807
;806:					//
;807:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 808
;808:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 809
;809:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 810
;810:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 811
;811:				}
LABELV $369
line 805
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $371
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $368
line 812
;812:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $375
JUMPV
LABELV $372
line 814
;813:					//
;814:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 815
;815:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 816
;816:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 817
;817:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 818
;818:				}
LABELV $373
line 812
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $375
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $372
line 820
;819:				//
;820:				break;
LABELV $351
line 823
;821:			}
;822:		}
;823:	}
LABELV $320
line 824
;824:}
LABELV $318
endproc BotCTFOrders_BothFlagsAtBase 320 16
export BotCTFOrders
proc BotCTFOrders 20 4
line 831
;825:
;826:/*
;827:==================
;828:BotCTFOrders
;829:==================
;830:*/
;831:void BotCTFOrders(bot_state_t *bs) {
line 835
;832:	int flagstatus;
;833:
;834:	//
;835:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
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
NEI4 $380
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $381
JUMPV
LABELV $380
line 836
;836:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $381
line 838
;837:	//
;838:	switch(flagstatus) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $382
ADDRLP4 16
INDIRI4
CNSTI4 3
GTI4 $382
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $388
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $388
address $384
address $385
address $386
address $387
code
LABELV $384
line 839
;839:		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsAtBase
CALLV
pop
ADDRGP4 $383
JUMPV
LABELV $385
line 840
;840:		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_EnemyFlagNotAtBase
CALLV
pop
ADDRGP4 $383
JUMPV
LABELV $386
line 841
;841:		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_FlagNotAtBase
CALLV
pop
ADDRGP4 $383
JUMPV
LABELV $387
line 842
;842:		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsNotAtBase
CALLV
pop
LABELV $382
LABELV $383
line 844
;843:	}
;844:}
LABELV $379
endproc BotCTFOrders 20 4
export BotCreateGroup
proc BotCreateGroup 76 20
line 852
;845:
;846:
;847:/*
;848:==================
;849:BotCreateGroup
;850:==================
;851:*/
;852:void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
line 857
;853:	char name[MAX_NETNAME], leadername[MAX_NETNAME];
;854:	int i;
;855:
;856:	// the others in the group will follow the teammates[0]
;857:	ClientName(teammates[0], leadername, sizeof(leadername));
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 858
;858:	for (i = 1; i < groupsize; i++)
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $393
JUMPV
LABELV $390
line 859
;859:	{
line 860
;860:		ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 861
;861:		if (teammates[0] == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $394
line 862
;862:			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 863
;863:		}
ADDRGP4 $395
JUMPV
LABELV $394
line 864
;864:		else {
line 865
;865:			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 40
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 866
;866:		}
LABELV $395
line 867
;867:		BotSayTeamOrderAlways(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 868
;868:	}
LABELV $391
line 858
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $393
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $390
line 869
;869:}
LABELV $389
endproc BotCreateGroup 76 20
bss
align 4
LABELV $397
skip 4
export BotTeamOrders
code
proc BotTeamOrders 1316 12
line 878
;870:
;871:/*
;872:==================
;873:BotTeamOrders
;874:
;875:  FIXME: defend key areas?
;876:==================
;877:*/
;878:void BotTeamOrders(bot_state_t *bs) {
line 884
;879:	int teammates[MAX_CLIENTS];
;880:	int numteammates, i;
;881:	char buf[MAX_INFO_STRING];
;882:	static int maxclients;
;883:
;884:	if (!maxclients)
ADDRGP4 $397
INDIRI4
CNSTI4 0
NEI4 $398
line 885
;885:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $63
ARGP4
ADDRLP4 1288
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $397
ADDRLP4 1288
INDIRI4
ASGNI4
LABELV $398
line 887
;886:
;887:	numteammates = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 888
;888:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $403
JUMPV
LABELV $400
line 889
;889:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 891
;890:		//if no config string or no name
;891:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 0
EQI4 $406
ADDRLP4 4
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1296
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1296
INDIRP4
ARGP4
ADDRLP4 1300
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 0
NEI4 $404
LABELV $406
ADDRGP4 $401
JUMPV
LABELV $404
line 893
;892:		//skip spectators
;893:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 1304
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1304
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 3
NEI4 $407
ADDRGP4 $401
JUMPV
LABELV $407
line 895
;894:		//
;895:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1312
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 0
EQI4 $409
line 896
;896:			teammates[numteammates] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 897
;897:			numteammates++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 898
;898:		}
LABELV $409
line 899
;899:	}
LABELV $401
line 888
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $403
ADDRLP4 0
INDIRI4
ADDRGP4 $397
INDIRI4
GEI4 $411
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $400
LABELV $411
line 901
;900:	//
;901:	switch(numteammates) {
ADDRLP4 1028
INDIRI4
CNSTI4 1
LTI4 $412
ADDRLP4 1028
INDIRI4
CNSTI4 5
GTI4 $412
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $427-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $427
address $413
address $413
address $416
address $417
address $419
code
line 902
;902:		case 1: break;
line 904
;903:		case 2:
;904:		{
line 906
;905:			//nothing special
;906:			break;
LABELV $416
line 909
;907:		}
;908:		case 3:
;909:		{
line 911
;910:			//have one follow another and one free roaming
;911:			BotCreateGroup(bs, teammates, 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 912
;912:			break;
ADDRGP4 $413
JUMPV
LABELV $417
line 915
;913:		}
;914:		case 4:
;915:		{
line 916
;916:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 917
;917:			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 918
;918:			break;
ADDRGP4 $413
JUMPV
LABELV $419
line 921
;919:		}
;920:		case 5:
;921:		{
line 922
;922:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 923
;923:			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 924
;924:			break;
ADDRGP4 $413
JUMPV
LABELV $412
line 927
;925:		}
;926:		default:
;927:		{
line 928
;928:			if (numteammates <= 10) {
ADDRLP4 1028
INDIRI4
CNSTI4 10
GTI4 $413
line 929
;929:				for (i = 0; i < numteammates / 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $426
JUMPV
LABELV $423
line 930
;930:					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1300
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 1300
INDIRI4
LSHI4
ADDRLP4 1032
ADDP4
ARGP4
ADDRLP4 1300
INDIRI4
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 931
;931:				}
LABELV $424
line 929
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $426
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
DIVI4
LTI4 $423
line 932
;932:			}
line 933
;933:			break;
LABELV $413
line 936
;934:		}
;935:	}
;936:}
LABELV $396
endproc BotTeamOrders 1316 12
export FindHumanTeamLeader
proc FindHumanTeamLeader 12 12
line 1898
;937:
;938:#ifdef MISSIONPACK
;939:
;940:/*
;941:==================
;942:Bot1FCTFOrders_FlagAtCenter
;943:
;944:  X% defend the base, Y% get the flag
;945:==================
;946:*/
;947:void Bot1FCTFOrders_FlagAtCenter(bot_state_t *bs) {
;948:	int numteammates, defenders, attackers, i;
;949:	int teammates[MAX_CLIENTS];
;950:	char name[MAX_NETNAME];
;951:
;952:	//sort team mates by travel time to base
;953:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;954:	//sort team mates by CTF preference
;955:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;956:	//passive strategy
;957:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;958:		//different orders based on the number of team mates
;959:		switch(numteammates) {
;960:			case 1: break;
;961:			case 2:
;962:			{
;963:				//the one closest to the base will defend the base
;964:				ClientName(teammates[0], name, sizeof(name));
;965:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;966:				BotSayTeamOrder(bs, teammates[0]);
;967:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;968:				//the other will get the flag
;969:				ClientName(teammates[1], name, sizeof(name));
;970:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;971:				BotSayTeamOrder(bs, teammates[1]);
;972:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;973:				break;
;974:			}
;975:			case 3:
;976:			{
;977:				//the one closest to the base will defend the base
;978:				ClientName(teammates[0], name, sizeof(name));
;979:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;980:				BotSayTeamOrder(bs, teammates[0]);
;981:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;982:				//the second one closest to the base will defend the base
;983:				ClientName(teammates[1], name, sizeof(name));
;984:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;985:				BotSayTeamOrder(bs, teammates[1]);
;986:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;987:				//the other will get the flag
;988:				ClientName(teammates[2], name, sizeof(name));
;989:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;990:				BotSayTeamOrder(bs, teammates[2]);
;991:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;992:				break;
;993:			}
;994:			default:
;995:			{
;996:				//50% defend the base
;997:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;998:				if (defenders > 5) defenders = 5;
;999:				//40% get the flag
;1000:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1001:				if (attackers > 4) attackers = 4;
;1002:				for (i = 0; i < defenders; i++) {
;1003:					//
;1004:					ClientName(teammates[i], name, sizeof(name));
;1005:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1006:					BotSayTeamOrder(bs, teammates[i]);
;1007:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1008:				}
;1009:				for (i = 0; i < attackers; i++) {
;1010:					//
;1011:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1012:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1013:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1014:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1015:				}
;1016:				//
;1017:				break;
;1018:			}
;1019:		}
;1020:	}
;1021:	else { //agressive
;1022:		//different orders based on the number of team mates
;1023:		switch(numteammates) {
;1024:			case 1: break;
;1025:			case 2:
;1026:			{
;1027:				//the one closest to the base will defend the base
;1028:				ClientName(teammates[0], name, sizeof(name));
;1029:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1030:				BotSayTeamOrder(bs, teammates[0]);
;1031:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1032:				//the other will get the flag
;1033:				ClientName(teammates[1], name, sizeof(name));
;1034:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1035:				BotSayTeamOrder(bs, teammates[1]);
;1036:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1037:				break;
;1038:			}
;1039:			case 3:
;1040:			{
;1041:				//the one closest to the base will defend the base
;1042:				ClientName(teammates[0], name, sizeof(name));
;1043:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1044:				BotSayTeamOrder(bs, teammates[0]);
;1045:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1046:				//the others should go for the enemy flag
;1047:				ClientName(teammates[1], name, sizeof(name));
;1048:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1049:				BotSayTeamOrder(bs, teammates[1]);
;1050:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1051:				//
;1052:				ClientName(teammates[2], name, sizeof(name));
;1053:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1054:				BotSayTeamOrder(bs, teammates[2]);
;1055:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1056:				break;
;1057:			}
;1058:			default:
;1059:			{
;1060:				//30% defend the base
;1061:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1062:				if (defenders > 3) defenders = 3;
;1063:				//60% get the flag
;1064:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1065:				if (attackers > 6) attackers = 6;
;1066:				for (i = 0; i < defenders; i++) {
;1067:					//
;1068:					ClientName(teammates[i], name, sizeof(name));
;1069:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1070:					BotSayTeamOrder(bs, teammates[i]);
;1071:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1072:				}
;1073:				for (i = 0; i < attackers; i++) {
;1074:					//
;1075:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1076:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1077:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1078:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1079:				}
;1080:				//
;1081:				break;
;1082:			}
;1083:		}
;1084:	}
;1085:}
;1086:
;1087:/*
;1088:==================
;1089:Bot1FCTFOrders_TeamHasFlag
;1090:
;1091:  X% towards neutral flag, Y% go towards enemy base and accompany flag carrier if visible
;1092:==================
;1093:*/
;1094:void Bot1FCTFOrders_TeamHasFlag(bot_state_t *bs) {
;1095:	int numteammates, defenders, attackers, i, other;
;1096:	int teammates[MAX_CLIENTS];
;1097:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1098:
;1099:	//sort team mates by travel time to base
;1100:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1101:	//sort team mates by CTF preference
;1102:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1103:	//passive strategy
;1104:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1105:		//different orders based on the number of team mates
;1106:		switch(numteammates) {
;1107:			case 1: break;
;1108:			case 2:
;1109:			{
;1110:				//tell the one not carrying the flag to attack the enemy base
;1111:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1112:				else other = teammates[0];
;1113:				ClientName(other, name, sizeof(name));
;1114:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1115:				BotSayTeamOrder(bs, other);
;1116:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_OFFENSE);
;1117:				break;
;1118:			}
;1119:			case 3:
;1120:			{
;1121:				//tell the one closest to the base not carrying the flag to defend the base
;1122:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1123:				else other = teammates[1];
;1124:				ClientName(other, name, sizeof(name));
;1125:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1126:				BotSayTeamOrder(bs, other);
;1127:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1128:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1129:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1130:				else other = teammates[1];
;1131:				ClientName(other, name, sizeof(name));
;1132:				if ( bs->flagcarrier != -1 ) {
;1133:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1134:					if (bs->flagcarrier == bs->client) {
;1135:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1136:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1137:					}
;1138:					else {
;1139:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1140:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1141:					}
;1142:				}
;1143:				else {
;1144:					//
;1145:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1146:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;1147:				}
;1148:				BotSayTeamOrder(bs, other);
;1149:				break;
;1150:			}
;1151:			default:
;1152:			{
;1153:				//30% will defend the base
;1154:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1155:				if (defenders > 3) defenders = 3;
;1156:				//70% accompanies the flag carrier
;1157:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1158:				if (attackers > 7) attackers = 7;
;1159:				for (i = 0; i < defenders; i++) {
;1160:					//
;1161:					if (teammates[i] == bs->flagcarrier) {
;1162:						continue;
;1163:					}
;1164:					ClientName(teammates[i], name, sizeof(name));
;1165:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1166:					BotSayTeamOrder(bs, teammates[i]);
;1167:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1168:				}
;1169:				if (bs->flagcarrier != -1) {
;1170:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1171:					for (i = 0; i < attackers; i++) {
;1172:						//
;1173:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1174:							continue;
;1175:						}
;1176:						//
;1177:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1178:						if (bs->flagcarrier == bs->client) {
;1179:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1180:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1181:						}
;1182:						else {
;1183:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1184:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1185:						}
;1186:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1187:					}
;1188:				}
;1189:				else {
;1190:					for (i = 0; i < attackers; i++) {
;1191:						//
;1192:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1193:							continue;
;1194:						}
;1195:						//
;1196:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1197:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1198:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1199:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1200:					}
;1201:				}
;1202:				//
;1203:				break;
;1204:			}
;1205:		}
;1206:	}
;1207:	else { //agressive
;1208:		//different orders based on the number of team mates
;1209:		switch(numteammates) {
;1210:			case 1: break;
;1211:			case 2:
;1212:			{
;1213:				//tell the one not carrying the flag to defend the base
;1214:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1215:				else other = teammates[0];
;1216:				ClientName(other, name, sizeof(name));
;1217:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1218:				BotSayTeamOrder(bs, other);
;1219:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1220:				break;
;1221:			}
;1222:			case 3:
;1223:			{
;1224:				//tell the one closest to the base not carrying the flag to defend the base
;1225:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1226:				else other = teammates[1];
;1227:				ClientName(other, name, sizeof(name));
;1228:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1229:				BotSayTeamOrder(bs, other);
;1230:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1231:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1232:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1233:				else other = teammates[1];
;1234:				ClientName(other, name, sizeof(name));
;1235:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1236:				if (bs->flagcarrier == bs->client) {
;1237:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1238:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1239:				}
;1240:				else {
;1241:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1242:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1243:				}
;1244:				BotSayTeamOrder(bs, other);
;1245:				break;
;1246:			}
;1247:			default:
;1248:			{
;1249:				//20% will defend the base
;1250:				defenders = (int) (float) numteammates * 0.2 + 0.5;
;1251:				if (defenders > 2) defenders = 2;
;1252:				//80% accompanies the flag carrier
;1253:				attackers = (int) (float) numteammates * 0.8 + 0.5;
;1254:				if (attackers > 8) attackers = 8;
;1255:				for (i = 0; i < defenders; i++) {
;1256:					//
;1257:					if (teammates[i] == bs->flagcarrier) {
;1258:						continue;
;1259:					}
;1260:					ClientName(teammates[i], name, sizeof(name));
;1261:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1262:					BotSayTeamOrder(bs, teammates[i]);
;1263:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1264:				}
;1265:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1266:				for (i = 0; i < attackers; i++) {
;1267:					//
;1268:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1269:						continue;
;1270:					}
;1271:					//
;1272:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1273:					if (bs->flagcarrier == bs->client) {
;1274:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1275:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1276:					}
;1277:					else {
;1278:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1279:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1280:					}
;1281:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1282:				}
;1283:				//
;1284:				break;
;1285:			}
;1286:		}
;1287:	}
;1288:}
;1289:
;1290:/*
;1291:==================
;1292:Bot1FCTFOrders_EnemyHasFlag
;1293:
;1294:  X% defend the base, Y% towards neutral flag
;1295:==================
;1296:*/
;1297:void Bot1FCTFOrders_EnemyHasFlag(bot_state_t *bs) {
;1298:	int numteammates, defenders, attackers, i;
;1299:	int teammates[MAX_CLIENTS];
;1300:	char name[MAX_NETNAME];
;1301:
;1302:	//sort team mates by travel time to base
;1303:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1304:	//sort team mates by CTF preference
;1305:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1306:	//passive strategy
;1307:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1308:		//different orders based on the number of team mates
;1309:		switch(numteammates) {
;1310:			case 1: break;
;1311:			case 2:
;1312:			{
;1313:				//both defend the base
;1314:				ClientName(teammates[0], name, sizeof(name));
;1315:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1316:				BotSayTeamOrder(bs, teammates[0]);
;1317:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1318:				//
;1319:				ClientName(teammates[1], name, sizeof(name));
;1320:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1321:				BotSayTeamOrder(bs, teammates[1]);
;1322:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1323:				break;
;1324:			}
;1325:			case 3:
;1326:			{
;1327:				//the one closest to the base will defend the base
;1328:				ClientName(teammates[0], name, sizeof(name));
;1329:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1330:				BotSayTeamOrder(bs, teammates[0]);
;1331:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1332:				//the second one closest to the base will defend the base
;1333:				ClientName(teammates[1], name, sizeof(name));
;1334:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1335:				BotSayTeamOrder(bs, teammates[1]);
;1336:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1337:				//the other will also defend the base
;1338:				ClientName(teammates[2], name, sizeof(name));
;1339:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1340:				BotSayTeamOrder(bs, teammates[2]);
;1341:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_DEFEND);
;1342:				break;
;1343:			}
;1344:			default:
;1345:			{
;1346:				//80% will defend the base
;1347:				defenders = (int) (float) numteammates * 0.8 + 0.5;
;1348:				if (defenders > 8) defenders = 8;
;1349:				//10% will try to return the flag
;1350:				attackers = (int) (float) numteammates * 0.1 + 0.5;
;1351:				if (attackers > 2) attackers = 2;
;1352:				for (i = 0; i < defenders; i++) {
;1353:					//
;1354:					ClientName(teammates[i], name, sizeof(name));
;1355:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1356:					BotSayTeamOrder(bs, teammates[i]);
;1357:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1358:				}
;1359:				for (i = 0; i < attackers; i++) {
;1360:					//
;1361:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1362:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1363:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1364:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1365:				}
;1366:				//
;1367:				break;
;1368:			}
;1369:		}
;1370:	}
;1371:	else { //agressive
;1372:		//different orders based on the number of team mates
;1373:		switch(numteammates) {
;1374:			case 1: break;
;1375:			case 2:
;1376:			{
;1377:				//the one closest to the base will defend the base
;1378:				ClientName(teammates[0], name, sizeof(name));
;1379:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1380:				BotSayTeamOrder(bs, teammates[0]);
;1381:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1382:				//the other will get the flag
;1383:				ClientName(teammates[1], name, sizeof(name));
;1384:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1385:				BotSayTeamOrder(bs, teammates[1]);
;1386:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1387:				break;
;1388:			}
;1389:			case 3:
;1390:			{
;1391:				//the one closest to the base will defend the base
;1392:				ClientName(teammates[0], name, sizeof(name));
;1393:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1394:				BotSayTeamOrder(bs, teammates[0]);
;1395:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1396:				//the others should go for the enemy flag
;1397:				ClientName(teammates[1], name, sizeof(name));
;1398:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1399:				BotSayTeamOrder(bs, teammates[1]);
;1400:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1401:				//
;1402:				ClientName(teammates[2], name, sizeof(name));
;1403:				BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1404:				BotSayTeamOrder(bs, teammates[2]);
;1405:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1406:				break;
;1407:			}
;1408:			default:
;1409:			{
;1410:				//70% defend the base
;1411:				defenders = (int) (float) numteammates * 0.7 + 0.5;
;1412:				if (defenders > 8) defenders = 8;
;1413:				//20% try to return the flag
;1414:				attackers = (int) (float) numteammates * 0.2 + 0.5;
;1415:				if (attackers > 2) attackers = 2;
;1416:				for (i = 0; i < defenders; i++) {
;1417:					//
;1418:					ClientName(teammates[i], name, sizeof(name));
;1419:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1420:					BotSayTeamOrder(bs, teammates[i]);
;1421:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1422:				}
;1423:				for (i = 0; i < attackers; i++) {
;1424:					//
;1425:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1426:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1427:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1428:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1429:				}
;1430:				//
;1431:				break;
;1432:			}
;1433:		}
;1434:	}
;1435:}
;1436:
;1437:/*
;1438:==================
;1439:Bot1FCTFOrders_EnemyDroppedFlag
;1440:
;1441:  X% defend the base, Y% get the flag
;1442:==================
;1443:*/
;1444:void Bot1FCTFOrders_EnemyDroppedFlag(bot_state_t *bs) {
;1445:	int numteammates, defenders, attackers, i;
;1446:	int teammates[MAX_CLIENTS];
;1447:	char name[MAX_NETNAME];
;1448:
;1449:	//sort team mates by travel time to base
;1450:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1451:	//sort team mates by CTF preference
;1452:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1453:	//passive strategy
;1454:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1455:		//different orders based on the number of team mates
;1456:		switch(numteammates) {
;1457:			case 1: break;
;1458:			case 2:
;1459:			{
;1460:				//the one closest to the base will defend the base
;1461:				ClientName(teammates[0], name, sizeof(name));
;1462:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1463:				BotSayTeamOrder(bs, teammates[0]);
;1464:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1465:				//the other will get the flag
;1466:				ClientName(teammates[1], name, sizeof(name));
;1467:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1468:				BotSayTeamOrder(bs, teammates[1]);
;1469:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1470:				break;
;1471:			}
;1472:			case 3:
;1473:			{
;1474:				//the one closest to the base will defend the base
;1475:				ClientName(teammates[0], name, sizeof(name));
;1476:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1477:				BotSayTeamOrder(bs, teammates[0]);
;1478:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1479:				//the second one closest to the base will defend the base
;1480:				ClientName(teammates[1], name, sizeof(name));
;1481:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1482:				BotSayTeamOrder(bs, teammates[1]);
;1483:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1484:				//the other will get the flag
;1485:				ClientName(teammates[2], name, sizeof(name));
;1486:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1487:				BotSayTeamOrder(bs, teammates[2]);
;1488:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1489:				break;
;1490:			}
;1491:			default:
;1492:			{
;1493:				//50% defend the base
;1494:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1495:				if (defenders > 5) defenders = 5;
;1496:				//40% get the flag
;1497:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1498:				if (attackers > 4) attackers = 4;
;1499:				for (i = 0; i < defenders; i++) {
;1500:					//
;1501:					ClientName(teammates[i], name, sizeof(name));
;1502:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1503:					BotSayTeamOrder(bs, teammates[i]);
;1504:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1505:				}
;1506:				for (i = 0; i < attackers; i++) {
;1507:					//
;1508:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1509:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1510:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1511:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1512:				}
;1513:				//
;1514:				break;
;1515:			}
;1516:		}
;1517:	}
;1518:	else { //agressive
;1519:		//different orders based on the number of team mates
;1520:		switch(numteammates) {
;1521:			case 1: break;
;1522:			case 2:
;1523:			{
;1524:				//the one closest to the base will defend the base
;1525:				ClientName(teammates[0], name, sizeof(name));
;1526:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1527:				BotSayTeamOrder(bs, teammates[0]);
;1528:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1529:				//the other will get the flag
;1530:				ClientName(teammates[1], name, sizeof(name));
;1531:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1532:				BotSayTeamOrder(bs, teammates[1]);
;1533:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1534:				break;
;1535:			}
;1536:			case 3:
;1537:			{
;1538:				//the one closest to the base will defend the base
;1539:				ClientName(teammates[0], name, sizeof(name));
;1540:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1541:				BotSayTeamOrder(bs, teammates[0]);
;1542:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1543:				//the others should go for the enemy flag
;1544:				ClientName(teammates[1], name, sizeof(name));
;1545:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1546:				BotSayTeamOrder(bs, teammates[1]);
;1547:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1548:				//
;1549:				ClientName(teammates[2], name, sizeof(name));
;1550:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1551:				BotSayTeamOrder(bs, teammates[2]);
;1552:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1553:				break;
;1554:			}
;1555:			default:
;1556:			{
;1557:				//30% defend the base
;1558:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1559:				if (defenders > 3) defenders = 3;
;1560:				//60% get the flag
;1561:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1562:				if (attackers > 6) attackers = 6;
;1563:				for (i = 0; i < defenders; i++) {
;1564:					//
;1565:					ClientName(teammates[i], name, sizeof(name));
;1566:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1567:					BotSayTeamOrder(bs, teammates[i]);
;1568:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1569:				}
;1570:				for (i = 0; i < attackers; i++) {
;1571:					//
;1572:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1573:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1574:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1575:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_DEFEND);
;1576:				}
;1577:				//
;1578:				break;
;1579:			}
;1580:		}
;1581:	}
;1582:}
;1583:
;1584:/*
;1585:==================
;1586:Bot1FCTFOrders
;1587:==================
;1588:*/
;1589:void Bot1FCTFOrders(bot_state_t *bs) {
;1590:	switch(bs->neutralflagstatus) {
;1591:		case 0: Bot1FCTFOrders_FlagAtCenter(bs); break;
;1592:		case 1: Bot1FCTFOrders_TeamHasFlag(bs); break;
;1593:		case 2: Bot1FCTFOrders_EnemyHasFlag(bs); break;
;1594:		case 3: Bot1FCTFOrders_EnemyDroppedFlag(bs); break;
;1595:	}
;1596:}
;1597:
;1598:/*
;1599:==================
;1600:BotObeliskOrders
;1601:
;1602:  X% in defence Y% in offence
;1603:==================
;1604:*/
;1605:void BotObeliskOrders(bot_state_t *bs) {
;1606:	int numteammates, defenders, attackers, i;
;1607:	int teammates[MAX_CLIENTS];
;1608:	char name[MAX_NETNAME];
;1609:
;1610:	//sort team mates by travel time to base
;1611:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1612:	//sort team mates by CTF preference
;1613:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1614:	//passive strategy
;1615:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1616:		//different orders based on the number of team mates
;1617:		switch(numteammates) {
;1618:			case 1: break;
;1619:			case 2:
;1620:			{
;1621:				//the one closest to the base will defend the base
;1622:				ClientName(teammates[0], name, sizeof(name));
;1623:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1624:				BotSayTeamOrder(bs, teammates[0]);
;1625:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1626:				//the other will attack the enemy base
;1627:				ClientName(teammates[1], name, sizeof(name));
;1628:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1629:				BotSayTeamOrder(bs, teammates[1]);
;1630:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1631:				break;
;1632:			}
;1633:			case 3:
;1634:			{
;1635:				//the one closest to the base will defend the base
;1636:				ClientName(teammates[0], name, sizeof(name));
;1637:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1638:				BotSayTeamOrder(bs, teammates[0]);
;1639:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1640:				//the one second closest to the base also defends the base
;1641:				ClientName(teammates[1], name, sizeof(name));
;1642:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1643:				BotSayTeamOrder(bs, teammates[1]);
;1644:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1645:				//the other one attacks the enemy base
;1646:				ClientName(teammates[2], name, sizeof(name));
;1647:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1648:				BotSayTeamOrder(bs, teammates[2]);
;1649:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1650:				break;
;1651:			}
;1652:			default:
;1653:			{
;1654:				//50% defend the base
;1655:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1656:				if (defenders > 5) defenders = 5;
;1657:				//40% attack the enemy base
;1658:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1659:				if (attackers > 4) attackers = 4;
;1660:				for (i = 0; i < defenders; i++) {
;1661:					//
;1662:					ClientName(teammates[i], name, sizeof(name));
;1663:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1664:					BotSayTeamOrder(bs, teammates[i]);
;1665:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1666:				}
;1667:				for (i = 0; i < attackers; i++) {
;1668:					//
;1669:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1670:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1671:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1672:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1673:				}
;1674:				//
;1675:				break;
;1676:			}
;1677:		}
;1678:	}
;1679:	else {
;1680:		//different orders based on the number of team mates
;1681:		switch(numteammates) {
;1682:			case 1: break;
;1683:			case 2:
;1684:			{
;1685:				//the one closest to the base will defend the base
;1686:				ClientName(teammates[0], name, sizeof(name));
;1687:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1688:				BotSayTeamOrder(bs, teammates[0]);
;1689:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1690:				//the other will attack the enemy base
;1691:				ClientName(teammates[1], name, sizeof(name));
;1692:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1693:				BotSayTeamOrder(bs, teammates[1]);
;1694:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1695:				break;
;1696:			}
;1697:			case 3:
;1698:			{
;1699:				//the one closest to the base will defend the base
;1700:				ClientName(teammates[0], name, sizeof(name));
;1701:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1702:				BotSayTeamOrder(bs, teammates[0]);
;1703:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1704:				//the others attack the enemy base
;1705:				ClientName(teammates[1], name, sizeof(name));
;1706:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1707:				BotSayTeamOrder(bs, teammates[1]);
;1708:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1709:				//
;1710:				ClientName(teammates[2], name, sizeof(name));
;1711:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1712:				BotSayTeamOrder(bs, teammates[2]);
;1713:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1714:				break;
;1715:			}
;1716:			default:
;1717:			{
;1718:				//30% defend the base
;1719:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1720:				if (defenders > 3) defenders = 3;
;1721:				//70% attack the enemy base
;1722:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1723:				if (attackers > 7) attackers = 7;
;1724:				for (i = 0; i < defenders; i++) {
;1725:					//
;1726:					ClientName(teammates[i], name, sizeof(name));
;1727:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1728:					BotSayTeamOrder(bs, teammates[i]);
;1729:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1730:				}
;1731:				for (i = 0; i < attackers; i++) {
;1732:					//
;1733:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1734:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1735:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1736:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1737:				}
;1738:				//
;1739:				break;
;1740:			}
;1741:		}
;1742:	}
;1743:}
;1744:
;1745:/*
;1746:==================
;1747:BotHarvesterOrders
;1748:
;1749:  X% defend the base, Y% harvest
;1750:==================
;1751:*/
;1752:void BotHarvesterOrders(bot_state_t *bs) {
;1753:	int numteammates, defenders, attackers, i;
;1754:	int teammates[MAX_CLIENTS];
;1755:	char name[MAX_NETNAME];
;1756:
;1757:	//sort team mates by travel time to base
;1758:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1759:	//sort team mates by CTF preference
;1760:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1761:	//passive strategy
;1762:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1763:		//different orders based on the number of team mates
;1764:		switch(numteammates) {
;1765:			case 1: break;
;1766:			case 2:
;1767:			{
;1768:				//the one closest to the base will defend the base
;1769:				ClientName(teammates[0], name, sizeof(name));
;1770:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1771:				BotSayTeamOrder(bs, teammates[0]);
;1772:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1773:				//the other will harvest
;1774:				ClientName(teammates[1], name, sizeof(name));
;1775:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1776:				BotSayTeamOrder(bs, teammates[1]);
;1777:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1778:				break;
;1779:			}
;1780:			case 3:
;1781:			{
;1782:				//the one closest to the base will defend the base
;1783:				ClientName(teammates[0], name, sizeof(name));
;1784:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1785:				BotSayTeamOrder(bs, teammates[0]);
;1786:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1787:				//the one second closest to the base also defends the base
;1788:				ClientName(teammates[1], name, sizeof(name));
;1789:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1790:				BotSayTeamOrder(bs, teammates[1]);
;1791:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1792:				//the other one goes harvesting
;1793:				ClientName(teammates[2], name, sizeof(name));
;1794:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1795:				BotSayTeamOrder(bs, teammates[2]);
;1796:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1797:				break;
;1798:			}
;1799:			default:
;1800:			{
;1801:				//50% defend the base
;1802:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1803:				if (defenders > 5) defenders = 5;
;1804:				//40% goes harvesting
;1805:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1806:				if (attackers > 4) attackers = 4;
;1807:				for (i = 0; i < defenders; i++) {
;1808:					//
;1809:					ClientName(teammates[i], name, sizeof(name));
;1810:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1811:					BotSayTeamOrder(bs, teammates[i]);
;1812:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1813:				}
;1814:				for (i = 0; i < attackers; i++) {
;1815:					//
;1816:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1817:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1818:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1819:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1820:				}
;1821:				//
;1822:				break;
;1823:			}
;1824:		}
;1825:	}
;1826:	else {
;1827:		//different orders based on the number of team mates
;1828:		switch(numteammates) {
;1829:			case 1: break;
;1830:			case 2:
;1831:			{
;1832:				//the one closest to the base will defend the base
;1833:				ClientName(teammates[0], name, sizeof(name));
;1834:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1835:				BotSayTeamOrder(bs, teammates[0]);
;1836:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1837:				//the other will harvest
;1838:				ClientName(teammates[1], name, sizeof(name));
;1839:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1840:				BotSayTeamOrder(bs, teammates[1]);
;1841:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1842:				break;
;1843:			}
;1844:			case 3:
;1845:			{
;1846:				//the one closest to the base will defend the base
;1847:				ClientName(teammates[0], name, sizeof(name));
;1848:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1849:				BotSayTeamOrder(bs, teammates[0]);
;1850:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1851:				//the others go harvesting
;1852:				ClientName(teammates[1], name, sizeof(name));
;1853:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1854:				BotSayTeamOrder(bs, teammates[1]);
;1855:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1856:				//
;1857:				ClientName(teammates[2], name, sizeof(name));
;1858:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1859:				BotSayTeamOrder(bs, teammates[2]);
;1860:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1861:				break;
;1862:			}
;1863:			default:
;1864:			{
;1865:				//30% defend the base
;1866:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1867:				if (defenders > 3) defenders = 3;
;1868:				//70% go harvesting
;1869:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1870:				if (attackers > 7) attackers = 7;
;1871:				for (i = 0; i < defenders; i++) {
;1872:					//
;1873:					ClientName(teammates[i], name, sizeof(name));
;1874:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1875:					BotSayTeamOrder(bs, teammates[i]);
;1876:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1877:				}
;1878:				for (i = 0; i < attackers; i++) {
;1879:					//
;1880:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1881:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1882:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1883:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1884:				}
;1885:				//
;1886:				break;
;1887:			}
;1888:		}
;1889:	}
;1890:}
;1891:#endif
;1892:
;1893:/*
;1894:==================
;1895:FindHumanTeamLeader
;1896:==================
;1897:*/
;1898:int FindHumanTeamLeader(bot_state_t *bs) {
line 1901
;1899:	int i;
;1900:
;1901:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $430
line 1902
;1902:		if ( g_entities[i].inuse ) {
CNSTI4 820
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $434
line 1904
;1903:			// if this player is not a bot
;1904:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
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
NEI4 $437
line 1906
;1905:				// if this player is ok with being the leader
;1906:				if (!notleader[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
INDIRI4
CNSTI4 0
NEI4 $441
line 1908
;1907:					// if this player is on the same team
;1908:					if ( BotSameTeam(bs, i) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $443
line 1909
;1909:						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1911
;1910:						// if not yet ordered to do anything
;1911:						if ( !BotSetLastOrderedTask(bs) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $445
line 1913
;1912:							// go on defense by default
;1913:							BotVoiceChat_Defend(bs, i, SAY_TELL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 1914
;1914:						}
LABELV $445
line 1915
;1915:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $429
JUMPV
LABELV $443
line 1917
;1916:					}
;1917:				}
LABELV $441
line 1918
;1918:			}
LABELV $437
line 1919
;1919:		}
LABELV $434
line 1920
;1920:	}
LABELV $431
line 1901
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $430
line 1921
;1921:	return qfalse;
CNSTI4 0
RETI4
LABELV $429
endproc FindHumanTeamLeader 12 12
export BotTeamAI
proc BotTeamAI 72 12
line 1929
;1922:}
;1923:
;1924:/*
;1925:==================
;1926:BotTeamAI
;1927:==================
;1928:*/
;1929:void BotTeamAI(bot_state_t *bs) {
line 1934
;1930:	int numteammates;
;1931:	char netname[MAX_NETNAME];
;1932:
;1933:	//
;1934:	if ( gametype < GT_TEAM  )
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $448
line 1935
;1935:		return;
ADDRGP4 $447
JUMPV
LABELV $448
line 1937
;1936:	// make sure we've got a valid team leader
;1937:	if (!BotValidTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotValidTeamLeader
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $450
line 1939
;1938:		//
;1939:		if (!FindHumanTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 FindHumanTeamLeader
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $452
line 1941
;1940:			//
;1941:			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRP4
CNSTI4 6932
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $454
ADDRLP4 48
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $454
line 1942
;1942:				if (bs->entergame_time + 10 > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
CNSTF4 1092616192
ADDF4
ADDRGP4 floattime
INDIRF4
LEF4 $456
line 1943
;1943:					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1944
;1944:				}
ADDRGP4 $457
JUMPV
LABELV $456
line 1945
;1945:				else {
line 1946
;1946:					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1947
;1947:				}
LABELV $457
line 1948
;1948:			}
LABELV $454
line 1949
;1949:			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $458
ADDRLP4 56
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $458
line 1951
;1950:				// if asked for a team leader and no response
;1951:				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $460
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1952
;1952:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1953
;1953:				bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
CNSTF4 0
ASGNF4
line 1954
;1954:				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
CNSTF4 1092616192
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1955
;1955:			}
LABELV $458
line 1956
;1956:			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
EQF4 $447
ADDRLP4 60
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $447
line 1957
;1957:				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $463
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1958
;1958:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1959
;1959:				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $464
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1960
;1960:				ClientName(bs->client, netname, sizeof(netname));
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
line 1961
;1961:				strncpy(bs->teamleader, netname, sizeof(bs->teamleader));
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1962
;1962:				bs->teamleader[sizeof(bs->teamleader)] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6900
CNSTU4 32
ADDI4
ADDP4
CNSTI1 0
ASGNI1
line 1963
;1963:				bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 1964
;1964:			}
line 1965
;1965:			return;
ADDRGP4 $447
JUMPV
LABELV $452
line 1967
;1966:		}
;1967:	}
LABELV $450
line 1968
;1968:	bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
CNSTF4 0
ASGNF4
line 1969
;1969:	bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 1972
;1970:
;1971:	//return if this bot is NOT the team leader
;1972:	ClientName(bs->client, netname, sizeof(netname));
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
line 1973
;1973:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $465
ADDRGP4 $447
JUMPV
LABELV $465
line 1975
;1974:	//
;1975:	numteammates = BotNumTeamMates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotNumTeamMates
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 48
INDIRI4
ASGNI4
line 1977
;1976:	//give orders
;1977:	switch(gametype) {
ADDRLP4 52
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 3
EQI4 $469
ADDRLP4 52
INDIRI4
CNSTI4 4
EQI4 $475
ADDRGP4 $467
JUMPV
LABELV $469
line 1979
;1978:		case GT_TEAM:
;1979:		{
line 1980
;1980:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $472
ADDRLP4 56
INDIRP4
CNSTI4 6968
ADDP4
INDIRI4
CNSTI4 0
EQI4 $470
LABELV $472
line 1981
;1981:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1982
;1982:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1983
;1983:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 0
ASGNI4
line 1984
;1984:			}
LABELV $470
line 1986
;1985:			//if it's time to give orders
;1986:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
EQF4 $468
ADDRLP4 60
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $468
line 1987
;1987:				BotTeamOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamOrders
CALLV
pop
line 1989
;1988:				//give orders again after 120 seconds
;1989:				bs->teamgiveorders_time = FloatTime() + 120;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1990
;1990:			}
line 1991
;1991:			break;
ADDRGP4 $468
JUMPV
LABELV $475
line 1994
;1992:		}
;1993:		case GT_CTF:
;1994:		{
line 1997
;1995:			//if the number of team mates changed or the flag status changed
;1996:			//or someone wants to know what to do
;1997:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $479
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $479
ADDRLP4 56
INDIRP4
CNSTI4 6968
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $476
LABELV $479
line 1998
;1998:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1999
;1999:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2000
;2000:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 2001
;2001:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 0
ASGNI4
line 2002
;2002:			}
LABELV $476
line 2004
;2003:			//if there were no flag captures the last 3 minutes
;2004:			if (bs->lastflagcapture_time < FloatTime() - 240) {
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1131413504
SUBF4
GEF4 $480
line 2005
;2005:				bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2007
;2006:				//randomly change the CTF strategy
;2007:				if (random() < 0.4) {
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1053609165
GEF4 $482
line 2008
;2008:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2009
;2009:					bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2010
;2010:				}
LABELV $482
line 2011
;2011:			}
LABELV $480
line 2013
;2012:			//if it's time to give orders
;2013:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $468
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $468
line 2014
;2014:				BotCTFOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders
CALLV
pop
line 2016
;2015:				//
;2016:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
CNSTF4 0
ASGNF4
line 2017
;2017:			}
line 2018
;2018:			break;
LABELV $467
LABELV $468
line 2078
;2019:		}
;2020:#ifdef MISSIONPACK
;2021:		case GT_1FCTF:
;2022:		{
;2023:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
;2024:				bs->teamgiveorders_time = FloatTime();
;2025:				bs->numteammates = numteammates;
;2026:				bs->flagstatuschanged = qfalse;
;2027:				bs->forceorders = qfalse;
;2028:			}
;2029:			//if there were no flag captures the last 4 minutes
;2030:			if (bs->lastflagcapture_time < FloatTime() - 240) {
;2031:				bs->lastflagcapture_time = FloatTime();
;2032:				//randomly change the CTF strategy
;2033:				if (random() < 0.4) {
;2034:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
;2035:					bs->teamgiveorders_time = FloatTime();
;2036:				}
;2037:			}
;2038:			//if it's time to give orders
;2039:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 2) {
;2040:				Bot1FCTFOrders(bs);
;2041:				//
;2042:				bs->teamgiveorders_time = 0;
;2043:			}
;2044:			break;
;2045:		}
;2046:		case GT_OBELISK:
;2047:		{
;2048:			if (bs->numteammates != numteammates || bs->forceorders) {
;2049:				bs->teamgiveorders_time = FloatTime();
;2050:				bs->numteammates = numteammates;
;2051:				bs->forceorders = qfalse;
;2052:			}
;2053:			//if it's time to give orders
;2054:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2055:				BotObeliskOrders(bs);
;2056:				//give orders again after 30 seconds
;2057:				bs->teamgiveorders_time = FloatTime() + 30;
;2058:			}
;2059:			break;
;2060:		}
;2061:		case GT_HARVESTER:
;2062:		{
;2063:			if (bs->numteammates != numteammates || bs->forceorders) {
;2064:				bs->teamgiveorders_time = FloatTime();
;2065:				bs->numteammates = numteammates;
;2066:				bs->forceorders = qfalse;
;2067:			}
;2068:			//if it's time to give orders
;2069:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2070:				BotHarvesterOrders(bs);
;2071:				//give orders again after 30 seconds
;2072:				bs->teamgiveorders_time = FloatTime() + 30;
;2073:			}
;2074:			break;
;2075:		}
;2076:#endif
;2077:	}
;2078:}
LABELV $447
endproc BotTeamAI 72 12
bss
export ctftaskpreferences
align 4
LABELV ctftaskpreferences
skip 2560
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
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
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
LABELV $464
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $463
byte 1 105
byte 1 97
byte 1 109
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $460
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $215
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $210
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $171
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $165
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $164
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $163
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $162
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $138
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $74
byte 1 116
byte 1 0
align 1
LABELV $70
byte 1 110
byte 1 0
align 1
LABELV $63
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
