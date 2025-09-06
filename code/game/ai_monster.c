// ai_monster.c
//
// Implementation of Quake 1-style monster AI scaffolding
// for use inside Quake 3 VM.
//
#include "ai_monster.h"
float fmodf(float x, float y) {
    return x - floor(x / y) * y;
}
static int checkpvs_client = 0;

gentity_t* checkclient(void) {
    int i;
    gentity_t* ent;

    // loop through clients (one per call, wrap around)
    for (i = 0; i < level.maxclients; i++) {
        checkpvs_client = (checkpvs_client + 1) % level.maxclients;
        ent = &g_entities[checkpvs_client];
        if (!ent->inuse || !ent->client)
            continue;

        // must be alive
        if (ent->health <= 0)
            continue;

        // make sure it's in PVS of some monster (optional optimization)
        // if (!gi.inPVS(monster->s.origin, ent->s.origin))
        //    continue;

        return ent;
    }

    return NULL;
}

qboolean FacingIdeal(gentity_t* self) {
    float delta = AngleNormalize360(self->s.angles[YAW] - self->monsterinfo->ideal_yaw);
    if (delta > 45 && delta < 315) {
        return qfalse;
    }
    return qtrue;
}

void AI_ChangeYaw(gentity_t* ent) {
    float ideal, current, move, delta, speed;

    if (!ent || !ent->monsterinfo)
        return;

    ideal = ent->monsterinfo->ideal_yaw;
    current = AngleMod(ent->s.angles[1]);  // current yaw
    delta = ideal - current;

    // wrap delta to [-180, 180]
    while (delta > 180.0f) delta -= 360.0f;
    while (delta < -180.0f) delta += 360.0f;

    // move by at most yaw_speed
    speed = ent->monsterinfo->yaw_speed;
    if (speed <= 0.0f)
        speed = 20.0f; // default speed if not set

    if (delta > speed)
        move = speed;
    else if (delta < -speed)
        move = -speed;
    else
        move = delta;

    ent->s.angles[1] += move;

    // wrap final yaw to [0,360)
    if (ent->s.angles[1] < 0) ent->s.angles[1] += 360.0f;
    if (ent->s.angles[1] >= 360.0f) ent->s.angles[1] -= 360.0f;
}

//
// Range categorization
//

range_t Range(gentity_t* self, gentity_t* targ) {
    vec3_t spot1, spot2;
    vec3_t targ_offset;
    vec3_t delta;
    float r;
    if (targ->client) {
        targ_offset[0] = 0;
        targ_offset[1] = 0;
        targ_offset[2] = targ->client->ps.viewheight;
    }
    else {
        VectorClear(targ_offset); // zero vector
    }

    VectorAdd(targ->r.currentOrigin, targ_offset, spot2);
    VectorAdd(self->r.currentOrigin, self->monsterinfo->view_ofs, spot1);
    VectorSubtract(spot1, spot2, delta);
    r = VectorLength(delta);
    // G_Printf("spot1 %.1f %.1f %.1f spot2 %.1f %.1f %.1f r %.1f\n",
    // spot1[0], spot1[1], spot1[2], spot2[0], spot2[1], spot2[2], r);

    if (r < 120)
        return RANGE_MELEE;
    if (r < 500)
        return RANGE_NEAR;
    if (r < 1000)
        return RANGE_MID;
    return RANGE_FAR;
}

//
// Visibility check
//
qboolean Visible(gentity_t* self, gentity_t* targ) {
    vec3_t spot1, spot2;
    trace_t tr;

    VectorAdd(self->r.currentOrigin, self->monsterinfo->view_ofs, spot1);

    trap_Trace(&tr, spot1, NULL, NULL, targ->r.currentOrigin, self->s.number, MASK_SOLID);

    if (tr.fraction == 1.0f) {
        return qtrue;
    }
    return qfalse;
}

//
// Infront check
//
qboolean Infront(gentity_t* self, gentity_t* targ) {
    vec3_t vec, forward;
    float dot;

    AngleVectors(self->s.angles, forward, NULL, NULL);
    VectorSubtract(targ->r.currentOrigin, self->r.currentOrigin, vec);
    VectorNormalize(vec);

    dot = DotProduct(vec, forward);

    return (dot > 0.3f) ? qtrue : qfalse;
}

