/*
 * Copyright (c) Tom, 2019.
 *
 * Extract symbols from live from libmis.dylib
 * Some symbols are listed in the libmis_symbols.h file.
 * It is up to you to cast the symbol to the correct type.
 *
 * @TOM_LICENSE_SOURCE_START
 *
 * 1) Credit would be sick, but I really can't control what you do ¯\_(ツ)_/¯
 * 2) I'm not responsible for what you do with this AND I'm not responsible for any damage you cause ("THIS SOFTWARE IS PROVIDED AS IS", etc)
 * 3) I'm under no obligation to provide support. (But if you reach out I'll gladly take a look if I have time)
 *
 * @TOM_LICENSE_SOURCE_END
 */

#include "libmis_live.h"

#include <Foundation/Foundation.h>
#include <dlfcn.h>




#define libmis_path "/usr/lib/libmis.dylib"





void* extract(char* symbol_name)
{
	// This is fine, dlopen() only actually opens it once - all subsequent calls just return the existing handle.
	void* handle = dlopen(libmis_path, RTLD_LAZY | RTLD_NOLOAD);

	if (handle == NULL)
	{
#ifdef debug
        printf("Could not open libmis.dylib:\n    %s\n", dlerror());
#endif
		return NULL;
	}


	void* symbol = dlsym(handle, symbol_name);

	if (symbol == NULL)
	{
#ifdef debug
        printf("Could not locate symbol '%s':\n   %s\n", symbol_name, dlerror());
#endif
		return NULL;
	}

    
    // we intentionally aren't calling dlclose(handle);
    

    return symbol;
}
