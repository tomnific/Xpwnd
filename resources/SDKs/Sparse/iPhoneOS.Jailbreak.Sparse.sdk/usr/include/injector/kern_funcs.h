#ifndef _KERN_FUNCS_H_
#define _KERN_FUNCS_H_

// 'temp' fix kmem combo issues
// anything that includes this header may want to undef these...
#include <kmem/kmem.h>
#define tfp0 kf_tfp0
#define kmem_alloc kf_kmem_alloc
#define kread kf_kread
#define kwrite kf_kwrite
#define get_kernel_base kf_get_kernel_base

void set_tfp0(mach_port_t port);
void wk32(uint64_t kaddr, uint32_t val);
void wk64(uint64_t kaddr, uint64_t val);
uint32_t rk32(uint64_t kaddr);
uint64_t rk64(uint64_t kaddr);
uint64_t kmem_alloc(uint64_t size);
vm_address_t get_kernel_base(mach_port_t tfp0);
size_t kread(uint64_t where, void *p, size_t size);
size_t kwrite(uint64_t where, const void *p, size_t size);


#include "./kern_funcs.c"
#endif // _KERN_FUNCS_H_
