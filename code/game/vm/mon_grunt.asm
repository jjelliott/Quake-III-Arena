export grunt_stand1
code
proc grunt_stand1 0 4
file "game/grunt.frames"
line 1
;1:FRAME(grunt_stand1, 0, grunt_stand2, { AI_Stand(self); })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand2
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $53
endproc grunt_stand1 0 4
export grunt_stand2
proc grunt_stand2 0 4
line 3
;2:FRAME(grunt_stand2, 1, grunt_stand3, { AI_Stand(self); })
;3:FRAME(grunt_stand3, 2, grunt_stand4, { AI_Stand(self); })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand3
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $55
endproc grunt_stand2 0 4
export grunt_stand3
proc grunt_stand3 0 4
line 5
;4:
;5:FRAME(grunt_stand4, 3, grunt_stand5, { AI_Stand(self); })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $57
endproc grunt_stand3 0 4
export grunt_stand4
proc grunt_stand4 0 4
line 8
;6:FRAME(grunt_stand5, 4, grunt_stand6, { AI_Stand(self); })
;7:FRAME(grunt_stand6, 5, grunt_stand7, { AI_Stand(self); })
;8:FRAME(grunt_stand7, 6, grunt_stand8, { AI_Stand(self); })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand5
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 3
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $59
endproc grunt_stand4 0 4
export grunt_stand5
proc grunt_stand5 0 4
line 10
;9:FRAME(grunt_stand8, 7, grunt_stand1, { AI_Stand(self); })
;10:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand6
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $61
endproc grunt_stand5 0 4
export grunt_stand6
proc grunt_stand6 0 4
line 12
;11:FRAME(grunt_die1, 8, grunt_die2, {  })
;12:FRAME(grunt_die2, 9, grunt_die3, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand7
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 5
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $63
endproc grunt_stand6 0 4
export grunt_stand7
proc grunt_stand7 0 4
line 14
;13:FRAME(grunt_die3, 10, grunt_die4, {  })
;14:FRAME(grunt_die4,11, grunt_die5, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand8
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 6
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $65
endproc grunt_stand7 0 4
export grunt_stand8
proc grunt_stand8 0 4
line 16
;15:FRAME(grunt_die5, 12, grunt_die6, {  })
;16:FRAME(grunt_die6, 13, grunt_die7, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_stand1
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 7
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
LABELV $67
endproc grunt_stand8 0 4
export grunt_die1
proc grunt_die1 0 0
line 19
;17:FRAME(grunt_die7, 14, grunt_die8, {  })
;18:FRAME(grunt_die8, 15, grunt_die9, {  })
;19:FRAME(grunt_die9, 16, grunt_die10, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die2
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 8
ASGNI4
LABELV $69
endproc grunt_die1 0 0
export grunt_die2
proc grunt_die2 0 0
line 21
;20:FRAME(grunt_die10, 17, grunt_die10, {  })
;21:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die3
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 9
ASGNI4
LABELV $71
endproc grunt_die2 0 0
export grunt_die3
proc grunt_die3 0 0
line 23
;22:FRAME(grunt_diec1, 18, grunt_diec2, {  })
;23:FRAME(grunt_diec2, 19, grunt_diec3, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 10
ASGNI4
LABELV $73
endproc grunt_die3 0 0
export grunt_die4
proc grunt_die4 0 0
line 25
;24:FRAME(grunt_diec3, 20, grunt_diec4, {  })
;25:FRAME(grunt_diec4, 21, grunt_diec5, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die5
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 11
ASGNI4
LABELV $75
endproc grunt_die4 0 0
export grunt_die5
proc grunt_die5 0 0
line 27
;26:FRAME(grunt_diec5, 22, grunt_diec6, {  })
;27:FRAME(grunt_diec6, 23, grunt_diec7, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die6
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 12
ASGNI4
LABELV $77
endproc grunt_die5 0 0
export grunt_die6
proc grunt_die6 0 0
line 29
;28:FRAME(grunt_diec7, 24, grunt_diec8, {  })
;29:FRAME(grunt_diec8, 25, grunt_diec9, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die7
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 13
ASGNI4
LABELV $79
endproc grunt_die6 0 0
export grunt_die7
proc grunt_die7 0 0
line 31
;30:FRAME(grunt_diec9, 26, grunt_diec10, {  })
;31:FRAME(grunt_diec10, 27, grunt_diec11, {  })
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die8
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 14
ASGNI4
LABELV $81
endproc grunt_die7 0 0
export grunt_die8
proc grunt_die8 0 0
line 33
;32:FRAME(grunt_diec11, 28, grunt_diec11, {  })
;33:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die9
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 15
ASGNI4
LABELV $83
endproc grunt_die8 0 0
export grunt_die9
proc grunt_die9 0 0
line 35
;34:
;35:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die10
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 16
ASGNI4
LABELV $85
endproc grunt_die9 0 0
export grunt_die10
proc grunt_die10 0 0
line 37
;36:
;37:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_die10
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 17
ASGNI4
LABELV $87
endproc grunt_die10 0 0
export grunt_diec1
proc grunt_diec1 0 0
line 40
;38:
;39:
;40:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec2
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 18
ASGNI4
LABELV $89
endproc grunt_diec1 0 0
export grunt_diec2
proc grunt_diec2 0 0
line 42
;41:
;42:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec3
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 19
ASGNI4
LABELV $91
endproc grunt_diec2 0 0
export grunt_diec3
proc grunt_diec3 0 0
line 44
;43:
;44:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 20
ASGNI4
LABELV $93
endproc grunt_diec3 0 0
export grunt_diec4
proc grunt_diec4 0 0
line 46
;45:
;46:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec5
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 21
ASGNI4
LABELV $95
endproc grunt_diec4 0 0
export grunt_diec5
proc grunt_diec5 0 0
line 48
;47:
;48:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec6
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 22
ASGNI4
LABELV $97
endproc grunt_diec5 0 0
export grunt_diec6
proc grunt_diec6 0 0
line 50
;49:
;50:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec7
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 23
ASGNI4
LABELV $99
endproc grunt_diec6 0 0
export grunt_diec7
proc grunt_diec7 0 0
line 52
;51:
;52:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec8
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 24
ASGNI4
LABELV $101
endproc grunt_diec7 0 0
export grunt_diec8
proc grunt_diec8 0 0
line 54
;53:
;54:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec9
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 25
ASGNI4
LABELV $103
endproc grunt_diec8 0 0
export grunt_diec9
proc grunt_diec9 0 0
line 56
;55:
;56:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec10
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 26
ASGNI4
LABELV $105
endproc grunt_diec9 0 0
export grunt_diec10
proc grunt_diec10 0 0
line 58
;57:
;58:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec11
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 27
ASGNI4
LABELV $107
endproc grunt_diec10 0 0
export grunt_diec11
proc grunt_diec11 0 0
line 60
;59:
;60:
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 grunt_diec11
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 28
ASGNI4
LABELV $109
endproc grunt_diec11 0 0
proc grunt_stand 0 4
file "game/mon_grunt.c"
line 35
;1:// monster_grunt_q1.c
;2://
;3:// Example Quake 1 Grunt monster using the ai_monster scaffolding.
;4://
;5:
;6:#include "ai_monster.h"
;7:#include "ai_monframe.h"
;8:// 1) Generate forward declarations
;9:#define FRAME FRAME_DECL
;10:#include "grunt.frames"
;11:#undef FRAME
;12:
;13:// 2) Generate actual function definitions
;14:#define FRAME FRAME_DEF
;15:#include "grunt.frames"
;16:#undef FRAME
;17:
;18:// ---------------------------------------------------------------------------
;19:// Frame definitions (replace indices with actual MD3 export values)
;20:// ---------------------------------------------------------------------------
;21:#define FRAME_STAND1     0
;22:#define FRAME_STAND20    19
;23:#define FRAME_RUN1       20
;24:#define FRAME_RUN10      29
;25:#define FRAME_ATTACK1    30
;26:#define FRAME_ATTACK8    37
;27:#define FRAME_PAIN1      38
;28:#define FRAME_PAIN2      39
;29:#define FRAME_DEATH1     40
;30:#define FRAME_DEATH10    49
;31:
;32:// ---------------------------------------------------------------------------
;33:// State callbacks
;34:// ---------------------------------------------------------------------------
;35:static void grunt_stand(gentity_t* self) {
line 36
;36:    self->monsterinfo->startframe = FRAME_STAND1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 37
;37:    self->monsterinfo->endframe = FRAME_STAND20;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 19
ASGNI4
line 38
;38:    AI_Stand(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_Stand
CALLV
pop
line 39
;39:}
LABELV $111
endproc grunt_stand 0 4
proc grunt_walk 0 8
line 44
;40:
;41:
;42:
;43:
;44:static void grunt_walk(gentity_t* self) {
line 45
;45:    self->monsterinfo->startframe = FRAME_RUN1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 20
ASGNI4
line 46
;46:    self->monsterinfo->endframe = FRAME_RUN10;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 29
ASGNI4
line 47
;47:    AI_WalkFrame(self, 8);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 AI_WalkFrame
CALLV
pop
line 48
;48:}
LABELV $112
endproc grunt_walk 0 8
proc grunt_run 0 8
line 50
;49:
;50:static void grunt_run(gentity_t* self) {
line 51
;51:    self->monsterinfo->startframe = FRAME_RUN1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 20
ASGNI4
line 52
;52:    self->monsterinfo->endframe = FRAME_RUN10;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 29
ASGNI4
line 53
;53:    AI_RunFrame(self, 12);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 AI_RunFrame
CALLV
pop
line 54
;54:}
LABELV $113
endproc grunt_run 0 8
proc grunt_attack 0 8
line 56
;55:
;56:static void grunt_attack(gentity_t* self) {
line 57
;57:    self->monsterinfo->startframe = FRAME_ATTACK1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 30
ASGNI4
line 58
;58:    self->monsterinfo->endframe = FRAME_ATTACK8;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 37
ASGNI4
line 60
;59:    // TODO: fire projectile / hitscan at mid-frame
;60:    AI_RunFrame(self, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 AI_RunFrame
CALLV
pop
line 61
;61:}
LABELV $114
endproc grunt_attack 0 8
proc grunt_pain 0 0
line 63
;62:
;63:static void grunt_pain(gentity_t* self, gentity_t* attacker, int damage) {
line 64
;64:    self->monsterinfo->startframe = FRAME_PAIN1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 38
ASGNI4
line 65
;65:    self->monsterinfo->endframe = FRAME_PAIN2;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 39
ASGNI4
line 66
;66:    self->s.frame = FRAME_PAIN1;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 38
ASGNI4
line 67
;67:}
LABELV $115
endproc grunt_pain 0 0
proc grunt_die 4 4
line 70
;68:
;69:static void grunt_die(gentity_t* self, gentity_t* inflictor, gentity_t* attacker,
;70:    int damage, int mod) {
line 71
;71:    if (random() < 0.5) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $117
line 72
;72:        grunt_die1(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 grunt_die1
CALLV
pop
line 73
;73:    } else
ADDRGP4 $118
JUMPV
LABELV $117
line 74
;74:    {
line 75
;75:        grunt_diec1(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 grunt_diec1
CALLV
pop
line 76
;76:    }
LABELV $118
line 77
;77:}
LABELV $116
endproc grunt_die 4 4
proc grunt_sight 4 12
line 79
;78:
;79:static void grunt_sight(gentity_t* self, gentity_t* other) {
line 81
;80:    // Play the sight sound, alert animation, etc.
;81:    G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/sight1.wav"));
ADDRGP4 $120
ARGP4
ADDRLP4 0
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 82
;82:}
LABELV $119
endproc grunt_sight 4 12
export SP_monster_grunt_q1
proc SP_monster_grunt_q1 12 4
line 86
;83:// ---------------------------------------------------------------------------
;84:// Spawn
;85:// ---------------------------------------------------------------------------
;86:void SP_monster_grunt_q1(gentity_t* self) {
line 87
;87:    AI_InitForEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AI_InitForEntity
CALLV
pop
line 89
;88:    // Assign callbacks
;89:    self->monsterinfo->th_stand = grunt_stand1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 56
ADDP4
ADDRGP4 grunt_stand1
ASGNP4
line 90
;90:    self->monsterinfo->th_walk = grunt_walk;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 grunt_walk
ASGNP4
line 91
;91:    self->monsterinfo->th_run = grunt_run;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 grunt_run
ASGNP4
line 92
;92:    self->monsterinfo->th_melee = grunt_attack;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 grunt_attack
ASGNP4
line 93
;93:    self->monsterinfo->th_missile = grunt_attack;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 72
ADDP4
ADDRGP4 grunt_attack
ASGNP4
line 94
;94:    self->monsterinfo->th_pain = grunt_pain;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 grunt_pain
ASGNP4
line 95
;95:    self->monsterinfo->th_die = grunt_die;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 80
ADDP4
ADDRGP4 grunt_die
ASGNP4
line 96
;96:    self->monsterinfo->th_sight = grunt_sight;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 grunt_sight
ASGNP4
line 99
;97:
;98:    // Starting state
;99:    self->monsterinfo->startframe = FRAME_STAND1;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 100
;100:    self->monsterinfo->endframe = FRAME_STAND20;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 19
ASGNI4
line 101
;101:    self->s.frame = FRAME_STAND1;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 104
;102:
;103:    // Q3 entity setup
;104:    self->health = 30;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 30
ASGNI4
line 105
;105:    self->max_health = 30;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 30
ASGNI4
line 106
;106:    self->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 107
;107:    self->clipmask = MASK_MONSTERSOLID;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 33619969
ASGNI4
line 108
;108:    self->r.svFlags |= SVF_MONSTER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 109
;109:    self->r.svFlags &= ~SVF_NOCLIENT; // make sure it’s not ignored by server
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 110
;110:    self->r.contents = CONTENTS_BODY;    // treated as a physical body
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 113
;111:
;112:    // Model / bounding box
;113:    self->s.modelindex = G_ModelIndex("models/monsters/grunt.md3");
ADDRGP4 $122
ARGP4
ADDRLP4 8
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 114
;114:    VectorSet(self->r.mins, -16, -16, -24);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3250585600
ASGNF4
line 115
;115:    VectorSet(self->r.maxs, 16, 16, 40);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1109393408
ASGNF4
line 116
;116:    VectorSet(self->monsterinfo->view_ofs, 0, 0, 24 );
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1103101952
ASGNF4
line 118
;117:    // self->s.pos.trBase[2] += 8; // raise 16 units for rendering
;118:    trap_LinkEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 119
;119:    self->think = WalkMonsterStart;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 WalkMonsterStart
ASGNP4
line 120
;120:    self->nextthink = level.time + 1;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 121
;121:}
LABELV $121
endproc SP_monster_grunt_q1 12 4
import WalkMonsterStart
import AI_SetMoveTarget
import AI_Touch_MoveTarget
import SP_path_corner_q1
import AI_RunFrame
import AI_WalkFrame
import AI_Stand
import AI_FoundTarget
import AI_FindTarget
import AI_Range
import AI_InFront
import AI_Visible
import AI_CheckClientPVS
import AI_Sub_AttackFinished
import AI_FacingIdeal
import AI_ChangeYaw
import AI_WalkMove
import AI_MoveToGoal
import AI_ClearEntity
import AI_InitForEntity
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
LABELV $122
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $120
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
