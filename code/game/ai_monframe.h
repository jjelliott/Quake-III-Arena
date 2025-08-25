// ai_monframe.h
// Single-line macros for defining monster frame functions

#define FRAME_DECL(name, frameEnum, nextFunc, body) void name(gentity_t *self);

// Definition macro
#define FRAME_DEF(name, frameEnum, nextFunc, body) void name(gentity_t *self) { self->nextthink = level.time + 100; self->think = nextFunc; self->s.frame = frameEnum; body; }