qboolean AI_FindTarget(gentity_t* self)
{
    gentity_t* client;
    float r;

    G_Printf("Searching for enemy\n");
    // quick sight wakeup (sight_entity from other monsters)
    if (level.sight_entity_time >= level.time - 100 && !(self->spawnflags & 3)) {
        client = level.sight_entity;
        if (client && client->enemy == self->enemy)
            return qtrue;
    }
    else {
        client = checkclient(); // TODO: implement checkclient
        if (!client)
            return qfalse;
    }
    // G_Printf("%s\n", client->classname);
    if (client == self->enemy) {
        return qfalse;
    }

    if (client->flags & FL_NOTARGET)
        return qfalse;

    if (client->client && (client->client->ps.powerups[PW_INVIS] > level.time))
        return qfalse;

    r = Range(self, client);
    if (r == RANGE_FAR)
    {
        // G_Printf("player too far");
        return qfalse;
    }
    if (!Visible(self, client))
    {
        // G_Printf("player not visible");
        return qfalse;
    }
    if (r == RANGE_NEAR) {
        if (client->show_hostile < level.time && !Infront(self, client))
            return qfalse;
    }
    else if (r == RANGE_MID) {
        if (!Infront(self, client))
            return qfalse;
    }

    // got one
    self->enemy = client;
    if (strcmp(client->classname, "player") != 0) {
        self->enemy = client->enemy;
        if (!self->enemy || strcmp(self->enemy->classname, "player") != 0) {
            self->enemy = NULL;
            return qfalse;
        }
    }

    AI_FoundTarget(self);
    return qtrue;
}

void SUB_AttackFinished(gentity_t* self, float delay) {
    self->monsterinfo->attack_finished = level.time + delay;
}
void HuntTarget(gentity_t* self) {

    vec3_t dir;
    if (!self->enemy) {
        return;
    }

    self->monsterinfo->goalentity = self->enemy;

    // switch to running AI
    if (self->monsterinfo && self->monsterinfo->th_run) {
        self->think = self->monsterinfo->th_run;
    }

    // face enemy
    VectorSubtract(self->enemy->r.currentOrigin, self->r.currentOrigin, dir);
    self->monsterinfo->ideal_yaw = vectoyaw(dir);

    // schedule next think
    self->nextthink = level.time + FRAMETIME; // ~0.1s

    // delay before attacking
    SUB_AttackFinished(self, 1.0f);
}
void AI_FoundTarget(gentity_t* self) {
    if (self->enemy && strcmp(self->enemy->classname, "player") == 0) {
        level.sight_entity = self;
        level.sight_entity_time = level.time;
    }self->monsterinfo->attack_finished = level.time + 3000;

    self->show_hostile = level.time + 1000; // ms

    if (self->monsterinfo->th_sight) {
        self->monsterinfo->th_sight(self, self->enemy);
    }
    // G_Printf("spotted enemy!\n");
    HuntTarget(self);
}

void SUB_CheckRefire(gentity_t* self, void thinkFn(gentity_t* nSelf))
{
    if (self->monsterinfo->cnt == 1)
        return;

    if (!Visible(self, self->enemy))
        return;

    self->monsterinfo->cnt = 1;
    self->think = thinkFn;
};
// ---------------------------------------------------------------------------
// Frame drivers
// ---------------------------------------------------------------------------
void AI_Face(gentity_t* self)
{
    vec3_t dir;
    VectorSubtract(self->enemy->r.currentOrigin, self->r.currentOrigin, dir);
    self->monsterinfo->ideal_yaw = vectoyaw(dir);
    AI_ChangeYaw(self);
    trap_LinkEntity(self);
    VectorCopy(self->r.currentOrigin, self->s.origin);
    self->s.pos.trType = TR_STATIONARY;
    VectorCopy(self->r.currentOrigin, self->s.pos.trBase);
    self->s.apos.trType = TR_STATIONARY; // angles won't be interpolated
    self->s.apos.trTime = level.time;
    self->s.apos.trBase[YAW] = self->s.angles[YAW];
    
}
void AI_Stand(gentity_t* self) {
    if (AI_FindTarget(self)) {
        return; // target acquired, HuntTarget() is triggered
    }

    if (level.time > self->monsterinfo->pausetime) {
        if (self->monsterinfo && self->monsterinfo->th_walk) {
            self->monsterinfo->th_walk(self);
        }
    }
}

