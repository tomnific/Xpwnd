#ifndef JAILBREAK_COMMON_H
#define JAILBREAK_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>             // uint*_t
#include <stdbool.h>
#include <mach-o/loader.h>
#include <mach/error.h>




#define MACH_HEADER_MAGIC    MH_MAGIC_64
#define MACH_LC_SEGMENT      LC_SEGMENT_64

#define LOG(str, args...) printf("[*] " str, ##args)

#define SafeFree(x) do { if (x) free(x); } while(false)
#define SafeFreeNULL(x) do { SafeFree(x); (x) = NULL; } while(false)
#define CFSafeRelease(x) do { if (x) CFRelease(x); } while(false)
#define CFSafeReleaseNULL(x) do { CFSafeRelease(x); (x) = NULL; } while(false)
#define SafeSFree(x) do { if (KERN_POINTER_VALID(x)) sfree(x); } while(false)
#define SafeSFreeNULL(x) do { SafeSFree(x); (x) = KPTR_NULL; } while(false)
#define SafeIOFree(x, size) do { if (KERN_POINTER_VALID(x)) IOFree(x, size); } while(false)
#define SafeIOFreeNULL(x, size) do { SafeIOFree(x, size); (x) = KPTR_NULL; } while(false)

#define __FILENAME__ (__builtin_strrchr(__FILE__, '/') ? __builtin_strrchr(__FILE__, '/') + 1 : __FILE__)

#define kCFCoreFoundationVersionNumber_iOS_12_0 1535.12
#define kCFCoreFoundationVersionNumber_iOS_11_3 1452.23
#define kCFCoreFoundationVersionNumber_iOS_11_0 1443.00

#define KPTR_NULL ((kptr_t) 0)
#define KERN_POINTER_VALID(val) ((val) >= 0xffff000000000000 && (val) != 0xffffffffffffffff)
#define STATIC_KERNEL_BASE_ADDRESS 0xfffffff007004000

#define OPT(x) (offset_options?((rk64(offset_options) & OPT_ ##x)?true:false):false)
#define OPT_GET_TASK_ALLOW (1<<0)
#define OPT_CS_DEBUGGED (1<<1)





typedef uint64_t kptr_t;

#endif