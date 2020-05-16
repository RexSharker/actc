; RUN: llc -march=amdgcn -mtriple=amdgcn---amdgiz -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,SI %s
; RUN: llc -march=amdgcn -mtriple=amdgcn---amdgiz -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,VI %s

; GCN-LABEL: {{^}}extract_vector_elt_v1i8:
; GCN: s_load_dword [[LOAD:s[0-9]+]]
; GCN: v_mov_b32_e32 [[V_LOAD:v[0-9]+]], [[LOAD]]
; GCN: buffer_store_byte [[V_LOAD]]
define amdgpu_kernel void @extract_vector_elt_v1i8(i8 addrspace(1)* %out, <1 x i8> %foo) #0 {
  %p0 = extractelement <1 x i8> %foo, i32 0
  store i8 %p0, i8 addrspace(1)* %out
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v2i8:
; GCN: s_load_dword s
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 s{{[0-9]+}}, s{{[0-9]+}}, 8
; GCN-NOT: {{flat|buffer|global}}
; GCN: buffer_store_byte
; GCN: buffer_store_byte
define amdgpu_kernel void @extract_vector_elt_v2i8(i8 addrspace(1)* %out, <2 x i8> %foo) #0 {
  %p0 = extractelement <2 x i8> %foo, i32 0
  %p1 = extractelement <2 x i8> %foo, i32 1
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v3i8:
; GCN: s_load_dword s
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 s{{[0-9]+}}, s{{[0-9]+}}, 16
; GCN-NOT: {{flat|buffer|global}}
; GCN: buffer_store_byte
; GCN: buffer_store_byte
define amdgpu_kernel void @extract_vector_elt_v3i8(i8 addrspace(1)* %out, <3 x i8> %foo) #0 {
  %p0 = extractelement <3 x i8> %foo, i32 0
  %p1 = extractelement <3 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v4i8:
; GCN: s_load_dword s
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 s{{[0-9]+}}, s{{[0-9]+}}, 16
; GCN-NOT: {{flat|buffer|global}}
; GCN: buffer_store_byte
; GCN: buffer_store_byte
define amdgpu_kernel void @extract_vector_elt_v4i8(i8 addrspace(1)* %out, <4 x i8> %foo) #0 {
  %p0 = extractelement <4 x i8> %foo, i32 0
  %p1 = extractelement <4 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v8i8:
; GCN: s_load_dword [[VAL:s[0-9]+]]
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 s{{[0-9]+}}, [[VAL]], 16
; GCN-NOT: {{flat|buffer|global}}
; GCN: buffer_store_byte
; GCN: buffer_store_byte
define amdgpu_kernel void @extract_vector_elt_v8i8(i8 addrspace(1)* %out, <8 x i8> %foo) #0 {
  %p0 = extractelement <8 x i8> %foo, i32 0
  %p1 = extractelement <8 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v16i8:
; GCN: s_load_dword [[LOAD0:s[0-9]+]]
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 [[ELT2:s[0-9]+]], [[LOAD0]], 16
; GCN-DAG: v_mov_b32_e32 [[V_LOAD0:v[0-9]+]], [[LOAD0]]
; GCN-DAG: v_mov_b32_e32 [[V_ELT2:v[0-9]+]], [[ELT2]]
; GCN: buffer_store_byte [[V_ELT2]]
; GCN: buffer_store_byte [[V_LOAD0]]
define amdgpu_kernel void @extract_vector_elt_v16i8(i8 addrspace(1)* %out, <16 x i8> %foo) #0 {
  %p0 = extractelement <16 x i8> %foo, i32 0
  %p1 = extractelement <16 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v32i8:
; GCN: s_load_dword [[LOAD0:s[0-9]+]]
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 [[ELT2:s[0-9]+]], [[LOAD0]], 16
; GCN-DAG: v_mov_b32_e32 [[V_LOAD0:v[0-9]+]], [[LOAD0]]
; GCN-DAG: v_mov_b32_e32 [[V_ELT2:v[0-9]+]], [[ELT2]]
; GCN: buffer_store_byte [[V_ELT2]]
; GCN: buffer_store_byte [[V_LOAD0]]
define amdgpu_kernel void @extract_vector_elt_v32i8(i8 addrspace(1)* %out, <32 x i8> %foo) #0 {
  %p0 = extractelement <32 x i8> %foo, i32 0
  %p1 = extractelement <32 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; GCN-LABEL: {{^}}extract_vector_elt_v64i8:
; GCN: s_load_dword [[LOAD0:s[0-9]+]]
; GCN-NOT: {{flat|buffer|global}}
; GCN: s_lshr_b32 [[ELT2:s[0-9]+]], [[LOAD0]], 16
; GCN-DAG: v_mov_b32_e32 [[V_LOAD0:v[0-9]+]], [[LOAD0]]
; GCN-DAG: v_mov_b32_e32 [[V_ELT2:v[0-9]+]], [[ELT2]]
; GCN: buffer_store_byte [[V_ELT2]]
; GCN: buffer_store_byte [[V_LOAD0]]
define amdgpu_kernel void @extract_vector_elt_v64i8(i8 addrspace(1)* %out, <64 x i8> %foo) #0 {
  %p0 = extractelement <64 x i8> %foo, i32 0
  %p1 = extractelement <64 x i8> %foo, i32 2
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p1, i8 addrspace(1)* %out
  store i8 %p0, i8 addrspace(1)* %out1
  ret void
}

; FIXME: SI generates much worse code from that's a pain to match

