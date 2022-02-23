; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.block = type { i64, %union.mem_t }
%union.mem_t = type { %struct.link_t }
%struct.link_t = type { %struct.block*, %struct.block* }

@heap_start = internal unnamed_addr global %struct.block* null, align 8, !dbg !0
@.str.3 = private unnamed_addr constant [16 x i8] c"block too small\00", align 1
@.str.4 = private unnamed_addr constant [20 x i8] c"block not connected\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"coalesce error\00", align 1
@list_head = internal unnamed_addr global [15 x %struct.block*] zeroinitializer, align 16, !dbg !50
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @msan.module_ctor, i8* null }]
@__msan_track_origins = weak_odr local_unnamed_addr constant i32 2
@str = private unnamed_addr constant [15 x i8] c"Prologue error\00"
@str.6 = private unnamed_addr constant [30 x i8] c"blocks outside the boundaries\00"
@str.7 = private unnamed_addr constant [17 x i8] c"block size error\00"
@__msan_retval_tls = external thread_local(initialexec) global [100 x i64]
@__msan_retval_origin_tls = external thread_local(initialexec) global i32
@__msan_param_tls = external thread_local(initialexec) global [100 x i64]
@__msan_param_origin_tls = external thread_local(initialexec) global [200 x i32]
@__msan_va_arg_tls = external thread_local(initialexec) global [100 x i64]
@__msan_va_arg_overflow_size_tls = external thread_local(initialexec) global i64
@__msan_origin_tls = external thread_local(initialexec) global i32

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local zeroext i1 @mm_checkheap(i32 %line) local_unnamed_addr #0 !dbg !72 {
entry:
  call void @llvm.dbg.value(metadata i32 %line, metadata !76, metadata !DIExpression()), !dbg !82
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !83
  %call = call i8* @mem_heap_lo() #4, !dbg !83
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !84
  %0 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !84
  %1 = bitcast i8* %call to %struct.block*, !dbg !84
  call void @llvm.dbg.value(metadata %struct.block* %1, metadata !77, metadata !DIExpression()), !dbg !85
  call void @llvm.dbg.value(metadata i64 0, metadata !79, metadata !DIExpression()), !dbg !86
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !81, metadata !DIExpression()), !dbg !87
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !88
  store i32 %0, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !88
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !88
  %call1 = call fastcc i64 @get_size(%struct.block* %1), !dbg !88
  %_msret67 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !90
  %2 = xor i64 %_msret67, -1, !dbg !90
  %3 = and i64 %call1, %2, !dbg !90
  %4 = icmp eq i64 %3, 0, !dbg !90
  %5 = icmp ne i64 %_msret67, 0, !dbg !90
  %_msprop_icmp = and i1 %5, %4, !dbg !90
  br i1 %_msprop_icmp, label %6, label %8, !dbg !91, !prof !92

; <label>:6:                                      ; preds = %entry
  %7 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !90
  store i32 %7, i32* @__msan_origin_tls, align 4, !dbg !91
  call void @__msan_warning_noreturn() #4, !dbg !91
  call void asm sideeffect "", ""() #4, !dbg !91
  unreachable, !dbg !91

; <label>:8:                                      ; preds = %entry
  %cmp = icmp eq i64 %call1, 0, !dbg !90
  br i1 %cmp, label %lor.lhs.false, label %if.then, !dbg !91

lor.lhs.false:                                    ; preds = %8
  %9 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !93, !tbaa !94
  %_msld = load i64, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080) to i64*), align 8, !dbg !98
  %10 = load i32, i32* inttoptr (i64 add (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080), i64 17592186044416) to i32*), align 8, !dbg !98
  call void @llvm.dbg.value(metadata %struct.block* %9, metadata !78, metadata !DIExpression()), !dbg !98
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !99
  store i32 %0, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !99
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !99
  %call2 = call fastcc zeroext i1 @get_alloc(%struct.block* %1), !dbg !99
  %_msret68 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !100
  br i1 %_msret68, label %11, label %13, !dbg !100, !prof !92

; <label>:11:                                     ; preds = %lor.lhs.false
  %12 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !100
  store i32 %12, i32* @__msan_origin_tls, align 4, !dbg !100
  call void @__msan_warning_noreturn() #4, !dbg !100
  call void asm sideeffect "", ""() #4, !dbg !100
  unreachable, !dbg !100

; <label>:13:                                     ; preds = %lor.lhs.false
  br i1 %call2, label %while.cond.preheader, label %if.then, !dbg !100

while.cond.preheader:                             ; preds = %13
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !81, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.value(metadata i64 undef, metadata !79, metadata !DIExpression()), !dbg !86
  call void @llvm.dbg.value(metadata %struct.block* %9, metadata !78, metadata !DIExpression()), !dbg !98
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !101
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !101
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !101
  %call462 = call fastcc i64 @get_size(%struct.block* %9), !dbg !101
  %_msret69 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !102
  %14 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !102
  %15 = xor i64 %_msret69, -1, !dbg !102
  %16 = and i64 %call462, %15, !dbg !102
  %17 = icmp eq i64 %16, 0, !dbg !102
  %18 = icmp ne i64 %_msret69, 0, !dbg !102
  %_msprop_icmp70 = and i1 %18, %17, !dbg !102
  br i1 %_msprop_icmp70, label %19, label %20, !dbg !103, !prof !92

; <label>:19:                                     ; preds = %while.cond.preheader
  store i32 %14, i32* @__msan_origin_tls, align 4, !dbg !103
  call void @__msan_warning_noreturn() #4, !dbg !103
  call void asm sideeffect "", ""() #4, !dbg !103
  unreachable, !dbg !103

; <label>:20:                                     ; preds = %while.cond.preheader
  %cmp563 = icmp eq i64 %call462, 0, !dbg !102
  br i1 %cmp563, label %return, label %while.body.preheader, !dbg !103

while.body.preheader:                             ; preds = %20
  br label %while.body, !dbg !104

if.then:                                          ; preds = %8, %13
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !107
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !107
  %puts = call i32 @puts(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str, i64 0, i64 0)), !dbg !107
  br label %return, !dbg !109

while.body:                                       ; preds = %while.body.preheader, %107
  %_msphi_s71 = phi i64 [ %_msret88, %107 ], [ %_msret69, %while.body.preheader ]
  %_msphi_o72 = phi i32 [ %101, %107 ], [ %14, %while.body.preheader ]
  %call466 = phi i64 [ %call4, %107 ], [ %call462, %while.body.preheader ]
  %_msphi_s73 = phi i64 [ %_msphi_s75, %107 ], [ 0, %while.body.preheader ]
  %_msphi_o74 = phi i32 [ %_msphi_o76, %107 ], [ 0, %while.body.preheader ]
  %block_prev.065 = phi %struct.block* [ %block.064, %107 ], [ null, %while.body.preheader ]
  %_msphi_s75 = phi i64 [ %_msret87, %107 ], [ %_msld, %while.body.preheader ]
  %_msphi_o76 = phi i32 [ %100, %107 ], [ %10, %while.body.preheader ]
  %block.064 = phi %struct.block* [ %call44, %107 ], [ %9, %while.body.preheader ]
  call void @llvm.dbg.value(metadata %struct.block* %block_prev.065, metadata !81, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.value(metadata %struct.block* %block.064, metadata !78, metadata !DIExpression()), !dbg !98
  %21 = and i64 %_msphi_s71, 15, !dbg !104
  %rem = and i64 %call466, 15, !dbg !104
  %22 = xor i64 %21, -1, !dbg !110
  %23 = and i64 %rem, %22, !dbg !110
  %24 = icmp eq i64 %23, 0, !dbg !110
  %25 = icmp ne i64 %21, 0, !dbg !110
  %_msprop_icmp77 = and i1 %25, %24, !dbg !110
  br i1 %_msprop_icmp77, label %26, label %27, !dbg !111, !prof !92

; <label>:26:                                     ; preds = %while.body
  store i32 %_msphi_o72, i32* @__msan_origin_tls, align 4, !dbg !111
  call void @__msan_warning_noreturn() #4, !dbg !111
  call void asm sideeffect "", ""() #4, !dbg !111
  unreachable, !dbg !111

; <label>:27:                                     ; preds = %while.body
  %cmp7 = icmp eq i64 %rem, 0, !dbg !110
  br i1 %cmp7, label %if.end10, label %if.then8, !dbg !111

if.then8:                                         ; preds = %27
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !112
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !112
  %puts61 = call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.7, i64 0, i64 0)), !dbg !112
  br label %return, !dbg !114

if.end10:                                         ; preds = %27
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !115
  %call14 = call i8* @mem_heap_lo() #4, !dbg !115
  %_msret78 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !117
  %_msprop = or i64 %_msret78, %_msphi_s75, !dbg !118
  %28 = icmp eq i64 %_msprop, 0, !dbg !118
  br i1 %28, label %33, label %29, !dbg !119, !prof !120

; <label>:29:                                     ; preds = %if.end10
  %30 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !117
  %31 = icmp eq i64 %_msret78, 0, !dbg !118
  %32 = select i1 %31, i32 %_msphi_o76, i32 %30, !dbg !118
  store i32 %32, i32* @__msan_origin_tls, align 4, !dbg !119
  call void @__msan_warning_noreturn() #4, !dbg !119
  call void asm sideeffect "", ""() #4, !dbg !119
  unreachable, !dbg !119

; <label>:33:                                     ; preds = %if.end10
  %34 = bitcast i8* %call14 to %struct.block*, !dbg !117
  %cmp15 = icmp ult %struct.block* %block.064, %34, !dbg !118
  br i1 %cmp15, label %if.then19, label %lor.lhs.false16, !dbg !119

lor.lhs.false16:                                  ; preds = %33
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !121
  %call17 = call i8* @mem_heap_hi() #4, !dbg !121
  %_msret80 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !122
  %_msprop81 = or i64 %_msret80, %_msphi_s75, !dbg !123
  %35 = icmp eq i64 %_msprop81, 0, !dbg !123
  br i1 %35, label %40, label %36, !dbg !124, !prof !120

; <label>:36:                                     ; preds = %lor.lhs.false16
  %37 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !122
  %38 = icmp eq i64 %_msret80, 0, !dbg !123
  %39 = select i1 %38, i32 %_msphi_o76, i32 %37, !dbg !123
  store i32 %39, i32* @__msan_origin_tls, align 4, !dbg !124
  call void @__msan_warning_noreturn() #4, !dbg !124
  call void asm sideeffect "", ""() #4, !dbg !124
  unreachable, !dbg !124

; <label>:40:                                     ; preds = %lor.lhs.false16
  %41 = bitcast i8* %call17 to %struct.block*, !dbg !122
  %cmp18 = icmp ugt %struct.block* %block.064, %41, !dbg !123
  br i1 %cmp18, label %if.then19, label %if.end21, !dbg !124

if.then19:                                        ; preds = %40, %33
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !125
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !125
  %puts60 = call i32 @puts(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @str.6, i64 0, i64 0)), !dbg !125
  br label %return, !dbg !127

if.end21:                                         ; preds = %40
  store i64 %_msphi_s75, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !128
  store i32 %_msphi_o76, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !128
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !128
  %call22 = call fastcc i64 @get_size(%struct.block* %block.064), !dbg !128
  %_msret82 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !130
  %42 = xor i64 %_msret82, -16, !dbg !130
  %43 = and i64 %call22, %42, !dbg !130
  %44 = icmp ult i64 %43, 16, !dbg !130
  %45 = or i64 %_msret82, %call22, !dbg !130
  %46 = icmp ult i64 %45, 16, !dbg !130
  %47 = xor i1 %44, %46, !dbg !130
  br i1 %47, label %48, label %50, !dbg !131, !prof !92

; <label>:48:                                     ; preds = %if.end21
  %49 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !130
  store i32 %49, i32* @__msan_origin_tls, align 4, !dbg !131
  call void @__msan_warning_noreturn() #4, !dbg !131
  call void asm sideeffect "", ""() #4, !dbg !131
  unreachable, !dbg !131

; <label>:50:                                     ; preds = %if.end21
  %cmp23 = icmp ult i64 %call22, 16, !dbg !130
  br i1 %cmp23, label %if.then24, label %if.end26, !dbg !131

if.then24:                                        ; preds = %50
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !132
  store i64 0, i64* @__msan_va_arg_overflow_size_tls, align 8, !dbg !132
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !132
  %call25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0)), !dbg !132
  br label %return, !dbg !134

if.end26:                                         ; preds = %50
  %51 = ptrtoint %struct.block* %block_prev.065 to i64, !dbg !135
  %52 = xor i64 %_msphi_s73, -1, !dbg !135
  %53 = and i64 %51, %52, !dbg !135
  %54 = icmp eq i64 %53, 0, !dbg !135
  %55 = icmp ne i64 %_msphi_s73, 0, !dbg !135
  %_msprop_icmp84 = and i1 %55, %54, !dbg !135
  %tobool = icmp eq %struct.block* %block_prev.065, null, !dbg !135
  %56 = ptrtoint %struct.block* %block.064 to i64, !dbg !137
  %57 = xor i64 %56, %51, !dbg !137
  %58 = or i64 %_msphi_s75, %_msphi_s73, !dbg !137
  %59 = xor i64 %58, -1, !dbg !137
  %60 = and i64 %57, %59, !dbg !137
  %61 = icmp eq i64 %60, 0, !dbg !137
  %62 = icmp ne i64 %58, 0, !dbg !137
  %_msprop_icmp85 = and i1 %62, %61, !dbg !137
  %cmp27 = icmp eq %struct.block* %block_prev.065, %block.064, !dbg !137
  %63 = xor i1 %tobool, true, !dbg !138
  %64 = xor i1 %cmp27, true, !dbg !138
  %65 = and i1 %_msprop_icmp84, %_msprop_icmp85, !dbg !138
  %66 = and i1 %_msprop_icmp85, %63, !dbg !138
  %67 = and i1 %_msprop_icmp84, %64, !dbg !138
  %68 = or i1 %67, %66, !dbg !138
  %69 = or i1 %65, %68, !dbg !138
  br i1 %69, label %70, label %74, !dbg !138, !prof !92

; <label>:70:                                     ; preds = %if.end26
  %71 = icmp eq i64 %_msphi_s75, 0, !dbg !137
  %72 = select i1 %71, i32 %_msphi_o74, i32 %_msphi_o76, !dbg !137
  %73 = select i1 %_msprop_icmp85, i32 %72, i32 %_msphi_o74, !dbg !138
  store i32 %73, i32* @__msan_origin_tls, align 4, !dbg !138
  call void @__msan_warning_noreturn() #4, !dbg !138
  call void asm sideeffect "", ""() #4, !dbg !138
  unreachable, !dbg !138

; <label>:74:                                     ; preds = %if.end26
  %or.cond = or i1 %tobool, %cmp27, !dbg !138
  br i1 %or.cond, label %if.end37, label %land.lhs.true28, !dbg !138

land.lhs.true28:                                  ; preds = %74
  store i64 %_msphi_s73, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !139
  store i32 %_msphi_o74, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !139
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !139
  %call29 = call fastcc i64 @get_size(%struct.block* nonnull %block_prev.065), !dbg !139
  %_msret92 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !140
  %75 = xor i64 %_msret92, -1, !dbg !140
  %76 = and i64 %call29, %75, !dbg !140
  %77 = icmp eq i64 %76, 0, !dbg !140
  %78 = icmp ne i64 %_msret92, 0, !dbg !140
  %_msprop_icmp93 = and i1 %78, %77, !dbg !140
  br i1 %_msprop_icmp93, label %79, label %81, !dbg !141, !prof !92

; <label>:79:                                     ; preds = %land.lhs.true28
  %80 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !140
  store i32 %80, i32* @__msan_origin_tls, align 4, !dbg !141
  call void @__msan_warning_noreturn() #4, !dbg !141
  call void asm sideeffect "", ""() #4, !dbg !141
  unreachable, !dbg !141

; <label>:81:                                     ; preds = %land.lhs.true28
  %cmp30 = icmp eq i64 %call29, 0, !dbg !140
  br i1 %cmp30, label %if.end37, label %if.then31, !dbg !141

if.then31:                                        ; preds = %81
  store i64 %_msphi_s73, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !142
  store i32 %_msphi_o74, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !142
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !142
  %call32 = call fastcc %struct.block* @find_next(%struct.block* nonnull %block_prev.065), !dbg !142
  %_msret94 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !145
  %82 = ptrtoint %struct.block* %call32 to i64, !dbg !145
  %83 = xor i64 %82, %56, !dbg !145
  %84 = or i64 %_msret94, %_msphi_s75, !dbg !145
  %85 = xor i64 %84, -1, !dbg !145
  %86 = and i64 %83, %85, !dbg !145
  %87 = icmp eq i64 %86, 0, !dbg !145
  %88 = icmp ne i64 %84, 0, !dbg !145
  %_msprop_icmp95 = and i1 %88, %87, !dbg !145
  br i1 %_msprop_icmp95, label %89, label %93, !dbg !146, !prof !92

; <label>:89:                                     ; preds = %if.then31
  %90 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !145
  %91 = icmp eq i64 %_msret94, 0, !dbg !145
  %92 = select i1 %91, i32 %_msphi_o76, i32 %90, !dbg !145
  store i32 %92, i32* @__msan_origin_tls, align 4, !dbg !146
  call void @__msan_warning_noreturn() #4, !dbg !146
  call void asm sideeffect "", ""() #4, !dbg !146
  unreachable, !dbg !146

; <label>:93:                                     ; preds = %if.then31
  %cmp33 = icmp eq %struct.block* %block.064, %call32, !dbg !145
  br i1 %cmp33, label %if.end37, label %if.then34, !dbg !146

if.then34:                                        ; preds = %93
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !147
  store i64 0, i64* @__msan_va_arg_overflow_size_tls, align 8, !dbg !147
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !147
  %call35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.4, i64 0, i64 0)), !dbg !147
  br label %return, !dbg !149

if.end37:                                         ; preds = %93, %81, %74
  store i64 %_msphi_s73, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !150
  store i32 %_msphi_o74, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !150
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !150
  %call38 = call fastcc zeroext i1 @get_alloc(%struct.block* %block_prev.065), !dbg !150
  %_msret86 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !152
  br i1 %_msret86, label %94, label %96, !dbg !152, !prof !92

; <label>:94:                                     ; preds = %if.end37
  %95 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !152
  store i32 %95, i32* @__msan_origin_tls, align 4, !dbg !152
  call void @__msan_warning_noreturn() #4, !dbg !152
  call void asm sideeffect "", ""() #4, !dbg !152
  unreachable, !dbg !152

; <label>:96:                                     ; preds = %if.end37
  br i1 %call38, label %if.end43, label %land.lhs.true39, !dbg !152

land.lhs.true39:                                  ; preds = %96
  store i64 %_msphi_s75, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !153
  store i32 %_msphi_o76, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !153
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !153
  %call40 = call fastcc zeroext i1 @get_alloc(%struct.block* %block.064), !dbg !153
  %_msret90 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !154
  br i1 %_msret90, label %97, label %99, !dbg !154, !prof !92

; <label>:97:                                     ; preds = %land.lhs.true39
  %98 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !154
  store i32 %98, i32* @__msan_origin_tls, align 4, !dbg !154
  call void @__msan_warning_noreturn() #4, !dbg !154
  call void asm sideeffect "", ""() #4, !dbg !154
  unreachable, !dbg !154

; <label>:99:                                     ; preds = %land.lhs.true39
  br i1 %call40, label %if.end43, label %if.then41, !dbg !154

if.then41:                                        ; preds = %99
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !155
  store i64 0, i64* @__msan_va_arg_overflow_size_tls, align 8, !dbg !155
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !155
  %call42 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.5, i64 0, i64 0)), !dbg !155
  br label %return, !dbg !157

if.end43:                                         ; preds = %99, %96
  store i64 %_msphi_s75, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !158
  store i32 %_msphi_o76, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !158
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !158
  %call44 = call fastcc %struct.block* @find_next(%struct.block* %block.064), !dbg !158
  %_msret87 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !87
  %100 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !87
  call void @llvm.dbg.value(metadata %struct.block* %block.064, metadata !81, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.value(metadata i64 undef, metadata !79, metadata !DIExpression()), !dbg !86
  call void @llvm.dbg.value(metadata %struct.block* %call44, metadata !78, metadata !DIExpression()), !dbg !98
  store i64 %_msret87, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !101
  store i32 %100, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !101
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !101
  %call4 = call fastcc i64 @get_size(%struct.block* %call44), !dbg !101
  %_msret88 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !102
  %101 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !102
  %102 = xor i64 %_msret88, -1, !dbg !102
  %103 = and i64 %call4, %102, !dbg !102
  %104 = icmp eq i64 %103, 0, !dbg !102
  %105 = icmp ne i64 %_msret88, 0, !dbg !102
  %_msprop_icmp89 = and i1 %105, %104, !dbg !102
  br i1 %_msprop_icmp89, label %106, label %107, !dbg !103, !prof !92

; <label>:106:                                    ; preds = %if.end43
  store i32 %101, i32* @__msan_origin_tls, align 4, !dbg !103
  call void @__msan_warning_noreturn() #4, !dbg !103
  call void asm sideeffect "", ""() #4, !dbg !103
  unreachable, !dbg !103

; <label>:107:                                    ; preds = %if.end43
  %cmp5 = icmp eq i64 %call4, 0, !dbg !102
  br i1 %cmp5, label %return.loopexit, label %while.body, !dbg !103, !llvm.loop !159

return.loopexit:                                  ; preds = %107
  br label %return, !dbg !161

return:                                           ; preds = %return.loopexit, %20, %if.then41, %if.then34, %if.then24, %if.then19, %if.then8, %if.then
  %retval.0 = phi i1 [ false, %if.then ], [ false, %if.then8 ], [ false, %if.then19 ], [ false, %if.then24 ], [ false, %if.then34 ], [ false, %if.then41 ], [ true, %20 ], [ true, %return.loopexit ], !dbg !162
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !161
  store i32 0, i32* @__msan_retval_origin_tls, align 4, !dbg !161
  ret i1 %retval.0, !dbg !161
}

declare dso_local i8* @mem_heap_lo() local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @get_size(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !163 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !168
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !168
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !167, metadata !DIExpression()), !dbg !168
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !169
  %call = call fastcc zeroext i1 @ifmini(%struct.block* %block), !dbg !169
  %_msret = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !169
  br i1 %_msret, label %2, label %4, !dbg !169, !prof !92

; <label>:2:                                      ; preds = %entry
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !169
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !169
  call void @__msan_warning_noreturn() #4, !dbg !169
  call void asm sideeffect "", ""() #4, !dbg !169
  unreachable, !dbg !169

; <label>:4:                                      ; preds = %entry
  br i1 %call, label %cond.end, label %cond.false, !dbg !169

cond.false:                                       ; preds = %4
  %_mscmp4 = icmp eq i64 %0, 0, !dbg !170
  br i1 %_mscmp4, label %6, label %5, !dbg !170, !prof !120

; <label>:5:                                      ; preds = %cond.false
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !170
  call void @__msan_warning_noreturn() #4, !dbg !170
  call void asm sideeffect "", ""() #4, !dbg !170
  unreachable, !dbg !170

; <label>:6:                                      ; preds = %cond.false
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !170
  %7 = load i64, i64* %header, align 8, !dbg !170, !tbaa !171
  %8 = ptrtoint %struct.block* %block to i64, !dbg !174
  %9 = xor i64 %8, 87960930222080, !dbg !174
  %10 = inttoptr i64 %9 to i64*, !dbg !174
  %11 = add i64 %9, 17592186044416, !dbg !174
  %12 = inttoptr i64 %11 to i32*, !dbg !174
  %_msld = load i64, i64* %10, align 8, !dbg !174
  %13 = load i32, i32* %12, align 8, !dbg !174
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !174
  store i32 %13, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !174
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !174
  %call1 = call fastcc i64 @extract_size(i64 %7), !dbg !174
  %_msret3 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !169
  %14 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !169
  br label %cond.end, !dbg !169

cond.end:                                         ; preds = %4, %6
  %_msphi_s = phi i64 [ %_msret3, %6 ], [ 0, %4 ], !dbg !169
  %_msphi_o = phi i32 [ %14, %6 ], [ 0, %4 ], !dbg !169
  %cond = phi i64 [ %call1, %6 ], [ 16, %4 ], !dbg !169
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !175
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !175
  ret i64 %cond, !dbg !175
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @get_alloc(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !176 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !181
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !180, metadata !DIExpression()), !dbg !181
  %_mscmp = icmp eq i64 %0, 0, !dbg !182
  br i1 %_mscmp, label %3, label %1, !dbg !182, !prof !120

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !181
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !182
  call void @__msan_warning_noreturn() #4, !dbg !182
  call void asm sideeffect "", ""() #4, !dbg !182
  unreachable, !dbg !182

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !182
  %4 = load i64, i64* %header, align 8, !dbg !182, !tbaa !171
  %5 = ptrtoint %struct.block* %block to i64, !dbg !183
  %6 = xor i64 %5, 87960930222080, !dbg !183
  %7 = inttoptr i64 %6 to i64*, !dbg !183
  %8 = add i64 %6, 17592186044416, !dbg !183
  %9 = inttoptr i64 %8 to i32*, !dbg !183
  %_msld = load i64, i64* %7, align 8, !dbg !183
  %10 = load i32, i32* %9, align 8, !dbg !183
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !183
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !183
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !183
  %call = call fastcc zeroext i1 @extract_alloc(i64 %4), !dbg !183
  ret i1 %call, !dbg !184
}

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

declare dso_local i8* @mem_heap_hi() local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_next(%struct.block* readonly %block) unnamed_addr #0 !dbg !185 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !190
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !190
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !189, metadata !DIExpression()), !dbg !190
  %2 = bitcast %struct.block* %block to i8*, !dbg !191
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !192
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !192
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !193
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !193
  %_msprop = or i64 %_msret, %0, !dbg !193
  %4 = icmp eq i64 %_msret, 0, !dbg !193
  %5 = select i1 %4, i32 %1, i32 %3, !dbg !193
  %add.ptr = getelementptr inbounds i8, i8* %2, i64 %call, !dbg !193
  %6 = bitcast i8* %add.ptr to %struct.block*, !dbg !194
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !195
  store i32 %5, i32* @__msan_retval_origin_tls, align 4, !dbg !195
  ret %struct.block* %6, !dbg !195
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #0 !dbg !196 {
entry:
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !202
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !202
  %call = call i8* @mem_sbrk(i64 16) #4, !dbg !202
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !203
  %0 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !203
  %1 = ptrtoint i8* %call to i64, !dbg !203
  %.demorgan = or i64 %_msret, %1, !dbg !203
  %2 = icmp eq i64 %.demorgan, -1, !dbg !203
  %3 = icmp ne i64 %_msret, 0, !dbg !203
  %_msprop_icmp = and i1 %3, %2, !dbg !203
  br i1 %_msprop_icmp, label %4, label %5, !dbg !205, !prof !92

; <label>:4:                                      ; preds = %entry
  store i32 %0, i32* @__msan_origin_tls, align 4, !dbg !205
  call void @__msan_warning_noreturn() #4, !dbg !205
  call void asm sideeffect "", ""() #4, !dbg !205
  unreachable, !dbg !205

; <label>:5:                                      ; preds = %entry
  %cmp = icmp eq i8* %call, inttoptr (i64 -1 to i8*), !dbg !203
  br i1 %cmp, label %return, label %if.end, !dbg !205

if.end:                                           ; preds = %5
  %6 = bitcast i8* %call to i64*, !dbg !206
  call void @llvm.dbg.value(metadata i64* %6, metadata !200, metadata !DIExpression()), !dbg !207
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !208
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !208
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !208
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !208
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !208
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !208
  %call1 = call fastcc i64 @pack(i64 0, i1 zeroext false, i1 zeroext false, i1 zeroext false, i1 zeroext true), !dbg !208
  %_msret17 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !209
  %7 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !209
  br i1 %3, label %8, label %9, !dbg !209, !prof !92

; <label>:8:                                      ; preds = %if.end
  store i32 %0, i32* @__msan_origin_tls, align 4, !dbg !209
  call void @__msan_warning_noreturn() #4, !dbg !209
  call void asm sideeffect "", ""() #4, !dbg !209
  unreachable, !dbg !209

; <label>:9:                                      ; preds = %if.end
  %10 = ptrtoint i8* %call to i64, !dbg !209
  %11 = xor i64 %10, 87960930222080, !dbg !209
  %12 = inttoptr i64 %11 to i64*, !dbg !209
  store i64 %_msret17, i64* %12, align 8, !dbg !209
  %_mscmp24 = icmp eq i64 %_msret17, 0, !dbg !209
  br i1 %_mscmp24, label %20, label %13, !dbg !209, !prof !120

; <label>:13:                                     ; preds = %9
  %14 = add i64 %11, 17592186044416, !dbg !209
  %15 = call i32 @__msan_chain_origin(i32 %7) #4, !dbg !209
  %16 = zext i32 %15 to i64, !dbg !209
  %17 = shl nuw i64 %16, 32, !dbg !209
  %18 = or i64 %17, %16, !dbg !209
  %19 = inttoptr i64 %14 to i64*, !dbg !209
  store i64 %18, i64* %19, align 8, !dbg !209
  br label %20, !dbg !209

; <label>:20:                                     ; preds = %9, %13
  store i64 %call1, i64* %6, align 8, !dbg !209, !tbaa !210
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !211
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !211
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !211
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !211
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !211
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !211
  %call2 = call fastcc i64 @pack(i64 0, i1 zeroext false, i1 zeroext false, i1 zeroext true, i1 zeroext true), !dbg !211
  %_msret18 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !212
  %21 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !212
  %arrayidx3 = getelementptr inbounds i8, i8* %call, i64 8, !dbg !212
  %22 = bitcast i8* %arrayidx3 to i64*, !dbg !212
  br i1 false, label %23, label %24, !dbg !213, !prof !92

; <label>:23:                                     ; preds = %20
  unreachable, !dbg !213

; <label>:24:                                     ; preds = %20
  %25 = ptrtoint i8* %arrayidx3 to i64, !dbg !213
  %26 = xor i64 %25, 87960930222080, !dbg !213
  %27 = inttoptr i64 %26 to i64*, !dbg !213
  store i64 %_msret18, i64* %27, align 8, !dbg !213
  %_mscmp25 = icmp eq i64 %_msret18, 0, !dbg !213
  br i1 %_mscmp25, label %35, label %28, !dbg !213, !prof !120

