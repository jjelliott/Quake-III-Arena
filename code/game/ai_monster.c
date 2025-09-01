// ai_monster.c
//
// Implementation of Quake 1-style monster AI scaffolding
// for use inside Quake 3 VM.
//
#include "ai_monster.h"

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
    G_Printf("spot1 %.1f %.1f %.1f spot2 %.1f %.1f %.1f r %.1f\n",
        spot1[0], spot1[1], spot1[2], spot2[0], spot2[1], spot2[2], r);

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
    G_Printf("%s\n", client->classname);
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
        G_Printf("player too far");
        return qfalse;
    }
    if (!Visible(self, client))
    {
        G_Printf("player not visible");
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
    }

    self->show_hostile = level.time + 1000; // ms

    if (self->monsterinfo->th_sight) {
        self->monsterinfo->th_sight(self, self->enemy);
    }
    G_Printf("spotted enemy!\n");
    HuntTarget(self);
}

// ---------------------------------------------------------------------------
// Frame drivers
// ---------------------------------------------------------------------------
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

void AI_Run(gentity_t* self, float dist) {
    gentity_t* enemy = self->enemy;

    if (!enemy || !enemy->inuse || enemy->health <= 0) {
        // handle oldenemy fallback, or go idle
        return;
    }

    self->show_hostile = level.time + 1000;

    qboolean enemy_visible = Visible(self, enemy);
    if (enemy_visible) {
        self->monsterinfo->search_time = level.time + 5000;
    }

    float enemy_yaw = vectoyaw(enemy->r.currentOrigin - self->r.currentOrigin);

    // Attack state handling
    if (self->monsterinfo->attack_state == AS_MISSILE) {
        // ai_run_missile(self, enemy_yaw);
        return;
    }
    if (self->monsterinfo->attack_state == AS_MELEE) {
        // ai_run_melee(self, enemy_yaw);
        return;
    }

    if (self->monsterinfo->th_check && self->monsterinfo->th_check(self)) {
        return;
    }

    if (self->monsterinfo->attack_state == AS_SLIDING) {
        // ai_run_slide(self, enemy_yaw, dist);
        return;
    }

    movetogoal(self, dist);
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
qboolean AI_MoveToGoal(gentity_t* self, float dist) {

    vec3_t dir;
    if (!self->monsterinfo || !self->monsterinfo->goalentity) return qfalse;

    // Simple face & move
    VectorSubtract(self->monsterinfo->goalentity->r.currentOrigin, self->r.currentOrigin, dir);
    self->s.pos.trDelta[0] = dir[0] * 0.1f; // crude movement
    self->s.pos.trDelta[1] = dir[1] * 0.1f;
    return qtrue;
}

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

// Reusable WalkMonsterStart
void WalkMonsterStart(gentity_t* self) {
    G_Printf("walkmonster starting\n");
    // raise off floor a bit
    self->s.origin[2] += 1;
    Monster_DropToFloor(self);

    // check if monster is stuck
    if (!AI_MoveToGoal(self, 0)) {
        G_Printf("walkmonster in wall at: %.2f %.2f %.2f\n",
            self->s.origin[0], self->s.origin[1], self->s.origin[2]);
    }

    self->takedamage = qtrue;
    // self->ideal_yaw = self->s.angles[1];

    // if (!self->yaw_speed)
        // self->yaw_speed = 20;

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

    self->die = Monster_Die;
    // total_monsters++;
}