void AI_Walk(gentity_t* self, float dist) {
}

// float CheckAttack(gentity_t* self) 
// {
//     vec3_t	spot1, spot2;
//      gentity_t*	targ;
//      float		chance;
//
//     targ = self->enemy;
//
//     // see if any entities are in the way of the shot
//     spot1 = self->origin + self.view_ofs;
//     spot2 = targ.origin + targ.view_ofs;
//
//     traceline(spot1, spot2, qfalse, self);
//
//     if (trace_ent != targ)
//         return qfalse;		// don't have a clear shot
//
//     if (trace_inopen && trace_inwater)
//         return qfalse;			// sight line crossed contents
//
//     if (enemy_range == RANGE_MELEE)
//     {	// melee attack
//         if (self.th_melee)
//         {
//             if (self.classname == "monster_knight")
//                 knight_attack();
//             else
//                 self.th_melee();
//
//             return qtrue;
//         }
//     }
//
//     // missile attack
//         if (!self.th_missile)
//             return qfalse;
//
//         if (time < self.attack_finished)
//             return qfalse;
//
//         if (enemy_range == RANGE_FAR)
//             return qfalse;
//
//         if (enemy_range == RANGE_MELEE)
//         {
//             chance = 0.9;
//             self->monsterinfo->attack_finished = 0;
//         }
//         else if (enemy_range == RANGE_NEAR)
//         {
//             if (self.th_melee)
//                 chance = 0.2;
//             else
//                 chance = 0.4;
//         }
//         else if (enemy_range == RANGE_MID)
//         {
//             if (self.th_melee)
//                 chance = 0.05;
//             else
//                 chance = 0.1;
//         }
//         else
//             chance = 0;
//
//         if (random() < chance)
//         {
//             self->monsterinfo->th_missile(self);
//             SUB_AttackFinished(self, 2 * random());
//             return qtrue;
//         }
//
//         return qfalse;
// };

void AI_Run_Missile(gentity_t* self, float enemy_yaw)
{
    self->monsterinfo->ideal_yaw = enemy_yaw;
    AI_ChangeYaw(self);
    if (FacingIdeal(self))
    {
        self->monsterinfo->th_missile(self);
        self->monsterinfo->attack_state = AS_STRAIGHT;
    }

}

void AI_Run(gentity_t* self, float dist) {
    float enemy_yaw;
    qboolean enemy_visible;
    vec3_t dir;
    gentity_t* enemy = self->enemy;
    range_t enemy_range;

    if (!enemy || !enemy->inuse || enemy->health <= 0) {
        // handle oldenemy fallback, or go idle
        return;
    }

    self->show_hostile = level.time + 1000;

    enemy_visible = Visible(self, enemy);
    if (enemy_visible) {
        self->monsterinfo->search_time = level.time + 5000;
    }

    VectorSubtract(enemy->r.currentOrigin, self->r.currentOrigin, dir);
    enemy_yaw = vectoyaw(dir);
    enemy_range = Range(self, enemy);
    // Attack state handling
    if (self->monsterinfo->attack_state == AS_MISSILE) {
        AI_Run_Missile(self, enemy_yaw);
        return;
    }
    if (self->monsterinfo->attack_state == AS_MELEE) {
        // ai_run_melee(self, enemy_yaw);
        return;
    }

    if (self->monsterinfo->th_check && self->monsterinfo->th_check(self, enemy_range)) {
        return;
    }

    // if (AI_CheckAttack(self))
    // {
	   //  
    // }

    if (self->monsterinfo->attack_state == AS_SLIDING) {
        // ai_run_slide(self, enemy_yaw, dist);
        return;
    }

    AI_MoveToGoal(self, dist);
}