; <label>:28:                                     ; preds = %24
  %29 = add i64 %26, 17592186044416, !dbg !213
  %30 = call i32 @__msan_chain_origin(i32 %21) #4, !dbg !213
  %31 = zext i32 %30 to i64, !dbg !213
  %32 = shl nuw i64 %31, 32, !dbg !213
  %33 = or i64 %32, %31, !dbg !213
  %34 = inttoptr i64 %29 to i64*, !dbg !213
  store i64 %33, i64* %34, align 8, !dbg !213
  br label %35, !dbg !213

; <label>:35:                                     ; preds = %24, %28
  store i64 %call2, i64* %22, align 8, !dbg !213, !tbaa !210
  store i64 0, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080) to i64*), align 8, !dbg !214
  br i1 false, label %36, label %37, !dbg !214, !prof !92

; <label>:36:                                     ; preds = %35
  br label %37, !dbg !214

; <label>:37:                                     ; preds = %35, %36
  store i8* %arrayidx3, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !214, !tbaa !94
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !215
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !215
  %call5 = call fastcc %struct.block* @extend_heap(i64 4096), !dbg !215
  %_msret19 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !217
  %38 = ptrtoint %struct.block* %call5 to i64, !dbg !217
  %39 = xor i64 %_msret19, -1, !dbg !217
  %40 = and i64 %39, %38, !dbg !217
  %41 = icmp eq i64 %40, 0, !dbg !217
  %42 = icmp ne i64 %_msret19, 0, !dbg !217
  %_msprop_icmp20 = and i1 %42, %41, !dbg !217
  br i1 %_msprop_icmp20, label %43, label %45, !dbg !218, !prof !92

; <label>:43:                                     ; preds = %37
  %44 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !217
  store i32 %44, i32* @__msan_origin_tls, align 4, !dbg !218
  call void @__msan_warning_noreturn() #4, !dbg !218
  call void asm sideeffect "", ""() #4, !dbg !218
  unreachable, !dbg !218

; <label>:45:                                     ; preds = %37
  %cmp6 = icmp eq %struct.block* %call5, null, !dbg !217
  br i1 %cmp6, label %return, label %return.loopexit, !dbg !218

return.loopexit:                                  ; preds = %45
  %46 = call i8* @__msan_memset(i8* bitcast ([15 x %struct.block*]* @list_head to i8*), i32 0, i64 120) #4, !dbg !219
  br label %return, !dbg !223

return:                                           ; preds = %return.loopexit, %45, %5
  %retval.0 = phi i1 [ false, %5 ], [ false, %45 ], [ true, %return.loopexit ], !dbg !224
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !223
  store i32 0, i32* @__msan_retval_origin_tls, align 4, !dbg !223
  ret i1 %retval.0, !dbg !223
}

declare dso_local i8* @mem_sbrk(i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @pack(i64 %size, i1 zeroext %prev_mini, i1 zeroext %mini, i1 zeroext %prev_alloc, i1 zeroext %alloc) unnamed_addr #0 !dbg !225 {
entry:
  %0 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !235
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !235
  %2 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !235
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !235
  %4 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !235
  %5 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !235
  %6 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !235
  %7 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !235
  %8 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !235
  %9 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !235
  call void @llvm.dbg.value(metadata i64 %size, metadata !229, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.value(metadata i1 %prev_mini, metadata !230, metadata !DIExpression()), !dbg !236
  call void @llvm.dbg.value(metadata i1 %mini, metadata !231, metadata !DIExpression()), !dbg !237
  call void @llvm.dbg.value(metadata i1 %prev_alloc, metadata !232, metadata !DIExpression()), !dbg !238
  call void @llvm.dbg.value(metadata i1 %alloc, metadata !233, metadata !DIExpression()), !dbg !239
  call void @llvm.dbg.value(metadata i64 %size, metadata !234, metadata !DIExpression()), !dbg !240
  %_msprop = zext i1 %8 to i64, !dbg !241
  %or = zext i1 %alloc to i64, !dbg !241
  %10 = xor i64 %or, -1, !dbg !241
  %11 = xor i64 %size, -1, !dbg !241
  %12 = and i64 %6, %_msprop, !dbg !241
  %13 = and i64 %6, %10, !dbg !241
  %14 = and i64 %_msprop, %11, !dbg !241
  %15 = or i64 %14, %13, !dbg !241
  %16 = or i64 %15, %12, !dbg !241
  %17 = icmp eq i64 %6, 0, !dbg !241
  %18 = select i1 %17, i32 %9, i32 %7, !dbg !241
  %spec.select = or i64 %or, %size, !dbg !241
  call void @llvm.dbg.value(metadata i64 %spec.select, metadata !234, metadata !DIExpression()), !dbg !240
  %19 = and i64 %16, -3, !dbg !242
  %or6 = or i64 %spec.select, 2, !dbg !242
  call void @llvm.dbg.value(metadata i64 %or6, metadata !234, metadata !DIExpression()), !dbg !240
  %20 = select i1 %prev_alloc, i64 %19, i64 %16, !dbg !245
  %21 = xor i64 %or6, %spec.select, !dbg !245
  %22 = or i64 %16, %21, !dbg !245
  %_msprop_select = select i1 %4, i64 %22, i64 %20, !dbg !245
  %23 = select i1 %4, i32 %5, i32 %18, !dbg !245
  %word.1 = select i1 %prev_alloc, i64 %or6, i64 %spec.select, !dbg !245
  call void @llvm.dbg.value(metadata i64 %word.1, metadata !234, metadata !DIExpression()), !dbg !240
  %24 = and i64 %_msprop_select, -5, !dbg !246
  %or10 = or i64 %word.1, 4, !dbg !246
  %25 = select i1 %mini, i64 %24, i64 %_msprop_select, !dbg !249
  %26 = xor i64 %or10, %word.1, !dbg !249
  %27 = or i64 %_msprop_select, %26, !dbg !249
  %_msprop_select21 = select i1 %2, i64 %27, i64 %25, !dbg !249
  %28 = select i1 %2, i32 %3, i32 %23, !dbg !249
  %spec.select20 = select i1 %mini, i64 %or10, i64 %word.1, !dbg !249
  call void @llvm.dbg.value(metadata i64 %spec.select20, metadata !234, metadata !DIExpression()), !dbg !240
  %29 = and i64 %_msprop_select21, -9, !dbg !250
  %or14 = or i64 %spec.select20, 8, !dbg !250
  call void @llvm.dbg.value(metadata i64 %or14, metadata !234, metadata !DIExpression()), !dbg !240
  %30 = select i1 %prev_mini, i64 %29, i64 %_msprop_select21, !dbg !253
  %31 = xor i64 %or14, %spec.select20, !dbg !253
  %32 = or i64 %_msprop_select21, %31, !dbg !253
  %_msprop_select22 = select i1 %0, i64 %32, i64 %30, !dbg !253
  %33 = select i1 %0, i32 %1, i32 %28, !dbg !253
  %word.3 = select i1 %prev_mini, i64 %or14, i64 %spec.select20, !dbg !253
  call void @llvm.dbg.value(metadata i64 %word.3, metadata !234, metadata !DIExpression()), !dbg !240
  store i64 %_msprop_select22, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !254
  store i32 %33, i32* @__msan_retval_origin_tls, align 4, !dbg !254
  ret i64 %word.3, !dbg !254
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @extend_heap(i64 %size) unnamed_addr #0 !dbg !255 {
entry:
  call void @llvm.dbg.value(metadata i64 %size, metadata !259, metadata !DIExpression()), !dbg !263
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !264
  %call = call fastcc i64 @round_up(i64 %size), !dbg !264
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !263
  %0 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !263
  call void @llvm.dbg.value(metadata i64 %call, metadata !259, metadata !DIExpression()), !dbg !263
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !265
  store i32 %0, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !265
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !265
  %call1 = call i8* @mem_sbrk(i64 %call) #4, !dbg !265
  %_msret14 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !267
  %1 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !267
  call void @llvm.dbg.value(metadata i8* %call1, metadata !260, metadata !DIExpression()), !dbg !267
  %2 = ptrtoint i8* %call1 to i64, !dbg !268
  %.demorgan = or i64 %_msret14, %2, !dbg !268
  %3 = icmp eq i64 %.demorgan, -1, !dbg !268
  %4 = icmp ne i64 %_msret14, 0, !dbg !268
  %_msprop_icmp = and i1 %4, %3, !dbg !268
  br i1 %_msprop_icmp, label %5, label %6, !dbg !269, !prof !92

; <label>:5:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !269
  call void @__msan_warning_noreturn() #4, !dbg !269
  call void asm sideeffect "", ""() #4, !dbg !269
  unreachable, !dbg !269

; <label>:6:                                      ; preds = %entry
  %cmp = icmp eq i8* %call1, inttoptr (i64 -1 to i8*), !dbg !268
  br i1 %cmp, label %return, label %if.end, !dbg !269

if.end:                                           ; preds = %6
  store i64 %_msret14, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !270
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !270
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !270
  %call2 = call fastcc %struct.block* @payload_to_header(i8* %call1), !dbg !270
  %_msret15 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !271
  %7 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !271
  call void @llvm.dbg.value(metadata %struct.block* %call2, metadata !261, metadata !DIExpression()), !dbg !271
  store i64 %_msret15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !272
  store i32 %7, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !272
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !272
  %call3 = call fastcc zeroext i1 @ifpremini(%struct.block* nonnull %call2), !dbg !272
  %_msret16 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !273
  %8 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !273
  store i64 %_msret15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !273
  store i32 %7, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !273
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !273
  %call4 = call fastcc zeroext i1 @ifprealloc(%struct.block* nonnull %call2), !dbg !273
  %_msret17 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !274
  %9 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !274
  store i64 %_msret15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !274
  store i32 %7, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !274
  store i64 %_msret, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !274
  store i32 %0, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !274
  store i1 %_msret16, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !274
  store i32 %8, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !274
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !274
  store i1 %_msret17, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !274
  store i32 %9, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !274
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !274
  call fastcc void @write_block(%struct.block* nonnull %call2, i64 %call, i1 zeroext %call3, i1 zeroext false, i1 zeroext %call4, i1 zeroext false), !dbg !274
  store i64 %_msret15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !275
  store i32 %7, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !275
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !275
  %call5 = call fastcc %struct.block* @find_next(%struct.block* nonnull %call2), !dbg !275
  %_msret18 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !276
  %10 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !276
  call void @llvm.dbg.value(metadata %struct.block* %call5, metadata !262, metadata !DIExpression()), !dbg !276
  store i64 %_msret18, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !277
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !277
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !277
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !277
  call fastcc void @write_epilogue(%struct.block* %call5, i1 zeroext false, i1 zeroext false), !dbg !277
  store i64 %_msret15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !278
  store i32 %7, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !278
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !278
  %call6 = call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %call2), !dbg !278
  %_msret19 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !271
  %11 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !271
  call void @llvm.dbg.value(metadata %struct.block* %call6, metadata !261, metadata !DIExpression()), !dbg !271
  br label %return, !dbg !279

return:                                           ; preds = %6, %if.end
  %_msphi_s = phi i64 [ %_msret19, %if.end ], [ 0, %6 ], !dbg !280
  %_msphi_o = phi i32 [ %11, %if.end ], [ 0, %6 ], !dbg !280
  %retval.0 = phi %struct.block* [ %call6, %if.end ], [ null, %6 ], !dbg !280
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !281
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !281
  ret %struct.block* %retval.0, !dbg !281
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_malloc(i64 %size) local_unnamed_addr #0 !dbg !282 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !294
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !294
  call void @llvm.dbg.value(metadata i64 %size, metadata !286, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i8* null, metadata !290, metadata !DIExpression()), !dbg !295
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !296, !tbaa !94
  %_msld = load i64, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080) to i64*), align 8, !dbg !298
  %3 = ptrtoint %struct.block* %2 to i64, !dbg !298
  %4 = xor i64 %_msld, -1, !dbg !298
  %5 = and i64 %4, %3, !dbg !298
  %6 = icmp eq i64 %5, 0, !dbg !298
  %7 = icmp ne i64 %_msld, 0, !dbg !298
  %_msprop_icmp = and i1 %7, %6, !dbg !298
  br i1 %_msprop_icmp, label %8, label %10, !dbg !299, !prof !92

; <label>:8:                                      ; preds = %entry
  %9 = load i32, i32* inttoptr (i64 add (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080), i64 17592186044416) to i32*), align 8, !dbg !298
  store i32 %9, i32* @__msan_origin_tls, align 4, !dbg !299
  call void @__msan_warning_noreturn() #4, !dbg !299
  call void asm sideeffect "", ""() #4, !dbg !299
  unreachable, !dbg !299

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq %struct.block* %2, null, !dbg !298
  br i1 %cmp, label %if.then, label %if.end, !dbg !299

if.then:                                          ; preds = %10
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !300
  %call = call zeroext i1 @mm_init(), !dbg !300
  br label %if.end, !dbg !302

if.end:                                           ; preds = %if.then, %10
  %11 = xor i64 %0, -1, !dbg !303
  %12 = and i64 %11, %size, !dbg !303
  %13 = icmp eq i64 %12, 0, !dbg !303
  %14 = icmp ne i64 %0, 0, !dbg !303
  %_msprop_icmp52 = and i1 %14, %13, !dbg !303
  br i1 %_msprop_icmp52, label %15, label %16, !dbg !305, !prof !92

; <label>:15:                                     ; preds = %if.end
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !305
  call void @__msan_warning_noreturn() #4, !dbg !305
  call void asm sideeffect "", ""() #4, !dbg !305
  unreachable, !dbg !305

; <label>:16:                                     ; preds = %if.end
  %cmp1 = icmp eq i64 %size, 0, !dbg !303
  br i1 %cmp1, label %return, label %if.end3, !dbg !305

if.end3:                                          ; preds = %16
  %add = add i64 %size, 8, !dbg !306
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !307
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !307
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !307
  %call4 = call fastcc i64 @round_up(i64 %add), !dbg !307
  %_msret53 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !308
  %17 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !308
  call void @llvm.dbg.value(metadata i64 %call4, metadata !287, metadata !DIExpression()), !dbg !308
  store i64 %_msret53, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !309
  store i32 %17, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !309
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !309
  %call5 = call fastcc %struct.block* @find_fit(i64 %call4), !dbg !309
  %_msret54 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !310
  %18 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !310
  call void @llvm.dbg.value(metadata %struct.block* %call5, metadata !289, metadata !DIExpression()), !dbg !310
  %19 = ptrtoint %struct.block* %call5 to i64, !dbg !311
  %20 = xor i64 %_msret54, -1, !dbg !311
  %21 = and i64 %20, %19, !dbg !311
  %22 = icmp eq i64 %21, 0, !dbg !311
  %23 = icmp ne i64 %_msret54, 0, !dbg !311
  %_msprop_icmp55 = and i1 %23, %22, !dbg !311
  br i1 %_msprop_icmp55, label %24, label %25, !dbg !313, !prof !92

; <label>:24:                                     ; preds = %if.end3
  store i32 %18, i32* @__msan_origin_tls, align 4, !dbg !313
  call void @__msan_warning_noreturn() #4, !dbg !313
  call void asm sideeffect "", ""() #4, !dbg !313
  unreachable, !dbg !313

; <label>:25:                                     ; preds = %if.end3
  %cmp6 = icmp eq %struct.block* %call5, null, !dbg !311
  br i1 %cmp6, label %if.then7, label %if.end13, !dbg !313

if.then7:                                         ; preds = %25
  store i64 %_msret53, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !314
  store i32 %17, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !314
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !314
  %call8 = call fastcc i64 @max(i64 %call4), !dbg !314
  %_msret56 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !316
  %26 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !316
  call void @llvm.dbg.value(metadata i64 %call8, metadata !288, metadata !DIExpression()), !dbg !316
  store i64 %_msret56, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !317
  store i32 %26, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !317
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !317
  %call9 = call fastcc %struct.block* @extend_heap(i64 %call8), !dbg !317
  %_msret57 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !310
  %27 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !310
  call void @llvm.dbg.value(metadata %struct.block* %call9, metadata !289, metadata !DIExpression()), !dbg !310
  %28 = ptrtoint %struct.block* %call9 to i64, !dbg !318
  %29 = xor i64 %_msret57, -1, !dbg !318
  %30 = and i64 %29, %28, !dbg !318
  %31 = icmp eq i64 %30, 0, !dbg !318
  %32 = icmp ne i64 %_msret57, 0, !dbg !318
  %_msprop_icmp58 = and i1 %32, %31, !dbg !318
  br i1 %_msprop_icmp58, label %33, label %34, !dbg !320, !prof !92

; <label>:33:                                     ; preds = %if.then7
  store i32 %27, i32* @__msan_origin_tls, align 4, !dbg !320
  call void @__msan_warning_noreturn() #4, !dbg !320
  call void asm sideeffect "", ""() #4, !dbg !320
  unreachable, !dbg !320

; <label>:34:                                     ; preds = %if.then7
  %cmp10 = icmp eq %struct.block* %call9, null, !dbg !318
  br i1 %cmp10, label %return, label %if.end13, !dbg !320

if.end13:                                         ; preds = %34, %25
  %_msphi_s59 = phi i64 [ %_msret57, %34 ], [ %_msret54, %25 ], !dbg !321
  %_msphi_o60 = phi i32 [ %27, %34 ], [ %18, %25 ], !dbg !321
  %block.0 = phi %struct.block* [ %call9, %34 ], [ %call5, %25 ], !dbg !321
  call void @llvm.dbg.value(metadata %struct.block* %block.0, metadata !289, metadata !DIExpression()), !dbg !310
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !322
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !322
  call fastcc void @remove_list(%struct.block* nonnull %block.0), !dbg !322
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !323
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !323
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !323
  %call14 = call fastcc i64 @get_size(%struct.block* nonnull %block.0), !dbg !323
  %_msret61 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !324
  %35 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !324
  call void @llvm.dbg.value(metadata i64 %call14, metadata !291, metadata !DIExpression()), !dbg !324
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !325
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !325
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !325
  %call15 = call fastcc zeroext i1 @ifpremini(%struct.block* nonnull %block.0), !dbg !325
  %_msret62 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !326
  %36 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !326
  %37 = xor i64 %call14, 16, !dbg !326
  %38 = xor i64 %_msret61, -1, !dbg !326
  %39 = and i64 %37, %38, !dbg !326
  %40 = icmp eq i64 %39, 0, !dbg !326
  %41 = icmp ne i64 %_msret61, 0, !dbg !326
  %_msprop_icmp63 = and i1 %41, %40, !dbg !326
  %cmp16 = icmp eq i64 %call14, 16, !dbg !326
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !327
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !327
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !327
  %call17 = call fastcc zeroext i1 @ifprealloc(%struct.block* nonnull %block.0), !dbg !327
  %_msret64 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !328
  %42 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !328
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !328
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !328
  store i64 %_msret61, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !328
  store i32 %35, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !328
  store i1 %_msret62, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !328
  store i32 %36, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !328
  store i1 %_msprop_icmp63, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !328
  store i32 %35, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !328
  store i1 %_msret64, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !328
  store i32 %42, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !328
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !328
  call fastcc void @write_block(%struct.block* nonnull %block.0, i64 %call14, i1 zeroext %call15, i1 zeroext %cmp16, i1 zeroext %call17, i1 zeroext true), !dbg !328
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !329
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !329
  store i64 %_msret53, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !329
  store i32 %17, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !329
  call fastcc void @split_block(%struct.block* nonnull %block.0, i64 %call4), !dbg !329
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !330
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !330
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !330
  %call18 = call fastcc i64 @get_size(%struct.block* nonnull %block.0), !dbg !330
  %_msret65 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !324
  %43 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !324
  call void @llvm.dbg.value(metadata i64 %call18, metadata !291, metadata !DIExpression()), !dbg !324
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !331
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !331
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !331
  %call19 = call fastcc %struct.block* @find_next(%struct.block* nonnull %block.0), !dbg !331
  %_msret66 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !332
  %44 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !332
  call void @llvm.dbg.value(metadata %struct.block* %call19, metadata !292, metadata !DIExpression()), !dbg !332
  store i64 %_msret66, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !333
  store i32 %44, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !333
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !333
  %call20 = call fastcc i64 @get_size(%struct.block* %call19), !dbg !333
  %_msret67 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !334
  call void @llvm.dbg.value(metadata i64 %call20, metadata !293, metadata !DIExpression()), !dbg !334
  %45 = xor i64 %_msret67, -1, !dbg !335
  %46 = and i64 %call20, %45, !dbg !335
  %47 = icmp eq i64 %46, 0, !dbg !335
  %48 = icmp ne i64 %_msret67, 0, !dbg !335
  %_msprop_icmp68 = and i1 %48, %47, !dbg !335
  br i1 %_msprop_icmp68, label %49, label %51, !dbg !337, !prof !92

; <label>:49:                                     ; preds = %if.end13
  %50 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !334
  store i32 %50, i32* @__msan_origin_tls, align 4, !dbg !337
  call void @__msan_warning_noreturn() #4, !dbg !337
  call void asm sideeffect "", ""() #4, !dbg !337
  unreachable, !dbg !337

; <label>:51:                                     ; preds = %if.end13
  %cmp21 = icmp eq i64 %call20, 0, !dbg !335
  br i1 %cmp21, label %if.else, label %if.then22, !dbg !337

if.then22:                                        ; preds = %51
  %_mscmp80 = icmp eq i64 %_msret66, 0, !dbg !338
  br i1 %_mscmp80, label %53, label %52, !dbg !338, !prof !120

; <label>:52:                                     ; preds = %if.then22
  store i32 %44, i32* @__msan_origin_tls, align 4, !dbg !338
  call void @__msan_warning_noreturn() #4, !dbg !338
  call void asm sideeffect "", ""() #4, !dbg !338
  unreachable, !dbg !338

; <label>:53:                                     ; preds = %if.then22
  %header = getelementptr inbounds %struct.block, %struct.block* %call19, i64 0, i32 0, !dbg !338
  %54 = load i64, i64* %header, align 8, !dbg !338, !tbaa !171
  %55 = ptrtoint %struct.block* %call19 to i64, !dbg !340
  %56 = xor i64 %55, 87960930222080, !dbg !340
  %57 = inttoptr i64 %56 to i64*, !dbg !340
  %58 = add i64 %56, 17592186044416, !dbg !340
  %59 = inttoptr i64 %58 to i32*, !dbg !340
  %_msld71 = load i64, i64* %57, align 8, !dbg !340
  %60 = load i32, i32* %59, align 8, !dbg !340
  store i64 %_msld71, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !340
  store i32 %60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !340
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !340
  %call23 = call fastcc i64 @extract_size(i64 %54), !dbg !340
  %_msret72 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !341
  %61 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !341
  %62 = xor i64 %call18, 16, !dbg !341
  %63 = xor i64 %_msret65, -1, !dbg !341
  %64 = and i64 %62, %63, !dbg !341
  %65 = icmp eq i64 %64, 0, !dbg !341
  %66 = icmp ne i64 %_msret65, 0, !dbg !341
  %_msprop_icmp73 = and i1 %66, %65, !dbg !341
  %cmp24 = icmp eq i64 %call18, 16, !dbg !341
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !342
  store i32 %44, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !342
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !342
  %call25 = call fastcc zeroext i1 @ifmini(%struct.block* %call19), !dbg !342
  %_msret74 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !343
  %67 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !343
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !343
  store i32 %44, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !343
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !343
  %call26 = call fastcc zeroext i1 @get_alloc(%struct.block* %call19), !dbg !343
  %_msret75 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !344
  %68 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !344
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !344
  store i32 %44, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !344
  store i64 %_msret72, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !344
  store i32 %61, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !344
  store i1 %_msprop_icmp73, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !344
  store i32 %43, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !344
  store i1 %_msret74, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !344
  store i32 %67, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !344
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !344
  store i1 %_msret75, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !344
  store i32 %68, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 40) to i32*), align 4, !dbg !344
  call fastcc void @write_block(%struct.block* %call19, i64 %call23, i1 zeroext %cmp24, i1 zeroext %call25, i1 zeroext true, i1 zeroext %call26), !dbg !344
  br label %if.end28, !dbg !345

if.else:                                          ; preds = %51
  %69 = xor i64 %call18, 16, !dbg !346
  %70 = xor i64 %_msret65, -1, !dbg !346
  %71 = and i64 %69, %70, !dbg !346
  %72 = icmp eq i64 %71, 0, !dbg !346
  %73 = icmp ne i64 %_msret65, 0, !dbg !346
  %_msprop_icmp69 = and i1 %73, %72, !dbg !346
  %cmp27 = icmp eq i64 %call18, 16, !dbg !346
  store i64 %_msret66, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !348
  store i32 %44, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !348
  store i1 %_msprop_icmp69, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !348
  store i32 %43, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !348
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !348
  call fastcc void @write_epilogue(%struct.block* %call19, i1 zeroext %cmp27, i1 zeroext true), !dbg !348
  br label %if.end28

if.end28:                                         ; preds = %if.else, %53
  store i64 %_msphi_s59, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !349
  store i32 %_msphi_o60, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !349
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !349
  %call29 = call fastcc i8* @header_to_payload(%struct.block* nonnull %block.0), !dbg !349
  %_msret70 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !295
  %74 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !295
  call void @llvm.dbg.value(metadata i8* %call29, metadata !290, metadata !DIExpression()), !dbg !295
  br label %return, !dbg !350

return:                                           ; preds = %34, %16, %if.end28
  %_msphi_s = phi i64 [ %_msret70, %if.end28 ], [ 0, %16 ], [ 0, %34 ], !dbg !321
  %_msphi_o = phi i32 [ %74, %if.end28 ], [ 0, %16 ], [ 0, %34 ], !dbg !321
  %retval.0 = phi i8* [ %call29, %if.end28 ], [ null, %16 ], [ null, %34 ], !dbg !321
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !351
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !351
  ret i8* %retval.0, !dbg !351
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @round_up(i64 %size) unnamed_addr #0 !dbg !352 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !358
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !358
  call void @llvm.dbg.value(metadata i64 %size, metadata !356, metadata !DIExpression()), !dbg !358
  call void @llvm.dbg.value(metadata i64 16, metadata !357, metadata !DIExpression()), !dbg !359
  %add = add i64 %size, 15, !dbg !360
  %2 = and i64 %0, -16, !dbg !361
  %div = and i64 %add, -16, !dbg !361
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !362
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !362
  ret i64 %div, !dbg !362
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_fit(i64 %asize) unnamed_addr #0 !dbg !363 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !370
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !370
  call void @llvm.dbg.value(metadata i64 %asize, metadata !365, metadata !DIExpression()), !dbg !370
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !371
  %call = call fastcc i32 @findlist(i64 %asize), !dbg !371
  %_msret = load i32, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !372
  call void @llvm.dbg.value(metadata i32 %call, metadata !366, metadata !DIExpression()), !dbg !372
  call void @llvm.dbg.value(metadata i32 %call, metadata !367, metadata !DIExpression()), !dbg !373
  %2 = icmp eq i32 %_msret, 0, !dbg !374
  br i1 %2, label %5, label %3, !dbg !375, !prof !120

; <label>:3:                                      ; preds = %entry
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !372
  store i32 %4, i32* @__msan_origin_tls, align 4, !dbg !375
  call void @__msan_warning_noreturn() #4, !dbg !375
  call void asm sideeffect "", ""() #4, !dbg !375
  unreachable, !dbg !375

; <label>:5:                                      ; preds = %entry
  %cmp18 = icmp slt i32 %call, 15, !dbg !374
  br i1 %cmp18, label %while.body.preheader, label %return, !dbg !375

while.body.preheader:                             ; preds = %5
  %6 = sext i32 %call to i64, !dbg !376
  br label %while.body, !dbg !376

while.body:                                       ; preds = %while.body.preheader, %49
  %indvars.iv = phi i64 [ %6, %while.body.preheader ], [ %indvars.iv.next, %49 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !367, metadata !DIExpression()), !dbg !373
  %arrayidx = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %indvars.iv, !dbg !376
  br i1 false, label %7, label %8, !dbg !376, !prof !92

; <label>:7:                                      ; preds = %while.body
  unreachable, !dbg !376

; <label>:8:                                      ; preds = %while.body
  %9 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !376, !tbaa !94
  %10 = ptrtoint %struct.block** %arrayidx to i64, !dbg !377
  %11 = xor i64 %10, 87960930222080, !dbg !377
  %12 = inttoptr i64 %11 to i64*, !dbg !377
  %13 = add i64 %11, 17592186044416, !dbg !377
  %14 = inttoptr i64 %13 to i32*, !dbg !377
  %_msld = load i64, i64* %12, align 8, !dbg !377
  %15 = load i32, i32* %14, align 8, !dbg !377
  call void @llvm.dbg.value(metadata %struct.block* %9, metadata !368, metadata !DIExpression()), !dbg !377
  %16 = ptrtoint %struct.block* %9 to i64, !dbg !378
  %17 = xor i64 %_msld, -1, !dbg !378
  %18 = and i64 %17, %16, !dbg !378
  %19 = icmp eq i64 %18, 0, !dbg !378
  %20 = icmp ne i64 %_msld, 0, !dbg !378
  %_msprop_icmp = and i1 %20, %19, !dbg !378
  br i1 %_msprop_icmp, label %21, label %22, !dbg !380, !prof !92

; <label>:21:                                     ; preds = %8
  store i32 %15, i32* @__msan_origin_tls, align 4, !dbg !380
  call void @__msan_warning_noreturn() #4, !dbg !380
  call void asm sideeffect "", ""() #4, !dbg !380
  unreachable, !dbg !380

; <label>:22:                                     ; preds = %8
  %cmp1 = icmp eq %struct.block* %9, null, !dbg !378
  br i1 %cmp1, label %if.end8, label %do.body.preheader, !dbg !380

do.body.preheader:                                ; preds = %22
  br label %do.body, !dbg !381

do.body:                                          ; preds = %do.body.preheader, %47
  %_msphi_s31 = phi i64 [ %_msld35, %47 ], [ %_msld, %do.body.preheader ], !dbg !385
  %_msphi_o32 = phi i32 [ %37, %47 ], [ %15, %do.body.preheader ], !dbg !385
  %block.0 = phi %struct.block* [ %31, %47 ], [ %9, %do.body.preheader ], !dbg !385
  call void @llvm.dbg.value(metadata %struct.block* %block.0, metadata !368, metadata !DIExpression()), !dbg !377
  store i64 %_msphi_s31, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !381
  store i32 %_msphi_o32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !381
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !381
  %call2 = call fastcc i64 @get_size(%struct.block* %block.0), !dbg !381
  %_msret33 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !386
  %_msprop34 = or i64 %_msret33, %0, !dbg !386
  %23 = icmp eq i64 %_msprop34, 0, !dbg !386
  br i1 %23, label %28, label %24, !dbg !387, !prof !120