; FIXME: 16-bit and 32-bit shift not combined after legalize to to
; isTypeDesirableForOp in SimplifyDemandedBits

; GCN-LABEL: {{^}}dynamic_extract_vector_elt_v2i8:
; VI: s_load_dword [[LOAD:s[0-9]+]], s[0:1], 0x2c
; VI-NEXT: s_load_dword [[IDX:s[0-9]+]], s[0:1], 0x30
; VI-NOT: {{flat|buffer|global}}
; VI: s_lshr_b32 [[ELT1:s[0-9]+]], [[LOAD]], 8
; VI: v_lshlrev_b16_e64 [[ELT2:v[0-9]+]], 8, [[ELT1]]
; VI: s_and_b32 [[ELT0:s[0-9]+]], [[LOAD]], 0xff{{$}}
; VI: v_or_b32_e32 [[BUILD_VEC:v[0-9]+]], [[ELT0]], [[ELT2]]
; VI-DAG: s_lshl_b32 [[SCALED_IDX:s[0-9]+]], [[IDX]], 3
; VI: v_lshrrev_b16_e32 [[EXTRACT:v[0-9]+]], [[SCALED_IDX]], [[BUILD_VEC]]
; VI: buffer_store_byte [[EXTRACT]]
define amdgpu_kernel void @dynamic_extract_vector_elt_v2i8(i8 addrspace(1)* %out, <2 x i8> %foo, i32 %idx) #0 {
  %elt = extractelement <2 x i8> %foo, i32 %idx
  store i8 %elt, i8 addrspace(1)* %out
  ret void
}

; GCN-LABEL: {{^}}dynamic_extract_vector_elt_v3i8:
; VI: s_load_dword [[LOAD:s[0-9]+]], s[0:1], 0x2c
; VI-NEXT: s_load_dword [[IDX:s[0-9]+]], s[0:1], 0x30
; VI-NOT: {{flat|buffer|global}}
; VI: s_lshr_b32 [[ELT12:s[0-9]+]], [[LOAD]], 8
; VI: v_lshlrev_b16_e64 [[ELT1:v[0-9]+]], 8, [[ELT12]]
; VI: s_and_b32 [[ELT0:s[0-9]+]], [[LOAD]], 0xff{{$}}
; VI: v_or_b32_e32 [[VEC3:v[0-9]+]], [[ELT0]], [[ELT1]]
; VI: s_lshl_b32 [[SCALED_IDX:s[0-9]+]], [[IDX]], 3
; VI: v_lshrrev_b32_e32 [[EXTRACT:v[0-9]+]], [[SCALED_IDX]], [[VEC3]]
; VI: buffer_store_byte [[EXTRACT]]
define amdgpu_kernel void @dynamic_extract_vector_elt_v3i8(i8 addrspace(1)* %out, <3 x i8> %foo, i32 %idx) #0 {
  %p0 = extractelement <3 x i8> %foo, i32 %idx
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p0, i8 addrspace(1)* %out
  ret void
}

; GCN-LABEL: {{^}}dynamic_extract_vector_elt_v4i8:
; VI: s_load_dword [[IDX:s[0-9]+]], s[0:1], 0x34
; VI: s_load_dword [[VEC4:s[0-9]+]], s{{\[[0-9]+:[0-9]+\]}}, 0x0

; VI: s_lshl_b32 [[SCALED_IDX:s[0-9]+]], [[IDX]], 3
; VI: s_lshr_b32 [[EXTRACT:s[0-9]+]], [[VEC4]], [[SCALED_IDX]]

; VI: v_mov_b32_e32 [[V_EXTRACT:v[0-9]+]], [[EXTRACT]]
; VI: buffer_store_byte [[V_EXTRACT]]
define amdgpu_kernel void @dynamic_extract_vector_elt_v4i8(i8 addrspace(1)* %out, <4 x i8> addrspace(4)* %vec.ptr, i32 %idx) #0 {
  %vec = load <4 x i8>, <4 x i8> addrspace(4)* %vec.ptr
  %p0 = extractelement <4 x i8> %vec, i32 %idx
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p0, i8 addrspace(1)* %out
  ret void
}

; GCN-LABEL: {{^}}dynamic_extract_vector_elt_v8i8:
; VI: s_load_dword [[IDX:s[0-9]+]], s[0:1], 0x34
; VI: s_load_dwordx2 [[VEC8:s\[[0-9]+:[0-9]+\]]], s{{\[[0-9]+:[0-9]+\]}}, 0x0

; VI: s_lshl_b32 [[SCALED_IDX:s[0-9]+]], [[IDX]], 3
; VI: s_lshr_b64 s{{\[}}[[EXTRACT_LO:[0-9]+]]:{{[0-9]+\]}}, [[VEC8]], [[SCALED_IDX]]
; VI: v_mov_b32_e32 [[V_EXTRACT:v[0-9]+]], s[[EXTRACT_LO]]
; VI: buffer_store_byte [[V_EXTRACT]]
define amdgpu_kernel void @dynamic_extract_vector_elt_v8i8(i8 addrspace(1)* %out, <8 x i8> addrspace(4)* %vec.ptr, i32 %idx) #0 {
  %vec = load <8 x i8>, <8 x i8> addrspace(4)* %vec.ptr
  %p0 = extractelement <8 x i8> %vec, i32 %idx
  %out1 = getelementptr i8, i8 addrspace(1)* %out, i32 1
  store i8 %p0, i8 addrspace(1)* %out
  ret void
}

attributes #0 = { nounwind }
