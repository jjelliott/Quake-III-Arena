// monster_grunt_q1.c
//
// Example Quake 1 Grunt monster using the ai_monster scaffolding.
//

#include "ai_monster.h"
#include "ai_monframe.h"
// 1) Generate forward declarations
#define FRAME FRAME_DECL
#include "grunt.frames"
#undef FRAME

// 2) Generate actual function definitions
#define FRAME FRAME_DEF
#include "grunt.frames"
#undef FRAME



static void grunt_die(gentity_t* self, gentity_t* inflictor, gentity_t* attacker,
    int damage, int mod) {
    if (random() < 0.5) 
    {
        grunt_die1(self);
    }
	else
    {
        grunt_diec1(self);
    }
}

static void grunt_sight(gentity_t* self, gentity_t* other) {
    // Play the sight sound, alert animation, etc.
    G_Sound(self, CHAN_VOICE, G_SoundIndex("sounds/monsters/grunt/sight1.wav"));
}
// ---------------------------------------------------------------------------
// Spawn
// ---------------------------------------------------------------------------
void SP_monster_grunt_q1(gentity_t* self) {
    AI_InitForEntity(self);
    // Assign callbacks
    self->monsterinfo->th_stand = grunt_stand1;
    self->monsterinfo->th_walk = grunt_walk;
    self->monsterinfo->th_run = grunt_run;
    self->monsterinfo->th_melee = grunt_attack;
    self->monsterinfo->th_missile = grunt_attack;
    self->monsterinfo->th_pain = grunt_pain;
    self->monsterinfo->th_die = grunt_die;
    self->monsterinfo->th_sight = grunt_sight;

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