; <label>:24:                                     ; preds = %do.body
  %25 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !386
  %26 = icmp eq i64 %0, 0, !dbg !386
  %27 = select i1 %26, i32 %25, i32 %1, !dbg !386
  store i32 %27, i32* @__msan_origin_tls, align 4, !dbg !387
  call void @__msan_warning_noreturn() #4, !dbg !387
  call void asm sideeffect "", ""() #4, !dbg !387
  unreachable, !dbg !387

; <label>:28:                                     ; preds = %do.body
  %cmp3 = icmp ult i64 %call2, %asize, !dbg !386
  br i1 %cmp3, label %if.end, label %return.loopexit, !dbg !387

if.end:                                           ; preds = %28
  %next = getelementptr inbounds %struct.block, %struct.block* %block.0, i64 0, i32 1, i32 0, i32 0, !dbg !388
  %_mscmp41 = icmp eq i64 %_msphi_s31, 0, !dbg !388
  br i1 %_mscmp41, label %30, label %29, !dbg !388, !prof !120

; <label>:29:                                     ; preds = %if.end
  store i32 %_msphi_o32, i32* @__msan_origin_tls, align 4, !dbg !388
  call void @__msan_warning_noreturn() #4, !dbg !388
  call void asm sideeffect "", ""() #4, !dbg !388
  unreachable, !dbg !388

; <label>:30:                                     ; preds = %if.end
  %31 = load %struct.block*, %struct.block** %next, align 8, !dbg !388, !tbaa !389
  %32 = ptrtoint %struct.block** %next to i64, !dbg !377
  %33 = xor i64 %32, 87960930222080, !dbg !377
  %34 = inttoptr i64 %33 to i64*, !dbg !377
  %35 = add i64 %33, 17592186044416, !dbg !377
  %36 = inttoptr i64 %35 to i32*, !dbg !377
  %_msld35 = load i64, i64* %34, align 8, !dbg !377
  %37 = load i32, i32* %36, align 8, !dbg !377
  call void @llvm.dbg.value(metadata %struct.block* %31, metadata !368, metadata !DIExpression()), !dbg !377
  %38 = ptrtoint %struct.block* %31 to i64, !dbg !390
  %39 = xor i64 %38, %16, !dbg !390
  %40 = or i64 %_msld35, %_msld, !dbg !390
  %41 = xor i64 %40, -1, !dbg !390
  %42 = and i64 %39, %41, !dbg !390
  %43 = icmp eq i64 %42, 0, !dbg !390
  %44 = icmp ne i64 %40, 0, !dbg !390
  %_msprop_icmp36 = and i1 %44, %43, !dbg !390
  br i1 %_msprop_icmp36, label %45, label %47, !dbg !391, !prof !92

; <label>:45:                                     ; preds = %30
  %46 = select i1 %20, i32 %15, i32 %37, !dbg !390
  store i32 %46, i32* @__msan_origin_tls, align 4, !dbg !391
  call void @__msan_warning_noreturn() #4, !dbg !391
  call void asm sideeffect "", ""() #4, !dbg !391
  unreachable, !dbg !391

; <label>:47:                                     ; preds = %30
  %cmp7 = icmp eq %struct.block* %31, %9, !dbg !390
  br i1 %cmp7, label %if.end8.loopexit, label %do.body, !dbg !391, !llvm.loop !392

if.end8.loopexit:                                 ; preds = %47
  br label %if.end8, !dbg !395

if.end8:                                          ; preds = %if.end8.loopexit, %22
  call void @llvm.dbg.value(metadata i32 undef, metadata !367, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !373
  br i1 false, label %48, label %49, !dbg !375, !prof !92

; <label>:48:                                     ; preds = %if.end8
  unreachable, !dbg !375

; <label>:49:                                     ; preds = %if.end8
  %cmp = icmp slt i64 %indvars.iv, 14, !dbg !374
  %indvars.iv.next = add nsw i64 %indvars.iv, 1, !dbg !395
  br i1 %cmp, label %while.body, label %return.loopexit43, !dbg !375, !llvm.loop !396

return.loopexit:                                  ; preds = %28
  call void @llvm.dbg.value(metadata %struct.block* %block.0, metadata !368, metadata !DIExpression()), !dbg !377
  br label %return, !dbg !398

return.loopexit43:                                ; preds = %49
  br label %return, !dbg !398

return:                                           ; preds = %return.loopexit43, %return.loopexit, %5
  %_msphi_s29 = phi i64 [ 0, %5 ], [ %_msphi_s31, %return.loopexit ], [ 0, %return.loopexit43 ], !dbg !399
  %_msphi_o30 = phi i32 [ 0, %5 ], [ %_msphi_o32, %return.loopexit ], [ 0, %return.loopexit43 ], !dbg !399
  %retval.0 = phi %struct.block* [ null, %5 ], [ %block.0, %return.loopexit ], [ null, %return.loopexit43 ], !dbg !399
  store i64 %_msphi_s29, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !398
  store i32 %_msphi_o30, i32* @__msan_retval_origin_tls, align 4, !dbg !398
  ret %struct.block* %retval.0, !dbg !398
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @max(i64 %x) unnamed_addr #0 !dbg !400 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !404
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !404
  call void @llvm.dbg.value(metadata i64 %x, metadata !402, metadata !DIExpression()), !dbg !404
  call void @llvm.dbg.value(metadata i64 4096, metadata !403, metadata !DIExpression()), !dbg !405
  %2 = xor i64 %0, -1, !dbg !406
  %3 = and i64 %2, %x, !dbg !406
  %4 = icmp ugt i64 %3, 4096, !dbg !406
  %5 = or i64 %0, %x, !dbg !406
  %6 = icmp ugt i64 %5, 4096, !dbg !406
  %7 = xor i1 %4, %6, !dbg !406
  %cmp = icmp ugt i64 %x, 4096, !dbg !406
  %8 = select i1 %cmp, i64 %0, i64 0, !dbg !407
  %9 = xor i64 %x, 4096, !dbg !407
  %10 = or i64 %0, %9, !dbg !407
  %_msprop_select = select i1 %7, i64 %10, i64 %8, !dbg !407
  %11 = or i1 %7, %cmp, !dbg !407
  %12 = select i1 %11, i32 %1, i32 0, !dbg !407
  %cond = select i1 %cmp, i64 %x, i64 4096, !dbg !407
  store i64 %_msprop_select, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !408
  store i32 %12, i32* @__msan_retval_origin_tls, align 4, !dbg !408
  ret i64 %cond, !dbg !408
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @remove_list(%struct.block* readonly %block) unnamed_addr #0 !dbg !409 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !417
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !417
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !413, metadata !DIExpression()), !dbg !417
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !418
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !418
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !419
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !419
  call void @llvm.dbg.value(metadata i64 %call, metadata !414, metadata !DIExpression()), !dbg !419
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !420
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !420
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !420
  %call1 = call fastcc i32 @findlist(i64 %call), !dbg !420
  %_msret39 = load i32, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !421
  call void @llvm.dbg.value(metadata i32 %call1, metadata !415, metadata !DIExpression()), !dbg !421
  %idxprom = sext i32 %call1 to i64, !dbg !422
  %3 = icmp eq i32 %_msret39, 0, !dbg !422
  %arrayidx = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %idxprom, !dbg !422
  br i1 %3, label %6, label %4, !dbg !422, !prof !120

; <label>:4:                                      ; preds = %entry
  %5 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !421
  store i32 %5, i32* @__msan_origin_tls, align 4, !dbg !422
  call void @__msan_warning_noreturn() #4, !dbg !422
  call void asm sideeffect "", ""() #4, !dbg !422
  unreachable, !dbg !422

; <label>:6:                                      ; preds = %entry
  %7 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !422, !tbaa !94
  %8 = ptrtoint %struct.block** %arrayidx to i64, !dbg !424
  %9 = xor i64 %8, 87960930222080, !dbg !424
  %10 = inttoptr i64 %9 to i64*, !dbg !424
  %11 = add i64 %9, 17592186044416, !dbg !424
  %_msld = load i64, i64* %10, align 8, !dbg !424
  %12 = ptrtoint %struct.block* %7 to i64, !dbg !424
  %13 = ptrtoint %struct.block* %block to i64, !dbg !424
  %14 = xor i64 %12, %13, !dbg !424
  %15 = or i64 %_msld, %0, !dbg !424
  %16 = xor i64 %15, -1, !dbg !424
  %17 = and i64 %14, %16, !dbg !424
  %18 = icmp eq i64 %17, 0, !dbg !424
  %19 = icmp ne i64 %15, 0, !dbg !424
  %_msprop_icmp = and i1 %19, %18, !dbg !424
  %20 = icmp ne i64 %0, 0, !dbg !424
  br i1 %_msprop_icmp, label %21, label %25, !dbg !425, !prof !92

; <label>:21:                                     ; preds = %6
  %22 = inttoptr i64 %11 to i32*, !dbg !424
  %23 = load i32, i32* %22, align 8, !dbg !424
  %24 = select i1 %20, i32 %1, i32 %23, !dbg !424
  store i32 %24, i32* @__msan_origin_tls, align 4, !dbg !425
  call void @__msan_warning_noreturn() #4, !dbg !425
  call void asm sideeffect "", ""() #4, !dbg !425
  unreachable, !dbg !425

; <label>:25:                                     ; preds = %6
  %cmp = icmp eq %struct.block* %7, %block, !dbg !424
  br i1 %cmp, label %if.then, label %if.end11, !dbg !425

if.then:                                          ; preds = %25
  %next = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 0, !dbg !426
  br i1 %20, label %26, label %27, !dbg !426, !prof !92

; <label>:26:                                     ; preds = %if.then
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !426
  call void @__msan_warning_noreturn() #4, !dbg !426
  call void asm sideeffect "", ""() #4, !dbg !426
  unreachable, !dbg !426

; <label>:27:                                     ; preds = %if.then
  %28 = load %struct.block*, %struct.block** %next, align 8, !dbg !426, !tbaa !389
  %29 = ptrtoint %struct.block** %next to i64, !dbg !429
  %30 = xor i64 %29, 87960930222080, !dbg !429
  %31 = inttoptr i64 %30 to i64*, !dbg !429
  %32 = add i64 %30, 17592186044416, !dbg !429
  %33 = inttoptr i64 %32 to i32*, !dbg !429
  %_msld41 = load i64, i64* %31, align 8, !dbg !429
  %34 = load i32, i32* %33, align 8, !dbg !429
  %35 = ptrtoint %struct.block* %28 to i64, !dbg !429
  %36 = xor i64 %35, %13, !dbg !429
  %37 = xor i64 %_msld41, -1, !dbg !429
  %38 = and i64 %36, %37, !dbg !429
  %39 = icmp eq i64 %38, 0, !dbg !429
  %40 = icmp ne i64 %_msld41, 0, !dbg !429
  %_msprop_icmp42 = and i1 %40, %39, !dbg !429
  br i1 %_msprop_icmp42, label %41, label %42, !dbg !430, !prof !92

; <label>:41:                                     ; preds = %27
  store i32 %34, i32* @__msan_origin_tls, align 4, !dbg !430
  call void @__msan_warning_noreturn() #4, !dbg !430
  call void asm sideeffect "", ""() #4, !dbg !430
  unreachable, !dbg !430

; <label>:42:                                     ; preds = %27
  %cmp2 = icmp eq %struct.block* %28, %block, !dbg !429
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !430

if.then3:                                         ; preds = %42
  br i1 false, label %43, label %44, !dbg !431, !prof !92

; <label>:43:                                     ; preds = %if.then3
  unreachable, !dbg !431

; <label>:44:                                     ; preds = %if.then3
  store i64 0, i64* %10, align 8, !dbg !431
  store %struct.block* null, %struct.block** %arrayidx, align 8, !dbg !431, !tbaa !94
  br label %return, !dbg !433

if.else:                                          ; preds = %42
  br i1 false, label %45, label %46, !dbg !434, !prof !92

; <label>:45:                                     ; preds = %if.else
  unreachable, !dbg !434

; <label>:46:                                     ; preds = %if.else
  store i64 %_msld41, i64* %10, align 8, !dbg !434
  br i1 %40, label %47, label %53, !dbg !434, !prof !92

; <label>:47:                                     ; preds = %46
  %48 = call i32 @__msan_chain_origin(i32 %34) #4, !dbg !434
  %49 = zext i32 %48 to i64, !dbg !434
  %50 = shl nuw i64 %49, 32, !dbg !434
  %51 = or i64 %50, %49, !dbg !434
  %52 = inttoptr i64 %11 to i64*, !dbg !434
  store i64 %51, i64* %52, align 8, !dbg !434
  br label %53, !dbg !434

; <label>:53:                                     ; preds = %46, %47
  store %struct.block* %28, %struct.block** %arrayidx, align 8, !dbg !434, !tbaa !94
  br label %if.end11, !dbg !436

if.end11:                                         ; preds = %53, %25
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !437
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !437
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !437
  %call12 = call fastcc zeroext i1 @ifmini(%struct.block* %block), !dbg !437
  %_msret43 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !439
  br i1 %_msret43, label %54, label %56, !dbg !439, !prof !92

; <label>:54:                                     ; preds = %if.end11
  %55 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !439
  store i32 %55, i32* @__msan_origin_tls, align 4, !dbg !439
  call void @__msan_warning_noreturn() #4, !dbg !439
  call void asm sideeffect "", ""() #4, !dbg !439
  unreachable, !dbg !439

; <label>:56:                                     ; preds = %if.end11
  br i1 %call12, label %if.then13, label %if.else15, !dbg !439

if.then13:                                        ; preds = %56
  br i1 %20, label %57, label %58, !dbg !440, !prof !92

; <label>:57:                                     ; preds = %if.then13
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !440
  call void @__msan_warning_noreturn() #4, !dbg !440
  call void asm sideeffect "", ""() #4, !dbg !440
  unreachable, !dbg !440

; <label>:58:                                     ; preds = %if.then13
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !440
  %59 = load i64, i64* %header, align 8, !dbg !440, !tbaa !171
  %60 = ptrtoint %struct.block* %block to i64, !dbg !442
  %61 = xor i64 %60, 87960930222080, !dbg !442
  %62 = inttoptr i64 %61 to i64*, !dbg !442
  %63 = add i64 %61, 17592186044416, !dbg !442
  %64 = inttoptr i64 %63 to i32*, !dbg !442
  %_msld44 = load i64, i64* %62, align 8, !dbg !442
  %65 = load i32, i32* %64, align 8, !dbg !442
  store i64 %_msld44, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !442
  store i32 %65, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !442
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !442
  %call14 = call fastcc i64 @extract_size(i64 %59), !dbg !442
  %_msret45 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !443
  %66 = lshr i64 %_msret45, 1, !dbg !443
  %shr = lshr i64 %call14, 1, !dbg !443
  %67 = inttoptr i64 %shr to %struct.block*, !dbg !444
  call void @llvm.dbg.value(metadata %struct.block* %67, metadata !416, metadata !DIExpression()), !dbg !445
  br label %if.end18, !dbg !446

if.else15:                                        ; preds = %56
  %prev = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 1, !dbg !447
  br i1 %20, label %68, label %69, !dbg !447, !prof !92

; <label>:68:                                     ; preds = %if.else15
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !447
  call void @__msan_warning_noreturn() #4, !dbg !447
  call void asm sideeffect "", ""() #4, !dbg !447
  unreachable, !dbg !447

; <label>:69:                                     ; preds = %if.else15
  %70 = load %struct.block*, %struct.block** %prev, align 8, !dbg !447, !tbaa !389
  %71 = ptrtoint %struct.block** %prev to i64, !dbg !445
  %72 = xor i64 %71, 87960930222080, !dbg !445
  %73 = inttoptr i64 %72 to i64*, !dbg !445
  %74 = add i64 %72, 17592186044416, !dbg !445
  %75 = inttoptr i64 %74 to i32*, !dbg !445
  %_msld48 = load i64, i64* %73, align 8, !dbg !445
  call void @llvm.dbg.value(metadata %struct.block* %70, metadata !416, metadata !DIExpression()), !dbg !445
  br label %if.end18

if.end18:                                         ; preds = %69, %58
  %_msphi_s = phi i64 [ %66, %58 ], [ %_msld48, %69 ], !dbg !449
  %_msphi_o.in = phi i32* [ @__msan_retval_origin_tls, %58 ], [ %75, %69 ]
  %prev_block.0 = phi %struct.block* [ %67, %58 ], [ %70, %69 ], !dbg !449
  %_msphi_o = load i32, i32* %_msphi_o.in, align 4, !dbg !449
  call void @llvm.dbg.value(metadata %struct.block* %prev_block.0, metadata !416, metadata !DIExpression()), !dbg !445
  %next21 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 0, !dbg !450
  br i1 %20, label %76, label %77, !dbg !450, !prof !92

; <label>:76:                                     ; preds = %if.end18
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !450
  call void @__msan_warning_noreturn() #4, !dbg !450
  call void asm sideeffect "", ""() #4, !dbg !450
  unreachable, !dbg !450

; <label>:77:                                     ; preds = %if.end18
  %78 = load %struct.block*, %struct.block** %next21, align 8, !dbg !450, !tbaa !389
  %79 = ptrtoint %struct.block** %next21 to i64, !dbg !451
  %80 = xor i64 %79, 87960930222080, !dbg !451
  %81 = inttoptr i64 %80 to i64*, !dbg !451
  %82 = add i64 %80, 17592186044416, !dbg !451
  %83 = inttoptr i64 %82 to i32*, !dbg !451
  %_msld46 = load i64, i64* %81, align 8, !dbg !451
  %84 = load i32, i32* %83, align 8, !dbg !451
  store i64 %_msld46, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !451
  store i32 %84, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !451
  store i64 %_msphi_s, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !451
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !451
  call fastcc void @set_pointer(%struct.block* %78, %struct.block* %prev_block.0), !dbg !451
  br i1 false, label %85, label %86, !dbg !452, !prof !92

; <label>:85:                                     ; preds = %77
  unreachable, !dbg !452

; <label>:86:                                     ; preds = %77
  %87 = bitcast %struct.block** %next21 to i64*, !dbg !452
  %88 = load i64, i64* %87, align 8, !dbg !452, !tbaa !389
  %89 = ptrtoint %struct.block** %next21 to i64, !dbg !453
  %90 = xor i64 %89, 87960930222080, !dbg !453
  %91 = inttoptr i64 %90 to i64*, !dbg !453
  %92 = add i64 %90, 17592186044416, !dbg !453
  %93 = inttoptr i64 %92 to i32*, !dbg !453
  %_msld47 = load i64, i64* %91, align 8, !dbg !453
  %94 = load i32, i32* %93, align 8, !dbg !453
  %memory25 = getelementptr inbounds %struct.block, %struct.block* %prev_block.0, i64 0, i32 1, !dbg !453
  %95 = bitcast %union.mem_t* %memory25 to i64*, !dbg !454
  %_mscmp58 = icmp eq i64 %_msphi_s, 0, !dbg !454
  br i1 %_mscmp58, label %97, label %96, !dbg !454, !prof !120

; <label>:96:                                     ; preds = %86
  store i32 %_msphi_o, i32* @__msan_origin_tls, align 4, !dbg !454
  call void @__msan_warning_noreturn() #4, !dbg !454
  call void asm sideeffect "", ""() #4, !dbg !454
  unreachable, !dbg !454

; <label>:97:                                     ; preds = %86
  %98 = ptrtoint %union.mem_t* %memory25 to i64, !dbg !454
  %99 = xor i64 %98, 87960930222080, !dbg !454
  %100 = inttoptr i64 %99 to i64*, !dbg !454
  store i64 %_msld47, i64* %100, align 8, !dbg !454
  %_mscmp61 = icmp eq i64 %_msld47, 0, !dbg !454
  br i1 %_mscmp61, label %108, label %101, !dbg !454, !prof !120

; <label>:101:                                    ; preds = %97
  %102 = add i64 %99, 17592186044416, !dbg !454
  %103 = call i32 @__msan_chain_origin(i32 %94) #4, !dbg !454
  %104 = zext i32 %103 to i64, !dbg !454
  %105 = shl nuw i64 %104, 32, !dbg !454
  %106 = or i64 %105, %104, !dbg !454
  %107 = inttoptr i64 %102 to i64*, !dbg !454
  store i64 %106, i64* %107, align 8, !dbg !454
  br label %108, !dbg !454

; <label>:108:                                    ; preds = %97, %101
  store i64 %88, i64* %95, align 8, !dbg !454, !tbaa !389
  br label %return, !dbg !455

return:                                           ; preds = %108, %44
  ret void, !dbg !455
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @write_block(%struct.block* %block, i64 %size, i1 zeroext %prev_mini, i1 zeroext %mini, i1 zeroext %prev_alloc, i1 zeroext %alloc) unnamed_addr #0 !dbg !456 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !469
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !469
  %2 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !469
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 40) to i32*), align 4, !dbg !469
  %4 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !469
  %5 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !469
  %6 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !469
  %7 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !469
  %8 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !469
  %9 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !469
  %10 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !469
  %11 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !469
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !460, metadata !DIExpression()), !dbg !469
  call void @llvm.dbg.value(metadata i64 %size, metadata !461, metadata !DIExpression()), !dbg !470
  call void @llvm.dbg.value(metadata i1 %prev_mini, metadata !462, metadata !DIExpression()), !dbg !471
  call void @llvm.dbg.value(metadata i1 %mini, metadata !463, metadata !DIExpression()), !dbg !472
  call void @llvm.dbg.value(metadata i1 %prev_alloc, metadata !464, metadata !DIExpression()), !dbg !473
  call void @llvm.dbg.value(metadata i1 %alloc, metadata !465, metadata !DIExpression()), !dbg !474
  store i64 %10, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !475
  store i32 %11, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !475
  store i1 %8, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !475
  store i32 %9, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !475
  store i1 %6, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !475
  store i32 %7, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !475
  store i1 %4, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !475
  store i32 %5, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !475
  store i1 %2, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !475
  store i32 %3, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !475
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !475
  %call = call fastcc i64 @pack(i64 %size, i1 zeroext %prev_mini, i1 zeroext %mini, i1 zeroext %prev_alloc, i1 zeroext %alloc), !dbg !475
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !476
  %12 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !476
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !476
  %_mscmp = icmp eq i64 %0, 0, !dbg !477
  br i1 %_mscmp, label %14, label %13, !dbg !477, !prof !120

; <label>:13:                                     ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !477
  call void @__msan_warning_noreturn() #4, !dbg !477
  call void asm sideeffect "", ""() #4, !dbg !477
  unreachable, !dbg !477

; <label>:14:                                     ; preds = %entry
  %15 = ptrtoint %struct.block* %block to i64, !dbg !477
  %16 = xor i64 %15, 87960930222080, !dbg !477
  %17 = inttoptr i64 %16 to i64*, !dbg !477
  store i64 %_msret, i64* %17, align 8, !dbg !477
  %_mscmp26 = icmp ne i64 %_msret, 0, !dbg !477
  br i1 %_mscmp26, label %18, label %25, !dbg !477, !prof !92

; <label>:18:                                     ; preds = %14
  %19 = add i64 %16, 17592186044416, !dbg !477
  %20 = call i32 @__msan_chain_origin(i32 %12) #4, !dbg !477
  %21 = zext i32 %20 to i64, !dbg !477
  %22 = shl nuw i64 %21, 32, !dbg !477
  %23 = or i64 %22, %21, !dbg !477
  %24 = inttoptr i64 %19 to i64*, !dbg !477
  store i64 %23, i64* %24, align 8, !dbg !477
  br label %25, !dbg !477

; <label>:25:                                     ; preds = %14, %18
  store i64 %call, i64* %header, align 8, !dbg !477, !tbaa !171
  %26 = xor i1 %mini, true, !dbg !478
  %27 = xor i1 %alloc, true, !dbg !478
  %28 = and i1 %2, %6, !dbg !478
  %29 = and i1 %2, %26, !dbg !478
  %30 = and i1 %6, %27, !dbg !478
  %31 = or i1 %29, %30, !dbg !478
  %32 = or i1 %28, %31, !dbg !478
  br i1 %32, label %33, label %35, !dbg !478, !prof !92

; <label>:33:                                     ; preds = %25
  %34 = select i1 %2, i32 %3, i32 %7, !dbg !478
  store i32 %34, i32* @__msan_origin_tls, align 4, !dbg !478
  call void @__msan_warning_noreturn() #4, !dbg !478
  call void asm sideeffect "", ""() #4, !dbg !478
  unreachable, !dbg !478

; <label>:35:                                     ; preds = %25
  %brmerge = or i1 %mini, %alloc, !dbg !478
  br i1 %brmerge, label %if.end, label %if.then, !dbg !478

if.then:                                          ; preds = %35
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !479
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !479
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !479
  %call9 = call fastcc i64* @header_to_footer(%struct.block* nonnull %block), !dbg !479
  %_msret23 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !480
  call void @llvm.dbg.value(metadata i64* %call9, metadata !466, metadata !DIExpression()), !dbg !480
  %_mscmp25 = icmp eq i64 %_msret23, 0, !dbg !481
  br i1 %_mscmp25, label %38, label %36, !dbg !481, !prof !120

; <label>:36:                                     ; preds = %if.then
  %37 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !480
  store i32 %37, i32* @__msan_origin_tls, align 4, !dbg !481
  call void @__msan_warning_noreturn() #4, !dbg !481
  call void asm sideeffect "", ""() #4, !dbg !481
  unreachable, !dbg !481

; <label>:38:                                     ; preds = %if.then
  %39 = ptrtoint i64* %call9 to i64, !dbg !481
  %40 = xor i64 %39, 87960930222080, !dbg !481
  %41 = inttoptr i64 %40 to i64*, !dbg !481
  store i64 %_msret, i64* %41, align 8, !dbg !481
  br i1 %_mscmp26, label %42, label %49, !dbg !481, !prof !92

; <label>:42:                                     ; preds = %38
  %43 = add i64 %40, 17592186044416, !dbg !481
  %44 = call i32 @__msan_chain_origin(i32 %12) #4, !dbg !481
  %45 = zext i32 %44 to i64, !dbg !481
  %46 = shl nuw i64 %45, 32, !dbg !481
  %47 = or i64 %46, %45, !dbg !481
  %48 = inttoptr i64 %43 to i64*, !dbg !481
  store i64 %47, i64* %48, align 8, !dbg !481
  br label %49, !dbg !481

; <label>:49:                                     ; preds = %38, %42
  store i64 %call, i64* %call9, align 8, !dbg !481, !tbaa !210
  br label %if.end, !dbg !482

if.end:                                           ; preds = %35, %49
  ret void, !dbg !483
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @ifpremini(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !484 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !487
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !486, metadata !DIExpression()), !dbg !487
  %_mscmp = icmp eq i64 %0, 0, !dbg !488
  br i1 %_mscmp, label %3, label %1, !dbg !488, !prof !120

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !487
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !488
  call void @__msan_warning_noreturn() #4, !dbg !488
  call void asm sideeffect "", ""() #4, !dbg !488
  unreachable, !dbg !488

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !488
  %4 = load i64, i64* %header, align 8, !dbg !488, !tbaa !171
  %5 = ptrtoint %struct.block* %block to i64, !dbg !489
  %6 = xor i64 %5, 87960930222080, !dbg !489
  %7 = inttoptr i64 %6 to i64*, !dbg !489
  %8 = add i64 %6, 17592186044416, !dbg !489
  %9 = inttoptr i64 %8 to i32*, !dbg !489
  %_msld = load i64, i64* %7, align 8, !dbg !489
  %10 = load i32, i32* %9, align 8, !dbg !489
  %11 = and i64 %_msld, 8, !dbg !489
  %and = and i64 %4, 8, !dbg !489
  %12 = xor i64 %11, -1, !dbg !490
  %13 = and i64 %and, %12, !dbg !490
  %14 = icmp eq i64 %13, 0, !dbg !490
  %15 = icmp ne i64 %11, 0, !dbg !490
  %_msprop_icmp = and i1 %15, %14, !dbg !490
  %tobool = icmp ne i64 %and, 0, !dbg !490
  store i1 %_msprop_icmp, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !491
  store i32 %10, i32* @__msan_retval_origin_tls, align 4, !dbg !491
  ret i1 %tobool, !dbg !491
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @ifprealloc(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !492 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !495
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !494, metadata !DIExpression()), !dbg !495
  %_mscmp = icmp eq i64 %0, 0, !dbg !496
  br i1 %_mscmp, label %3, label %1, !dbg !496, !prof !120

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !495
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !496
  call void @__msan_warning_noreturn() #4, !dbg !496
  call void asm sideeffect "", ""() #4, !dbg !496
  unreachable, !dbg !496

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !496
  %4 = load i64, i64* %header, align 8, !dbg !496, !tbaa !171
  %5 = ptrtoint %struct.block* %block to i64, !dbg !497
  %6 = xor i64 %5, 87960930222080, !dbg !497
  %7 = inttoptr i64 %6 to i64*, !dbg !497
  %8 = add i64 %6, 17592186044416, !dbg !497
  %9 = inttoptr i64 %8 to i32*, !dbg !497
  %_msld = load i64, i64* %7, align 8, !dbg !497
  %10 = load i32, i32* %9, align 8, !dbg !497
  %11 = and i64 %_msld, 2, !dbg !497
  %and = and i64 %4, 2, !dbg !497
  %12 = xor i64 %11, -1, !dbg !498
  %13 = and i64 %and, %12, !dbg !498
  %14 = icmp eq i64 %13, 0, !dbg !498
  %15 = icmp ne i64 %11, 0, !dbg !498
  %_msprop_icmp = and i1 %15, %14, !dbg !498
  %tobool = icmp ne i64 %and, 0, !dbg !498
  store i1 %_msprop_icmp, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !499
  store i32 %10, i32* @__msan_retval_origin_tls, align 4, !dbg !499
  ret i1 %tobool, !dbg !499
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @split_block(%struct.block* %block, i64 %asize) unnamed_addr #0 !dbg !500 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !513
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !513
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !513
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !513
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !504, metadata !DIExpression()), !dbg !513
  call void @llvm.dbg.value(metadata i64 %asize, metadata !505, metadata !DIExpression()), !dbg !514
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !515
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !515
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !516
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !516
  call void @llvm.dbg.value(metadata i64 %call, metadata !506, metadata !DIExpression()), !dbg !516
  %_msprop = or i64 %_msret, %0, !dbg !517
  %5 = icmp ne i64 %0, 0, !dbg !517
  %6 = select i1 %5, i32 %1, i32 %4, !dbg !517
  %sub = sub i64 %call, %asize, !dbg !517
  %7 = xor i64 %_msprop, -1, !dbg !518
  %8 = and i64 %sub, %7, !dbg !518
  %9 = icmp ugt i64 %8, 15, !dbg !518
  %10 = or i64 %_msprop, %sub, !dbg !518
  %11 = icmp ugt i64 %10, 15, !dbg !518
  %12 = xor i1 %9, %11, !dbg !518
  br i1 %12, label %13, label %14, !dbg !519, !prof !92

