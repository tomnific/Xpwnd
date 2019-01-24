/*
 * Copyright (c) Tom, 2019.
 * 
 * Extract symbols from live from libmis.dylib
 * Some symbols are listed in the libmis_symbols.h file.
 * It is up to you to cast the symbol to the correct type.
 *
 * @TOM_LICENSE_HEADER_START
 * 
 * 1) Credit would be sick, but I really can't control what you do ¯\_(ツ)_/¯
 * 2) I'm not responsible for what you do with this AND I'm not responsible for any damage you cause ("THIS SOFTWARE IS PROVIDED AS IS", etc)
 * 3) I'm under no obligation to provide support. (But if you reach out I'll gladly take a look if I have time)
 *
 * @TOM_LICENSE_HEADER_END
 */

#ifndef libmis_live_h
#define libmis_live_h

void* extract(char* symbol_name);


#include "./libmis_live.c"
#endif
