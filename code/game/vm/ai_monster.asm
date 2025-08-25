data
align 4
LABELV checkpvs_client
byte 4 0
export checkclient
code
proc checkclient 16 0
file "game/ai_monster.c"
line 10
;1:// ai_monster.c
;2://
;3:// Implementation of Quake 1-style monster AI scaffolding
;4:// for use inside Quake 3 VM.
;5://
;6:#include "ai_monster.h"
;7:
;8:static int checkpvs_client = 0;
;9:
;10:gentity_t* checkclient(void) {
line 15
;11:    int i;
;12:    gentity_t* ent;
;13:
;14:    // loop through clients (one per call, wrap around)
;15:    for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $57
JUMPV
LABELV $54
line 16
;16:        checkpvs_client = (checkpvs_client + 1) % level.maxclients;
ADDRLP4 8
ADDRGP4 checkpvs_client
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ADDRGP4 level+24
INDIRI4
MODI4
ASGNI4
line 17
;17:        ent = &g_entities[checkpvs_client];
ADDRLP4 0
CNSTI4 820
ADDRGP4 checkpvs_client
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 18
;18:        if (!ent->inuse || !ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $62
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $60
LABELV $62
line 19
;19:            continue;
ADDRGP4 $55
JUMPV
LABELV $60
line 22
;20:
;21:        // must be alive
;22:        if (ent->health <= 0)
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $63
line 23
;23:            continue;
ADDRGP4 $55
JUMPV
LABELV $63
line 29
;24:
;25:        // make sure it's in PVS of some monster (optional optimization)
;26:        // if (!gi.inPVS(monster->s.origin, ent->s.origin))
;27:        //    continue;
;28:
;29:        return ent;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $53
JUMPV
LABELV $55
line 15
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $57
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $54
line 32
;30:    }
;31:
;32:    return NULL;
CNSTP4 0
RETP4
LABELV $53
endproc checkclient 16 0
export Range
proc Range 72 32
line 45
;33:}
;34:
;35://
;36:// Range categorization
;37://
;38:typedef enum {
;39:    RANGE_MELEE,
;40:    RANGE_NEAR,
;41:    RANGE_MID,
;42:    RANGE_FAR
;43:} range_t;
;44:
;45:range_t Range(gentity_t* self, gentity_t* targ) {
line 50
;46:    vec3_t spot1, spot2;
;47:    vec3_t targ_offset;
;48:    vec3_t delta;
;49:    float r;
;50:    if (targ->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $67
line 51
;51:        targ_offset[0] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 52
;52:        targ_offset[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 53
;53:        targ_offset[2] = targ->client->ps.viewheight;
ADDRLP4 24+8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 54
;54:    }
ADDRGP4 $68
JUMPV
LABELV $67
line 55
;55:    else {
line 56
;56:        VectorClear(targ_offset); // zero vector
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 24+8
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 52
INDIRF4
ASGNF4
line 57
;57:    }
LABELV $68
line 59
;58:
;59:    VectorAdd(targ->r.currentOrigin, targ_offset, spot2);
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 52
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 52
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 60
;60:    VectorAdd(self->r.currentOrigin, self->monsterinfo->view_ofs, spot1);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 56
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 64
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
line 61
;61:    VectorSubtract(spot1, spot2, delta);
ADDRLP4 40
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 62
;62:    r = VectorLength(delta);
ADDRLP4 40
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 68
INDIRF4
ASGNF4
line 63
;63:    G_Printf("spot1 %.1f %.1f %.1f spot2 %.1f %.1f %.1f r %.1f\n",
ADDRGP4 $85
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 G_Printf
CALLV
pop
line 66
;64:        spot1[0], spot1[1], spot1[2], spot2[0], spot2[1], spot2[2], r);
;65:
;66:    if (r < 120)
ADDRLP4 36
INDIRF4
CNSTF4 1123024896
GEF4 $90
line 67
;67:        return RANGE_MELEE;
CNSTI4 0
RETI4
ADDRGP4 $66
JUMPV
LABELV $90
line 68
;68:    if (r < 500)
ADDRLP4 36
INDIRF4
CNSTF4 1140457472
GEF4 $92
line 69
;69:        return RANGE_NEAR;
CNSTI4 1
RETI4
ADDRGP4 $66
JUMPV
LABELV $92
line 70
;70:    if (r < 1000)
ADDRLP4 36
INDIRF4
CNSTF4 1148846080
GEF4 $94
line 71
;71:        return RANGE_MID;
CNSTI4 2
RETI4
ADDRGP4 $66
JUMPV
LABELV $94
line 72
;72:    return RANGE_FAR;
CNSTI4 3
RETI4
LABELV $66
endproc Range 72 32
export Visible
proc Visible 96 28
line 78
;73:}
;74:
;75://
;76:// Visibility check
;77://
;78:qboolean Visible(gentity_t* self, gentity_t* targ) {
line 82
;79:    vec3_t spot1, spot2;
;80:    trace_t tr;
;81:
;82:    VectorAdd(self->r.currentOrigin, self->monsterinfo->view_ofs, spot1);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 88
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
line 84
;83:
;84:    trap_Trace(&tr, spot1, NULL, NULL, targ->r.currentOrigin, self->s.number, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
CNSTP4 0
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 86
;85:
;86:    if (tr.fraction == 1.0f) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $99
line 87
;87:        return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $96
JUMPV
LABELV $99
line 89
;88:    }
;89:    return qfalse;
CNSTI4 0
RETI4
LABELV $96
endproc Visible 96 28
export Infront
proc Infront 56 16
line 95
;90:}
;91:
;92://
;93:// Infront check
;94://
;95:qboolean Infront(gentity_t* self, gentity_t* targ) {
line 99
;96:    vec3_t vec, forward;
;97:    float dot;
;98:
;99:    AngleVectors(self->s.angles, forward, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
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
line 100
;100:    VectorSubtract(targ->r.currentOrigin, self->r.currentOrigin, vec);
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 488
ASGNI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 492
ASGNI4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 496
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 101
;101:    VectorNormalize(vec);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 103
;102:
;103:    dot = DotProduct(vec, forward);
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 105
;104:
;105:    return (dot > 0.3f) ? qtrue : qfalse;
ADDRLP4 24
INDIRF4
CNSTF4 1050253722
LEF4 $110
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $110
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $111
ADDRLP4 52
INDIRI4
RETI4
LABELV $102
endproc Infront 56 16
export AI_FindTarget
proc AI_FindTarget 36 8
line 109
;106:}
;107:
;108:qboolean AI_FindTarget(gentity_t* self)
;109:{
line 113
;110:    gentity_t* client;
;111:    float r;
;112:
;113:    G_Printf("Searching for enemy\n");
ADDRGP4 $113
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 115
;114:    // quick sight wakeup (sight_entity from other monsters)
;115:    if (level.sight_entity_time >= level.time - 100 && !(self->spawnflags & 3)) {
ADDRGP4 level+9172
INDIRF4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
SUBI4
CVIF4 4
LTF4 $114
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
NEI4 $114
line 116
;116:        client = level.sight_entity;
ADDRLP4 0
ADDRGP4 level+9168
INDIRP4
ASGNP4
line 117
;117:        if (client && client->enemy == self->enemy)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $115
ADDRLP4 12
CNSTI4 772
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
CVPU4 4
NEU4 $115
line 118
;118:            return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $112
JUMPV
line 119
;119:    }
LABELV $114
line 120
;120:    else {
line 121
;121:        client = checkclient(); // TODO: implement checkclient
ADDRLP4 8
ADDRGP4 checkclient
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 122
;122:        if (!client)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $121
line 123
;123:            return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $121
line 124
;124:    }
LABELV $115
line 125
;125:    G_Printf("%s\n", client->classname);
ADDRGP4 $123
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 126
;126:    if (client == self->enemy) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
NEU4 $124
line 127
;127:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $124
line 130
;128:    }
;129:
;130:    if (client->flags & FL_NOTARGET)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $126
line 131
;131:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $126
line 133
;132:
;133:    if (client->client && (client->client->ps.powerups[PW_INVIS] > level.time))
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $128
ADDRLP4 8
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $128
line 134
;134:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $128
line 136
;135:
;136:    r = Range(self, client);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Range
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 137
;137:    if (r == RANGE_FAR)
ADDRLP4 4
INDIRF4
CNSTF4 1077936128
NEF4 $131
line 138
;138:    {
line 139
;139:        G_Printf("player too far");
ADDRGP4 $133
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 140
;140:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $131
line 142
;141:    }
;142:    if (!Visible(self, client))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Visible
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $134
line 143
;143:    {
line 144
;144:        G_Printf("player not visible");
ADDRGP4 $136
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 145
;145:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $134
line 147
;146:    }
;147:    if (r == RANGE_NEAR) {
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $137
line 148
;148:        if (client->show_hostile < level.time && !Infront(self, client))
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $138
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Infront
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $138
line 149
;149:            return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
line 150
;150:    }
LABELV $137
line 151
;151:    else if (r == RANGE_MID) {
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
NEF4 $142
line 152
;152:        if (!Infront(self, client))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Infront
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $144
line 153
;153:            return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $144
line 154
;154:    }
LABELV $142
LABELV $138
line 157
;155:
;156:    // got one
;157:    self->enemy = client;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 158
;158:    if (strcmp(client->classname, "player") != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $146
line 159
;159:        self->enemy = client->enemy;
ADDRLP4 24
CNSTI4 772
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 160
;160:        if (!self->enemy || strcmp(self->enemy->classname, "player") != 0) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $151
ADDRLP4 28
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $149
LABELV $151
line 161
;161:            self->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
CNSTP4 0
ASGNP4
line 162
;162:            return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $149
line 164
;163:        }
;164:    }
LABELV $146
line 166
;165:
;166:    AI_FoundTarget(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_FoundTarget
CALLV
pop
line 167
;167:    return qtrue;
CNSTI4 1
RETI4
LABELV $112
endproc AI_FindTarget 36 8
export SUB_AttackFinished
proc SUB_AttackFinished 0 0
line 170
;168:}
;169:
;170:void SUB_AttackFinished(gentity_t* self, float delay) {
line 171
;171:    self->monsterinfo->attack_finished = level.time + delay;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 172
;172:}
LABELV $152
endproc SUB_AttackFinished 0 0
export HuntTarget
proc HuntTarget 52 8
line 173
;173:void HuntTarget(gentity_t* self) {
line 176
;174:
;175:    vec3_t dir;
;176:    if (!self->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $155
line 177
;177:        return;
ADDRGP4 $154
JUMPV
LABELV $155
line 180
;178:    }
;179:
;180:    self->monsterinfo->goalentity = self->enemy;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ASGNP4
line 183
;181:
;182:    // switch to running AI
;183:    if (self->monsterinfo && self->monsterinfo->th_run) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $157
ADDRLP4 16
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $157
line 184
;184:        self->think = self->monsterinfo->th_run;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
ASGNP4
line 185
;185:    }
LABELV $157
line 188
;186:
;187:    // face enemy
;188:    VectorSubtract(self->enemy->r.currentOrigin, self->r.currentOrigin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 772
ADDP4
ASGNP4
ADDRLP4 32
CNSTI4 488
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 492
ASGNI4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 496
ASGNI4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 189
;189:    self->monsterinfo->ideal_yaw = vectoyaw(dir);
ADDRLP4 0
ARGP4
ADDRLP4 48
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 192
;190:
;191:    // schedule next think
;192:    self->nextthink = level.time + FRAMETIME; // ~0.1s
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 195
;193:
;194:    // delay before attacking
;195:    SUB_AttackFinished(self, 1.0f);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 SUB_AttackFinished
CALLV
pop
line 196
;196:}
LABELV $154
endproc HuntTarget 52 8
export AI_FoundTarget
proc AI_FoundTarget 12 8
line 197
;197:void AI_FoundTarget(gentity_t* self) {
line 198
;198:    if (self->enemy && strcmp(self->enemy->classname, "player") == 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $163
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $163
line 199
;199:        level.sight_entity = self;
ADDRGP4 level+9168
ADDRFP4 0
INDIRP4
ASGNP4
line 200
;200:        level.sight_entity_time = level.time;
ADDRGP4 level+9172
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 201
;201:    }
LABELV $163
line 203
;202:
;203:    self->show_hostile = level.time + 1000; // ms
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ASGNF4
line 205
;204:
;205:    if (self->monsterinfo->th_sight) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $169
line 206
;206:        self->monsterinfo->th_sight(self, self->enemy);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 207
;207:    }
LABELV $169
line 208
;208:    G_Printf("spotted enemy!\n");
ADDRGP4 $171
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 209
;209:    HuntTarget(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 HuntTarget
CALLV
pop
line 210
;210:}
LABELV $162
endproc AI_FoundTarget 12 8
export AI_Stand
proc AI_Stand 16 4
line 215
;211:
;212:// ---------------------------------------------------------------------------
;213:// Frame drivers
;214:// ---------------------------------------------------------------------------
;215:void AI_Stand(gentity_t* self) {
line 216
;216:    if (AI_FindTarget(self)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 AI_FindTarget
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $173
line 217
;217:        return; // target acquired, HuntTarget() is triggered
ADDRGP4 $172
JUMPV
LABELV $173
line 220
;218:    }
;219:
;220:    if (level.time > self->monsterinfo->pausetime) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $175
line 221
;221:        if (self->monsterinfo && self->monsterinfo->th_walk) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $178
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $178
line 222
;222:            self->monsterinfo->th_walk(self);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 223
;223:        }
LABELV $178
line 224
;224:    }
LABELV $175
line 225
;225:}
LABELV $172
endproc AI_Stand 16 4
export AI_WalkFrame
proc AI_WalkFrame 16 8
line 227
;226:
;227:void AI_WalkFrame(gentity_t* self, float dist) {
line 228
;228:    if (!self->monsterinfo) return;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $181
ADDRGP4 $180
JUMPV
LABELV $181
line 229
;229:    if (AI_MoveToGoal(self, dist)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 AI_MoveToGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $183
line 231
;230:        // reached target, handled in AI_Touch_MoveTarget
;231:    }
LABELV $183
line 232
;232:    self->s.frame++;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 172
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
line 233
;233:    if (self->s.frame > self->monsterinfo->endframe)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $185
line 234
;234:        self->s.frame = self->monsterinfo->startframe;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
INDIRI4
ASGNI4
LABELV $185
line 235
;235:}
LABELV $180
endproc AI_WalkFrame 16 8
export AI_RunFrame
proc AI_RunFrame 12 8
line 237
;236:
;237:void AI_RunFrame(gentity_t* self, float dist) {
line 238
;238:    if (!self->monsterinfo) return;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $188
ADDRGP4 $187
JUMPV
LABELV $188
line 239
;239:    AI_MoveToGoal(self, dist);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 AI_MoveToGoal
CALLI4
pop
line 240
;240:    self->s.frame++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 241
;241:    if (self->s.frame > self->monsterinfo->endframe)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $190
line 242
;242:        self->s.frame = self->monsterinfo->startframe;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
INDIRI4
ASGNI4
LABELV $190
line 243
;243:}
LABELV $187
endproc AI_RunFrame 12 8
export AI_InitForEntity
proc AI_InitForEntity 4 12
line 248
;244:
;245:// ---------------------------------------------------------------------------
;246:// Init helpers
;247:// ---------------------------------------------------------------------------
;248:void AI_InitForEntity(gentity_t* ent) {
line 249
;249:    ent->monsterinfo = G_Alloc(sizeof(monsterinfo_t));
CNSTI4 88
ARGI4
ADDRLP4 0
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 250
;250:    memset(ent->monsterinfo, 0, sizeof(monsterinfo_t));
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 88
ARGI4
ADDRGP4 memset
CALLP4
pop
line 251
;251:}
LABELV $192
endproc AI_InitForEntity 4 12
export AI_ClearEntity
proc AI_ClearEntity 0 4
line 253
;252:
;253:void AI_ClearEntity(gentity_t* ent) {
line 254
;254:    if (ent->monsterinfo) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $194
line 255
;255:        G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 256
;256:        ent->monsterinfo = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
CNSTP4 0
ASGNP4
line 257
;257:    }
LABELV $194
line 258
;258:}
LABELV $193
endproc AI_ClearEntity 0 4
export AI_MoveToGoal
proc AI_MoveToGoal 48 0
line 263
;259:
;260:// ---------------------------------------------------------------------------
;261:// Basic movement / targeting stubs (to be expanded)
;262:// ---------------------------------------------------------------------------
;263:qboolean AI_MoveToGoal(gentity_t* self, float dist) {
line 266
;264:
;265:    vec3_t dir;
;266:    if (!self->monsterinfo || !self->monsterinfo->goalentity) return qfalse;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $199
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $197
LABELV $199
CNSTI4 0
RETI4
ADDRGP4 $196
JUMPV
LABELV $197
line 269
;267:
;268:    // Simple face & move
;269:    VectorSubtract(self->monsterinfo->goalentity->r.currentOrigin, self->r.currentOrigin, dir);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 28
CNSTI4 44
ASGNI4
ADDRLP4 32
CNSTI4 488
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 492
ASGNI4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 496
ASGNI4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 270
;270:    self->s.pos.trDelta[0] = dir[0] * 0.1f; // crude movement
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1036831949
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 271
;271:    self->s.pos.trDelta[1] = dir[1] * 0.1f;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1036831949
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
line 272
;272:    return qtrue;
CNSTI4 1
RETI4
LABELV $196
endproc AI_MoveToGoal 48 0
export AI_SetMoveTarget
proc AI_SetMoveTarget 0 0
line 275
;273:}
;274:
;275:void AI_SetMoveTarget(gentity_t* self, gentity_t* target) {
line 276
;276:    if (!self->monsterinfo) return;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $204
ADDRGP4 $203
JUMPV
LABELV $204
line 277
;277:    self->monsterinfo->goalentity = target;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 278
;278:}
LABELV $203
endproc AI_SetMoveTarget 0 0
export Monster_DropToFloor
proc Monster_DropToFloor 88 28
line 280
;279:
;280:void Monster_DropToFloor(gentity_t* ent) {
line 284
;281:    trace_t tr;
;282:    vec3_t start, end;
;283:
;284:    VectorCopy(ent->s.origin, start);
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 285
;285:    VectorCopy(ent->s.origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 286
;286:    end[2] -= 8192; // big number to go to floor
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1174405120
SUBF4
ASGNF4
line 288
;287:
;288:    trap_Trace(&tr, start, ent->r.mins, ent->r.maxs, end, ent->s.number, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 80
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 290
;289:
;290:    if (tr.fraction < 1.0) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
GEF4 $208
line 291
;291:        G_SetOrigin(ent, tr.endpos);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 292
;292:        trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 293
;293:    }
ADDRGP4 $209
JUMPV
LABELV $208
line 294
;294:    else {
line 295
;295:        G_Printf("Monster failed to drop to floor at %.1f %.1f %.1f\n",
ADDRGP4 $212
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_Printf
CALLV
pop
line 297
;296:            ent->s.origin[0], ent->s.origin[1], ent->s.origin[2]);
;297:    }
LABELV $209
line 298
;298:}
LABELV $206
endproc Monster_DropToFloor 88 28
export Monster_Die
proc Monster_Die 4 20
line 300
;299:
;300:void Monster_Die(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
line 302
;301:    // play death animation, drop loot, etc.
;302:    self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 303
;303:    self->r.contents = 0;        // not solid to anything
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 304
;304:    self->clipmask = 0;          // doesn’t collide when tracing against world
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 0
ASGNI4
line 305
;305:    trap_LinkEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 307
;306:
;307:    self->monsterinfo->th_die(self, inflictor, attacker, damage, mod);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRP4
CALLV
pop
line 308
;308:}
LABELV $213
endproc Monster_Die 4 20
export WalkMonsterStart
proc WalkMonsterStart 40 16
line 311
;309:
;310:// Reusable WalkMonsterStart
;311:void WalkMonsterStart(gentity_t* self) {
line 312
;312:    G_Printf("walkmonster starting\n");
ADDRGP4 $215
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 314
;313:    // raise off floor a bit
;314:    self->s.origin[2] += 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 315
;315:    Monster_DropToFloor(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Monster_DropToFloor
CALLV
pop
line 318
;316:
;317:    // check if monster is stuck
;318:    if (!AI_MoveToGoal(self, 0)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 4
ADDRGP4 AI_MoveToGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $216
line 319
;319:        G_Printf("walkmonster in wall at: %.2f %.2f %.2f\n",
ADDRGP4 $218
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_Printf
CALLV
pop
line 321
;320:            self->s.origin[0], self->s.origin[1], self->s.origin[2]);
;321:    }
LABELV $216
line 323
;322:
;323:    self->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 336
;324:    // self->ideal_yaw = self->s.angles[1];
;325:
;326:    // if (!self->yaw_speed)
;327:        // self->yaw_speed = 20;
;328:
;329:    // VectorSet(self->view_ofs, 0, 0, 25);
;330:    // self->use = Monster_Use;
;331:
;332:    // self->team = TEAM_MONSTERS;
;333:    // self->flags |= FL_MONSTER;
;334:
;335:
;336:    if (self->target) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $219
line 337
;337:        self->monsterinfo->goalentity = G_Find(NULL, FOFS(targetname), self->target);
CNSTP4 0
ARGP4
CNSTI4 652
ARGI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 338
;338:        if (self->monsterinfo->goalentity) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $221
line 342
;339:            // self->ideal_yaw = vectoyaw(self->goalentity->s.origin - self->s.origin);
;340:
;341:            // Call the walk function if defined, else stand
;342:            if (self->monsterinfo && self->monsterinfo->th_walk &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $223
ADDRLP4 16
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $223
ADDRLP4 16
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $225
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $223
line 344
;343:                strcmp(self->monsterinfo->goalentity->classname, "path_corner") == 0)
;344:            {
line 345
;345:                self->think = self->monsterinfo->th_walk;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ASGNP4
line 346
;346:            }
ADDRGP4 $220
JUMPV
LABELV $223
line 347
;347:            else if (self->monsterinfo && self->monsterinfo->th_stand) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 28
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $220
ADDRLP4 28
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $220
line 348
;348:                self->monsterinfo->pausetime = 99999999;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 99999999
ASGNI4
line 349
;349:                self->think = self->monsterinfo->th_stand;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
ASGNP4
line 350
;350:            }
line 351
;351:        }
ADDRGP4 $220
JUMPV
LABELV $221
line 352
;352:        else {
line 353
;353:            G_Printf("Monster can't find target at: %.2f %.2f %.2f\n",
ADDRGP4 $228
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_Printf
CALLV
pop
line 355
;354:                self->s.origin[0], self->s.origin[1], self->s.origin[2]);
;355:        }
line 356
;356:    }
ADDRGP4 $220
JUMPV
LABELV $219
line 357
;357:    else if (self->monsterinfo && self->monsterinfo->th_stand) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $229
ADDRLP4 8
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $229
line 358
;358:        self->monsterinfo->pausetime = 99999999;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 99999999
ASGNI4
line 359
;359:        self->think = self->monsterinfo->th_stand;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
ASGNP4
line 360
;360:    }
LABELV $229
LABELV $220
line 363
;361:
;362:    // Spread think times
;363:    self->nextthink += random() * 0.5 * 1000;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1148846080
CNSTF4 1056964608
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 365
;364:
;365:    self->die = Monster_Die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 Monster_Die
ASGNP4
line 367
;366:    // total_monsters++;
;367:}
LABELV $214
endproc WalkMonsterStart 40 16
import AI_Touch_MoveTarget
import SP_path_corner_q1
import AI_Range
import AI_InFront
import AI_Visible
import AI_CheckClientPVS
import AI_Sub_AttackFinished
import AI_FacingIdeal
import AI_ChangeYaw
import AI_WalkMove
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
LABELV $228
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $225
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $218
byte 1 119
byte 1 97
byte 1 108
byte 1 107
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 119
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 119
byte 1 97
byte 1 108
byte 1 107
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $148
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $136
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $133
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 102
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $123
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $113
byte 1 83
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 49
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 50
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 114
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 10
byte 1 0