; <label>:13:                                     ; preds = %entry
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !519
  call void @__msan_warning_noreturn() #4, !dbg !519
  call void asm sideeffect "", ""() #4, !dbg !519
  unreachable, !dbg !519

; <label>:14:                                     ; preds = %entry
  %cmp = icmp ugt i64 %sub, 15, !dbg !518
  br i1 %cmp, label %if.then, label %if.end29, !dbg !519

if.then:                                          ; preds = %14
  %15 = xor i64 %asize, 16, !dbg !520
  %16 = xor i64 %0, -1, !dbg !520
  %17 = and i64 %15, %16, !dbg !520
  %18 = icmp eq i64 %17, 0, !dbg !520
  %_msprop_icmp = and i1 %5, %18, !dbg !520
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !522
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !522
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !522
  %call3 = call fastcc zeroext i1 @ifpremini(%struct.block* %block), !dbg !522
  %_msret50 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !522
  %19 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !522
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !522
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !522
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !522
  %call4 = call fastcc zeroext i1 @ifprealloc(%struct.block* %block), !dbg !522
  %_msret51 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !524
  %20 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !524
  br i1 %_msprop_icmp, label %21, label %22, !dbg !524, !prof !92

; <label>:21:                                     ; preds = %if.then
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !524
  call void @__msan_warning_noreturn() #4, !dbg !524
  call void asm sideeffect "", ""() #4, !dbg !524
  unreachable, !dbg !524

; <label>:22:                                     ; preds = %if.then
  %cmp1 = icmp eq i64 %asize, 16, !dbg !520
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !524

if.then2:                                         ; preds = %22
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !525
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !525
  store i64 %0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !525
  store i32 %1, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !525
  store i1 %_msret50, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !525
  store i32 %19, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !525
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !525
  store i1 %_msret51, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !525
  store i32 %20, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !525
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !525
  call fastcc void @write_block(%struct.block* %block, i64 16, i1 zeroext %call3, i1 zeroext true, i1 zeroext %call4, i1 zeroext true), !dbg !525
  br label %if.end, !dbg !527

if.else:                                          ; preds = %22
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !528
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !528
  store i64 %0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !528
  store i32 %1, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !528
  store i1 %_msret50, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !528
  store i32 %19, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !528
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !528
  store i1 %_msret51, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !528
  store i32 %20, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !528
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !528
  call fastcc void @write_block(%struct.block* %block, i64 %asize, i1 zeroext %call3, i1 zeroext false, i1 zeroext %call4, i1 zeroext true), !dbg !528
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !529
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !529
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !529
  %call7 = call fastcc %struct.block* @find_next(%struct.block* %block), !dbg !529
  %_msret52 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !530
  %23 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !530
  call void @llvm.dbg.value(metadata %struct.block* %call7, metadata !507, metadata !DIExpression()), !dbg !530
  %24 = xor i64 %sub, 16, !dbg !531
  %25 = and i64 %24, %7, !dbg !531
  %26 = icmp eq i64 %25, 0, !dbg !531
  %27 = icmp ne i64 %_msprop, 0, !dbg !531
  %_msprop_icmp53 = and i1 %27, %26, !dbg !531
  %cmp9 = icmp eq i64 %sub, 16, !dbg !531
  store i64 %_msret52, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !532
  store i32 %23, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !532
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !532
  %call14 = call fastcc zeroext i1 @ifpremini(%struct.block* %call7), !dbg !532
  %_msret54 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !535
  %28 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !535
  br i1 %_msprop_icmp53, label %29, label %30, !dbg !535, !prof !92

; <label>:29:                                     ; preds = %if.end
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !535
  call void @__msan_warning_noreturn() #4, !dbg !535
  call void asm sideeffect "", ""() #4, !dbg !535
  unreachable, !dbg !535

; <label>:30:                                     ; preds = %if.end
  br i1 %cmp9, label %if.then12, label %if.else15, !dbg !535

if.then12:                                        ; preds = %30
  store i64 %_msret52, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !536
  store i32 %23, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !536
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !536
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !536
  store i1 %_msret54, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !536
  store i32 %28, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !536
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !536
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !536
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !536
  call fastcc void @write_block(%struct.block* %call7, i64 16, i1 zeroext %call14, i1 zeroext true, i1 zeroext true, i1 zeroext false), !dbg !536
  br label %if.end18, !dbg !538

if.else15:                                        ; preds = %30
  store i64 %_msret52, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !539
  store i32 %23, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !539
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !539
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !539
  store i1 %_msret54, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !539
  store i32 %28, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !539
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !539
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !539
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !539
  call fastcc void @write_block(%struct.block* %call7, i64 %sub, i1 zeroext %call14, i1 zeroext false, i1 zeroext true, i1 zeroext false), !dbg !539
  br label %if.end18

if.end18:                                         ; preds = %if.else15, %if.then12
  store i64 %_msret52, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !540
  store i32 %23, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !540
  call fastcc void @insert_free_block(%struct.block* %call7), !dbg !540
  store i64 %_msret52, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !541
  store i32 %23, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !541
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !541
  %call19 = call fastcc %struct.block* @find_next(%struct.block* %call7), !dbg !541
  %_msret55 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !542
  %31 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !542
  call void @llvm.dbg.value(metadata %struct.block* %call19, metadata !511, metadata !DIExpression()), !dbg !542
  store i64 %_msret55, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !543
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !543
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !543
  %call20 = call fastcc i64 @get_size(%struct.block* %call19), !dbg !543
  %_msret56 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !544
  call void @llvm.dbg.value(metadata i64 %call20, metadata !512, metadata !DIExpression()), !dbg !544
  %32 = xor i64 %_msret56, -1, !dbg !545
  %33 = and i64 %call20, %32, !dbg !545
  %34 = icmp eq i64 %33, 0, !dbg !545
  %35 = icmp ne i64 %_msret56, 0, !dbg !545
  %_msprop_icmp57 = and i1 %35, %34, !dbg !545
  br i1 %_msprop_icmp57, label %36, label %38, !dbg !547, !prof !92

; <label>:36:                                     ; preds = %if.end18
  %37 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !544
  store i32 %37, i32* @__msan_origin_tls, align 4, !dbg !547
  call void @__msan_warning_noreturn() #4, !dbg !547
  call void asm sideeffect "", ""() #4, !dbg !547
  unreachable, !dbg !547

; <label>:38:                                     ; preds = %if.end18
  %cmp21 = icmp eq i64 %call20, 0, !dbg !545
  br i1 %cmp21, label %if.else26, label %if.then22, !dbg !547

if.then22:                                        ; preds = %38
  %_mscmp64 = icmp eq i64 %_msret55, 0, !dbg !548
  br i1 %_mscmp64, label %40, label %39, !dbg !548, !prof !120

; <label>:39:                                     ; preds = %if.then22
  store i32 %31, i32* @__msan_origin_tls, align 4, !dbg !548
  call void @__msan_warning_noreturn() #4, !dbg !548
  call void asm sideeffect "", ""() #4, !dbg !548
  unreachable, !dbg !548

; <label>:40:                                     ; preds = %if.then22
  %header = getelementptr inbounds %struct.block, %struct.block* %call19, i64 0, i32 0, !dbg !548
  %41 = load i64, i64* %header, align 8, !dbg !548, !tbaa !171
  %42 = ptrtoint %struct.block* %call19 to i64, !dbg !550
  %43 = xor i64 %42, 87960930222080, !dbg !550
  %44 = inttoptr i64 %43 to i64*, !dbg !550
  %45 = add i64 %43, 17592186044416, !dbg !550
  %46 = inttoptr i64 %45 to i32*, !dbg !550
  %_msld = load i64, i64* %44, align 8, !dbg !550
  %47 = load i32, i32* %46, align 8, !dbg !550
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !550
  store i32 %47, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !550
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !550
  %call23 = call fastcc i64 @extract_size(i64 %41), !dbg !550
  %_msret58 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !551
  %48 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !551
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !551
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !551
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !551
  %call24 = call fastcc zeroext i1 @ifmini(%struct.block* %call19), !dbg !551
  %_msret59 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !552
  %49 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !552
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !552
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !552
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !552
  %call25 = call fastcc zeroext i1 @get_alloc(%struct.block* %call19), !dbg !552
  %_msret60 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !553
  %50 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !553
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !553
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !553
  store i64 %_msret58, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !553
  store i32 %48, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !553
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !553
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !553
  store i1 %_msret59, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !553
  store i32 %49, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !553
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !553
  store i1 %_msret60, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !553
  store i32 %50, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 40) to i32*), align 4, !dbg !553
  call fastcc void @write_block(%struct.block* %call19, i64 %call23, i1 zeroext %cmp9, i1 zeroext %call24, i1 zeroext false, i1 zeroext %call25), !dbg !553
  br label %if.end29, !dbg !554

if.else26:                                        ; preds = %38
  store i64 %_msret55, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !555
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !555
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !555
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !555
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !555
  call fastcc void @write_epilogue(%struct.block* %call19, i1 zeroext %cmp9, i1 zeroext false), !dbg !555
  br label %if.end29

if.end29:                                         ; preds = %40, %if.else26, %14
  ret void, !dbg !557
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @extract_size(i64 %word) unnamed_addr #0 !dbg !558 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !563
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !563
  call void @llvm.dbg.value(metadata i64 %word, metadata !562, metadata !DIExpression()), !dbg !563
  %2 = and i64 %0, -16, !dbg !564
  %and = and i64 %word, -16, !dbg !564
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !565
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !565
  ret i64 %and, !dbg !565
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @ifmini(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !566 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !569
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !568, metadata !DIExpression()), !dbg !569
  %_mscmp = icmp eq i64 %0, 0, !dbg !570
  br i1 %_mscmp, label %3, label %1, !dbg !570, !prof !120

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !569
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !570
  call void @__msan_warning_noreturn() #4, !dbg !570
  call void asm sideeffect "", ""() #4, !dbg !570
  unreachable, !dbg !570

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !570
  %4 = load i64, i64* %header, align 8, !dbg !570, !tbaa !171
  %5 = ptrtoint %struct.block* %block to i64, !dbg !571
  %6 = xor i64 %5, 87960930222080, !dbg !571
  %7 = inttoptr i64 %6 to i64*, !dbg !571
  %8 = add i64 %6, 17592186044416, !dbg !571
  %9 = inttoptr i64 %8 to i32*, !dbg !571
  %_msld = load i64, i64* %7, align 8, !dbg !571
  %10 = load i32, i32* %9, align 8, !dbg !571
  %11 = and i64 %_msld, 4, !dbg !571
  %and = and i64 %4, 4, !dbg !571
  %12 = xor i64 %11, -1, !dbg !572
  %13 = and i64 %and, %12, !dbg !572
  %14 = icmp eq i64 %13, 0, !dbg !572
  %15 = icmp ne i64 %11, 0, !dbg !572
  %_msprop_icmp = and i1 %15, %14, !dbg !572
  %tobool = icmp ne i64 %and, 0, !dbg !572
  store i1 %_msprop_icmp, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !573
  store i32 %10, i32* @__msan_retval_origin_tls, align 4, !dbg !573
  ret i1 %tobool, !dbg !573
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @write_epilogue(%struct.block* nocapture %block, i1 zeroext %prev_mini, i1 zeroext %prev_alloc) unnamed_addr #0 !dbg !574 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !581
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !581
  %2 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !581
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !581
  %4 = load i1, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !581
  %5 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !581
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !578, metadata !DIExpression()), !dbg !581
  call void @llvm.dbg.value(metadata i1 %prev_mini, metadata !579, metadata !DIExpression()), !dbg !582
  call void @llvm.dbg.value(metadata i1 %prev_alloc, metadata !580, metadata !DIExpression()), !dbg !583
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !584
  store i1 %4, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !584
  store i32 %5, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !584
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !584
  store i1 %2, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !584
  store i32 %3, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !584
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !584
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !584
  %call = call fastcc i64 @pack(i64 0, i1 zeroext %prev_mini, i1 zeroext false, i1 zeroext %prev_alloc, i1 zeroext true), !dbg !584
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !585
  %6 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !585
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !585
  %_mscmp = icmp eq i64 %0, 0, !dbg !586
  br i1 %_mscmp, label %8, label %7, !dbg !586, !prof !120

; <label>:7:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !586
  call void @__msan_warning_noreturn() #4, !dbg !586
  call void asm sideeffect "", ""() #4, !dbg !586
  unreachable, !dbg !586

; <label>:8:                                      ; preds = %entry
  %9 = ptrtoint %struct.block* %block to i64, !dbg !586
  %10 = xor i64 %9, 87960930222080, !dbg !586
  %11 = inttoptr i64 %10 to i64*, !dbg !586
  store i64 %_msret, i64* %11, align 8, !dbg !586
  %_mscmp3 = icmp eq i64 %_msret, 0, !dbg !586
  br i1 %_mscmp3, label %19, label %12, !dbg !586, !prof !120

; <label>:12:                                     ; preds = %8
  %13 = add i64 %10, 17592186044416, !dbg !586
  %14 = call i32 @__msan_chain_origin(i32 %6) #4, !dbg !586
  %15 = zext i32 %14 to i64, !dbg !586
  %16 = shl nuw i64 %15, 32, !dbg !586
  %17 = or i64 %16, %15, !dbg !586
  %18 = inttoptr i64 %13 to i64*, !dbg !586
  store i64 %17, i64* %18, align 8, !dbg !586
  br label %19, !dbg !586

; <label>:19:                                     ; preds = %8, %12
  store i64 %call, i64* %header, align 8, !dbg !586, !tbaa !171
  ret void, !dbg !587
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i8* @header_to_payload(%struct.block* readnone %block) unnamed_addr #0 !dbg !588 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !593
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !593
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !592, metadata !DIExpression()), !dbg !593
  %memory = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, !dbg !594
  %arraydecay = bitcast %union.mem_t* %memory to i8*, !dbg !595
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !596
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !596
  ret i8* %arraydecay, !dbg !596
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local void @mm_free(i8* %bp) local_unnamed_addr #0 !dbg !597 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !605
  call void @llvm.dbg.value(metadata i8* %bp, metadata !601, metadata !DIExpression()), !dbg !605
  %1 = ptrtoint i8* %bp to i64, !dbg !606
  %2 = xor i64 %0, -1, !dbg !606
  %3 = and i64 %2, %1, !dbg !606
  %4 = icmp eq i64 %3, 0, !dbg !606
  %5 = icmp ne i64 %0, 0, !dbg !606
  %_msprop_icmp = and i1 %5, %4, !dbg !606
  br i1 %_msprop_icmp, label %6, label %8, !dbg !608, !prof !92

; <label>:6:                                      ; preds = %entry
  %7 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !605
  store i32 %7, i32* @__msan_origin_tls, align 4, !dbg !608
  call void @__msan_warning_noreturn() #4, !dbg !608
  call void asm sideeffect "", ""() #4, !dbg !608
  unreachable, !dbg !608

; <label>:8:                                      ; preds = %entry
  %cmp = icmp eq i8* %bp, null, !dbg !606
  br i1 %cmp, label %return, label %if.end, !dbg !608

if.end:                                           ; preds = %8
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !609
  %call = call fastcc %struct.block* @payload_to_header(i8* nonnull %bp), !dbg !609
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !610
  %9 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !610
  call void @llvm.dbg.value(metadata %struct.block* %call, metadata !602, metadata !DIExpression()), !dbg !610
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !611
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !611
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !611
  %call1 = call fastcc i64 @get_size(%struct.block* nonnull %call), !dbg !611
  %_msret33 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !612
  %10 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !612
  call void @llvm.dbg.value(metadata i64 %call1, metadata !603, metadata !DIExpression()), !dbg !612
  %11 = xor i64 %call1, 16, !dbg !613
  %12 = xor i64 %_msret33, -1, !dbg !613
  %13 = and i64 %11, %12, !dbg !613
  %14 = icmp eq i64 %13, 0, !dbg !613
  %15 = icmp ne i64 %_msret33, 0, !dbg !613
  %_msprop_icmp34 = and i1 %15, %14, !dbg !613
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !615
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !615
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !615
  %call4 = call fastcc zeroext i1 @ifpremini(%struct.block* nonnull %call), !dbg !615
  %_msret35 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !615
  %16 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !615
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !615
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !615
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !615
  %call5 = call fastcc zeroext i1 @ifprealloc(%struct.block* nonnull %call), !dbg !615
  %_msret36 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !617
  %17 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !617
  br i1 %_msprop_icmp34, label %18, label %19, !dbg !617, !prof !92

; <label>:18:                                     ; preds = %if.end
  store i32 %10, i32* @__msan_origin_tls, align 4, !dbg !617
  call void @__msan_warning_noreturn() #4, !dbg !617
  call void asm sideeffect "", ""() #4, !dbg !617
  unreachable, !dbg !617

; <label>:19:                                     ; preds = %if.end
  %cmp2 = icmp eq i64 %call1, 16, !dbg !613
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !617

if.then3:                                         ; preds = %19
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !618
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !618
  store i64 %_msret33, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !618
  store i32 %10, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !618
  store i1 %_msret35, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !618
  store i32 %16, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !618
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !618
  store i1 %_msret36, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !618
  store i32 %17, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !618
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !618
  call fastcc void @write_block(%struct.block* nonnull %call, i64 16, i1 zeroext %call4, i1 zeroext true, i1 zeroext %call5, i1 zeroext false), !dbg !618
  br label %if.end8, !dbg !620

if.else:                                          ; preds = %19
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !621
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !621
  store i64 %_msret33, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !621
  store i32 %10, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !621
  store i1 %_msret35, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !621
  store i32 %16, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !621
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !621
  store i1 %_msret36, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !621
  store i32 %17, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !621
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !621
  call fastcc void @write_block(%struct.block* nonnull %call, i64 %call1, i1 zeroext %call4, i1 zeroext false, i1 zeroext %call5, i1 zeroext false), !dbg !621
  br label %if.end8

if.end8:                                          ; preds = %if.else, %if.then3
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !622
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !622
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !622
  %call9 = call fastcc %struct.block* @find_next(%struct.block* nonnull %call), !dbg !622
  %_msret37 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !623
  %20 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !623
  call void @llvm.dbg.value(metadata %struct.block* %call9, metadata !604, metadata !DIExpression()), !dbg !623
  store i64 %_msret37, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !624
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !624
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !624
  %call10 = call fastcc i64 @get_size(%struct.block* %call9), !dbg !624
  %_msret38 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !626
  %21 = xor i64 %_msret38, -1, !dbg !626
  %22 = and i64 %call10, %21, !dbg !626
  %23 = icmp eq i64 %22, 0, !dbg !626
  %24 = icmp ne i64 %_msret38, 0, !dbg !626
  %_msprop_icmp39 = and i1 %24, %23, !dbg !626
  br i1 %_msprop_icmp39, label %25, label %27, !dbg !627, !prof !92

; <label>:25:                                     ; preds = %if.end8
  %26 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !626
  store i32 %26, i32* @__msan_origin_tls, align 4, !dbg !627
  call void @__msan_warning_noreturn() #4, !dbg !627
  call void asm sideeffect "", ""() #4, !dbg !627
  unreachable, !dbg !627

; <label>:27:                                     ; preds = %if.end8
  %cmp11 = icmp eq i64 %call10, 0, !dbg !626
  br i1 %cmp11, label %if.else17, label %if.then12, !dbg !627

if.then12:                                        ; preds = %27
  %_mscmp48 = icmp eq i64 %_msret37, 0, !dbg !628
  br i1 %_mscmp48, label %29, label %28, !dbg !628, !prof !120

; <label>:28:                                     ; preds = %if.then12
  store i32 %20, i32* @__msan_origin_tls, align 4, !dbg !628
  call void @__msan_warning_noreturn() #4, !dbg !628
  call void asm sideeffect "", ""() #4, !dbg !628
  unreachable, !dbg !628

; <label>:29:                                     ; preds = %if.then12
  %header = getelementptr inbounds %struct.block, %struct.block* %call9, i64 0, i32 0, !dbg !628
  %30 = load i64, i64* %header, align 8, !dbg !628, !tbaa !171
  %31 = ptrtoint %struct.block* %call9 to i64, !dbg !630
  %32 = xor i64 %31, 87960930222080, !dbg !630
  %33 = inttoptr i64 %32 to i64*, !dbg !630
  %34 = add i64 %32, 17592186044416, !dbg !630
  %35 = inttoptr i64 %34 to i32*, !dbg !630
  %_msld = load i64, i64* %33, align 8, !dbg !630
  %36 = load i32, i32* %35, align 8, !dbg !630
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !630
  store i32 %36, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !630
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !630
  %call13 = call fastcc i64 @extract_size(i64 %30), !dbg !630
  %_msret42 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !631
  %37 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !631
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !631
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !631
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !631
  %call14 = call fastcc zeroext i1 @ifpremini(%struct.block* %call9), !dbg !631
  %_msret43 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !632
  %38 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !632
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !632
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !632
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !632
  %call15 = call fastcc zeroext i1 @ifmini(%struct.block* %call9), !dbg !632
  %_msret44 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !633
  %39 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !633
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !633
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !633
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !633
  %call16 = call fastcc zeroext i1 @get_alloc(%struct.block* %call9), !dbg !633
  %_msret45 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !634
  %40 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !634
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !634
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !634
  store i64 %_msret42, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !634
  store i32 %37, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !634
  store i1 %_msret43, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !634
  store i32 %38, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !634
  store i1 %_msret44, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !634
  store i32 %39, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !634
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !634
  store i1 %_msret45, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !634
  store i32 %40, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 40) to i32*), align 4, !dbg !634
  call fastcc void @write_block(%struct.block* %call9, i64 %call13, i1 zeroext %call14, i1 zeroext %call15, i1 zeroext false, i1 zeroext %call16), !dbg !634
  br label %if.end19, !dbg !635

if.else17:                                        ; preds = %27
  store i64 %_msret37, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !636
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !636
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !636
  %call18 = call fastcc zeroext i1 @ifpremini(%struct.block* %call9), !dbg !636
  %_msret40 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !638
  %41 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !638
  store i64 %_msret37, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !638
  store i32 %20, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !638
  store i1 %_msret40, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !638
  store i32 %41, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !638
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !638
  call fastcc void @write_epilogue(%struct.block* %call9, i1 zeroext %call18, i1 zeroext false), !dbg !638
  br label %if.end19

if.end19:                                         ; preds = %if.else17, %29
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !639
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !639
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !639
  %call20 = call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %call), !dbg !639
  call void @llvm.dbg.value(metadata %struct.block* %call20, metadata !602, metadata !DIExpression()), !dbg !610
  br label %return, !dbg !640

return:                                           ; preds = %8, %if.end19
  ret void, !dbg !640
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull %struct.block* @payload_to_header(i8* readnone %bp) unnamed_addr #0 !dbg !641 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !646
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !646
  call void @llvm.dbg.value(metadata i8* %bp, metadata !645, metadata !DIExpression()), !dbg !646
  %add.ptr = getelementptr inbounds i8, i8* %bp, i64 -8, !dbg !647
  %2 = bitcast i8* %add.ptr to %struct.block*, !dbg !648
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !649
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !649
  ret %struct.block* %2, !dbg !649
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @coalesce_block(%struct.block* %block) unnamed_addr #0 !dbg !650 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !666
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !666
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !652, metadata !DIExpression()), !dbg !666
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !667
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !667
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !668
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !668
  call void @llvm.dbg.value(metadata i64 %call, metadata !653, metadata !DIExpression()), !dbg !668
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !669
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !669
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !669
  %call1 = call fastcc %struct.block* @find_next(%struct.block* %block), !dbg !669
  %_msret81 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !670
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !670
  call void @llvm.dbg.value(metadata %struct.block* %call1, metadata !654, metadata !DIExpression()), !dbg !670
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !671
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !671
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !671
  %call2 = call fastcc zeroext i1 @ifprealloc(%struct.block* %block), !dbg !671
  %_msret82 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !672
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !672
  store i64 %_msret81, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !672
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !672
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !672
  %call3 = call fastcc zeroext i1 @get_alloc(%struct.block* %call1), !dbg !672
  %_msret83 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !673
  %5 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !673
  %call2.not = xor i1 %call2, true, !dbg !673
  %call3.not = xor i1 %call3, true, !dbg !673
  %6 = and i1 %_msret82, %_msret83, !dbg !673
  %7 = and i1 %call2, %_msret83, !dbg !673
  %8 = and i1 %_msret82, %call3, !dbg !673
  %9 = or i1 %8, %7, !dbg !673
  %10 = or i1 %6, %9, !dbg !673
  %11 = select i1 %_msret83, i32 %5, i32 %4, !dbg !673
  br i1 %10, label %12, label %13, !dbg !673, !prof !92

; <label>:12:                                     ; preds = %entry
  store i32 %11, i32* @__msan_origin_tls, align 4, !dbg !673
  call void @__msan_warning_noreturn() #4, !dbg !673
  call void asm sideeffect "", ""() #4, !dbg !673
  unreachable, !dbg !673

; <label>:13:                                     ; preds = %entry
  %brmerge = or i1 %call2.not, %call3.not, !dbg !673
  br i1 %brmerge, label %if.else, label %if.end27, !dbg !673

if.else:                                          ; preds = %13
  %14 = and i1 %_msret82, %call3.not, !dbg !674
  br i1 %14, label %15, label %17, !dbg !674, !prof !92

; <label>:15:                                     ; preds = %if.else
  %16 = select i1 %_msret82, i32 %4, i32 %5, !dbg !674
  store i32 %16, i32* @__msan_origin_tls, align 4, !dbg !674
  call void @__msan_warning_noreturn() #4, !dbg !674
  call void asm sideeffect "", ""() #4, !dbg !674
  unreachable, !dbg !674

; <label>:17:                                     ; preds = %if.else
  %brmerge78 = or i1 %call3, %call2.not, !dbg !674
  br i1 %brmerge78, label %if.else11, label %if.then9, !dbg !674

if.then9:                                         ; preds = %17
  store i64 %_msret81, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !675
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !675
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !675
  %call10 = call fastcc i64 @get_size(%struct.block* %call1), !dbg !675
  %_msret101 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !677
  %18 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !677
  %_msprop102 = or i64 %_msret101, %_msret, !dbg !677
  %19 = icmp eq i64 %_msret, 0, !dbg !677
  %20 = select i1 %19, i32 %18, i32 %2, !dbg !677
  %add = add i64 %call10, %call, !dbg !677
  call void @llvm.dbg.value(metadata i64 %add, metadata !653, metadata !DIExpression()), !dbg !668
  store i64 %_msret81, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !678
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !678
  call fastcc void @remove_list(%struct.block* %call1), !dbg !678
  br label %if.end27, !dbg !679

if.else11:                                        ; preds = %17
  %21 = and i1 %_msret83, %call2.not, !dbg !680
  br i1 %21, label %22, label %23, !dbg !680, !prof !92

; <label>:22:                                     ; preds = %if.else11
  store i32 %11, i32* @__msan_origin_tls, align 4, !dbg !680
  call void @__msan_warning_noreturn() #4, !dbg !680
  call void asm sideeffect "", ""() #4, !dbg !680
  unreachable, !dbg !680

; <label>:23:                                     ; preds = %if.else11
  %brmerge80 = or i1 %call2, %call3.not, !dbg !680
  br i1 %brmerge80, label %if.else19, label %if.then15, !dbg !680

if.then15:                                        ; preds = %23
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !681
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !681
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !681
  %call16 = call fastcc %struct.block* @find_prev(%struct.block* %block), !dbg !681
  %_msret98 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !682
  %24 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !682
  call void @llvm.dbg.value(metadata %struct.block* %call16, metadata !657, metadata !DIExpression()), !dbg !682
  store i64 %_msret98, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !683
  store i32 %24, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !683
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !683
  %call17 = call fastcc i64 @get_size(%struct.block* %call16), !dbg !683
  %_msret99 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !684
  %25 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !684
  %_msprop100 = or i64 %_msret99, %_msret, !dbg !684
  %26 = icmp eq i64 %_msret, 0, !dbg !684
  %27 = select i1 %26, i32 %25, i32 %2, !dbg !684
  %add18 = add i64 %call17, %call, !dbg !684
  call void @llvm.dbg.value(metadata i64 %add18, metadata !653, metadata !DIExpression()), !dbg !668
  store i64 %_msret98, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !685
  store i32 %24, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !685
  call fastcc void @remove_list(%struct.block* %call16), !dbg !685
  call void @llvm.dbg.value(metadata %struct.block* %call16, metadata !652, metadata !DIExpression()), !dbg !666
  br label %if.end27, !dbg !686

if.else19:                                        ; preds = %23
  store i64 %_msret81, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !687
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !687
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !687
  %call20 = call fastcc i64 @get_size(%struct.block* %call1), !dbg !687
  %_msret84 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !688
  %28 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !688
  %_msprop = or i64 %_msret84, %_msret, !dbg !688
  %29 = icmp eq i64 %_msret, 0, !dbg !688
  %30 = select i1 %29, i32 %28, i32 %2, !dbg !688
  %add21 = add i64 %call20, %call, !dbg !688
  call void @llvm.dbg.value(metadata i64 %add21, metadata !653, metadata !DIExpression()), !dbg !668
  store i64 %_msret81, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !689
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !689
  call fastcc void @remove_list(%struct.block* %call1), !dbg !689
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !690
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !690
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !690
  %call23 = call fastcc %struct.block* @find_prev(%struct.block* %block), !dbg !690
  %_msret85 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !691
  %31 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !691
  call void @llvm.dbg.value(metadata %struct.block* %call23, metadata !662, metadata !DIExpression()), !dbg !691
  store i64 %_msret85, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !692
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !692
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !692
  %call24 = call fastcc i64 @get_size(%struct.block* %call23), !dbg !692
  %_msret86 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !693
  %32 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !693
  %_msprop87 = or i64 %_msprop, %_msret86, !dbg !693
  %33 = icmp eq i64 %_msret86, 0, !dbg !693
  %34 = select i1 %33, i32 %30, i32 %32, !dbg !693
  %add25 = add i64 %add21, %call24, !dbg !693
  call void @llvm.dbg.value(metadata i64 %add25, metadata !653, metadata !DIExpression()), !dbg !668
  store i64 %_msret85, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !694
  store i32 %31, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !694
  call fastcc void @remove_list(%struct.block* %call23), !dbg !694
  call void @llvm.dbg.value(metadata %struct.block* %call23, metadata !652, metadata !DIExpression()), !dbg !666
  br label %if.end27