// ============================================================
// Helpers & constants
// ============================================================

#ifndef DI_NODIR
#define DI_NODIR   (-1.0f)
#endif

// Quake-style AngleMod in degrees
static float AI_AngleMod(float a) {
    a = fmodf(a, 360.0f);
    if (a < 0.0f) a += 360.0f;
    return a;
}

// Compute bbox abs mins/maxs for a gentity at a given origin
static void AI_AbsBoundsAt(const gentity_t* ent, const vec3_t at, vec3_t outMins, vec3_t outMaxs) {
    outMins[0] = at[0] + ent->r.mins[0];
    outMins[1] = at[1] + ent->r.mins[1];
    outMins[2] = at[2] + ent->r.mins[2];

    outMaxs[0] = at[0] + ent->r.maxs[0];
    outMaxs[1] = at[1] + ent->r.maxs[1];
    outMaxs[2] = at[2] + ent->r.maxs[2];
}

// Cheap 2D distance helper
static float AI_Dist2D(const vec3_t a, const vec3_t b) {
    vec3_t d;
    d[0] = a[0] - b[0];
    d[1] = a[1] - b[1];
    return sqrt(d[0] * d[0] + d[1] * d[1]);
}

// ============================================================
// CloseEnough  (Q1 SV_CloseEnough)
// bbox-vs-bbox distance check with a margin (dist)
// ============================================================
static qboolean AI_CloseEnough(gentity_t* ent, gentity_t* goal, float dist) {
    vec3_t emn, emx, gmn, gmx;

    AI_AbsBoundsAt(ent, ent->r.currentOrigin, emn, emx);
    AI_AbsBoundsAt(goal, goal->r.currentOrigin, gmn, gmx);

    // If any axis is separated more than dist, not close enough
    if (gmn[0] > emx[0] + dist) return qfalse;
    if (gmx[0] < emn[0] - dist) return qfalse;
    if (gmn[1] > emx[1] + dist) return qfalse;
    if (gmx[1] < emn[1] - dist) return qfalse;
    if (gmn[2] > emx[2] + dist) return qfalse;
    if (gmx[2] < emn[2] - dist) return qfalse;

    return qtrue;
}

