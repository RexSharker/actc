target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

define i32 @main() {
entry:
  call void (...) @globalfunc()
  ret i32 0
}

declare void @globalfunc(...)