if.end27:                                         ; preds = %13, %if.then9, %if.else19, %if.then15
  %_msphi_s = phi i64 [ %_msprop87, %if.else19 ], [ %_msprop100, %if.then15 ], [ %_msprop102, %if.then9 ], [ %_msret, %13 ], !dbg !695
  %_msphi_o = phi i32 [ %34, %if.else19 ], [ %27, %if.then15 ], [ %20, %if.then9 ], [ %2, %13 ], !dbg !695
  %block_size.0 = phi i64 [ %add25, %if.else19 ], [ %add18, %if.then15 ], [ %add, %if.then9 ], [ %call, %13 ], !dbg !695
  %_msphi_s88 = phi i64 [ %_msret85, %if.else19 ], [ %_msret98, %if.then15 ], [ %0, %if.then9 ], [ %0, %13 ]
  %_msphi_o89 = phi i32 [ %31, %if.else19 ], [ %24, %if.then15 ], [ %1, %if.then9 ], [ %1, %13 ]
  %block.addr.0 = phi %struct.block* [ %call23, %if.else19 ], [ %call16, %if.then15 ], [ %block, %if.then9 ], [ %block, %13 ]
  call void @llvm.dbg.value(metadata %struct.block* %block.addr.0, metadata !652, metadata !DIExpression()), !dbg !666
  call void @llvm.dbg.value(metadata i64 %block_size.0, metadata !653, metadata !DIExpression()), !dbg !668
  %35 = xor i64 %block_size.0, 16, !dbg !696
  %36 = xor i64 %_msphi_s, -1, !dbg !696
  %37 = and i64 %35, %36, !dbg !696
  %38 = icmp eq i64 %37, 0, !dbg !696
  %39 = icmp ne i64 %_msphi_s, 0, !dbg !696
  %_msprop_icmp = and i1 %39, %38, !dbg !696
  %cmp = icmp eq i64 %block_size.0, 16, !dbg !696
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !697
  store i32 %_msphi_o89, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !697
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !697
  %call29 = call fastcc zeroext i1 @ifpremini(%struct.block* %block.addr.0), !dbg !697
  %_msret90 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !698
  %40 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !698
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !698
  store i32 %_msphi_o89, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !698
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !698
  %call31 = call fastcc zeroext i1 @ifprealloc(%struct.block* %block.addr.0), !dbg !698
  %_msret91 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !699
  %41 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !699
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !699
  store i32 %_msphi_o89, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !699
  store i64 %_msphi_s, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !699
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !699
  store i1 %_msret90, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !699
  store i32 %40, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !699
  store i1 %_msprop_icmp, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !699
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !699
  store i1 %_msret91, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !699
  store i32 %41, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 32) to i32*), align 4, !dbg !699
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !699
  call fastcc void @write_block(%struct.block* %block.addr.0, i64 %block_size.0, i1 zeroext %call29, i1 zeroext %cmp, i1 zeroext %call31, i1 zeroext false), !dbg !699
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !700
  store i32 %_msphi_o89, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !700
  call fastcc void @insert_free_block(%struct.block* %block.addr.0), !dbg !700
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !701
  store i32 %_msphi_o89, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !701
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !701
  %call32 = call fastcc %struct.block* @find_next(%struct.block* %block.addr.0), !dbg !701
  %_msret92 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !670
  %42 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !670
  call void @llvm.dbg.value(metadata %struct.block* %call32, metadata !654, metadata !DIExpression()), !dbg !670
  store i64 %_msret92, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !702
  store i32 %42, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !702
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !702
  %call33 = call fastcc i64 @get_size(%struct.block* %call32), !dbg !702
  %_msret93 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !703
  call void @llvm.dbg.value(metadata i64 %call33, metadata !665, metadata !DIExpression()), !dbg !703
  %43 = xor i64 %_msret93, -1, !dbg !704
  %44 = and i64 %call33, %43, !dbg !704
  %45 = icmp eq i64 %44, 0, !dbg !704
  %46 = icmp ne i64 %_msret93, 0, !dbg !704
  %_msprop_icmp94 = and i1 %46, %45, !dbg !704
  br i1 %_msprop_icmp94, label %47, label %49, !dbg !706, !prof !92

; <label>:47:                                     ; preds = %if.end27
  %48 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !703
  store i32 %48, i32* @__msan_origin_tls, align 4, !dbg !706
  call void @__msan_warning_noreturn() #4, !dbg !706
  call void asm sideeffect "", ""() #4, !dbg !706
  unreachable, !dbg !706

; <label>:49:                                     ; preds = %if.end27
  %cmp34 = icmp eq i64 %call33, 0, !dbg !704
  br i1 %cmp34, label %if.else40, label %if.then35, !dbg !706

if.then35:                                        ; preds = %49
  %_mscmp106 = icmp eq i64 %_msret92, 0, !dbg !707
  br i1 %_mscmp106, label %51, label %50, !dbg !707, !prof !120

; <label>:50:                                     ; preds = %if.then35
  store i32 %42, i32* @__msan_origin_tls, align 4, !dbg !707
  call void @__msan_warning_noreturn() #4, !dbg !707
  call void asm sideeffect "", ""() #4, !dbg !707
  unreachable, !dbg !707

; <label>:51:                                     ; preds = %if.then35
  %header = getelementptr inbounds %struct.block, %struct.block* %call32, i64 0, i32 0, !dbg !707
  %52 = load i64, i64* %header, align 8, !dbg !707, !tbaa !171
  %53 = ptrtoint %struct.block* %call32 to i64, !dbg !709
  %54 = xor i64 %53, 87960930222080, !dbg !709
  %55 = inttoptr i64 %54 to i64*, !dbg !709
  %56 = add i64 %54, 17592186044416, !dbg !709
  %57 = inttoptr i64 %56 to i32*, !dbg !709
  %_msld = load i64, i64* %55, align 8, !dbg !709
  %58 = load i32, i32* %57, align 8, !dbg !709
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !709
  store i32 %58, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !709
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !709
  %call36 = call fastcc i64 @extract_size(i64 %52), !dbg !709
  %_msret95 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !710
  %59 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !710
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !710
  store i32 %42, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !710
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !710
  %call38 = call fastcc zeroext i1 @ifmini(%struct.block* %call32), !dbg !710
  %_msret96 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !711
  %60 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !711
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !711
  store i32 %42, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !711
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !711
  %call39 = call fastcc zeroext i1 @get_alloc(%struct.block* %call32), !dbg !711
  %_msret97 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !712
  %61 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !712
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !712
  store i32 %42, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !712
  store i64 %_msret95, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !712
  store i32 %59, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !712
  store i1 %_msprop_icmp, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !712
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !712
  store i1 %_msret96, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 24) to i1*), align 8, !dbg !712
  store i32 %60, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 24) to i32*), align 4, !dbg !712
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to i1*), align 8, !dbg !712
  store i1 %_msret97, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 40) to i1*), align 8, !dbg !712
  store i32 %61, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 40) to i32*), align 4, !dbg !712
  call fastcc void @write_block(%struct.block* %call32, i64 %call36, i1 zeroext %cmp, i1 zeroext %call38, i1 zeroext false, i1 zeroext %call39), !dbg !712
  br label %if.end42, !dbg !713

if.else40:                                        ; preds = %49
  store i64 %_msret92, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !714
  store i32 %42, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !714
  store i1 %_msprop_icmp, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i1*), align 8, !dbg !714
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !714
  store i1 false, i1* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i1*), align 8, !dbg !714
  call fastcc void @write_epilogue(%struct.block* %call32, i1 zeroext %cmp, i1 zeroext false), !dbg !714
  br label %if.end42

if.end42:                                         ; preds = %if.else40, %51
  store i64 %_msphi_s88, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !716
  store i32 %_msphi_o89, i32* @__msan_retval_origin_tls, align 4, !dbg !716
  ret %struct.block* %block.addr.0, !dbg !716
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_realloc(i8* %ptr, i64 %size) local_unnamed_addr #0 !dbg !717 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !726
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !726
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !726
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !726
  call void @llvm.dbg.value(metadata i8* %ptr, metadata !721, metadata !DIExpression()), !dbg !726
  call void @llvm.dbg.value(metadata i64 %size, metadata !722, metadata !DIExpression()), !dbg !727
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !728
  %call = call fastcc %struct.block* @payload_to_header(i8* %ptr), !dbg !728
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !729
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !729
  call void @llvm.dbg.value(metadata %struct.block* %call, metadata !723, metadata !DIExpression()), !dbg !729
  %5 = xor i64 %0, -1, !dbg !730
  %6 = and i64 %5, %size, !dbg !730
  %7 = icmp eq i64 %6, 0, !dbg !730
  %8 = icmp ne i64 %0, 0, !dbg !730
  %_msprop_icmp = and i1 %8, %7, !dbg !730
  br i1 %_msprop_icmp, label %9, label %10, !dbg !732, !prof !92

; <label>:9:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !732
  call void @__msan_warning_noreturn() #4, !dbg !732
  call void asm sideeffect "", ""() #4, !dbg !732
  unreachable, !dbg !732

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq i64 %size, 0, !dbg !730
  br i1 %cmp, label %if.then, label %if.end, !dbg !732

if.then:                                          ; preds = %10
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !733
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !733
  call void @mm_free(i8* %ptr), !dbg !733
  br label %return, !dbg !735

if.end:                                           ; preds = %10
  %11 = ptrtoint i8* %ptr to i64, !dbg !736
  %12 = xor i64 %2, -1, !dbg !736
  %13 = and i64 %12, %11, !dbg !736
  %14 = icmp eq i64 %13, 0, !dbg !736
  %15 = icmp ne i64 %2, 0, !dbg !736
  %_msprop_icmp23 = and i1 %15, %14, !dbg !736
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !738
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !738
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !738
  %call3 = call i8* @mm_malloc(i64 %size), !dbg !738
  %_msret24 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !739
  %16 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !739
  br i1 %_msprop_icmp23, label %17, label %18, !dbg !739, !prof !92

; <label>:17:                                     ; preds = %if.end
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !739
  call void @__msan_warning_noreturn() #4, !dbg !739
  call void asm sideeffect "", ""() #4, !dbg !739
  unreachable, !dbg !739

; <label>:18:                                     ; preds = %if.end
  %cmp1 = icmp eq i8* %ptr, null, !dbg !736
  br i1 %cmp1, label %return, label %if.end4, !dbg !739

if.end4:                                          ; preds = %18
  call void @llvm.dbg.value(metadata i8* %call3, metadata !725, metadata !DIExpression()), !dbg !740
  %19 = ptrtoint i8* %call3 to i64, !dbg !741
  %20 = xor i64 %_msret24, -1, !dbg !741
  %21 = and i64 %20, %19, !dbg !741
  %22 = icmp eq i64 %21, 0, !dbg !741
  %23 = icmp ne i64 %_msret24, 0, !dbg !741
  %_msprop_icmp25 = and i1 %23, %22, !dbg !741
  br i1 %_msprop_icmp25, label %24, label %25, !dbg !743, !prof !92

; <label>:24:                                     ; preds = %if.end4
  store i32 %16, i32* @__msan_origin_tls, align 4, !dbg !743
  call void @__msan_warning_noreturn() #4, !dbg !743
  call void asm sideeffect "", ""() #4, !dbg !743
  unreachable, !dbg !743

; <label>:25:                                     ; preds = %if.end4
  %cmp6 = icmp eq i8* %call3, null, !dbg !741
  br i1 %cmp6, label %return, label %if.end8, !dbg !743

if.end8:                                          ; preds = %25
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !744
  store i32 %4, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !744
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !744
  %call9 = call fastcc i64 @get_payload_size(%struct.block* nonnull %call), !dbg !744
  %_msret26 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !745
  %26 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !745
  call void @llvm.dbg.value(metadata i64 %call9, metadata !724, metadata !DIExpression()), !dbg !745
  %_msprop = or i64 %_msret26, %0, !dbg !746
  %27 = select i1 %8, i32 %1, i32 %26, !dbg !746
  %28 = icmp ne i64 %_msprop, 0, !dbg !746
  %cmp10 = icmp ugt i64 %call9, %size, !dbg !746
  %29 = select i1 %cmp10, i64 %0, i64 %_msret26, !dbg !748
  %30 = xor i64 %call9, %size, !dbg !748
  %31 = or i64 %_msprop, %30, !dbg !748
  %_msprop_select = select i1 %28, i64 %31, i64 %29, !dbg !748
  %32 = select i1 %cmp10, i32 %1, i32 %26, !dbg !748
  %33 = select i1 %28, i32 %27, i32 %32, !dbg !748
  %spec.select = select i1 %cmp10, i64 %size, i64 %call9, !dbg !748
  call void @llvm.dbg.value(metadata i64 %spec.select, metadata !724, metadata !DIExpression()), !dbg !745
  store i64 %_msret24, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !749
  store i32 %16, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !749
  store i64 %2, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !749
  store i32 %3, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !749
  store i64 %_msprop_select, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !749
  store i32 %33, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !749
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !749
  %call13 = call i8* @mem_memcpy(i8* nonnull %call3, i8* nonnull %ptr, i64 %spec.select) #4, !dbg !749
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !750
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !750
  call void @mm_free(i8* nonnull %ptr), !dbg !750
  br label %return, !dbg !751

return:                                           ; preds = %25, %18, %if.end8, %if.then
  %_msphi_s = phi i64 [ 0, %if.then ], [ %_msret24, %if.end8 ], [ %_msret24, %18 ], [ 0, %25 ], !dbg !738
  %_msphi_o = phi i32 [ 0, %if.then ], [ %16, %if.end8 ], [ %16, %18 ], [ 0, %25 ], !dbg !738
  %retval.0 = phi i8* [ null, %if.then ], [ %call3, %if.end8 ], [ %call3, %18 ], [ null, %25 ], !dbg !738
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !752
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !752
  ret i8* %retval.0, !dbg !752
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @get_payload_size(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !753 {
entry:
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !755, metadata !DIExpression()), !dbg !757
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !758
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !758
  call void @llvm.dbg.value(metadata i64 %call, metadata !756, metadata !DIExpression()), !dbg !759
  %sub = add i64 %call, -8, !dbg !760
  ret i64 %sub, !dbg !761
}

declare dso_local i8* @mem_memcpy(i8*, i8*, i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_calloc(i64 %elements, i64 %size) local_unnamed_addr #0 !dbg !762 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !770
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !770
  %2 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !770
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !770
  call void @llvm.dbg.value(metadata i64 %elements, metadata !766, metadata !DIExpression()), !dbg !770
  call void @llvm.dbg.value(metadata i64 %size, metadata !767, metadata !DIExpression()), !dbg !771
  %_msprop = or i64 %2, %0, !dbg !772
  %4 = icmp ne i64 %0, 0, !dbg !772
  %5 = select i1 %4, i32 %1, i32 %3, !dbg !772
  %mul = mul i64 %size, %elements, !dbg !772
  call void @llvm.dbg.value(metadata i64 %mul, metadata !769, metadata !DIExpression()), !dbg !773
  %6 = xor i64 %0, -1, !dbg !774
  %7 = and i64 %6, %elements, !dbg !774
  %8 = icmp eq i64 %7, 0, !dbg !774
  %_msprop_icmp = and i1 %4, %8, !dbg !774
  br i1 %_msprop_icmp, label %9, label %10, !dbg !776, !prof !92

; <label>:9:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !776
  call void @__msan_warning_noreturn() #4, !dbg !776
  call void asm sideeffect "", ""() #4, !dbg !776
  unreachable, !dbg !776

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq i64 %elements, 0, !dbg !774
  br i1 %cmp, label %return, label %if.end, !dbg !776

if.end:                                           ; preds = %10
  br i1 %4, label %11, label %12, !dbg !777, !prof !92

; <label>:11:                                     ; preds = %if.end
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !777
  call void @__msan_warning_noreturn() #4, !dbg !777
  call void asm sideeffect "", ""() #4, !dbg !777
  unreachable, !dbg !777

; <label>:12:                                     ; preds = %if.end
  %div = udiv i64 %mul, %elements, !dbg !777
  %13 = xor i64 %div, %size, !dbg !779
  %14 = xor i64 %_msprop, -1, !dbg !779
  %15 = and i64 %13, %14, !dbg !779
  %16 = icmp eq i64 %15, 0, !dbg !779
  %17 = icmp ne i64 %_msprop, 0, !dbg !779
  %_msprop_icmp15 = and i1 %17, %16, !dbg !779
  br i1 %_msprop_icmp15, label %18, label %21, !dbg !780, !prof !92

; <label>:18:                                     ; preds = %12
  %19 = icmp eq i64 %2, 0, !dbg !779
  %20 = select i1 %19, i32 %5, i32 %3, !dbg !779
  store i32 %20, i32* @__msan_origin_tls, align 4, !dbg !780
  call void @__msan_warning_noreturn() #4, !dbg !780
  call void asm sideeffect "", ""() #4, !dbg !780
  unreachable, !dbg !780

; <label>:21:                                     ; preds = %12
  %cmp1 = icmp eq i64 %div, %size, !dbg !779
  br i1 %cmp1, label %if.end3, label %return, !dbg !780

if.end3:                                          ; preds = %21
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !781
  store i32 %5, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !781
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !781
  %call = call i8* @mm_malloc(i64 %mul), !dbg !781
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !782
  %22 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !782
  call void @llvm.dbg.value(metadata i8* %call, metadata !768, metadata !DIExpression()), !dbg !782
  %23 = ptrtoint i8* %call to i64, !dbg !783
  %24 = xor i64 %_msret, -1, !dbg !783
  %25 = and i64 %24, %23, !dbg !783
  %26 = icmp eq i64 %25, 0, !dbg !783
  %27 = icmp ne i64 %_msret, 0, !dbg !783
  %_msprop_icmp16 = and i1 %27, %26, !dbg !783
  br i1 %_msprop_icmp16, label %28, label %29, !dbg !785, !prof !92

; <label>:28:                                     ; preds = %if.end3
  store i32 %22, i32* @__msan_origin_tls, align 4, !dbg !785
  call void @__msan_warning_noreturn() #4, !dbg !785
  call void asm sideeffect "", ""() #4, !dbg !785
  unreachable, !dbg !785

; <label>:29:                                     ; preds = %if.end3
  %cmp4 = icmp eq i8* %call, null, !dbg !783
  br i1 %cmp4, label %return, label %if.end6, !dbg !785

if.end6:                                          ; preds = %29
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !786
  store i32 %22, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !786
  store i32 0, i32* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i32*), align 8, !dbg !786
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !786
  store i32 %5, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !786
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !786
  %call7 = call i8* @mem_memset(i8* nonnull %call, i32 0, i64 %mul) #4, !dbg !786
  br label %return, !dbg !787

return:                                           ; preds = %29, %21, %10, %if.end6
  %_msphi_s = phi i64 [ %_msret, %if.end6 ], [ 0, %10 ], [ 0, %21 ], [ 0, %29 ], !dbg !788
  %_msphi_o = phi i32 [ %22, %if.end6 ], [ 0, %10 ], [ 0, %21 ], [ 0, %29 ], !dbg !788
  %retval.0 = phi i8* [ %call, %if.end6 ], [ null, %10 ], [ null, %21 ], [ null, %29 ], !dbg !788
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !789
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !789
  ret i8* %retval.0, !dbg !789
}

declare dso_local i8* @mem_memset(i8*, i32, i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @extract_alloc(i64 %word) unnamed_addr #0 !dbg !790 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !795
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !795
  call void @llvm.dbg.value(metadata i64 %word, metadata !794, metadata !DIExpression()), !dbg !795
  %2 = and i64 %0, 1, !dbg !796
  %and = and i64 %word, 1, !dbg !796
  %3 = xor i64 %2, -1, !dbg !797
  %4 = and i64 %and, %3, !dbg !797
  %5 = icmp eq i64 %4, 0, !dbg !797
  %6 = icmp ne i64 %2, 0, !dbg !797
  %_msprop_icmp = and i1 %6, %5, !dbg !797
  %tobool = icmp ne i64 %and, 0, !dbg !797
  store i1 %_msprop_icmp, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !798
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !798
  ret i1 %tobool, !dbg !798
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i32 @findlist(i64 %size) unnamed_addr #0 !dbg !799 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !806
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !806
  call void @llvm.dbg.value(metadata i64 %size, metadata !803, metadata !DIExpression()), !dbg !806
  %2 = xor i64 %size, 16, !dbg !807
  %3 = xor i64 %0, -1, !dbg !807
  %4 = and i64 %2, %3, !dbg !807
  %5 = icmp eq i64 %4, 0, !dbg !807
  %6 = icmp ne i64 %0, 0, !dbg !807
  %_msprop_icmp = and i1 %6, %5, !dbg !807
  br i1 %_msprop_icmp, label %7, label %8, !dbg !809, !prof !92

; <label>:7:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !809
  call void @__msan_warning_noreturn() #4, !dbg !809
  call void asm sideeffect "", ""() #4, !dbg !809
  unreachable, !dbg !809

; <label>:8:                                      ; preds = %entry
  %cmp = icmp eq i64 %size, 16, !dbg !807
  br i1 %cmp, label %return, label %while.cond.preheader, !dbg !809

while.cond.preheader:                             ; preds = %8
  br label %while.cond, !dbg !810

while.cond:                                       ; preds = %while.cond.preheader, %15
  %_msphi_s7 = phi i64 [ %9, %15 ], [ 0, %while.cond.preheader ], !dbg !811
  %block_size.0 = phi i64 [ %shl, %15 ], [ 32, %while.cond.preheader ], !dbg !811
  %i.0 = phi i32 [ %inc, %15 ], [ 1, %while.cond.preheader ], !dbg !811
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !805, metadata !DIExpression()), !dbg !813
  call void @llvm.dbg.value(metadata i64 %block_size.0, metadata !804, metadata !DIExpression()), !dbg !814
  %9 = shl i64 %_msphi_s7, 1, !dbg !810
  %shl = shl i64 %block_size.0, 1, !dbg !810
  %_msprop = or i64 %9, %0, !dbg !815
  %10 = icmp ne i64 %_msprop, 0, !dbg !815
  %11 = icmp ult i32 %i.0, 14, !dbg !816
  %12 = and i1 %10, %11, !dbg !817
  call void @llvm.dbg.value(metadata i64 %shl, metadata !804, metadata !DIExpression()), !dbg !814
  br i1 %12, label %13, label %15, !dbg !818, !prof !92

; <label>:13:                                     ; preds = %while.cond
  %14 = select i1 %6, i32 %1, i32 0, !dbg !815
  store i32 %14, i32* @__msan_origin_tls, align 4, !dbg !818
  call void @__msan_warning_noreturn() #4, !dbg !818
  call void asm sideeffect "", ""() #4, !dbg !818
  unreachable, !dbg !818

; <label>:15:                                     ; preds = %while.cond
  %inc = add nuw nsw i32 %i.0, 1, !dbg !819
  call void @llvm.dbg.value(metadata i32 %inc, metadata !805, metadata !DIExpression()), !dbg !813
  %cmp1 = icmp ult i64 %shl, %size, !dbg !815
  %16 = and i1 %cmp1, %11, !dbg !817
  br i1 %16, label %while.cond, label %return.loopexit, !dbg !818, !llvm.loop !820

return.loopexit:                                  ; preds = %15
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !805, metadata !DIExpression()), !dbg !813
  br label %return, !dbg !822

return:                                           ; preds = %return.loopexit, %8
  %retval.0 = phi i32 [ 0, %8 ], [ %i.0, %return.loopexit ], !dbg !823
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !822
  store i32 0, i32* @__msan_retval_origin_tls, align 4, !dbg !822
  ret i32 %retval.0, !dbg !822
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @set_pointer(%struct.block* nocapture %block, %struct.block* %prev_block) unnamed_addr #0 !dbg !824 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !830
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !830
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !830
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !830
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !828, metadata !DIExpression()), !dbg !830
  call void @llvm.dbg.value(metadata %struct.block* %prev_block, metadata !829, metadata !DIExpression()), !dbg !831
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !832
  %call = call fastcc zeroext i1 @ifmini(%struct.block* %block), !dbg !832
  %_msret = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !834
  br i1 %_msret, label %4, label %6, !dbg !834, !prof !92

; <label>:4:                                      ; preds = %entry
  %5 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !834
  store i32 %5, i32* @__msan_origin_tls, align 4, !dbg !834
  call void @__msan_warning_noreturn() #4, !dbg !834
  call void asm sideeffect "", ""() #4, !dbg !834
  unreachable, !dbg !834

; <label>:6:                                      ; preds = %entry
  br i1 %call, label %if.then, label %if.else, !dbg !834

if.then:                                          ; preds = %6
  %7 = shl i64 %0, 1, !dbg !835
  %8 = and i64 %7, -16, !dbg !837
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !838
  %_mscmp6 = icmp eq i64 %2, 0, !dbg !838
  br i1 %_mscmp6, label %10, label %9, !dbg !838, !prof !120

; <label>:9:                                      ; preds = %if.then
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !838
  call void @__msan_warning_noreturn() #4, !dbg !838
  call void asm sideeffect "", ""() #4, !dbg !838
  unreachable, !dbg !838

; <label>:10:                                     ; preds = %if.then
  %11 = ptrtoint %struct.block* %prev_block to i64, !dbg !839
  %shl = shl i64 %11, 1, !dbg !835
  %and = and i64 %shl, -16, !dbg !837
  %12 = load i64, i64* %header, align 8, !dbg !838, !tbaa !171
  %13 = ptrtoint %struct.block* %block to i64, !dbg !840
  %14 = xor i64 %13, 87960930222080, !dbg !840
  %15 = inttoptr i64 %14 to i64*, !dbg !840
  %16 = add i64 %14, 17592186044416, !dbg !840
  %17 = inttoptr i64 %16 to i32*, !dbg !840
  %_msld = load i64, i64* %15, align 8, !dbg !840
  %18 = load i32, i32* %17, align 8, !dbg !840
  %19 = and i64 %_msld, 15, !dbg !840
  %and1 = and i64 %12, 15, !dbg !840
  %20 = or i64 %19, %8, !dbg !841
  %21 = icmp eq i64 %8, 0, !dbg !841
  %22 = select i1 %21, i32 %18, i32 %1, !dbg !841
  %add = or i64 %and1, %and, !dbg !841
  br i1 false, label %23, label %24, !dbg !842, !prof !92

; <label>:23:                                     ; preds = %10
  unreachable, !dbg !842

; <label>:24:                                     ; preds = %10
  store i64 %20, i64* %15, align 8, !dbg !842
  %_mscmp9 = icmp eq i64 %20, 0, !dbg !842
  br i1 %_mscmp9, label %31, label %25, !dbg !842, !prof !120

; <label>:25:                                     ; preds = %24
  %26 = call i32 @__msan_chain_origin(i32 %22) #4, !dbg !842
  %27 = zext i32 %26 to i64, !dbg !842
  %28 = shl nuw i64 %27, 32, !dbg !842
  %29 = or i64 %28, %27, !dbg !842
  %30 = inttoptr i64 %16 to i64*, !dbg !842
  store i64 %29, i64* %30, align 8, !dbg !842
  br label %31, !dbg !842

; <label>:31:                                     ; preds = %24, %25
  store i64 %add, i64* %header, align 8, !dbg !842, !tbaa !171
  br label %if.end, !dbg !843

if.else:                                          ; preds = %6
  %prev = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 1, !dbg !844
  %_mscmp8 = icmp eq i64 %2, 0, !dbg !846
  br i1 %_mscmp8, label %33, label %32, !dbg !846, !prof !120

; <label>:32:                                     ; preds = %if.else
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !846
  call void @__msan_warning_noreturn() #4, !dbg !846
  call void asm sideeffect "", ""() #4, !dbg !846
  unreachable, !dbg !846

; <label>:33:                                     ; preds = %if.else
  %34 = ptrtoint %struct.block** %prev to i64, !dbg !846
  %35 = xor i64 %34, 87960930222080, !dbg !846
  %36 = inttoptr i64 %35 to i64*, !dbg !846
  store i64 %0, i64* %36, align 8, !dbg !846
  %_mscmp10 = icmp eq i64 %0, 0, !dbg !846
  br i1 %_mscmp10, label %44, label %37, !dbg !846, !prof !120

; <label>:37:                                     ; preds = %33
  %38 = add i64 %35, 17592186044416, !dbg !846
  %39 = call i32 @__msan_chain_origin(i32 %1) #4, !dbg !846
  %40 = zext i32 %39 to i64, !dbg !846
  %41 = shl nuw i64 %40, 32, !dbg !846
  %42 = or i64 %41, %40, !dbg !846
  %43 = inttoptr i64 %38 to i64*, !dbg !846
  store i64 %42, i64* %43, align 8, !dbg !846
  br label %44, !dbg !846

; <label>:44:                                     ; preds = %33, %37
  store %struct.block* %prev_block, %struct.block** %prev, align 8, !dbg !846, !tbaa !389
  br label %if.end

if.end:                                           ; preds = %44, %31
  ret void, !dbg !847
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i64* @header_to_footer(%struct.block* readonly %block) unnamed_addr #0 !dbg !848 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !853
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !853
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !852, metadata !DIExpression()), !dbg !853
  %memory = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, !dbg !854
  %arraydecay = bitcast %union.mem_t* %memory to i8*, !dbg !855
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !856
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !856
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !857
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !857
  %_msprop = or i64 %_msret, %0, !dbg !857
  %3 = icmp eq i64 %_msret, 0, !dbg !857
  %4 = select i1 %3, i32 %1, i32 %2, !dbg !857
  %add.ptr = getelementptr inbounds i8, i8* %arraydecay, i64 %call, !dbg !857
  %add.ptr1 = getelementptr inbounds i8, i8* %add.ptr, i64 -16, !dbg !858
  %5 = bitcast i8* %add.ptr1 to i64*, !dbg !859
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !860
  store i32 %4, i32* @__msan_retval_origin_tls, align 4, !dbg !860
  ret i64* %5, !dbg !860
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @insert_free_block(%struct.block* %block) unnamed_addr #0 !dbg !861 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !869
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !869
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !863, metadata !DIExpression()), !dbg !869
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !870
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !870
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !871
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !871
  call void @llvm.dbg.value(metadata i64 %call, metadata !864, metadata !DIExpression()), !dbg !871
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !872
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !872
  store i32 0, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !872
  %call1 = call fastcc i32 @findlist(i64 %call), !dbg !872
  %_msret43 = load i32, i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8, !dbg !873
  call void @llvm.dbg.value(metadata i32 %call1, metadata !865, metadata !DIExpression()), !dbg !873
  %idxprom = sext i32 %call1 to i64, !dbg !874
  %3 = icmp eq i32 %_msret43, 0, !dbg !874
  %arrayidx = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %idxprom, !dbg !874
  br i1 %3, label %6, label %4, !dbg !874, !prof !120