// ============================================================
// StepDirection  (Q1 SV_StepDirection)
// Turn toward yaw and try to walk 'dist' units along that yaw,
// with step-up and single drop-down to keep glued to floor.
// ============================================================
static qboolean AI_StepDirection(gentity_t* self, float yawDeg, float dist) {
    vec3_t move, start, raisedStart, end, downEnd, moveDir2D, yawDir;
    trace_t tr;
    float yawRad, delta, moveLen, moveYaw;
    float stepHeight = 18.0f;     // Q1-ish stair step
    int clipmask = MASK_SOLID;    // or MASK_PLAYERSOLID if you prefer

    // Set and turn toward ideal_yaw first
    self->monsterinfo->ideal_yaw = yawDeg;
    AI_ChangeYaw(self); // your yaw stepper (uses yaw_speed)

    // Build 2D move vector from yaw
    yawRad = yawDeg * (float)M_PI * 2.0f / 360.0f;
    move[0] = cos(yawRad) * dist;
    move[1] = sin(yawRad) * dist;
    move[2] = 0.0f;

    // Try horizontal move first
    VectorCopy(self->r.currentOrigin, start);
    VectorAdd(start, move, end);

    trap_Trace(&tr, start, self->r.mins, self->r.maxs, end, self->s.number, clipmask);
    if (tr.fraction < 1.0f) {
        // Blocked horizontally — try step up, then move, then drop down once
        VectorCopy(self->r.currentOrigin, raisedStart);
        raisedStart[2] += stepHeight;
        VectorAdd(raisedStart, move, end);

        trap_Trace(&tr, raisedStart, self->r.mins, self->r.maxs, end, self->s.number, clipmask);
        if (tr.fraction < 1.0f) {
            // Still blocked, fail
            return qfalse;
        }

        // We made the stepped move; now drop down up to stepHeight to land
        VectorCopy(tr.endpos, downEnd);
        downEnd[2] -= (stepHeight + 1.0f);
        trap_Trace(&tr, tr.endpos, self->r.mins, self->r.maxs, downEnd, self->s.number, clipmask);

        // If we hit something within stepHeight, land on it
        if (tr.fraction < 1.0f) {
            VectorCopy(tr.endpos, self->r.currentOrigin);
        }
        else {
            // Nothing to land on—undo (don’t take the step)
            return qfalse;
        }
    }
    else {
        // Horizontal was clear—take it, then do a small floor snap
        VectorCopy(tr.endpos, self->r.currentOrigin);

        VectorCopy(self->r.currentOrigin, downEnd);
        downEnd[2] -= 64.0f; // probe down a bit
        trap_Trace(&tr, self->r.currentOrigin, self->r.mins, self->r.maxs, downEnd, self->s.number, clipmask);
        G_Printf("trace endpos: %.2f %.2f %.2f fraction: %.2f\n",
            tr.endpos[0], tr.endpos[1], tr.endpos[2], tr.fraction);
        if (tr.fraction < 1.0f) {
            // Snap to ground contact
            self->r.currentOrigin[2] = tr.endpos[2];
        }
    }

    // Q1 parity: if we didn’t turn “far enough”, cancel the step.
    // In Q1 they compare current angles[YAW] to ideal_yaw; do the same:
    delta = AI_AngleMod(self->s.angles[YAW] - self->monsterinfo->ideal_yaw);
    if (delta > 45.0f && delta < 315.0f) {
        // Not turned enough yet; undo move
        VectorCopy(start, self->r.currentOrigin);
        VectorCopy(start, self->s.origin);
        trap_LinkEntity(self);
        return qfalse;
    }

    // Link/update render origin + yaw facing
    VectorSubtract(self->r.currentOrigin, start, moveDir2D);
    moveDir2D[2] = 0.0f;

    if (VectorLength(moveDir2D) > 0.1f) {
        self->s.angles[YAW] = vectoyaw(moveDir2D);
    }

    trap_LinkEntity(self);
    VectorCopy(self->r.currentOrigin, self->s.origin);
    self->s.pos.trType = TR_STATIONARY;
    VectorCopy(self->r.currentOrigin, self->s.pos.trBase);

    return qtrue;
}

// ============================================================
// NewChaseDir (Q1 SV_NewChaseDir)
// 8-way (45-degree) chase steering fallback if direct step fails
// ============================================================
static void AI_NewChaseDir(gentity_t* actor, gentity_t* enemy, float dist) {
    float olddir, turnaround;
    float deltax, deltay;
    float d1, d2, tdir;
    qboolean tryDiagFirst;
    vec3_t aorg, eorg;

    // quantize to 45s like Q1
    olddir = AI_AngleMod((float)((int)(actor->monsterinfo->ideal_yaw / 45.0f) * 45));
    turnaround = AI_AngleMod(olddir - 180.0f);

    VectorCopy(actor->r.currentOrigin, aorg);
    VectorCopy(enemy->r.currentOrigin, eorg);
    deltax = eorg[0] - aorg[0];
    deltay = eorg[1] - aorg[1];

    // Encode desired cardinal directions (0, 90, 180, 270) or DI_NODIR
    if (deltax > 10.0f)      d1 = 0.0f;
    else if (deltax < -10.0f)d1 = 180.0f;
    else                     d1 = DI_NODIR;

    if (deltay < -10.0f)     d2 = 270.0f;
    else if (deltay > 10.0f) d2 = 90.0f;
    else                     d2 = DI_NODIR;

    // Try direct diagonal if both defined
    if (d1 != DI_NODIR && d2 != DI_NODIR) {
        if (d1 == 0.0f)      tdir = (d2 == 90.0f) ? 45.0f : 315.0f;
        else                 tdir = (d2 == 90.0f) ? 135.0f : 225.0f;

        if (tdir != turnaround && AI_StepDirection(actor, tdir, dist))
            return;
    }

    // Try swapping priority (Q1 randomizes)
    tryDiagFirst = (((rand() & 3) & 1) != 0) || (fabs(deltay) > fabs(deltax));
    if (tryDiagFirst) {
        float tmp = d1; d1 = d2; d2 = tmp;
    }

    if (d1 != DI_NODIR && d1 != turnaround && AI_StepDirection(actor, d1, dist))
        return;

    if (d2 != DI_NODIR && d2 != turnaround && AI_StepDirection(actor, d2, dist))
        return;

    // Try continuing in olddir
    if (olddir != DI_NODIR && AI_StepDirection(actor, olddir, dist))
        return;

    // Sweep 0..315 or 315..0 (45 deg steps)
    if (rand() & 1) {
        for (tdir = 0.0f; tdir <= 315.0f; tdir += 45.0f) {
            if (tdir != turnaround && AI_StepDirection(actor, tdir, dist))
                return;
        }
    }
    else {
        for (tdir = 315.0f; tdir >= 0.0f; tdir -= 45.0f) {
            if (tdir != turnaround && AI_StepDirection(actor, tdir, dist))
                return;
        }
    }

    // Last resort: turnaround
    if (turnaround != DI_NODIR && AI_StepDirection(actor, turnaround, dist))
        return;

    // Can't move — restore ideal
    actor->monsterinfo->ideal_yaw = olddir;

    // Parity with Q1 bottom-fix: if not on valid ground, mark partial ground
    if (!(actor->monsterinfo->flags & FL_ONGROUND)) {
        actor->monsterinfo->flags |= FL_PARTIALGROUND; // define this in your flags if you want to track it
    }
}

