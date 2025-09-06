// monster_grunt_q1.c
//
// Example Quake 1 Grunt monster using the ai_monster scaffolding.
//

#include "ai_monster.h"
#include "ai_monframe.h"

typedef enum {
    STAND1,
    STAND2,
    STAND3,
    STAND4,
    STAND5,
    STAND6,
    STAND7,
    STAND8,
    DEATH1,
    DEATH2,
    DEATH3,
    DEATH4,
    DEATH5,
    DEATH6,
    DEATH7,
    DEATH8,
    DEATH9,
    DEATH10,
    DEATHC1,
    DEATHC2,
    DEATHC3,
    DEATHC4,
    DEATHC5,
    DEATHC6,
    DEATHC7,
    DEATHC8,
    DEATHC9,
    DEATHC10,
    DEATHC11,
    LOAD1,
    LOAD2,
    LOAD3,
    LOAD4,
    LOAD5,
    LOAD6,
    LOAD7,
    LOAD8,
    LOAD9,
    LOAD10,
    LOAD11,
    PAIN1,
    PAIN2,
    PAIN3,
    PAIN4,
    PAIN5,
    PAIN6,
    PAINB1,
    PAINB2,
    PAINB3,
    PAINB4,
    PAINB5,
    PAINB6,
    PAINB7,
    PAINB8,
    PAINB9,
    PAINB10,
    PAINB11,
    PAINB12,
    PAINB13,
    PAINB14,
    PAINC1,
    PAINC2,
    PAINC3,
    PAINC4,
    PAINC5,
    PAINC6,
    PAINC7,
    PAINC8,
    PAINC9,
    PAINC10,
    PAINC11,
    PAINC12,
    PAINC13,
    RUN1,
    RUN2,
    RUN3,
    RUN4,
    RUN5,
    RUN6,
    RUN7,
    RUN8,
    SHOOT1,
    SHOOT2,
    SHOOT3,
    SHOOT4,
    SHOOT5,
    SHOOT6,
    SHOOT7,
    SHOOT8,
    SHOOT9,
    PROWL1,
    PROWL2,
    PROWL3,
    PROWL4,
    PROWL5,
    PROWL6,
    PROWL7,
    PROWL8,
    PROWL9,
    PROWL10,
    PROWL11,
    PROWL12,
    PROWL13,
    PROWL14,
    PROWL15,
    PROWL16,
    PROWL17,
    PROWL18,
    PROWL19,
    PROWL20,
    PROWL21,
    PROWL22,
    PROWL23,
    PROWL24,
} frame_t;
// 1) Generate forward declarations
#define FRAME FRAME_DECL
#include "grunt.frames"
#undef FRAME

// 2) Generate actual function definitions
#define FRAME FRAME_DEF
#include "grunt.frames"
#undef FRAME

static void grunt_pain(gentity_t* self, gentity_t* attacker, int damage)
{
    float r;
	if (self->monsterinfo->pain_finished > level.time)
        return;

	 r = random();

    if (r < 0.2)
    {
        self->monsterinfo->pain_finished = level.time + 600;
        grunt_pain1(self);
        G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/pain1.wav"));
    }
    else if (r < 0.6)
    {
        self->monsterinfo->pain_finished = level.time + 1100;
        grunt_painb1(self);
        G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/pain2.wav"));
    }
    else
    {
        self->monsterinfo->pain_finished = level.time + 1100;
        grunt_painc1(self);

        G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/pain2.wav"));
    }
}


static void grunt_die(gentity_t* self, gentity_t* inflictor, gentity_t* attacker,
    int damage, int mod) {
    if (random() < 0.5) 
    {
        grunt_die1(self);
    }
	else
    {
        grunt_cdie1(self);
    }
}

static void grunt_sight(gentity_t* self, gentity_t* other) {
    // Play the sight sound, alert animation, etc.
    G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/sight1.wav"));
}

