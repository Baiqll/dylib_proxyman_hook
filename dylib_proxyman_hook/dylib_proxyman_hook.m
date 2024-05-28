//
//  dylib_proxyman_hook.m
//  dylib_proxyman_hook
//
//  Created by Baiqll on 2024/5/28.
//

#import "dylib_proxyman_hook.h"
#import "mach-o/dyld.h"
#import "dobby.h"


@implementation dylib_proxyman_hook

static uintptr_t sub_1002293f4_address = 0x1002293f4;

void (*sub_1002293f4)(void* arg0, void* arg1);

void hook_sub_1002293f4(void* arg0, void* arg1) {
    // arg1 + 0x50
    __asm__ __volatile__(
       "strb wzr, [x1, #0x50]"
     );
//    NSLog(@"sub_1002293f4: aslr=> %p",(void *)arg1);
    sub_1002293f4(arg0,arg1);
}

+ (void)load{

    uintptr_t aslr = _dyld_get_image_vmaddr_slide(0);
    
    sub_1002293f4_address += aslr;
    
    DobbyHook((void *)sub_1002293f4_address, hook_sub_1002293f4, (void *)&sub_1002293f4);

}

@end