// ============================================================
// MoveToGoal (Q1 SV_MoveToGoal)
// Called by ai_walk/ai_run drivers.
// ============================================================
qboolean AI_MoveToGoal(gentity_t* self, float dist) {
    gentity_t* goal;
    qboolean onGroundOrFree;
    qboolean closeToEnemy;

    // Require a goalentity like Q1 (in Q1 they compare to world; here just check non-NULL)
    if (!self->monsterinfo || !self->monsterinfo->goalentity)
    {
        G_Printf("movetogoal: no goalentity set\n");
	    return qfalse;
    }
    G_Printf("movetogoal start: self=%i goal=%i\n",
        self->s.number,
        self->monsterinfo->goalentity->s.number);
    goal = self->monsterinfo->goalentity;

    // Emulate Q1 "must be on ground/fly/swim". If you track FL_ONGROUND:
    onGroundOrFree = ((self->monsterinfo->flags & (FL_ONGROUND | FL_FLY | FL_SWIM)) != 0);
    if (!onGroundOrFree) {
        G_Printf("movetogoal not on ground: self=%i goal=%i\n",
            self->s.number,
            self->monsterinfo->goalentity->s.number);
        // Allow “free fall” AI to be idle; just bail this frame
        return qfalse;
    }

    // If the next step hits the enemy/goal, return immediately
    closeToEnemy = AI_CloseEnough(self, goal, dist);
    if (closeToEnemy) {
        G_Printf("movetogoal too close to enemy: self=%i goal=%i\n",
            self->s.number,
            self->monsterinfo->goalentity->s.number);
        return qfalse;
    }

    // Try stepping along current ideal yaw. Occasionally (rand) or on failure, pick a new chase dir.
    if (((rand() & 3) == 1) || !AI_StepDirection(self, self->monsterinfo->ideal_yaw, dist)) {
        AI_NewChaseDir(self, goal, dist);
    }


    VectorCopy(self->r.currentOrigin, self->s.pos.trBase);
    self->s.apos.trType = TR_STATIONARY; // angles won't be interpolated
    self->s.apos.trTime = level.time;
    self->s.apos.trBase[YAW] = self->s.angles[YAW];
    return qtrue;
}



// ---------------------------------------------------------------------------
// Init helpers
// ---------------------------------------------------------------------------
void AI_InitForEntity(gentity_t* ent) {
    ent->monsterinfo = G_Alloc(sizeof(monsterinfo_t));
    memset(ent->monsterinfo, 0, sizeof(monsterinfo_t));

}