static qboolean grunt_check(gentity_t* self, range_t enemy_range)
{
    vec3_t delta;
    vec3_t spot1, spot2;
    float r;
    trace_t* tr;
    gentity_t* targ;
    float chance;
    vec3_t targ_offset;
    targ = self->enemy;
    if (!targ)
        return qfalse;
    if (targ->client) {
        targ_offset[0] = 0;
        targ_offset[1] = 0;
        targ_offset[2] = targ->client->ps.viewheight;
    }
//     else if (targ->monsterinfo && targ->monsterinfo->view_ofs)
// {
//         VectorCopy(targ->monsterinfo->view_ofs, targ_offset);
//     }
    else 
    {
        VectorClear(targ_offset); // zero vector
    }
    // start and end points
    VectorAdd(self->r.currentOrigin, self->monsterinfo->view_ofs, spot1);
	VectorCopy(targ->r.currentOrigin, spot2);

    // do a trace between them
    trap_Trace(tr, spot1, vec3_origin, vec3_origin, spot2, qfalse, CONTENTS_SOLID);
    VectorSubtract(spot1, spot2, delta);
    r = VectorLength(delta);
    G_Printf("spot1 %.1f %.1f %.1f spot2 %.1f %.1f %.1f r %.1f\n",
    spot1[0], spot1[1], spot1[2], spot2[0], spot2[1], spot2[2], r);
    // check trace results
    // if (tr.inopen && tr.inwater)
    //     return qfalse; // line crosses contents

    // if (tr->entityNum != targ->s.number){
    //     G_Printf("trace entity not target!\n");
    //     return qfalse; // blocked by something else
    // }

    // missile attack delay
    if (level.time < self->monsterinfo->attack_finished)
        return qfalse;

    // no firing at far range
    if (enemy_range == RANGE_FAR)
        return qfalse;

    // chance based on range
    if (enemy_range == RANGE_MELEE)
        chance = 0.9f;
    else if (enemy_range == RANGE_NEAR)
        chance = 0.4f;
    else if (enemy_range == RANGE_MID)
        chance = 0.05f;
    else
        chance = 0.0f;

    if (random() < chance)
    {
        if (self->monsterinfo->th_missile)
            self->monsterinfo->th_missile(self);  // call monster's missile attack

        SUB_AttackFinished(self, (1 + random())*1000);

        // if (random() < 0.3f)
        //     self->v.lefty = !self->v.lefty;

        return qtrue;
    }

    return qfalse;
}
// ---------------------------------------------------------------------------
// Spawn
// ---------------------------------------------------------------------------
void SP_monster_grunt_q1(gentity_t* self) {
    AI_InitForEntity(self);
    // Assign callbacks
    self->monsterinfo->th_stand = grunt_stand1;
    self->monsterinfo->th_walk = grunt_walk1;
    self->monsterinfo->th_run = grunt_run1;
    self->monsterinfo->th_missile = grunt_atk1;
    self->monsterinfo->th_pain = grunt_pain;
    self->monsterinfo->th_die = grunt_die;
    self->monsterinfo->th_sight = grunt_sight;
    self->monsterinfo->th_check = grunt_check;

    self->s.frame = 0;

    // Q3 entity setup
    self->health = 30;
    self->max_health = 30;
    self->takedamage = qtrue;
    self->clipmask = MASK_MONSTERSOLID;
    self->r.svFlags |= SVF_MONSTER;
    self->r.svFlags &= ~SVF_NOCLIENT; // make sure it’s not ignored by server
    self->r.contents = CONTENTS_BODY;    // treated as a physical body

    // Model / bounding box
    self->s.modelindex = G_ModelIndex("models/monsters/grunt.md3");
    VectorSet(self->r.mins, -16, -16, -24);
    VectorSet(self->r.maxs, 16, 16, 40);
    VectorSet(self->monsterinfo->view_ofs, 0, 0, 24 );
    // self->s.pos.trBase[2] += 8; // raise 16 units for rendering
    trap_LinkEntity(self);
    self->think = WalkMonsterStart;
    self->nextthink = level.time + 1;
}