; <label>:4:                                      ; preds = %entry
  %5 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !873
  store i32 %5, i32* @__msan_origin_tls, align 4, !dbg !874
  call void @__msan_warning_noreturn() #4, !dbg !874
  call void asm sideeffect "", ""() #4, !dbg !874
  unreachable, !dbg !874

; <label>:6:                                      ; preds = %entry
  %7 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !874, !tbaa !94
  %8 = ptrtoint %struct.block** %arrayidx to i64, !dbg !875
  %9 = xor i64 %8, 87960930222080, !dbg !875
  %10 = inttoptr i64 %9 to i64*, !dbg !875
  %11 = add i64 %9, 17592186044416, !dbg !875
  %12 = inttoptr i64 %11 to i32*, !dbg !875
  %_msld = load i64, i64* %10, align 8, !dbg !875
  %13 = load i32, i32* %12, align 8, !dbg !875
  %14 = ptrtoint %struct.block* %7 to i64, !dbg !875
  %15 = xor i64 %_msld, -1, !dbg !875
  %16 = and i64 %15, %14, !dbg !875
  %17 = icmp eq i64 %16, 0, !dbg !875
  %18 = icmp ne i64 %_msld, 0, !dbg !875
  %_msprop_icmp = and i1 %18, %17, !dbg !875
  br i1 %_msprop_icmp, label %19, label %20, !dbg !876, !prof !92

; <label>:19:                                     ; preds = %6
  store i32 %13, i32* @__msan_origin_tls, align 4, !dbg !876
  call void @__msan_warning_noreturn() #4, !dbg !876
  call void asm sideeffect "", ""() #4, !dbg !876
  unreachable, !dbg !876

; <label>:20:                                     ; preds = %6
  %cmp = icmp eq %struct.block* %7, null, !dbg !875
  br i1 %cmp, label %if.then, label %if.else, !dbg !876

if.then:                                          ; preds = %20
  br i1 false, label %21, label %22, !dbg !877, !prof !92

; <label>:21:                                     ; preds = %if.then
  unreachable, !dbg !877

; <label>:22:                                     ; preds = %if.then
  store i64 %0, i64* %10, align 8, !dbg !877
  %_mscmp61 = icmp ne i64 %0, 0, !dbg !877
  br i1 %_mscmp61, label %23, label %29, !dbg !877, !prof !92

; <label>:23:                                     ; preds = %22
  %24 = call i32 @__msan_chain_origin(i32 %1) #4, !dbg !877
  %25 = zext i32 %24 to i64, !dbg !877
  %26 = shl nuw i64 %25, 32, !dbg !877
  %27 = or i64 %26, %25, !dbg !877
  %28 = inttoptr i64 %11 to i64*, !dbg !877
  store i64 %27, i64* %28, align 8, !dbg !877
  br label %29, !dbg !877

; <label>:29:                                     ; preds = %22, %23
  store %struct.block* %block, %struct.block** %arrayidx, align 8, !dbg !877, !tbaa !94
  %next = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 0, !dbg !879
  br i1 %_mscmp61, label %30, label %31, !dbg !880, !prof !92

; <label>:30:                                     ; preds = %29
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !880
  call void @__msan_warning_noreturn() #4, !dbg !880
  call void asm sideeffect "", ""() #4, !dbg !880
  unreachable, !dbg !880

; <label>:31:                                     ; preds = %29
  %32 = ptrtoint %struct.block** %next to i64, !dbg !880
  %33 = xor i64 %32, 87960930222080, !dbg !880
  %34 = inttoptr i64 %33 to i64*, !dbg !880
  store i64 0, i64* %34, align 8, !dbg !880
  br i1 false, label %35, label %36, !dbg !880, !prof !92

; <label>:35:                                     ; preds = %31
  br label %36, !dbg !880

; <label>:36:                                     ; preds = %31, %35
  store %struct.block* %block, %struct.block** %next, align 8, !dbg !880, !tbaa !389
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !881
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !881
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !881
  store i32 %1, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !881
  call fastcc void @set_pointer(%struct.block* %block, %struct.block* %block), !dbg !881
  br label %if.end28, !dbg !882

if.else:                                          ; preds = %20
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !883
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !883
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !883
  %call8 = call fastcc zeroext i1 @ifmini(%struct.block* %block), !dbg !883
  %_msret45 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !885
  br i1 %_msret45, label %37, label %39, !dbg !885, !prof !92

; <label>:37:                                     ; preds = %if.else
  %38 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !885
  store i32 %38, i32* @__msan_origin_tls, align 4, !dbg !885
  call void @__msan_warning_noreturn() #4, !dbg !885
  call void asm sideeffect "", ""() #4, !dbg !885
  unreachable, !dbg !885

; <label>:39:                                     ; preds = %if.else
  br i1 %call8, label %if.then9, label %if.else13, !dbg !885

if.then9:                                         ; preds = %39
  br i1 %18, label %40, label %41, !dbg !886, !prof !92

; <label>:40:                                     ; preds = %if.then9
  store i32 %13, i32* @__msan_origin_tls, align 4, !dbg !886
  call void @__msan_warning_noreturn() #4, !dbg !886
  call void asm sideeffect "", ""() #4, !dbg !886
  unreachable, !dbg !886

; <label>:41:                                     ; preds = %if.then9
  %header = getelementptr inbounds %struct.block, %struct.block* %7, i64 0, i32 0, !dbg !886
  %42 = load i64, i64* %header, align 8, !dbg !886, !tbaa !171
  %43 = ptrtoint %struct.block* %7 to i64, !dbg !888
  %44 = xor i64 %43, 87960930222080, !dbg !888
  %45 = inttoptr i64 %44 to i64*, !dbg !888
  %46 = add i64 %44, 17592186044416, !dbg !888
  %47 = inttoptr i64 %46 to i32*, !dbg !888
  %_msld46 = load i64, i64* %45, align 8, !dbg !888
  %48 = load i32, i32* %47, align 8, !dbg !888
  store i64 %_msld46, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !888
  store i32 %48, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !888
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !888
  %call12 = call fastcc i64 @extract_size(i64 %42), !dbg !888
  %_msret47 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !889
  %49 = lshr i64 %_msret47, 1, !dbg !889
  %shr = lshr i64 %call12, 1, !dbg !889
  %50 = inttoptr i64 %shr to %struct.block*, !dbg !890
  call void @llvm.dbg.value(metadata %struct.block* %50, metadata !866, metadata !DIExpression()), !dbg !891
  br label %if.end, !dbg !892

if.else13:                                        ; preds = %39
  %prev = getelementptr inbounds %struct.block, %struct.block* %7, i64 0, i32 1, i32 0, i32 1, !dbg !893
  br i1 %18, label %51, label %52, !dbg !893, !prof !92

; <label>:51:                                     ; preds = %if.else13
  store i32 %13, i32* @__msan_origin_tls, align 4, !dbg !893
  call void @__msan_warning_noreturn() #4, !dbg !893
  call void asm sideeffect "", ""() #4, !dbg !893
  unreachable, !dbg !893

; <label>:52:                                     ; preds = %if.else13
  %53 = load %struct.block*, %struct.block** %prev, align 8, !dbg !893, !tbaa !389
  %54 = ptrtoint %struct.block** %prev to i64, !dbg !891
  %55 = xor i64 %54, 87960930222080, !dbg !891
  %56 = inttoptr i64 %55 to i64*, !dbg !891
  %57 = add i64 %55, 17592186044416, !dbg !891
  %58 = inttoptr i64 %57 to i32*, !dbg !891
  %_msld50 = load i64, i64* %56, align 8, !dbg !891
  call void @llvm.dbg.value(metadata %struct.block* %53, metadata !866, metadata !DIExpression()), !dbg !891
  br label %if.end

if.end:                                           ; preds = %52, %41
  %_msphi_s = phi i64 [ %49, %41 ], [ %_msld50, %52 ], !dbg !895
  %_msphi_o.in = phi i32* [ @__msan_retval_origin_tls, %41 ], [ %58, %52 ]
  %prev_block.0 = phi %struct.block* [ %50, %41 ], [ %53, %52 ], !dbg !895
  %_msphi_o = load i32, i32* %_msphi_o.in, align 4, !dbg !895
  call void @llvm.dbg.value(metadata %struct.block* %prev_block.0, metadata !866, metadata !DIExpression()), !dbg !891
  br i1 false, label %59, label %60, !dbg !896, !prof !92

; <label>:59:                                     ; preds = %if.end
  unreachable, !dbg !896

; <label>:60:                                     ; preds = %if.end
  %61 = bitcast %struct.block** %arrayidx to i64*, !dbg !896
  %62 = load i64, i64* %61, align 8, !dbg !896, !tbaa !94
  %63 = ptrtoint %struct.block** %arrayidx to i64, !dbg !897
  %64 = xor i64 %63, 87960930222080, !dbg !897
  %65 = inttoptr i64 %64 to i64*, !dbg !897
  %66 = add i64 %64, 17592186044416, !dbg !897
  %67 = inttoptr i64 %66 to i32*, !dbg !897
  %_msld48 = load i64, i64* %65, align 8, !dbg !897
  %68 = load i32, i32* %67, align 8, !dbg !897
  %memory20 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, !dbg !897
  %69 = bitcast %union.mem_t* %memory20 to i64*, !dbg !898
  %_mscmp57 = icmp eq i64 %0, 0, !dbg !898
  br i1 %_mscmp57, label %71, label %70, !dbg !898, !prof !120

; <label>:70:                                     ; preds = %60
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !898
  call void @__msan_warning_noreturn() #4, !dbg !898
  call void asm sideeffect "", ""() #4, !dbg !898
  unreachable, !dbg !898

; <label>:71:                                     ; preds = %60
  %72 = ptrtoint %union.mem_t* %memory20 to i64, !dbg !898
  %73 = xor i64 %72, 87960930222080, !dbg !898
  %74 = inttoptr i64 %73 to i64*, !dbg !898
  store i64 %_msld48, i64* %74, align 8, !dbg !898
  %_mscmp63 = icmp eq i64 %_msld48, 0, !dbg !898
  br i1 %_mscmp63, label %82, label %75, !dbg !898, !prof !120

; <label>:75:                                     ; preds = %71
  %76 = add i64 %73, 17592186044416, !dbg !898
  %77 = call i32 @__msan_chain_origin(i32 %68) #4, !dbg !898
  %78 = zext i32 %77 to i64, !dbg !898
  %79 = shl nuw i64 %78, 32, !dbg !898
  %80 = or i64 %79, %78, !dbg !898
  %81 = inttoptr i64 %76 to i64*, !dbg !898
  store i64 %80, i64* %81, align 8, !dbg !898
  br label %82, !dbg !898

; <label>:82:                                     ; preds = %71, %75
  store i64 %62, i64* %69, align 8, !dbg !898, !tbaa !389
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !899
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !899
  store i64 %_msphi_s, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !899
  store i32 %_msphi_o, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !899
  call fastcc void @set_pointer(%struct.block* %block, %struct.block* %prev_block.0), !dbg !899
  %next25 = getelementptr inbounds %struct.block, %struct.block* %prev_block.0, i64 0, i32 1, i32 0, i32 0, !dbg !900
  %_mscmp58 = icmp eq i64 %_msphi_s, 0, !dbg !901
  br i1 %_mscmp58, label %84, label %83, !dbg !901, !prof !120

; <label>:83:                                     ; preds = %82
  store i32 %_msphi_o, i32* @__msan_origin_tls, align 4, !dbg !901
  call void @__msan_warning_noreturn() #4, !dbg !901
  call void asm sideeffect "", ""() #4, !dbg !901
  unreachable, !dbg !901

; <label>:84:                                     ; preds = %82
  %85 = ptrtoint %struct.block** %next25 to i64, !dbg !901
  %86 = xor i64 %85, 87960930222080, !dbg !901
  %87 = inttoptr i64 %86 to i64*, !dbg !901
  store i64 0, i64* %87, align 8, !dbg !901
  br i1 false, label %88, label %89, !dbg !901, !prof !92

; <label>:88:                                     ; preds = %84
  br label %89, !dbg !901

; <label>:89:                                     ; preds = %84, %88
  store %struct.block* %block, %struct.block** %next25, align 8, !dbg !901, !tbaa !389
  br i1 false, label %90, label %91, !dbg !902, !prof !92

; <label>:90:                                     ; preds = %89
  unreachable, !dbg !902

; <label>:91:                                     ; preds = %89
  %92 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !902, !tbaa !94
  %_msld49 = load i64, i64* %10, align 8, !dbg !903
  %93 = load i32, i32* %12, align 8, !dbg !903
  store i64 %_msld49, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !903
  store i32 %93, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !903
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !903
  store i32 %1, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !903
  call fastcc void @set_pointer(%struct.block* %92, %struct.block* %block), !dbg !903
  br label %if.end28

if.end28:                                         ; preds = %91, %36
  ret void, !dbg !904
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_prev(%struct.block* readonly %block) unnamed_addr #0 !dbg !905 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !911
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !911
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !907, metadata !DIExpression()), !dbg !911
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !912
  %call = call fastcc zeroext i1 @ifpremini(%struct.block* %block), !dbg !912
  %_msret = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !913
  br i1 %_msret, label %2, label %4, !dbg !913, !prof !92

; <label>:2:                                      ; preds = %entry
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !913
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !913
  call void @__msan_warning_noreturn() #4, !dbg !913
  call void asm sideeffect "", ""() #4, !dbg !913
  unreachable, !dbg !913

; <label>:4:                                      ; preds = %entry
  br i1 %call, label %if.then, label %if.else, !dbg !913

if.then:                                          ; preds = %4
  %add.ptr = getelementptr inbounds %struct.block, %struct.block* %block, i64 -1, i32 1, !dbg !914
  %5 = bitcast %union.mem_t* %add.ptr to %struct.block*, !dbg !916
  br label %return, !dbg !917

if.else:                                          ; preds = %4
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !918
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !918
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !918
  %call1 = call fastcc i64* @find_prev_footer(%struct.block* %block), !dbg !918
  %_msret7 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !919
  %6 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !919
  call void @llvm.dbg.value(metadata i64* %call1, metadata !908, metadata !DIExpression()), !dbg !919
  %_mscmp10 = icmp eq i64 %_msret7, 0, !dbg !920
  br i1 %_mscmp10, label %8, label %7, !dbg !920, !prof !120

; <label>:7:                                      ; preds = %if.else
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !920
  call void @__msan_warning_noreturn() #4, !dbg !920
  call void asm sideeffect "", ""() #4, !dbg !920
  unreachable, !dbg !920

; <label>:8:                                      ; preds = %if.else
  %9 = load i64, i64* %call1, align 8, !dbg !920, !tbaa !210
  %10 = ptrtoint i64* %call1 to i64, !dbg !922
  %11 = xor i64 %10, 87960930222080, !dbg !922
  %12 = inttoptr i64 %11 to i64*, !dbg !922
  %13 = add i64 %11, 17592186044416, !dbg !922
  %14 = inttoptr i64 %13 to i32*, !dbg !922
  %_msld = load i64, i64* %12, align 8, !dbg !922
  %15 = load i32, i32* %14, align 8, !dbg !922
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !922
  store i32 %15, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !922
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !922
  %call2 = call fastcc i64 @extract_size(i64 %9), !dbg !922
  %_msret8 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !923
  %16 = xor i64 %_msret8, -1, !dbg !923
  %17 = and i64 %call2, %16, !dbg !923
  %18 = icmp eq i64 %17, 0, !dbg !923
  %19 = icmp ne i64 %_msret8, 0, !dbg !923
  %_msprop_icmp = and i1 %19, %18, !dbg !923
  br i1 %_msprop_icmp, label %20, label %22, !dbg !924, !prof !92

; <label>:20:                                     ; preds = %8
  %21 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !923
  store i32 %21, i32* @__msan_origin_tls, align 4, !dbg !924
  call void @__msan_warning_noreturn() #4, !dbg !924
  call void asm sideeffect "", ""() #4, !dbg !924
  unreachable, !dbg !924

; <label>:22:                                     ; preds = %8
  %cmp = icmp eq i64 %call2, 0, !dbg !923
  br i1 %cmp, label %return, label %if.end, !dbg !924

if.end:                                           ; preds = %22
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !925
  store i32 %6, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !925
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !925
  %call4 = call fastcc %struct.block* @footer_to_header(i64* nonnull %call1), !dbg !925
  %_msret9 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !926
  %23 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !926
  br label %return, !dbg !926

return:                                           ; preds = %22, %if.end, %if.then
  %_msphi_s = phi i64 [ %0, %if.then ], [ %_msret9, %if.end ], [ 0, %22 ], !dbg !927
  %_msphi_o = phi i32 [ %1, %if.then ], [ %23, %if.end ], [ 0, %22 ], !dbg !927
  %retval.0 = phi %struct.block* [ %5, %if.then ], [ %call4, %if.end ], [ null, %22 ], !dbg !927
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !928
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !928
  ret %struct.block* %retval.0, !dbg !928
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i64* @find_prev_footer(%struct.block* readnone %block) unnamed_addr #0 !dbg !929 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !932
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !932
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !931, metadata !DIExpression()), !dbg !932
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !933
  %add.ptr = getelementptr inbounds i64, i64* %header, i64 -1, !dbg !934
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !935
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !935
  ret i64* %add.ptr, !dbg !935
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull %struct.block* @footer_to_header(i64* readonly %footer) unnamed_addr #0 !dbg !936 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !942
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !942
  call void @llvm.dbg.value(metadata i64* %footer, metadata !940, metadata !DIExpression()), !dbg !942
  %_mscmp = icmp eq i64 %0, 0, !dbg !943
  br i1 %_mscmp, label %3, label %2, !dbg !943, !prof !120

; <label>:2:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !943
  call void @__msan_warning_noreturn() #4, !dbg !943
  call void asm sideeffect "", ""() #4, !dbg !943
  unreachable, !dbg !943

; <label>:3:                                      ; preds = %entry
  %4 = load i64, i64* %footer, align 8, !dbg !943, !tbaa !210
  %5 = ptrtoint i64* %footer to i64, !dbg !944
  %6 = xor i64 %5, 87960930222080, !dbg !944
  %7 = inttoptr i64 %6 to i64*, !dbg !944
  %8 = add i64 %6, 17592186044416, !dbg !944
  %9 = inttoptr i64 %8 to i32*, !dbg !944
  %_msld = load i64, i64* %7, align 8, !dbg !944
  %10 = load i32, i32* %9, align 8, !dbg !944
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !944
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !944
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !944
  %call = call fastcc i64 @extract_size(i64 %4), !dbg !944
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !945
  %11 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !945
  call void @llvm.dbg.value(metadata i64 %call, metadata !941, metadata !DIExpression()), !dbg !945
  %add.ptr3 = getelementptr inbounds i64, i64* %footer, i64 1, !dbg !946
  %add.ptr = bitcast i64* %add.ptr3 to i8*, !dbg !946
  %12 = icmp eq i64 %_msret, 0, !dbg !947
  %idx.neg = sub i64 0, %call, !dbg !947
  %13 = select i1 %12, i32 %1, i32 %11, !dbg !947
  %add.ptr1 = getelementptr inbounds i8, i8* %add.ptr, i64 %idx.neg, !dbg !947
  %14 = bitcast i8* %add.ptr1 to %struct.block*, !dbg !948
  store i32 %13, i32* @__msan_retval_origin_tls, align 4, !dbg !949
  ret %struct.block* %14, !dbg !949
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

declare void @__msan_init() local_unnamed_addr