void AI_ClearEntity(gentity_t* ent) {
    if (ent->monsterinfo) {
        G_FreeEntity(ent);
        ent->monsterinfo = NULL;
    }
}

// ---------------------------------------------------------------------------
// Basic movement / targeting stubs (to be expanded)
// ---------------------------------------------------------------------------


void AI_SetMoveTarget(gentity_t* self, gentity_t* target) {
    if (!self->monsterinfo) return;
    self->monsterinfo->goalentity = target;
}

void Monster_DropToFloor(gentity_t* ent) {
    trace_t tr;
    vec3_t start, end;

    VectorCopy(ent->s.origin, start);
    VectorCopy(ent->s.origin, end);
    end[2] -= 8192; // big number to go to floor

    trap_Trace(&tr, start, ent->r.mins, ent->r.maxs, end, ent->s.number, MASK_SOLID);

    if (tr.fraction < 1.0) {
        G_SetOrigin(ent, tr.endpos);
        trap_LinkEntity(ent);

    }
    else {
        G_Printf("Monster failed to drop to floor at %.1f %.1f %.1f\n",
            ent->s.origin[0], ent->s.origin[1], ent->s.origin[2]);
    }
}


void Monster_Die(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
    // play death animation, drop loot, etc.
    self->takedamage = qfalse;
    self->r.contents = 0;        // not solid to anything
    self->clipmask = 0;          // doesn’t collide when tracing against world
    trap_LinkEntity(self);

    self->monsterinfo->th_die(self, inflictor, attacker, damage, mod);
}

void Monster_Pain(gentity_t* self, gentity_t* attacker, int damage)
{
    if (!self->enemy) 
    {
        self->enemy = attacker;
        AI_FoundTarget(self);
    }
    self->monsterinfo->th_pain(self, attacker, damage);
}

// Reusable WalkMonsterStart
void WalkMonsterStart(gentity_t* self) {
    G_Printf("walkmonster starting\n");
    // raise off floor a bit
    self->s.origin[2] += 1;
    Monster_DropToFloor(self);

    self->monsterinfo->flags |= FL_ONGROUND;
    // check if monster is stuck
    // if (!AI_MoveToGoal(self, 0)) {
    // G_Printf("walkmonster in wall at: %.2f %.2f %.2f\n",
    // self->s.origin[0], self->s.origin[1], self->s.origin[2]);
    // }

    self->takedamage = qtrue;
    // self->ideal_yaw = self->s.angles[1];

    if (!self->monsterinfo->yaw_speed)
        self->monsterinfo->yaw_speed = 20;

    // VectorSet(self->view_ofs, 0, 0, 25);
    // self->use = Monster_Use;

    // self->team = TEAM_MONSTERS;
    // self->flags |= FL_MONSTER;


    if (self->target) {
        self->monsterinfo->goalentity = G_Find(NULL, FOFS(targetname), self->target);
        if (self->monsterinfo->goalentity) {
            // self->ideal_yaw = vectoyaw(self->goalentity->s.origin - self->s.origin);

            // Call the walk function if defined, else stand
            if (self->monsterinfo && self->monsterinfo->th_walk &&
                strcmp(self->monsterinfo->goalentity->classname, "path_corner") == 0)
            {
                self->think = self->monsterinfo->th_walk;
            }
            else if (self->monsterinfo && self->monsterinfo->th_stand) {
                self->monsterinfo->pausetime = 99999999;
                self->think = self->monsterinfo->th_stand;
            }
        }
        else {
            G_Printf("Monster can't find target at: %.2f %.2f %.2f\n",
                self->s.origin[0], self->s.origin[1], self->s.origin[2]);
        }
    }
    else if (self->monsterinfo && self->monsterinfo->th_stand) {
        self->monsterinfo->pausetime = 99999999;
        self->think = self->monsterinfo->th_stand;
    }

    // Spread think times
    self->nextthink += random() * 0.5 * 1000;
    self->pain = Monster_Pain;
    self->die = Monster_Die;
    // total_monsters++;
}

