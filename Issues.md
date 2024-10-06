1. 07/13, 2024 from 7/09 

`zig test src/libHash.zig`

```error
typeof(m): libhash.mngHash(u64,u64)
Illegal instruction at address 0x7ff80dd7c38b
???:?:?: 0x7ff80dd7c38b in ??? (libsystem_platform.dylib)
Unwind error at address `libsystem_platform.dylib:0x7ff80dd7c38b` (error.InvalidDebugInfo), trace may be incomplete

error: the following test command crashed:
/Users/mickeyoh/test/Zig/Learning/Algorithm/algo_exe/.zig-cache/o/edd1097061f1bb140dde9c0bd9331553/test
```

内容:  構造体を呼ぶ形式にすると、ハングアップする。
おそらく、deinit()の処理がおかしい。
関数(hashfnc)を使うならば問題なし。
違いは構造体か、関数かの違い


self.map:
hash_map.HashMap(u64,u64,hash_map.AutoContext(u64),80)
{ .unmanaged = hash_map.HashMapUnmanaged(u64,u64,hash_map.AutoContext(u64),80){
                  .metadata = null, 
                  .size = 0, 
                  .available = 0, 
                  .pointer_stability = debug.SafetyLock{ .state = debug.SafetyLock.State__enum_2626.unlocked } 
                },
  .allocator = mem.Allocator{ 
                  .ptr = anyopaque@7ff7b3a8bbe0, 
                  .vtable = mem.Allocator.VTable{ 
                              .alloc = fn (*anyopaque, usize, u8, usize) ?[*]u8@10c479670, 
                              .resize = fn (*anyopaque, []u8, u8, usize, usize) bool@10c479880, 
                              .free = fn (*anyopaque, []u8, u8, usize) void@10c47a560 
                              } 
                }, 
  .ctx = hash_map.AutoContext(u64){ } 
}
****** 
q19_01.zig one:
hash_map.HashMap(q19_01.Keys,u64,hash_map.AutoContext(q19_01.Keys),80)
{ .unmanaged = hash_map.HashMapUnmanaged(q19_01.Keys,u64,hash_map.AutoContext(q19_01.Keys),80){ 
                .metadata = null, 
                .size = 0, 
                .available = 0, 
                .pointer_stability = debug.SafetyLock{ .state = debug.SafetyLock.State__enum_3337.unlocked } 
                }, 
  .allocator = mem.Allocator{ 
                  .ptr = anyopaque@7ff7b8711f28, 
                  .vtable = mem.Allocator.VTable{ 
                              .alloc = fn (*anyopaque, usize, u8, usize) ?[*]u8@1077f5040, 
                              .resize = fn (*anyopaque, []u8, u8, usize, usize) bool@1077f5250, 
                              .free = fn (*anyopaque, []u8, u8, usize) void@1077f5f30 
                              } 
                  }, 
  .ctx = hash_map.AutoContext(q19_01.Keys){ } 
}


