
// ai_monster.h
//
// Quake 1 → Quake 3 AI bridge
// Exposes helper functions & types for Q1-style monster logic
// to be used inside the Quake 3 game VM.
//

#ifndef AI_MONSTER_H
#define AI_MONSTER_H

#include "g_local.h"

// ---------------------------------------------------------------------------
// Macros
// ---------------------------------------------------------------------------
#define SEC(x)   ((x) * 1000)   // Q1 seconds → Q3 ms

// ---------------------------------------------------------------------------
// AI State (per-entity monsterinfo)
// ---------------------------------------------------------------------------
// typedef struct {
//     int     startframe;
//     int     endframe;
//     int     nextframe;
//
//     int     attack_finished;   // ms until next attack is allowed
//     int     pausetime;         // ms used in stand/walk logic
//
//     vec3_t  move_target;       // next path_corner goal
//     gentity_t* goalentity;     // current goal entity
//     gentity_t* enemy;          // current target enemy
//
//     // Function pointers (Quake 1 parity)
//     void (*th_stand)(gentity_t* self);
//     void (*th_walk)(gentity_t* self);
//     void (*th_run)(gentity_t* self);
//     void (*th_melee)(gentity_t* self);
//     void (*th_missile)(gentity_t* self);
//     void (*th_pain)(gentity_t* self, gentity_t* attacker, int damage);
//     void (*th_die)(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, vec3_t point);
//
// } monsterinfo_t;

// Attach to gentity_t
#define MONSTERINFO(ent)   ((monsterinfo_t*)(ent)->monsterinfo)

// ---------------------------------------------------------------------------
// API
// ---------------------------------------------------------------------------

// Init / teardown
void AI_InitForEntity(gentity_t* ent);
void AI_ClearEntity(gentity_t* ent);

// Movement / goal handling
qboolean AI_MoveToGoal(gentity_t* self, float dist);
qboolean AI_WalkMove(gentity_t* self, float yaw, float dist);
void AI_ChangeYaw(gentity_t* ent);
qboolean AI_FacingIdeal(gentity_t* ent);

// Combat / targeting
void AI_Sub_AttackFinished(gentity_t* self, float time);
gentity_t* AI_CheckClientPVS(gentity_t* self);
qboolean AI_Visible(gentity_t* self, gentity_t* other);
qboolean AI_InFront(gentity_t* self, gentity_t* other);
float AI_Range(gentity_t* self, gentity_t* other);
qboolean AI_FindTarget(gentity_t* self);
void AI_FoundTarget(gentity_t* self);

// Frame drivers
void AI_Stand(gentity_t* self);
void AI_WalkFrame(gentity_t* self, float dist);
void AI_RunFrame(gentity_t* self, float dist);

// Path_corner support
void SP_path_corner_q1(gentity_t* self);
void AI_Touch_MoveTarget(gentity_t* self, gentity_t* other, trace_t* trace);

// Utility
void AI_SetMoveTarget(gentity_t* self, gentity_t* target);
void WalkMonsterStart(gentity_t* self);
#endif // AI_MONSTER_H