define internal void @msan.module_ctor() {
  tail call void @__msan_init()
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #5

declare i32 @__msan_chain_origin(i32)

declare i8* @__msan_memmove(i8*, i8*, i64)

declare i8* @__msan_memcpy(i8*, i8*, i64)

declare i8* @__msan_memset(i8*, i32, i64)

declare void @__msan_warning_noreturn()

declare void @__msan_maybe_warning_1(i8, i32)

declare void @__msan_maybe_store_origin_1(i8, i8*, i32)

declare void @__msan_maybe_warning_2(i16, i32)

declare void @__msan_maybe_store_origin_2(i16, i8*, i32)

declare void @__msan_maybe_warning_4(i32, i32)

declare void @__msan_maybe_store_origin_4(i32, i8*, i32)

declare void @__msan_maybe_warning_8(i64, i32)

declare void @__msan_maybe_store_origin_8(i64, i8*, i32)

declare void @__msan_set_alloca_origin4(i8*, i64, i8*, i64)

declare void @__msan_poison_stack(i8*, i64)

attributes #0 = { noinline nounwind sanitize_memory uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="true" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="true" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="true" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind }
attributes #5 = { argmemonly nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!68, !69, !70}
!llvm.ident = !{!71}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "heap_start", scope: !2, file: !3, line: 163, type: !6, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !34)
!3 = !DIFile(filename: "mm.c", directory: "/afs/andrew.cmu.edu/usr20/yuchenwu/private/18213/malloc-lab-Chibadaisuki")
!4 = !{}
!5 = !{!6, !30, !31, !32, !33, !11}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "block_t", file: !3, line: 139, baseType: !8)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "block", file: !3, line: 157, size: 192, elements: !9)
!9 = !{!10, !15}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "header", scope: !8, file: !3, line: 158, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "word_t", file: !3, line: 77, baseType: !12)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !13, line: 55, baseType: !14)
!13 = !DIFile(filename: "/usr/include/stdint.h", directory: "/afs/andrew.cmu.edu/usr20/yuchenwu/private/18213/malloc-lab-Chibadaisuki")
!14 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "memory", scope: !8, file: !3, line: 159, baseType: !16, size: 128, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "mem_t", file: !3, line: 155, baseType: !17)
!17 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !3, line: 152, size: 128, elements: !18)
!18 = !{!19, !25}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "node", scope: !17, file: !3, line: 153, baseType: !20, size: 128)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "link_t", file: !3, line: 147, baseType: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 144, size: 128, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !21, file: !3, line: 145, baseType: !6, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !21, file: !3, line: 146, baseType: !6, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !17, file: !3, line: 154, baseType: !26)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, elements: !28)
!27 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!28 = !{!29}
!29 = !DISubrange(count: 0)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!32 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!34 = !{!35, !40, !42, !44, !46, !50, !0, !55, !58, !60, !62, !64, !66}
!35 = !DIGlobalVariableExpression(var: !36, expr: !DIExpression(DW_OP_constu, 16, DW_OP_stack_value))
!36 = distinct !DIGlobalVariable(name: "dsize", scope: !2, file: !3, line: 83, type: !37, isLocal: true, isDefinition: true)
!37 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !38)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !39, line: 62, baseType: !14)
!39 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr20/yuchenwu/private/18213/malloc-lab-Chibadaisuki")
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression(DW_OP_constu, 16, DW_OP_stack_value))
!41 = distinct !DIGlobalVariable(name: "mini_block_size", scope: !2, file: !3, line: 89, type: !37, isLocal: true, isDefinition: true)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression(DW_OP_constu, 8, DW_OP_stack_value))
!43 = distinct !DIGlobalVariable(name: "wsize", scope: !2, file: !3, line: 80, type: !37, isLocal: true, isDefinition: true)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression(DW_OP_constu, 4096, DW_OP_stack_value))
!45 = distinct !DIGlobalVariable(name: "chunksize", scope: !2, file: !3, line: 95, type: !37, isLocal: true, isDefinition: true)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression(DW_OP_constu, 15, DW_OP_stack_value))
!47 = distinct !DIGlobalVariable(name: "segnum", scope: !2, file: !3, line: 130, type: !48, isLocal: true, isDefinition: true)
!48 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !49)
!49 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(name: "list_head", scope: !2, file: !3, line: 165, type: !52, isLocal: true, isDefinition: true)
!52 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 960, elements: !53)
!53 = !{!54}
!54 = !DISubrange(count: 15)
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!56 = distinct !DIGlobalVariable(name: "alloc_mask", scope: !2, file: !3, line: 101, type: !57, isLocal: true, isDefinition: true)
!57 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression(DW_OP_constu, 2, DW_OP_stack_value))
!59 = distinct !DIGlobalVariable(name: "pre_alloc_mask", scope: !2, file: !3, line: 107, type: !57, isLocal: true, isDefinition: true)
!60 = !DIGlobalVariableExpression(var: !61, expr: !DIExpression(DW_OP_constu, 4, DW_OP_stack_value))
!61 = distinct !DIGlobalVariable(name: "mini_mask", scope: !2, file: !3, line: 113, type: !57, isLocal: true, isDefinition: true)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression(DW_OP_constu, 8, DW_OP_stack_value))
!63 = distinct !DIGlobalVariable(name: "pre_mini_mask", scope: !2, file: !3, line: 119, type: !57, isLocal: true, isDefinition: true)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression(DW_OP_constu, 32, DW_OP_stack_value))
!65 = distinct !DIGlobalVariable(name: "min_block_size", scope: !2, file: !3, line: 86, type: !37, isLocal: true, isDefinition: true)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_stack_value))
!67 = distinct !DIGlobalVariable(name: "size_mask", scope: !2, file: !3, line: 125, type: !57, isLocal: true, isDefinition: true)
!68 = !{i32 2, !"Dwarf Version", i32 4}
!69 = !{i32 2, !"Debug Info Version", i32 3}
!70 = !{i32 1, !"wchar_size", i32 4}
!71 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!72 = distinct !DISubprogram(name: "mm_checkheap", scope: !3, file: !3, line: 759, type: !73, isLocal: false, isDefinition: true, scopeLine: 759, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !75)
!73 = !DISubroutineType(types: !74)
!74 = !{!32, !49}
!75 = !{!76, !77, !78, !79, !81}
!76 = !DILocalVariable(name: "line", arg: 1, scope: !72, file: !3, line: 759, type: !49)
!77 = !DILocalVariable(name: "prologue", scope: !72, file: !3, line: 760, type: !6)
!78 = !DILocalVariable(name: "block", scope: !72, file: !3, line: 761, type: !6)
!79 = !DILocalVariable(name: "free_counts", scope: !72, file: !3, line: 762, type: !80)
!80 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!81 = !DILocalVariable(name: "block_prev", scope: !72, file: !3, line: 763, type: !6)
!82 = !DILocation(line: 759, column: 23, scope: !72)
!83 = !DILocation(line: 760, column: 36, scope: !72)
!84 = !DILocation(line: 760, column: 25, scope: !72)
!85 = !DILocation(line: 760, column: 14, scope: !72)
!86 = !DILocation(line: 762, column: 10, scope: !72)
!87 = !DILocation(line: 763, column: 14, scope: !72)
!88 = !DILocation(line: 764, column: 10, scope: !89)
!89 = distinct !DILexicalBlock(scope: !72, file: !3, line: 764, column: 9)
!90 = !DILocation(line: 764, column: 29, scope: !89)
!91 = !DILocation(line: 764, column: 35, scope: !89)
!92 = !{!"branch_weights", i32 1, i32 1000}
!93 = !DILocation(line: 761, column: 22, scope: !72)
!94 = !{!95, !95, i64 0}
!95 = !{!"any pointer", !96, i64 0}
!96 = !{!"omnipotent char", !97, i64 0}
!97 = !{!"Simple C/C++ TBAA"}
!98 = !DILocation(line: 761, column: 14, scope: !72)
!99 = !DILocation(line: 764, column: 40, scope: !89)
!100 = !DILocation(line: 764, column: 9, scope: !72)
!101 = !DILocation(line: 770, column: 11, scope: !72)
!102 = !DILocation(line: 770, column: 27, scope: !72)
!103 = !DILocation(line: 770, column: 5, scope: !72)
!104 = !DILocation(line: 773, column: 30, scope: !105)
!105 = distinct !DILexicalBlock(scope: !106, file: !3, line: 773, column: 13)
!106 = distinct !DILexicalBlock(scope: !72, file: !3, line: 771, column: 5)
!107 = !DILocation(line: 766, column: 9, scope: !108)
!108 = distinct !DILexicalBlock(scope: !89, file: !3, line: 765, column: 5)
!109 = !DILocation(line: 767, column: 9, scope: !108)
!110 = !DILocation(line: 773, column: 39, scope: !105)
!111 = !DILocation(line: 773, column: 13, scope: !106)
!112 = !DILocation(line: 775, column: 13, scope: !113)
!113 = distinct !DILexicalBlock(scope: !105, file: !3, line: 774, column: 9)
!114 = !DILocation(line: 776, column: 13, scope: !113)
!115 = !DILocation(line: 786, column: 32, scope: !116)
!116 = distinct !DILexicalBlock(scope: !106, file: !3, line: 786, column: 13)
!117 = !DILocation(line: 786, column: 21, scope: !116)
!118 = !DILocation(line: 786, column: 19, scope: !116)
!119 = !DILocation(line: 786, column: 46, scope: !116)
!120 = !{!"branch_weights", i32 1000, i32 1}
!121 = !DILocation(line: 786, column: 68, scope: !116)
!122 = !DILocation(line: 786, column: 57, scope: !116)
!123 = !DILocation(line: 786, column: 55, scope: !116)
!124 = !DILocation(line: 786, column: 13, scope: !106)
!125 = !DILocation(line: 788, column: 13, scope: !126)
!126 = distinct !DILexicalBlock(scope: !116, file: !3, line: 787, column: 9)
!127 = !DILocation(line: 789, column: 13, scope: !126)
!128 = !DILocation(line: 794, column: 13, scope: !129)
!129 = distinct !DILexicalBlock(scope: !106, file: !3, line: 794, column: 13)
!130 = !DILocation(line: 794, column: 29, scope: !129)
!131 = !DILocation(line: 794, column: 13, scope: !106)
!132 = !DILocation(line: 796, column: 13, scope: !133)
!133 = distinct !DILexicalBlock(scope: !129, file: !3, line: 795, column: 9)
!134 = !DILocation(line: 797, column: 13, scope: !133)
!135 = !DILocation(line: 802, column: 13, scope: !136)
!136 = distinct !DILexicalBlock(scope: !106, file: !3, line: 802, column: 13)
!137 = !DILocation(line: 802, column: 38, scope: !136)
!138 = !DILocation(line: 802, column: 24, scope: !136)
!139 = !DILocation(line: 802, column: 50, scope: !136)
!140 = !DILocation(line: 802, column: 71, scope: !136)
!141 = !DILocation(line: 802, column: 13, scope: !106)
!142 = !DILocation(line: 804, column: 26, scope: !143)
!143 = distinct !DILexicalBlock(scope: !144, file: !3, line: 804, column: 17)
!144 = distinct !DILexicalBlock(scope: !136, file: !3, line: 803, column: 9)
!145 = !DILocation(line: 804, column: 23, scope: !143)
!146 = !DILocation(line: 804, column: 17, scope: !144)
!147 = !DILocation(line: 806, column: 17, scope: !148)
!148 = distinct !DILexicalBlock(scope: !143, file: !3, line: 805, column: 13)
!149 = !DILocation(line: 807, column: 17, scope: !148)
!150 = !DILocation(line: 812, column: 14, scope: !151)
!151 = distinct !DILexicalBlock(scope: !106, file: !3, line: 812, column: 13)
!152 = !DILocation(line: 812, column: 36, scope: !151)
!153 = !DILocation(line: 812, column: 40, scope: !151)
!154 = !DILocation(line: 812, column: 13, scope: !106)
!155 = !DILocation(line: 814, column: 13, scope: !156)
!156 = distinct !DILexicalBlock(scope: !151, file: !3, line: 813, column: 9)
!157 = !DILocation(line: 815, column: 13, scope: !156)
!158 = !DILocation(line: 818, column: 17, scope: !106)
!159 = distinct !{!159, !103, !160}
!160 = !DILocation(line: 819, column: 5, scope: !72)
!161 = !DILocation(line: 823, column: 1, scope: !72)
!162 = !DILocation(line: 0, scope: !72)
!163 = distinct !DISubprogram(name: "get_size", scope: !3, file: !3, line: 276, type: !164, isLocal: true, isDefinition: true, scopeLine: 276, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !166)
!164 = !DISubroutineType(types: !165)
!165 = !{!38, !6}
!166 = !{!167}
!167 = !DILocalVariable(name: "block", arg: 1, scope: !163, file: !3, line: 276, type: !6)
!168 = !DILocation(line: 276, column: 33, scope: !163)
!169 = !DILocation(line: 277, column: 12, scope: !163)
!170 = !DILocation(line: 277, column: 66, scope: !163)
!171 = !{!172, !173, i64 0}
!172 = !{!"block", !173, i64 0, !96, i64 8}
!173 = !{!"long", !96, i64 0}
!174 = !DILocation(line: 277, column: 46, scope: !163)
!175 = !DILocation(line: 277, column: 5, scope: !163)
!176 = distinct !DISubprogram(name: "get_alloc", scope: !3, file: !3, line: 360, type: !177, isLocal: true, isDefinition: true, scopeLine: 360, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !179)
!177 = !DISubroutineType(types: !178)
!178 = !{!32, !6}
!179 = !{!180}
!180 = !DILocalVariable(name: "block", arg: 1, scope: !176, file: !3, line: 360, type: !6)
!181 = !DILocation(line: 360, column: 32, scope: !176)
!182 = !DILocation(line: 361, column: 33, scope: !176)
!183 = !DILocation(line: 361, column: 12, scope: !176)
!184 = !DILocation(line: 361, column: 5, scope: !176)
!185 = distinct !DISubprogram(name: "find_next", scope: !3, file: !3, line: 418, type: !186, isLocal: true, isDefinition: true, scopeLine: 418, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !188)
!186 = !DISubroutineType(types: !187)
!187 = !{!6, !6}
!188 = !{!189}
!189 = !DILocalVariable(name: "block", arg: 1, scope: !185, file: !3, line: 418, type: !6)
!190 = !DILocation(line: 418, column: 36, scope: !185)
!191 = !DILocation(line: 422, column: 24, scope: !185)
!192 = !DILocation(line: 422, column: 40, scope: !185)
!193 = !DILocation(line: 422, column: 38, scope: !185)
!194 = !DILocation(line: 422, column: 12, scope: !185)
!195 = !DILocation(line: 422, column: 5, scope: !185)
!196 = distinct !DISubprogram(name: "mm_init", scope: !3, file: !3, line: 832, type: !197, isLocal: false, isDefinition: true, scopeLine: 832, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !199)
!197 = !DISubroutineType(types: !198)
!198 = !{!32}
!199 = !{!200, !201}
!200 = !DILocalVariable(name: "start", scope: !196, file: !3, line: 834, type: !30)
!201 = !DILocalVariable(name: "i", scope: !196, file: !3, line: 835, type: !49)
!202 = !DILocation(line: 834, column: 32, scope: !196)
!203 = !DILocation(line: 837, column: 15, scope: !204)
!204 = distinct !DILexicalBlock(scope: !196, file: !3, line: 837, column: 9)
!205 = !DILocation(line: 837, column: 9, scope: !196)
!206 = !DILocation(line: 834, column: 21, scope: !196)
!207 = !DILocation(line: 834, column: 13, scope: !196)
!208 = !DILocation(line: 841, column: 16, scope: !196)
!209 = !DILocation(line: 841, column: 14, scope: !196)
!210 = !{!173, !173, i64 0}
!211 = !DILocation(line: 842, column: 16, scope: !196)
!212 = !DILocation(line: 842, column: 5, scope: !196)
!213 = !DILocation(line: 842, column: 14, scope: !196)
!214 = !DILocation(line: 845, column: 16, scope: !196)
!215 = !DILocation(line: 848, column: 9, scope: !216)
!216 = distinct !DILexicalBlock(scope: !196, file: !3, line: 848, column: 9)
!217 = !DILocation(line: 848, column: 32, scope: !216)
!218 = !DILocation(line: 848, column: 9, scope: !196)
!219 = !DILocation(line: 855, column: 22, scope: !220)
!220 = distinct !DILexicalBlock(scope: !221, file: !3, line: 854, column: 5)
!221 = distinct !DILexicalBlock(scope: !222, file: !3, line: 853, column: 5)
!222 = distinct !DILexicalBlock(scope: !196, file: !3, line: 853, column: 5)
!223 = !DILocation(line: 858, column: 1, scope: !196)
!224 = !DILocation(line: 0, scope: !196)
!225 = distinct !DISubprogram(name: "pack", scope: !3, file: !3, line: 219, type: !226, isLocal: true, isDefinition: true, scopeLine: 220, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !228)
!226 = !DISubroutineType(types: !227)
!227 = !{!11, !38, !32, !32, !32, !32}
!228 = !{!229, !230, !231, !232, !233, !234}
!229 = !DILocalVariable(name: "size", arg: 1, scope: !225, file: !3, line: 219, type: !38)
!230 = !DILocalVariable(name: "prev_mini", arg: 2, scope: !225, file: !3, line: 219, type: !32)
!231 = !DILocalVariable(name: "mini", arg: 3, scope: !225, file: !3, line: 219, type: !32)
!232 = !DILocalVariable(name: "prev_alloc", arg: 4, scope: !225, file: !3, line: 219, type: !32)
!233 = !DILocalVariable(name: "alloc", arg: 5, scope: !225, file: !3, line: 219, type: !32)
!234 = !DILocalVariable(name: "word", scope: !225, file: !3, line: 221, type: !11)
!235 = !DILocation(line: 219, column: 27, scope: !225)
!236 = !DILocation(line: 219, column: 38, scope: !225)
!237 = !DILocation(line: 219, column: 54, scope: !225)
!238 = !DILocation(line: 219, column: 65, scope: !225)
!239 = !DILocation(line: 219, column: 82, scope: !225)
!240 = !DILocation(line: 221, column: 12, scope: !225)
!241 = !DILocation(line: 222, column: 9, scope: !225)
!242 = !DILocation(line: 226, column: 14, scope: !243)
!243 = distinct !DILexicalBlock(scope: !244, file: !3, line: 225, column: 21)
!244 = distinct !DILexicalBlock(scope: !225, file: !3, line: 225, column: 9)
!245 = !DILocation(line: 225, column: 9, scope: !225)
!246 = !DILocation(line: 229, column: 14, scope: !247)
!247 = distinct !DILexicalBlock(scope: !248, file: !3, line: 228, column: 15)
!248 = distinct !DILexicalBlock(scope: !225, file: !3, line: 228, column: 9)
!249 = !DILocation(line: 228, column: 9, scope: !225)
!250 = !DILocation(line: 232, column: 14, scope: !251)
!251 = distinct !DILexicalBlock(scope: !252, file: !3, line: 231, column: 20)
!252 = distinct !DILexicalBlock(scope: !225, file: !3, line: 231, column: 9)
!253 = !DILocation(line: 231, column: 9, scope: !225)
!254 = !DILocation(line: 234, column: 5, scope: !225)
!255 = distinct !DISubprogram(name: "extend_heap", scope: !3, file: !3, line: 646, type: !256, isLocal: true, isDefinition: true, scopeLine: 646, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !258)
!256 = !DISubroutineType(types: !257)
!257 = !{!6, !38}
!258 = !{!259, !260, !261, !262}
!259 = !DILocalVariable(name: "size", arg: 1, scope: !255, file: !3, line: 646, type: !38)
!260 = !DILocalVariable(name: "bp", scope: !255, file: !3, line: 647, type: !31)
!261 = !DILocalVariable(name: "block", scope: !255, file: !3, line: 656, type: !6)
!262 = !DILocalVariable(name: "block_next", scope: !255, file: !3, line: 659, type: !6)
!263 = !DILocation(line: 646, column: 36, scope: !255)
!264 = !DILocation(line: 650, column: 12, scope: !255)
!265 = !DILocation(line: 651, column: 15, scope: !266)
!266 = distinct !DILexicalBlock(scope: !255, file: !3, line: 651, column: 9)
!267 = !DILocation(line: 647, column: 11, scope: !255)
!268 = !DILocation(line: 651, column: 31, scope: !266)
!269 = !DILocation(line: 651, column: 9, scope: !255)
!270 = !DILocation(line: 656, column: 22, scope: !255)
!271 = !DILocation(line: 656, column: 14, scope: !255)
!272 = !DILocation(line: 657, column: 30, scope: !255)
!273 = !DILocation(line: 657, column: 55, scope: !255)
!274 = !DILocation(line: 657, column: 5, scope: !255)
!275 = !DILocation(line: 659, column: 27, scope: !255)
!276 = !DILocation(line: 659, column: 14, scope: !255)
!277 = !DILocation(line: 660, column: 5, scope: !255)
!278 = !DILocation(line: 663, column: 13, scope: !255)
!279 = !DILocation(line: 665, column: 5, scope: !255)
!280 = !DILocation(line: 0, scope: !255)
!281 = !DILocation(line: 666, column: 1, scope: !255)
!282 = distinct !DISubprogram(name: "mm_malloc", scope: !3, file: !3, line: 867, type: !283, isLocal: false, isDefinition: true, scopeLine: 867, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !285)
!283 = !DISubroutineType(types: !284)
!284 = !{!31, !38}
!285 = !{!286, !287, !288, !289, !290, !291, !292, !293}
!286 = !DILocalVariable(name: "size", arg: 1, scope: !282, file: !3, line: 867, type: !38)
!287 = !DILocalVariable(name: "asize", scope: !282, file: !3, line: 870, type: !38)
!288 = !DILocalVariable(name: "extendsize", scope: !282, file: !3, line: 871, type: !38)
!289 = !DILocalVariable(name: "block", scope: !282, file: !3, line: 872, type: !6)
!290 = !DILocalVariable(name: "bp", scope: !282, file: !3, line: 873, type: !31)
!291 = !DILocalVariable(name: "block_size", scope: !282, file: !3, line: 908, type: !38)
!292 = !DILocalVariable(name: "block_next", scope: !282, file: !3, line: 918, type: !6)
!293 = !DILocalVariable(name: "block_next_size", scope: !282, file: !3, line: 919, type: !38)
!294 = !DILocation(line: 867, column: 21, scope: !282)
!295 = !DILocation(line: 873, column: 11, scope: !282)
!296 = !DILocation(line: 876, column: 9, scope: !297)
!297 = distinct !DILexicalBlock(scope: !282, file: !3, line: 876, column: 9)
!298 = !DILocation(line: 876, column: 20, scope: !297)
!299 = !DILocation(line: 876, column: 9, scope: !282)
!300 = !DILocation(line: 877, column: 9, scope: !301)
!301 = distinct !DILexicalBlock(scope: !297, file: !3, line: 876, column: 29)
!302 = !DILocation(line: 878, column: 5, scope: !301)
!303 = !DILocation(line: 881, column: 14, scope: !304)
!304 = distinct !DILexicalBlock(scope: !282, file: !3, line: 881, column: 9)
!305 = !DILocation(line: 881, column: 9, scope: !282)
!306 = !DILocation(line: 887, column: 27, scope: !282)
!307 = !DILocation(line: 887, column: 13, scope: !282)
!308 = !DILocation(line: 870, column: 12, scope: !282)
!309 = !DILocation(line: 890, column: 13, scope: !282)
!310 = !DILocation(line: 872, column: 14, scope: !282)
!311 = !DILocation(line: 893, column: 15, scope: !312)
!312 = distinct !DILexicalBlock(scope: !282, file: !3, line: 893, column: 9)
!313 = !DILocation(line: 893, column: 9, scope: !282)
!314 = !DILocation(line: 895, column: 22, scope: !315)
!315 = distinct !DILexicalBlock(scope: !312, file: !3, line: 893, column: 24)
!316 = !DILocation(line: 871, column: 12, scope: !282)
!317 = !DILocation(line: 896, column: 17, scope: !315)
!318 = !DILocation(line: 898, column: 19, scope: !319)
!319 = distinct !DILexicalBlock(scope: !315, file: !3, line: 898, column: 13)
!320 = !DILocation(line: 898, column: 13, scope: !315)
!321 = !DILocation(line: 0, scope: !282)
!322 = !DILocation(line: 905, column: 5, scope: !282)
!323 = !DILocation(line: 908, column: 25, scope: !282)
!324 = !DILocation(line: 908, column: 12, scope: !282)
!325 = !DILocation(line: 909, column: 36, scope: !282)
!326 = !DILocation(line: 909, column: 66, scope: !282)
!327 = !DILocation(line: 909, column: 87, scope: !282)
!328 = !DILocation(line: 909, column: 5, scope: !282)
!329 = !DILocation(line: 912, column: 5, scope: !282)
!330 = !DILocation(line: 915, column: 18, scope: !282)
!331 = !DILocation(line: 918, column: 27, scope: !282)
!332 = !DILocation(line: 918, column: 14, scope: !282)
!333 = !DILocation(line: 919, column: 30, scope: !282)
!334 = !DILocation(line: 919, column: 12, scope: !282)
!335 = !DILocation(line: 920, column: 25, scope: !336)
!336 = distinct !DILexicalBlock(scope: !282, file: !3, line: 920, column: 9)
!337 = !DILocation(line: 920, column: 9, scope: !282)
!338 = !DILocation(line: 922, column: 58, scope: !339)
!339 = distinct !DILexicalBlock(scope: !336, file: !3, line: 921, column: 5)
!340 = !DILocation(line: 922, column: 33, scope: !339)
!341 = !DILocation(line: 922, column: 79, scope: !339)
!342 = !DILocation(line: 922, column: 100, scope: !339)
!343 = !DILocation(line: 922, column: 126, scope: !339)
!344 = !DILocation(line: 922, column: 9, scope: !339)
!345 = !DILocation(line: 923, column: 5, scope: !339)
!346 = !DILocation(line: 926, column: 48, scope: !347)
!347 = distinct !DILexicalBlock(scope: !336, file: !3, line: 925, column: 5)
!348 = !DILocation(line: 926, column: 9, scope: !347)
!349 = !DILocation(line: 929, column: 10, scope: !282)
!350 = !DILocation(line: 932, column: 5, scope: !282)
!351 = !DILocation(line: 933, column: 1, scope: !282)
!352 = distinct !DISubprogram(name: "round_up", scope: !3, file: !3, line: 203, type: !353, isLocal: true, isDefinition: true, scopeLine: 203, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !355)
!353 = !DISubroutineType(types: !354)
!354 = !{!38, !38, !38}
!355 = !{!356, !357}
!356 = !DILocalVariable(name: "size", arg: 1, scope: !352, file: !3, line: 203, type: !38)
!357 = !DILocalVariable(name: "n", arg: 2, scope: !352, file: !3, line: 203, type: !38)
!358 = !DILocation(line: 203, column: 31, scope: !352)
!359 = !DILocation(line: 203, column: 44, scope: !352)
!360 = !DILocation(line: 204, column: 23, scope: !352)
!361 = !DILocation(line: 204, column: 14, scope: !352)
!362 = !DILocation(line: 204, column: 5, scope: !352)
!363 = distinct !DISubprogram(name: "find_fit", scope: !3, file: !3, line: 727, type: !256, isLocal: true, isDefinition: true, scopeLine: 727, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !364)
!364 = !{!365, !366, !367, !368}
!365 = !DILocalVariable(name: "asize", arg: 1, scope: !363, file: !3, line: 727, type: !38)
!366 = !DILocalVariable(name: "index", scope: !363, file: !3, line: 728, type: !49)
!367 = !DILocalVariable(name: "i", scope: !363, file: !3, line: 729, type: !49)
!368 = !DILocalVariable(name: "block", scope: !369, file: !3, line: 733, type: !6)
!369 = distinct !DILexicalBlock(scope: !363, file: !3, line: 732, column: 5)
!370 = !DILocation(line: 727, column: 33, scope: !363)
!371 = !DILocation(line: 728, column: 17, scope: !363)
!372 = !DILocation(line: 728, column: 9, scope: !363)
!373 = !DILocation(line: 729, column: 9, scope: !363)
!374 = !DILocation(line: 731, column: 14, scope: !363)
!375 = !DILocation(line: 731, column: 5, scope: !363)
!376 = !DILocation(line: 733, column: 26, scope: !369)
!377 = !DILocation(line: 733, column: 18, scope: !369)
!378 = !DILocation(line: 734, column: 19, scope: !379)
!379 = distinct !DILexicalBlock(scope: !369, file: !3, line: 734, column: 13)
!380 = !DILocation(line: 734, column: 13, scope: !369)
!381 = !DILocation(line: 738, column: 30, scope: !382)
!382 = distinct !DILexicalBlock(scope: !383, file: !3, line: 738, column: 21)
!383 = distinct !DILexicalBlock(scope: !384, file: !3, line: 737, column: 13)
!384 = distinct !DILexicalBlock(scope: !379, file: !3, line: 735, column: 9)
!385 = !DILocation(line: 0, scope: !383)
!386 = !DILocation(line: 738, column: 27, scope: !382)
!387 = !DILocation(line: 738, column: 21, scope: !383)
!388 = !DILocation(line: 742, column: 44, scope: !383)
!389 = !{!96, !96, i64 0}
!390 = !DILocation(line: 743, column: 28, scope: !384)
!391 = !DILocation(line: 743, column: 13, scope: !383)
!392 = distinct !{!392, !393, !394}
!393 = !DILocation(line: 736, column: 13, scope: !384)
!394 = !DILocation(line: 743, column: 43, scope: !384)
!395 = !DILocation(line: 745, column: 10, scope: !369)
!396 = distinct !{!396, !375, !397}
!397 = !DILocation(line: 746, column: 5, scope: !363)
!398 = !DILocation(line: 749, column: 1, scope: !363)
!399 = !DILocation(line: 0, scope: !363)
!400 = distinct !DISubprogram(name: "max", scope: !3, file: !3, line: 193, type: !353, isLocal: true, isDefinition: true, scopeLine: 193, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !401)
!401 = !{!402, !403}
!402 = !DILocalVariable(name: "x", arg: 1, scope: !400, file: !3, line: 193, type: !38)
!403 = !DILocalVariable(name: "y", arg: 2, scope: !400, file: !3, line: 193, type: !38)
!404 = !DILocation(line: 193, column: 26, scope: !400)
!405 = !DILocation(line: 193, column: 36, scope: !400)
!406 = !DILocation(line: 194, column: 15, scope: !400)
!407 = !DILocation(line: 194, column: 12, scope: !400)
!408 = !DILocation(line: 194, column: 5, scope: !400)
!409 = distinct !DISubprogram(name: "remove_list", scope: !3, file: !3, line: 502, type: !410, isLocal: true, isDefinition: true, scopeLine: 503, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !412)
!410 = !DISubroutineType(types: !411)
!411 = !{null, !6}
!412 = !{!413, !414, !415, !416}
!413 = !DILocalVariable(name: "block", arg: 1, scope: !409, file: !3, line: 502, type: !6)
!414 = !DILocalVariable(name: "block_size", scope: !409, file: !3, line: 504, type: !38)
!415 = !DILocalVariable(name: "index", scope: !409, file: !3, line: 505, type: !49)
!416 = !DILocalVariable(name: "prev_block", scope: !409, file: !3, line: 518, type: !6)
!417 = !DILocation(line: 502, column: 34, scope: !409)
!418 = !DILocation(line: 504, column: 25, scope: !409)
!419 = !DILocation(line: 504, column: 12, scope: !409)
!420 = !DILocation(line: 505, column: 17, scope: !409)
!421 = !DILocation(line: 505, column: 9, scope: !409)
!422 = !DILocation(line: 506, column: 9, scope: !423)
!423 = distinct !DILexicalBlock(scope: !409, file: !3, line: 506, column: 9)
!424 = !DILocation(line: 506, column: 26, scope: !423)
!425 = !DILocation(line: 506, column: 9, scope: !409)
!426 = !DILocation(line: 508, column: 32, scope: !427)
!427 = distinct !DILexicalBlock(scope: !428, file: !3, line: 508, column: 13)
!428 = distinct !DILexicalBlock(scope: !423, file: !3, line: 507, column: 5)
!429 = !DILocation(line: 508, column: 37, scope: !427)
!430 = !DILocation(line: 508, column: 13, scope: !428)
!431 = !DILocation(line: 510, column: 30, scope: !432)
!432 = distinct !DILexicalBlock(scope: !427, file: !3, line: 509, column: 9)
!433 = !DILocation(line: 511, column: 13, scope: !432)
!434 = !DILocation(line: 515, column: 30, scope: !435)
!435 = distinct !DILexicalBlock(scope: !427, file: !3, line: 514, column: 9)
!436 = !DILocation(line: 517, column: 5, scope: !428)
!437 = !DILocation(line: 519, column: 9, scope: !438)
!438 = distinct !DILexicalBlock(scope: !409, file: !3, line: 519, column: 9)
!439 = !DILocation(line: 519, column: 9, scope: !409)
!440 = !DILocation(line: 522, column: 55, scope: !441)
!441 = distinct !DILexicalBlock(scope: !438, file: !3, line: 520, column: 5)
!442 = !DILocation(line: 522, column: 35, scope: !441)
!443 = !DILocation(line: 522, column: 85, scope: !441)
!444 = !DILocation(line: 522, column: 22, scope: !441)
!445 = !DILocation(line: 518, column: 14, scope: !409)
!446 = !DILocation(line: 523, column: 5, scope: !441)
!447 = !DILocation(line: 526, column: 41, scope: !448)
!448 = distinct !DILexicalBlock(scope: !438, file: !3, line: 525, column: 5)
!449 = !DILocation(line: 0, scope: !448)
!450 = !DILocation(line: 528, column: 36, scope: !409)
!451 = !DILocation(line: 528, column: 5, scope: !409)
!452 = !DILocation(line: 529, column: 55, scope: !409)
!453 = !DILocation(line: 529, column: 17, scope: !409)
!454 = !DILocation(line: 529, column: 34, scope: !409)
!455 = !DILocation(line: 530, column: 1, scope: !409)
!456 = distinct !DISubprogram(name: "write_block", scope: !3, file: !3, line: 396, type: !457, isLocal: true, isDefinition: true, scopeLine: 397, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !459)
!457 = !DISubroutineType(types: !458)
!458 = !{null, !6, !38, !32, !32, !32, !32}
!459 = !{!460, !461, !462, !463, !464, !465, !466}
!460 = !DILocalVariable(name: "block", arg: 1, scope: !456, file: !3, line: 396, type: !6)
!461 = !DILocalVariable(name: "size", arg: 2, scope: !456, file: !3, line: 396, type: !38)
!462 = !DILocalVariable(name: "prev_mini", arg: 3, scope: !456, file: !3, line: 396, type: !32)
!463 = !DILocalVariable(name: "mini", arg: 4, scope: !456, file: !3, line: 396, type: !32)
!464 = !DILocalVariable(name: "prev_alloc", arg: 5, scope: !456, file: !3, line: 397, type: !32)
!465 = !DILocalVariable(name: "alloc", arg: 6, scope: !456, file: !3, line: 397, type: !32)
!466 = !DILocalVariable(name: "footerp", scope: !467, file: !3, line: 403, type: !30)
!467 = distinct !DILexicalBlock(scope: !468, file: !3, line: 402, column: 26)
!468 = distinct !DILexicalBlock(scope: !456, file: !3, line: 402, column: 9)
!469 = !DILocation(line: 396, column: 34, scope: !456)
!470 = !DILocation(line: 396, column: 48, scope: !456)
!471 = !DILocation(line: 396, column: 59, scope: !456)
!472 = !DILocation(line: 396, column: 75, scope: !456)
!473 = !DILocation(line: 397, column: 30, scope: !456)
!474 = !DILocation(line: 397, column: 47, scope: !456)
!475 = !DILocation(line: 400, column: 21, scope: !456)
!476 = !DILocation(line: 400, column: 12, scope: !456)
!477 = !DILocation(line: 400, column: 19, scope: !456)
!478 = !DILocation(line: 402, column: 16, scope: !468)
!479 = !DILocation(line: 403, column: 27, scope: !467)
!480 = !DILocation(line: 403, column: 17, scope: !467)
!481 = !DILocation(line: 404, column: 18, scope: !467)
!482 = !DILocation(line: 405, column: 5, scope: !467)
!483 = !DILocation(line: 406, column: 1, scope: !456)
!484 = distinct !DISubprogram(name: "ifpremini", scope: !3, file: !3, line: 267, type: !177, isLocal: true, isDefinition: true, scopeLine: 267, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !485)
!485 = !{!486}
!486 = !DILocalVariable(name: "block", arg: 1, scope: !484, file: !3, line: 267, type: !6)
!487 = !DILocation(line: 267, column: 32, scope: !484)
!488 = !DILocation(line: 268, column: 26, scope: !484)
!489 = !DILocation(line: 268, column: 33, scope: !484)
!490 = !DILocation(line: 268, column: 12, scope: !484)
!491 = !DILocation(line: 268, column: 5, scope: !484)
!492 = distinct !DISubprogram(name: "ifprealloc", scope: !3, file: !3, line: 253, type: !177, isLocal: true, isDefinition: true, scopeLine: 253, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !493)
!493 = !{!494}
!494 = !DILocalVariable(name: "block", arg: 1, scope: !492, file: !3, line: 253, type: !6)
!495 = !DILocation(line: 253, column: 33, scope: !492)
!496 = !DILocation(line: 254, column: 26, scope: !492)
!497 = !DILocation(line: 254, column: 33, scope: !492)
!498 = !DILocation(line: 254, column: 12, scope: !492)
!499 = !DILocation(line: 254, column: 5, scope: !492)
!500 = distinct !DISubprogram(name: "split_block", scope: !3, file: !3, line: 675, type: !501, isLocal: true, isDefinition: true, scopeLine: 675, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !503)
!501 = !DISubroutineType(types: !502)
!502 = !{null, !6, !38}
!503 = !{!504, !505, !506, !507, !510, !511, !512}
!504 = !DILocalVariable(name: "block", arg: 1, scope: !500, file: !3, line: 675, type: !6)
!505 = !DILocalVariable(name: "asize", arg: 2, scope: !500, file: !3, line: 675, type: !38)
!506 = !DILocalVariable(name: "block_size", scope: !500, file: !3, line: 678, type: !38)
!507 = !DILocalVariable(name: "block_next", scope: !508, file: !3, line: 681, type: !6)
!508 = distinct !DILexicalBlock(scope: !509, file: !3, line: 680, column: 50)
!509 = distinct !DILexicalBlock(scope: !500, file: !3, line: 680, column: 9)
!510 = !DILocalVariable(name: "mini", scope: !508, file: !3, line: 692, type: !32)
!511 = !DILocalVariable(name: "block_next_next", scope: !508, file: !3, line: 703, type: !6)
!512 = !DILocalVariable(name: "block_next_size", scope: !508, file: !3, line: 704, type: !38)
!513 = !DILocation(line: 675, column: 34, scope: !500)
!514 = !DILocation(line: 675, column: 48, scope: !500)
!515 = !DILocation(line: 678, column: 25, scope: !500)
!516 = !DILocation(line: 678, column: 12, scope: !500)
!517 = !DILocation(line: 680, column: 21, scope: !509)
!518 = !DILocation(line: 680, column: 30, scope: !509)
!519 = !DILocation(line: 680, column: 9, scope: !500)
!520 = !DILocation(line: 682, column: 18, scope: !521)
!521 = distinct !DILexicalBlock(scope: !508, file: !3, line: 682, column: 12)
!522 = !DILocation(line: 0, scope: !523)
!523 = distinct !DILexicalBlock(scope: !521, file: !3, line: 687, column: 9)
!524 = !DILocation(line: 682, column: 12, scope: !508)
!525 = !DILocation(line: 684, column: 13, scope: !526)
!526 = distinct !DILexicalBlock(scope: !521, file: !3, line: 683, column: 9)
!527 = !DILocation(line: 685, column: 9, scope: !526)
!528 = !DILocation(line: 688, column: 13, scope: !523)
!529 = !DILocation(line: 691, column: 22, scope: !508)
!530 = !DILocation(line: 681, column: 18, scope: !508)
!531 = !DILocation(line: 692, column: 43, scope: !508)
!532 = !DILocation(line: 0, scope: !533)
!533 = distinct !DILexicalBlock(scope: !534, file: !3, line: 698, column: 9)
!534 = distinct !DILexicalBlock(scope: !508, file: !3, line: 693, column: 12)
!535 = !DILocation(line: 693, column: 12, scope: !508)
!536 = !DILocation(line: 695, column: 13, scope: !537)
!537 = distinct !DILexicalBlock(scope: !534, file: !3, line: 694, column: 9)
!538 = !DILocation(line: 696, column: 9, scope: !537)
!539 = !DILocation(line: 699, column: 13, scope: !533)
!540 = !DILocation(line: 701, column: 9, scope: !508)
!541 = !DILocation(line: 703, column: 36, scope: !508)
!542 = !DILocation(line: 703, column: 18, scope: !508)
!543 = !DILocation(line: 704, column: 34, scope: !508)
!544 = !DILocation(line: 704, column: 16, scope: !508)
!545 = !DILocation(line: 705, column: 29, scope: !546)
!546 = distinct !DILexicalBlock(scope: !508, file: !3, line: 705, column: 13)
!547 = !DILocation(line: 705, column: 13, scope: !508)
!548 = !DILocation(line: 707, column: 72, scope: !549)
!549 = distinct !DILexicalBlock(scope: !546, file: !3, line: 706, column: 9)
!550 = !DILocation(line: 707, column: 42, scope: !549)
!551 = !DILocation(line: 707, column: 87, scope: !549)
!552 = !DILocation(line: 707, column: 119, scope: !549)
!553 = !DILocation(line: 707, column: 13, scope: !549)
!554 = !DILocation(line: 708, column: 9, scope: !549)
!555 = !DILocation(line: 711, column: 13, scope: !556)
!556 = distinct !DILexicalBlock(scope: !546, file: !3, line: 710, column: 9)
!557 = !DILocation(line: 716, column: 1, scope: !500)
!558 = distinct !DISubprogram(name: "extract_size", scope: !3, file: !3, line: 246, type: !559, isLocal: true, isDefinition: true, scopeLine: 246, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !561)
!559 = !DISubroutineType(types: !560)
!560 = !{!38, !11}
!561 = !{!562}
!562 = !DILocalVariable(name: "word", arg: 1, scope: !558, file: !3, line: 246, type: !11)
!563 = !DILocation(line: 246, column: 35, scope: !558)
!564 = !DILocation(line: 247, column: 18, scope: !558)
!565 = !DILocation(line: 247, column: 5, scope: !558)
!566 = distinct !DISubprogram(name: "ifmini", scope: !3, file: !3, line: 260, type: !177, isLocal: true, isDefinition: true, scopeLine: 260, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !567)
!567 = !{!568}
!568 = !DILocalVariable(name: "block", arg: 1, scope: !566, file: !3, line: 260, type: !6)
!569 = !DILocation(line: 260, column: 29, scope: !566)
!570 = !DILocation(line: 261, column: 26, scope: !566)
!571 = !DILocation(line: 261, column: 33, scope: !566)
!572 = !DILocation(line: 261, column: 12, scope: !566)
!573 = !DILocation(line: 261, column: 5, scope: !566)
!574 = distinct !DISubprogram(name: "write_epilogue", scope: !3, file: !3, line: 376, type: !575, isLocal: true, isDefinition: true, scopeLine: 376, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !577)
!575 = !DISubroutineType(types: !576)
!576 = !{null, !6, !32, !32}
!577 = !{!578, !579, !580}
!578 = !DILocalVariable(name: "block", arg: 1, scope: !574, file: !3, line: 376, type: !6)
!579 = !DILocalVariable(name: "prev_mini", arg: 2, scope: !574, file: !3, line: 376, type: !32)
!580 = !DILocalVariable(name: "prev_alloc", arg: 3, scope: !574, file: !3, line: 376, type: !32)
!581 = !DILocation(line: 376, column: 37, scope: !574)
!582 = !DILocation(line: 376, column: 49, scope: !574)
!583 = !DILocation(line: 376, column: 65, scope: !574)
!584 = !DILocation(line: 379, column: 21, scope: !574)
!585 = !DILocation(line: 379, column: 12, scope: !574)
!586 = !DILocation(line: 379, column: 19, scope: !574)
!587 = !DILocation(line: 380, column: 1, scope: !574)
!588 = distinct !DISubprogram(name: "header_to_payload", scope: !3, file: !3, line: 298, type: !589, isLocal: true, isDefinition: true, scopeLine: 298, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !591)
!589 = !DISubroutineType(types: !590)
!590 = !{!31, !6}
!591 = !{!592}
!592 = !DILocalVariable(name: "block", arg: 1, scope: !588, file: !3, line: 298, type: !6)
!593 = !DILocation(line: 298, column: 41, scope: !588)
!594 = !DILocation(line: 300, column: 28, scope: !588)
!595 = !DILocation(line: 300, column: 20, scope: !588)
!596 = !DILocation(line: 300, column: 5, scope: !588)
!597 = distinct !DISubprogram(name: "mm_free", scope: !3, file: !3, line: 942, type: !598, isLocal: false, isDefinition: true, scopeLine: 942, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !600)
!598 = !DISubroutineType(types: !599)
!599 = !{null, !31}
!600 = !{!601, !602, !603, !604}
!601 = !DILocalVariable(name: "bp", arg: 1, scope: !597, file: !3, line: 942, type: !31)
!602 = !DILocalVariable(name: "block", scope: !597, file: !3, line: 949, type: !6)
!603 = !DILocalVariable(name: "size", scope: !597, file: !3, line: 950, type: !38)
!604 = !DILocalVariable(name: "block_next", scope: !597, file: !3, line: 965, type: !6)
!605 = !DILocation(line: 942, column: 17, scope: !597)
!606 = !DILocation(line: 945, column: 12, scope: !607)
!607 = distinct !DILexicalBlock(scope: !597, file: !3, line: 945, column: 9)
!608 = !DILocation(line: 945, column: 9, scope: !597)
!609 = !DILocation(line: 949, column: 22, scope: !597)
!610 = !DILocation(line: 949, column: 14, scope: !597)
!611 = !DILocation(line: 950, column: 19, scope: !597)
!612 = !DILocation(line: 950, column: 12, scope: !597)
!613 = !DILocation(line: 956, column: 13, scope: !614)
!614 = distinct !DILexicalBlock(scope: !597, file: !3, line: 956, column: 8)
!615 = !DILocation(line: 0, scope: !616)
!616 = distinct !DILexicalBlock(scope: !614, file: !3, line: 961, column: 5)
!617 = !DILocation(line: 956, column: 8, scope: !597)
!618 = !DILocation(line: 958, column: 9, scope: !619)
!619 = distinct !DILexicalBlock(scope: !614, file: !3, line: 957, column: 5)
!620 = !DILocation(line: 959, column: 5, scope: !619)
!621 = !DILocation(line: 962, column: 9, scope: !616)
!622 = !DILocation(line: 965, column: 27, scope: !597)
!623 = !DILocation(line: 965, column: 14, scope: !597)
!624 = !DILocation(line: 966, column: 9, scope: !625)
!625 = distinct !DILexicalBlock(scope: !597, file: !3, line: 966, column: 9)
!626 = !DILocation(line: 966, column: 30, scope: !625)
!627 = !DILocation(line: 966, column: 9, scope: !597)
!628 = !DILocation(line: 968, column: 58, scope: !629)
!629 = distinct !DILexicalBlock(scope: !625, file: !3, line: 967, column: 5)
!630 = !DILocation(line: 968, column: 33, scope: !629)
!631 = !DILocation(line: 968, column: 67, scope: !629)
!632 = !DILocation(line: 968, column: 90, scope: !629)
!633 = !DILocation(line: 968, column: 117, scope: !629)
!634 = !DILocation(line: 968, column: 9, scope: !629)
!635 = !DILocation(line: 969, column: 5, scope: !629)
!636 = !DILocation(line: 972, column: 36, scope: !637)
!637 = distinct !DILexicalBlock(scope: !625, file: !3, line: 971, column: 5)
!638 = !DILocation(line: 972, column: 9, scope: !637)
!639 = !DILocation(line: 976, column: 13, scope: !597)
!640 = !DILocation(line: 979, column: 1, scope: !597)
!641 = distinct !DISubprogram(name: "payload_to_header", scope: !3, file: !3, line: 286, type: !642, isLocal: true, isDefinition: true, scopeLine: 286, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !644)
!642 = !DISubroutineType(types: !643)
!643 = !{!6, !31}
!644 = !{!645}
!645 = !DILocalVariable(name: "bp", arg: 1, scope: !641, file: !3, line: 286, type: !31)
!646 = !DILocation(line: 286, column: 41, scope: !641)
!647 = !DILocation(line: 287, column: 35, scope: !641)
!648 = !DILocation(line: 287, column: 12, scope: !641)
!649 = !DILocation(line: 287, column: 5, scope: !641)
!650 = distinct !DISubprogram(name: "coalesce_block", scope: !3, file: !3, line: 586, type: !186, isLocal: true, isDefinition: true, scopeLine: 586, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !651)
!651 = !{!652, !653, !654, !655, !656, !657, !662, !664, !665}
!652 = !DILocalVariable(name: "block", arg: 1, scope: !650, file: !3, line: 586, type: !6)
!653 = !DILocalVariable(name: "block_size", scope: !650, file: !3, line: 587, type: !38)
!654 = !DILocalVariable(name: "block_next", scope: !650, file: !3, line: 588, type: !6)
!655 = !DILocalVariable(name: "prev_alloc", scope: !650, file: !3, line: 590, type: !32)
!656 = !DILocalVariable(name: "next_alloc", scope: !650, file: !3, line: 591, type: !32)
!657 = !DILocalVariable(name: "block_prev", scope: !658, file: !3, line: 603, type: !6)
!658 = distinct !DILexicalBlock(scope: !659, file: !3, line: 602, column: 5)
!659 = distinct !DILexicalBlock(scope: !660, file: !3, line: 601, column: 14)
!660 = distinct !DILexicalBlock(scope: !661, file: !3, line: 596, column: 14)
!661 = distinct !DILexicalBlock(scope: !650, file: !3, line: 593, column: 9)
!662 = !DILocalVariable(name: "block_prev", scope: !663, file: !3, line: 612, type: !6)
!663 = distinct !DILexicalBlock(scope: !659, file: !3, line: 609, column: 5)
!664 = !DILocalVariable(name: "mini", scope: !650, file: !3, line: 618, type: !32)
!665 = !DILocalVariable(name: "block_next_size", scope: !650, file: !3, line: 623, type: !38)
!666 = !DILocation(line: 586, column: 41, scope: !650)
!667 = !DILocation(line: 587, column: 25, scope: !650)
!668 = !DILocation(line: 587, column: 12, scope: !650)
!669 = !DILocation(line: 588, column: 27, scope: !650)
!670 = !DILocation(line: 588, column: 14, scope: !650)
!671 = !DILocation(line: 590, column: 23, scope: !650)
!672 = !DILocation(line: 591, column: 23, scope: !650)
!673 = !DILocation(line: 593, column: 20, scope: !661)
!674 = !DILocation(line: 596, column: 25, scope: !660)
!675 = !DILocation(line: 598, column: 23, scope: !676)
!676 = distinct !DILexicalBlock(scope: !660, file: !3, line: 597, column: 5)
!677 = !DILocation(line: 598, column: 20, scope: !676)
!678 = !DILocation(line: 599, column: 9, scope: !676)
!679 = !DILocation(line: 600, column: 5, scope: !676)
!680 = !DILocation(line: 601, column: 26, scope: !659)
!681 = !DILocation(line: 603, column: 31, scope: !658)
!682 = !DILocation(line: 603, column: 18, scope: !658)
!683 = !DILocation(line: 604, column: 23, scope: !658)
!684 = !DILocation(line: 604, column: 20, scope: !658)
!685 = !DILocation(line: 605, column: 9, scope: !658)
!686 = !DILocation(line: 607, column: 5, scope: !658)
!687 = !DILocation(line: 610, column: 23, scope: !663)
!688 = !DILocation(line: 610, column: 20, scope: !663)
!689 = !DILocation(line: 611, column: 9, scope: !663)
!690 = !DILocation(line: 612, column: 31, scope: !663)
!691 = !DILocation(line: 612, column: 18, scope: !663)
!692 = !DILocation(line: 613, column: 23, scope: !663)
!693 = !DILocation(line: 613, column: 20, scope: !663)
!694 = !DILocation(line: 614, column: 9, scope: !663)
!695 = !DILocation(line: 0, scope: !676)
!696 = !DILocation(line: 618, column: 29, scope: !650)
!697 = !DILocation(line: 619, column: 36, scope: !650)
!698 = !DILocation(line: 620, column: 17, scope: !650)
!699 = !DILocation(line: 619, column: 5, scope: !650)
!700 = !DILocation(line: 621, column: 5, scope: !650)
!701 = !DILocation(line: 622, column: 18, scope: !650)
!702 = !DILocation(line: 623, column: 30, scope: !650)
!703 = !DILocation(line: 623, column: 12, scope: !650)
!704 = !DILocation(line: 624, column: 25, scope: !705)
!705 = distinct !DILexicalBlock(scope: !650, file: !3, line: 624, column: 9)
!706 = !DILocation(line: 624, column: 9, scope: !650)
!707 = !DILocation(line: 625, column: 58, scope: !708)
!708 = distinct !DILexicalBlock(scope: !705, file: !3, line: 624, column: 30)
!709 = !DILocation(line: 625, column: 33, scope: !708)
!710 = !DILocation(line: 626, column: 21, scope: !708)
!711 = !DILocation(line: 626, column: 48, scope: !708)
!712 = !DILocation(line: 625, column: 9, scope: !708)
!713 = !DILocation(line: 627, column: 5, scope: !708)
!714 = !DILocation(line: 629, column: 9, scope: !715)
!715 = distinct !DILexicalBlock(scope: !705, file: !3, line: 628, column: 10)
!716 = !DILocation(line: 632, column: 5, scope: !650)
!717 = distinct !DISubprogram(name: "mm_realloc", scope: !3, file: !3, line: 987, type: !718, isLocal: false, isDefinition: true, scopeLine: 987, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !720)
!718 = !DISubroutineType(types: !719)
!719 = !{!31, !31, !38}
!720 = !{!721, !722, !723, !724, !725}
!721 = !DILocalVariable(name: "ptr", arg: 1, scope: !717, file: !3, line: 987, type: !31)
!722 = !DILocalVariable(name: "size", arg: 2, scope: !717, file: !3, line: 987, type: !38)
!723 = !DILocalVariable(name: "block", scope: !717, file: !3, line: 988, type: !6)
!724 = !DILocalVariable(name: "copysize", scope: !717, file: !3, line: 989, type: !38)
!725 = !DILocalVariable(name: "newptr", scope: !717, file: !3, line: 990, type: !31)
!726 = !DILocation(line: 987, column: 21, scope: !717)
!727 = !DILocation(line: 987, column: 33, scope: !717)
!728 = !DILocation(line: 988, column: 22, scope: !717)
!729 = !DILocation(line: 988, column: 14, scope: !717)
!730 = !DILocation(line: 993, column: 14, scope: !731)
!731 = distinct !DILexicalBlock(scope: !717, file: !3, line: 993, column: 9)
!732 = !DILocation(line: 993, column: 9, scope: !717)
!733 = !DILocation(line: 994, column: 9, scope: !734)
!734 = distinct !DILexicalBlock(scope: !731, file: !3, line: 993, column: 20)
!735 = !DILocation(line: 995, column: 9, scope: !734)
!736 = !DILocation(line: 999, column: 13, scope: !737)
!737 = distinct !DILexicalBlock(scope: !717, file: !3, line: 999, column: 9)
!738 = !DILocation(line: 0, scope: !717)
!739 = !DILocation(line: 999, column: 9, scope: !717)
!740 = !DILocation(line: 990, column: 11, scope: !717)
!741 = !DILocation(line: 1007, column: 16, scope: !742)
!742 = distinct !DILexicalBlock(scope: !717, file: !3, line: 1007, column: 9)
!743 = !DILocation(line: 1007, column: 9, scope: !717)
!744 = !DILocation(line: 1012, column: 16, scope: !717)
!745 = !DILocation(line: 989, column: 12, scope: !717)
!746 = !DILocation(line: 1013, column: 14, scope: !747)
!747 = distinct !DILexicalBlock(scope: !717, file: !3, line: 1013, column: 9)
!748 = !DILocation(line: 1013, column: 9, scope: !717)
!749 = !DILocation(line: 1016, column: 5, scope: !717)
!750 = !DILocation(line: 1019, column: 5, scope: !717)
!751 = !DILocation(line: 1021, column: 5, scope: !717)
!752 = !DILocation(line: 1022, column: 1, scope: !717)
!753 = distinct !DISubprogram(name: "get_payload_size", scope: !3, file: !3, line: 338, type: !164, isLocal: true, isDefinition: true, scopeLine: 338, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !754)
!754 = !{!755, !756}
!755 = !DILocalVariable(name: "block", arg: 1, scope: !753, file: !3, line: 338, type: !6)
!756 = !DILocalVariable(name: "asize", scope: !753, file: !3, line: 339, type: !38)
!757 = !DILocation(line: 338, column: 41, scope: !753)
!758 = !DILocation(line: 339, column: 20, scope: !753)
!759 = !DILocation(line: 339, column: 12, scope: !753)
!760 = !DILocation(line: 340, column: 18, scope: !753)
!761 = !DILocation(line: 340, column: 5, scope: !753)
!762 = distinct !DISubprogram(name: "mm_calloc", scope: !3, file: !3, line: 1030, type: !763, isLocal: false, isDefinition: true, scopeLine: 1030, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !765)
!763 = !DISubroutineType(types: !764)
!764 = !{!31, !38, !38}
!765 = !{!766, !767, !768, !769}
!766 = !DILocalVariable(name: "elements", arg: 1, scope: !762, file: !3, line: 1030, type: !38)
!767 = !DILocalVariable(name: "size", arg: 2, scope: !762, file: !3, line: 1030, type: !38)
!768 = !DILocalVariable(name: "bp", scope: !762, file: !3, line: 1031, type: !31)
!769 = !DILocalVariable(name: "asize", scope: !762, file: !3, line: 1032, type: !38)
!770 = !DILocation(line: 1030, column: 21, scope: !762)
!771 = !DILocation(line: 1030, column: 38, scope: !762)
!772 = !DILocation(line: 1032, column: 29, scope: !762)
!773 = !DILocation(line: 1032, column: 12, scope: !762)
!774 = !DILocation(line: 1034, column: 18, scope: !775)
!775 = distinct !DILexicalBlock(scope: !762, file: !3, line: 1034, column: 9)
!776 = !DILocation(line: 1034, column: 9, scope: !762)
!777 = !DILocation(line: 1037, column: 15, scope: !778)
!778 = distinct !DILexicalBlock(scope: !762, file: !3, line: 1037, column: 9)
!779 = !DILocation(line: 1037, column: 26, scope: !778)
!780 = !DILocation(line: 1037, column: 9, scope: !762)
!781 = !DILocation(line: 1042, column: 10, scope: !762)
!782 = !DILocation(line: 1031, column: 11, scope: !762)
!783 = !DILocation(line: 1043, column: 12, scope: !784)
!784 = distinct !DILexicalBlock(scope: !762, file: !3, line: 1043, column: 9)
!785 = !DILocation(line: 1043, column: 9, scope: !762)
!786 = !DILocation(line: 1048, column: 5, scope: !762)
!787 = !DILocation(line: 1050, column: 5, scope: !762)
!788 = !DILocation(line: 0, scope: !762)
!789 = !DILocation(line: 1051, column: 1, scope: !762)
!790 = distinct !DISubprogram(name: "extract_alloc", scope: !3, file: !3, line: 351, type: !791, isLocal: true, isDefinition: true, scopeLine: 351, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !793)
!791 = !DISubroutineType(types: !792)
!792 = !{!32, !11}
!793 = !{!794}
!794 = !DILocalVariable(name: "word", arg: 1, scope: !790, file: !3, line: 351, type: !11)
!795 = !DILocation(line: 351, column: 34, scope: !790)
!796 = !DILocation(line: 352, column: 24, scope: !790)
!797 = !DILocation(line: 352, column: 12, scope: !790)
!798 = !DILocation(line: 352, column: 5, scope: !790)
!799 = distinct !DISubprogram(name: "findlist", scope: !3, file: !3, line: 472, type: !800, isLocal: true, isDefinition: true, scopeLine: 472, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !802)
!800 = !DISubroutineType(types: !801)
!801 = !{!49, !38}
!802 = !{!803, !804, !805}
!803 = !DILocalVariable(name: "size", arg: 1, scope: !799, file: !3, line: 472, type: !38)
!804 = !DILocalVariable(name: "block_size", scope: !799, file: !3, line: 477, type: !38)
!805 = !DILocalVariable(name: "i", scope: !799, file: !3, line: 478, type: !49)
!806 = !DILocation(line: 472, column: 28, scope: !799)
!807 = !DILocation(line: 473, column: 14, scope: !808)
!808 = distinct !DILexicalBlock(scope: !799, file: !3, line: 473, column: 9)
!809 = !DILocation(line: 473, column: 9, scope: !799)
!810 = !DILocation(line: 479, column: 30, scope: !799)
!811 = !DILocation(line: 0, scope: !812)
!812 = distinct !DILexicalBlock(scope: !799, file: !3, line: 480, column: 5)
!813 = !DILocation(line: 478, column: 9, scope: !799)
!814 = !DILocation(line: 477, column: 12, scope: !799)
!815 = !DILocation(line: 479, column: 17, scope: !799)
!816 = !DILocation(line: 479, column: 40, scope: !799)
!817 = !DILocation(line: 479, column: 35, scope: !799)
!818 = !DILocation(line: 479, column: 5, scope: !799)
!819 = !DILocation(line: 481, column: 10, scope: !812)
!820 = distinct !{!820, !818, !821}
!821 = !DILocation(line: 483, column: 5, scope: !799)
!822 = !DILocation(line: 485, column: 1, scope: !799)
!823 = !DILocation(line: 0, scope: !799)
!824 = distinct !DISubprogram(name: "set_pointer", scope: !3, file: !3, line: 491, type: !825, isLocal: true, isDefinition: true, scopeLine: 491, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !827)
!825 = !DISubroutineType(types: !826)
!826 = !{null, !6, !6}
!827 = !{!828, !829}
!828 = !DILocalVariable(name: "block", arg: 1, scope: !824, file: !3, line: 491, type: !6)
!829 = !DILocalVariable(name: "prev_block", arg: 2, scope: !824, file: !3, line: 491, type: !6)
!830 = !DILocation(line: 491, column: 34, scope: !824)
!831 = !DILocation(line: 491, column: 50, scope: !824)
!832 = !DILocation(line: 492, column: 9, scope: !833)
!833 = distinct !DILexicalBlock(scope: !824, file: !3, line: 492, column: 9)
!834 = !DILocation(line: 492, column: 9, scope: !824)
!835 = !DILocation(line: 493, column: 46, scope: !836)
!836 = distinct !DILexicalBlock(scope: !833, file: !3, line: 492, column: 24)
!837 = !DILocation(line: 493, column: 52, scope: !836)
!838 = !DILocation(line: 493, column: 75, scope: !836)
!839 = !DILocation(line: 493, column: 27, scope: !836)
!840 = !DILocation(line: 493, column: 82, scope: !836)
!841 = !DILocation(line: 493, column: 65, scope: !836)
!842 = !DILocation(line: 493, column: 23, scope: !836)
!843 = !DILocation(line: 494, column: 5, scope: !836)
!844 = !DILocation(line: 495, column: 28, scope: !845)
!845 = distinct !DILexicalBlock(scope: !833, file: !3, line: 494, column: 12)
!846 = !DILocation(line: 495, column: 33, scope: !845)
!847 = !DILocation(line: 497, column: 1, scope: !824)
!848 = distinct !DISubprogram(name: "header_to_footer", scope: !3, file: !3, line: 310, type: !849, isLocal: true, isDefinition: true, scopeLine: 310, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !851)
!849 = !DISubroutineType(types: !850)
!850 = !{!30, !6}
!851 = !{!852}
!852 = !DILocalVariable(name: "block", arg: 1, scope: !848, file: !3, line: 310, type: !6)
!853 = !DILocation(line: 310, column: 42, scope: !848)
!854 = !DILocation(line: 313, column: 30, scope: !848)
!855 = !DILocation(line: 313, column: 23, scope: !848)
!856 = !DILocation(line: 313, column: 47, scope: !848)
!857 = !DILocation(line: 313, column: 45, scope: !848)
!858 = !DILocation(line: 313, column: 63, scope: !848)
!859 = !DILocation(line: 313, column: 12, scope: !848)
!860 = !DILocation(line: 313, column: 5, scope: !848)
!861 = distinct !DISubprogram(name: "insert_free_block", scope: !3, file: !3, line: 535, type: !410, isLocal: true, isDefinition: true, scopeLine: 536, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !862)
!862 = !{!863, !864, !865, !866}
!863 = !DILocalVariable(name: "block", arg: 1, scope: !861, file: !3, line: 535, type: !6)
!864 = !DILocalVariable(name: "block_size", scope: !861, file: !3, line: 537, type: !38)
!865 = !DILocalVariable(name: "index", scope: !861, file: !3, line: 538, type: !49)
!866 = !DILocalVariable(name: "prev_block", scope: !867, file: !3, line: 547, type: !6)
!867 = distinct !DILexicalBlock(scope: !868, file: !3, line: 546, column: 10)
!868 = distinct !DILexicalBlock(scope: !861, file: !3, line: 540, column: 9)
!869 = !DILocation(line: 535, column: 40, scope: !861)
!870 = !DILocation(line: 537, column: 25, scope: !861)
!871 = !DILocation(line: 537, column: 12, scope: !861)
!872 = !DILocation(line: 538, column: 17, scope: !861)
!873 = !DILocation(line: 538, column: 9, scope: !861)
!874 = !DILocation(line: 540, column: 9, scope: !868)
!875 = !DILocation(line: 540, column: 26, scope: !868)
!876 = !DILocation(line: 540, column: 9, scope: !861)
!877 = !DILocation(line: 542, column: 26, scope: !878)
!878 = distinct !DILexicalBlock(scope: !868, file: !3, line: 541, column: 5)
!879 = !DILocation(line: 543, column: 39, scope: !878)
!880 = !DILocation(line: 543, column: 44, scope: !878)
!881 = !DILocation(line: 544, column: 9, scope: !878)
!882 = !DILocation(line: 545, column: 5, scope: !878)
!883 = !DILocation(line: 549, column: 13, scope: !884)
!884 = distinct !DILexicalBlock(scope: !867, file: !3, line: 549, column: 13)
!885 = !DILocation(line: 549, column: 13, scope: !867)
!886 = !DILocation(line: 552, column: 70, scope: !887)
!887 = distinct !DILexicalBlock(scope: !884, file: !3, line: 550, column: 9)
!888 = !DILocation(line: 552, column: 39, scope: !887)
!889 = !DILocation(line: 552, column: 100, scope: !887)
!890 = !DILocation(line: 552, column: 26, scope: !887)
!891 = !DILocation(line: 547, column: 18, scope: !867)
!892 = !DILocation(line: 553, column: 9, scope: !887)
!893 = !DILocation(line: 556, column: 58, scope: !894)
!894 = distinct !DILexicalBlock(scope: !884, file: !3, line: 555, column: 9)
!895 = !DILocation(line: 0, scope: !894)
!896 = !DILocation(line: 558, column: 35, scope: !867)
!897 = !DILocation(line: 558, column: 16, scope: !867)
!898 = !DILocation(line: 558, column: 33, scope: !867)
!899 = !DILocation(line: 559, column: 9, scope: !867)
!900 = !DILocation(line: 560, column: 33, scope: !867)
!901 = !DILocation(line: 560, column: 38, scope: !867)
!902 = !DILocation(line: 561, column: 21, scope: !867)
!903 = !DILocation(line: 561, column: 9, scope: !867)
!904 = !DILocation(line: 563, column: 1, scope: !861)
!905 = distinct !DISubprogram(name: "find_prev", scope: !3, file: !3, line: 450, type: !186, isLocal: true, isDefinition: true, scopeLine: 450, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !906)
!906 = !{!907, !908}
!907 = !DILocalVariable(name: "block", arg: 1, scope: !905, file: !3, line: 450, type: !6)
!908 = !DILocalVariable(name: "footerp", scope: !909, file: !3, line: 460, type: !30)
!909 = distinct !DILexicalBlock(scope: !910, file: !3, line: 458, column: 5)
!910 = distinct !DILexicalBlock(scope: !905, file: !3, line: 452, column: 9)
!911 = !DILocation(line: 450, column: 36, scope: !905)
!912 = !DILocation(line: 452, column: 9, scope: !910)
!913 = !DILocation(line: 452, column: 9, scope: !905)
!914 = !DILocation(line: 455, column: 42, scope: !915)
!915 = distinct !DILexicalBlock(scope: !910, file: !3, line: 453, column: 5)
!916 = !DILocation(line: 455, column: 16, scope: !915)
!917 = !DILocation(line: 455, column: 9, scope: !915)
!918 = !DILocation(line: 460, column: 27, scope: !909)
!919 = !DILocation(line: 460, column: 17, scope: !909)
!920 = !DILocation(line: 461, column: 26, scope: !921)
!921 = distinct !DILexicalBlock(scope: !909, file: !3, line: 461, column: 13)
!922 = !DILocation(line: 461, column: 13, scope: !921)
!923 = !DILocation(line: 461, column: 36, scope: !921)
!924 = !DILocation(line: 461, column: 13, scope: !909)
!925 = !DILocation(line: 464, column: 16, scope: !909)
!926 = !DILocation(line: 464, column: 9, scope: !909)
!927 = !DILocation(line: 0, scope: !909)
!928 = !DILocation(line: 466, column: 1, scope: !905)
!929 = distinct !DISubprogram(name: "find_prev_footer", scope: !3, file: !3, line: 430, type: !849, isLocal: true, isDefinition: true, scopeLine: 430, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !930)
!930 = !{!931}
!931 = !DILocalVariable(name: "block", arg: 1, scope: !929, file: !3, line: 430, type: !6)
!932 = !DILocation(line: 430, column: 42, scope: !929)
!933 = !DILocation(line: 432, column: 21, scope: !929)
!934 = !DILocation(line: 432, column: 29, scope: !929)
!935 = !DILocation(line: 432, column: 5, scope: !929)
!936 = distinct !DISubprogram(name: "footer_to_header", scope: !3, file: !3, line: 323, type: !937, isLocal: true, isDefinition: true, scopeLine: 323, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !939)
!937 = !DISubroutineType(types: !938)
!938 = !{!6, !30}
!939 = !{!940, !941}
!940 = !DILocalVariable(name: "footer", arg: 1, scope: !936, file: !3, line: 323, type: !30)
!941 = !DILocalVariable(name: "size", scope: !936, file: !3, line: 324, type: !38)
!942 = !DILocation(line: 323, column: 42, scope: !936)
!943 = !DILocation(line: 324, column: 32, scope: !936)
!944 = !DILocation(line: 324, column: 19, scope: !936)
!945 = !DILocation(line: 324, column: 12, scope: !936)
!946 = !DILocation(line: 326, column: 39, scope: !936)
!947 = !DILocation(line: 326, column: 47, scope: !936)
!948 = !DILocation(line: 326, column: 12, scope: !936)
!949 = !DILocation(line: 326, column: 5, scope: !936)
