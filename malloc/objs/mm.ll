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
@str = private unnamed_addr constant [15 x i8] c"Prologue error\00"
@str.6 = private unnamed_addr constant [30 x i8] c"blocks outside the boundaries\00"

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_checkheap(i32) local_unnamed_addr #0 !dbg !72 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !76, metadata !DIExpression()), !dbg !82
  %2 = tail call i8* @mem_heap_lo() #4, !dbg !83
  call void @llvm.dbg.value(metadata i8* %2, metadata !77, metadata !DIExpression()), !dbg !84
  %3 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !85, !tbaa !86
  call void @llvm.dbg.value(metadata %struct.block* %3, metadata !78, metadata !DIExpression()), !dbg !90
  call void @llvm.dbg.value(metadata i64 0, metadata !79, metadata !DIExpression()), !dbg !91
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !81, metadata !DIExpression()), !dbg !92
  %4 = bitcast i8* %2 to i64*
  %5 = load i64, i64* %4, align 8, !tbaa !93
  %6 = and i64 %5, -11, !dbg !96
  %7 = icmp eq i64 %6, 1, !dbg !96
  br i1 %7, label %8, label %15, !dbg !96

; <label>:8:                                      ; preds = %1
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !81, metadata !DIExpression()), !dbg !92
  call void @llvm.dbg.value(metadata i64 undef, metadata !79, metadata !DIExpression()), !dbg !91
  call void @llvm.dbg.value(metadata %struct.block* %3, metadata !78, metadata !DIExpression()), !dbg !90
  %9 = getelementptr %struct.block, %struct.block* %3, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !93
  %11 = and i64 %10, -12, !dbg !98
  %12 = icmp eq i64 %11, 0, !dbg !98
  br i1 %12, label %73, label %13, !dbg !99

; <label>:13:                                     ; preds = %8
  %14 = bitcast %struct.block* %3 to i8*, !dbg !90
  br label %17, !dbg !100

; <label>:15:                                     ; preds = %1
  %16 = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str, i64 0, i64 0)), !dbg !103
  br label %73, !dbg !105

; <label>:17:                                     ; preds = %13, %65
  %18 = phi i64* [ %69, %65 ], [ %9, %13 ]
  %19 = phi %struct.block* [ %21, %65 ], [ null, %13 ]
  %20 = phi i8* [ %22, %65 ], [ null, %13 ]
  %21 = phi %struct.block* [ %68, %65 ], [ %3, %13 ]
  %22 = phi i8* [ %67, %65 ], [ %14, %13 ]
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !81, metadata !DIExpression()), !dbg !92
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !78, metadata !DIExpression()), !dbg !90
  %23 = tail call i8* @mem_heap_lo() #4, !dbg !100
  %24 = bitcast i8* %23 to %struct.block*, !dbg !106
  %25 = icmp ult %struct.block* %21, %24, !dbg !107
  br i1 %25, label %30, label %26, !dbg !108

; <label>:26:                                     ; preds = %17
  %27 = tail call i8* @mem_heap_hi() #4, !dbg !109
  %28 = bitcast i8* %27 to %struct.block*, !dbg !110
  %29 = icmp ugt %struct.block* %21, %28, !dbg !111
  br i1 %29, label %30, label %32, !dbg !112

; <label>:30:                                     ; preds = %26, %17
  %31 = tail call i32 @puts(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @str.6, i64 0, i64 0)), !dbg !113
  br label %73, !dbg !115

; <label>:32:                                     ; preds = %26
  %33 = load i64, i64* %18, align 8, !tbaa !93
  %34 = and i64 %33, 4, !dbg !116
  %35 = icmp eq i64 %34, 0, !dbg !130
  %36 = and i64 %33, -16, !dbg !131
  %37 = select i1 %35, i64 %36, i64 16, !dbg !138
  %38 = icmp eq i64 %37, 0, !dbg !139
  br i1 %38, label %39, label %41, !dbg !140

; <label>:39:                                     ; preds = %32
  %40 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0)), !dbg !141
  br label %73, !dbg !143

; <label>:41:                                     ; preds = %32
  %42 = icmp eq %struct.block* %19, null, !dbg !144
  %43 = icmp eq %struct.block* %19, %21, !dbg !146
  %44 = or i1 %42, %43, !dbg !147
  %45 = getelementptr %struct.block, %struct.block* %19, i64 0, i32 0
  %46 = load i64, i64* %45, align 8, !tbaa !93
  br i1 %44, label %59, label %47, !dbg !147

; <label>:47:                                     ; preds = %41
  %48 = and i64 %46, 4, !dbg !148
  %49 = icmp eq i64 %48, 0, !dbg !151
  %50 = and i64 %46, -16, !dbg !152
  %51 = select i1 %49, i64 %50, i64 16, !dbg !154
  %52 = icmp eq i64 %51, 0, !dbg !155
  br i1 %52, label %59, label %53, !dbg !156

; <label>:53:                                     ; preds = %47
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !157, metadata !DIExpression()), !dbg !162
  %54 = getelementptr inbounds i8, i8* %20, i64 %51, !dbg !166
  %55 = bitcast i8* %54 to %struct.block*, !dbg !167
  %56 = icmp eq %struct.block* %21, %55, !dbg !168
  br i1 %56, label %59, label %57, !dbg !169

; <label>:57:                                     ; preds = %53
  %58 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.4, i64 0, i64 0)), !dbg !170
  br label %73, !dbg !172

; <label>:59:                                     ; preds = %41, %53, %47
  %60 = or i64 %46, %33, !dbg !173
  %61 = and i64 %60, 1, !dbg !173
  %62 = icmp eq i64 %61, 0, !dbg !173
  br i1 %62, label %63, label %65, !dbg !173

; <label>:63:                                     ; preds = %59
  %64 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.5, i64 0, i64 0)), !dbg !175
  br label %73, !dbg !177

; <label>:65:                                     ; preds = %59
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !157, metadata !DIExpression()), !dbg !178
  %66 = bitcast %struct.block* %21 to i8*, !dbg !180
  %67 = getelementptr inbounds i8, i8* %66, i64 %37, !dbg !181
  %68 = bitcast i8* %67 to %struct.block*, !dbg !182
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !81, metadata !DIExpression()), !dbg !92
  call void @llvm.dbg.value(metadata i64 undef, metadata !79, metadata !DIExpression()), !dbg !91
  call void @llvm.dbg.value(metadata %struct.block* %68, metadata !78, metadata !DIExpression()), !dbg !90
  %69 = bitcast i8* %67 to i64*
  %70 = load i64, i64* %69, align 8, !tbaa !93
  %71 = and i64 %70, -12, !dbg !98
  %72 = icmp eq i64 %71, 0, !dbg !98
  br i1 %72, label %73, label %17, !dbg !99, !llvm.loop !183

; <label>:73:                                     ; preds = %65, %8, %63, %57, %39, %30, %15
  %74 = phi i1 [ false, %15 ], [ false, %30 ], [ false, %39 ], [ false, %57 ], [ false, %63 ], [ true, %8 ], [ true, %65 ], !dbg !185
  ret i1 %74, !dbg !186
}

declare dso_local i8* @mem_heap_lo() local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

declare dso_local i8* @mem_heap_hi() local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #0 !dbg !187 {
  %1 = tail call i8* @mem_sbrk(i64 16) #4, !dbg !193
  %2 = icmp eq i8* %1, inttoptr (i64 -1 to i8*), !dbg !194
  br i1 %2, label %22, label %3, !dbg !196

; <label>:3:                                      ; preds = %0
  call void @llvm.dbg.value(metadata i8* %1, metadata !191, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !208
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()), !dbg !210
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !211
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !213
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()), !dbg !217
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !218
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !219
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 11, metadata !207, metadata !DIExpression()), !dbg !221
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !221
  %4 = getelementptr inbounds i8, i8* %1, i64 8, !dbg !222
  %5 = bitcast i8* %1 to <2 x i64>*, !dbg !223
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %5, align 8, !dbg !223, !tbaa !224
  store i8* %4, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !225, !tbaa !86
  call void @llvm.dbg.value(metadata i64 4096, metadata !226, metadata !DIExpression()) #4, !dbg !234
  call void @llvm.dbg.value(metadata i64 4096, metadata !226, metadata !DIExpression()) #4, !dbg !234
  %6 = tail call i8* @mem_sbrk(i64 4096) #4, !dbg !237
  call void @llvm.dbg.value(metadata i8* %6, metadata !231, metadata !DIExpression()) #4, !dbg !239
  %7 = icmp eq i8* %6, inttoptr (i64 -1 to i8*), !dbg !240
  br i1 %7, label %22, label %8, !dbg !241

; <label>:8:                                      ; preds = %3
  call void @llvm.dbg.value(metadata i8* %6, metadata !242, metadata !DIExpression()) #4, !dbg !247
  %9 = getelementptr inbounds i8, i8* %6, i64 -8, !dbg !249
  %10 = bitcast i8* %9 to %struct.block*, !dbg !250
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !232, metadata !DIExpression()) #4, !dbg !251
  %11 = bitcast i8* %9 to i64*
  %12 = load i64, i64* %11, align 8, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !252, metadata !DIExpression()) #4, !dbg !265
  call void @llvm.dbg.value(metadata i64 4096, metadata !257, metadata !DIExpression()) #4, !dbg !267
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !268
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !269
  call void @llvm.dbg.value(metadata i64 4096, metadata !198, metadata !DIExpression()) #4, !dbg !270
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !272
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !273
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !274
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !274
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !274
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !274
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !274
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !274
  %13 = and i64 %12, 10, !dbg !275
  %14 = or i64 %13, 4096, !dbg !275
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !274
  store i64 %14, i64* %11, align 8, !dbg !276, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !277, metadata !DIExpression()) #4, !dbg !282
  %15 = getelementptr inbounds i8, i8* %6, i64 4080, !dbg !284
  %16 = bitcast i8* %15 to i64*, !dbg !285
  call void @llvm.dbg.value(metadata i64* %16, metadata !262, metadata !DIExpression()) #4, !dbg !286
  call void @llvm.dbg.value(metadata i64 4096, metadata !198, metadata !DIExpression()) #4, !dbg !287
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !289
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !290
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 %12, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !291
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !291
  store i64 %14, i64* %16, align 8, !dbg !292, !tbaa !224
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !157, metadata !DIExpression()) #4, !dbg !293
  %17 = getelementptr inbounds i8, i8* %6, i64 4088, !dbg !295
  call void @llvm.dbg.value(metadata i8* %17, metadata !233, metadata !DIExpression()) #4, !dbg !296
  call void @llvm.dbg.value(metadata i8* %17, metadata !297, metadata !DIExpression()) #4, !dbg !304
  call void @llvm.dbg.value(metadata i1 false, metadata !302, metadata !DIExpression()) #4, !dbg !306
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !307
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !308
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()) #4, !dbg !310
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !311
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !312
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !313
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !314
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !314
  %18 = bitcast i8* %17 to i64*, !dbg !315
  store i64 1, i64* %18, align 8, !dbg !316, !tbaa !93
  %19 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %10) #4, !dbg !317
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !232, metadata !DIExpression()) #4, !dbg !251
  %20 = icmp eq %struct.block* %19, null, !dbg !318
  br i1 %20, label %22, label %21, !dbg !319

; <label>:21:                                     ; preds = %8
  call void @llvm.memset.p0i8.i64(i8* align 16 bitcast ([15 x %struct.block*]* @list_head to i8*), i8 0, i64 120, i1 false), !dbg !320
  br label %22, !dbg !324

; <label>:22:                                     ; preds = %21, %3, %8, %0
  %23 = phi i1 [ false, %0 ], [ false, %8 ], [ false, %3 ], [ true, %21 ], !dbg !325
  ret i1 %23, !dbg !324
}

declare dso_local i8* @mem_sbrk(i64) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_malloc(i64) local_unnamed_addr #0 !dbg !326 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !330, metadata !DIExpression()), !dbg !338
  call void @llvm.dbg.value(metadata i8* null, metadata !334, metadata !DIExpression()), !dbg !339
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !340, !tbaa !86
  %3 = icmp eq %struct.block* %2, null, !dbg !342
  br i1 %3, label %4, label %26, !dbg !343

; <label>:4:                                      ; preds = %1
  %5 = tail call i8* @mem_sbrk(i64 16) #4, !dbg !344
  %6 = icmp eq i8* %5, inttoptr (i64 -1 to i8*), !dbg !347
  br i1 %6, label %26, label %7, !dbg !348

; <label>:7:                                      ; preds = %4
  call void @llvm.dbg.value(metadata i8* %5, metadata !191, metadata !DIExpression()) #4, !dbg !349
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !350
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()) #4, !dbg !352
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !353
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !354
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !355
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !356
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !357
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()) #4, !dbg !359
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !360
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()) #4, !dbg !361
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !362
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 11, metadata !207, metadata !DIExpression()) #4, !dbg !363
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !363
  %8 = getelementptr inbounds i8, i8* %5, i64 8, !dbg !364
  %9 = bitcast i8* %5 to <2 x i64>*, !dbg !365
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %9, align 8, !dbg !365, !tbaa !224
  store i8* %8, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !366, !tbaa !86
  call void @llvm.dbg.value(metadata i64 4096, metadata !226, metadata !DIExpression()) #4, !dbg !367
  call void @llvm.dbg.value(metadata i64 4096, metadata !226, metadata !DIExpression()) #4, !dbg !367
  %10 = tail call i8* @mem_sbrk(i64 4096) #4, !dbg !369
  call void @llvm.dbg.value(metadata i8* %10, metadata !231, metadata !DIExpression()) #4, !dbg !370
  %11 = icmp eq i8* %10, inttoptr (i64 -1 to i8*), !dbg !371
  br i1 %11, label %26, label %12, !dbg !372

; <label>:12:                                     ; preds = %7
  call void @llvm.dbg.value(metadata i8* %10, metadata !242, metadata !DIExpression()) #4, !dbg !373
  %13 = getelementptr inbounds i8, i8* %10, i64 -8, !dbg !375
  %14 = bitcast i8* %13 to %struct.block*, !dbg !376
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !232, metadata !DIExpression()) #4, !dbg !377
  %15 = bitcast i8* %13 to i64*
  %16 = load i64, i64* %15, align 8, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !252, metadata !DIExpression()) #4, !dbg !378
  call void @llvm.dbg.value(metadata i64 4096, metadata !257, metadata !DIExpression()) #4, !dbg !380
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !381
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !382
  call void @llvm.dbg.value(metadata i64 4096, metadata !198, metadata !DIExpression()) #4, !dbg !383
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !385
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !386
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !387
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !387
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !387
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !387
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !387
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !387
  %17 = and i64 %16, 10, !dbg !388
  %18 = or i64 %17, 4096, !dbg !388
  call void @llvm.dbg.value(metadata i64 %18, metadata !207, metadata !DIExpression()) #4, !dbg !387
  store i64 %18, i64* %15, align 8, !dbg !389, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !277, metadata !DIExpression()) #4, !dbg !390
  %19 = getelementptr inbounds i8, i8* %10, i64 4080, !dbg !392
  %20 = bitcast i8* %19 to i64*, !dbg !393
  call void @llvm.dbg.value(metadata i64* %20, metadata !262, metadata !DIExpression()) #4, !dbg !394
  call void @llvm.dbg.value(metadata i64 4096, metadata !198, metadata !DIExpression()) #4, !dbg !395
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !397
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !398
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression()) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 4096, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !399
  call void @llvm.dbg.value(metadata i64 %18, metadata !207, metadata !DIExpression()) #4, !dbg !399
  store i64 %18, i64* %20, align 8, !dbg !400, !tbaa !224
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !157, metadata !DIExpression()) #4, !dbg !401
  %21 = getelementptr inbounds i8, i8* %10, i64 4088, !dbg !403
  call void @llvm.dbg.value(metadata i8* %21, metadata !233, metadata !DIExpression()) #4, !dbg !404
  call void @llvm.dbg.value(metadata i8* %21, metadata !297, metadata !DIExpression()) #4, !dbg !405
  call void @llvm.dbg.value(metadata i1 false, metadata !302, metadata !DIExpression()) #4, !dbg !407
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !408
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !409
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()) #4, !dbg !411
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !412
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !413
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !414
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !415
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !415
  %22 = bitcast i8* %21 to i64*, !dbg !416
  store i64 1, i64* %22, align 8, !dbg !417, !tbaa !93
  %23 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %14) #4, !dbg !418
  call void @llvm.dbg.value(metadata %struct.block* %23, metadata !232, metadata !DIExpression()) #4, !dbg !377
  %24 = icmp eq %struct.block* %23, null, !dbg !419
  br i1 %24, label %26, label %25, !dbg !420

; <label>:25:                                     ; preds = %12
  tail call void @llvm.memset.p0i8.i64(i8* align 16 bitcast ([15 x %struct.block*]* @list_head to i8*), i8 0, i64 120, i1 false) #4, !dbg !421
  br label %26, !dbg !422

; <label>:26:                                     ; preds = %25, %12, %7, %4, %1
  %27 = icmp eq i64 %0, 0, !dbg !423
  br i1 %27, label %339, label %28, !dbg !425

; <label>:28:                                     ; preds = %26
  call void @llvm.dbg.value(metadata i64 %0, metadata !426, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !432
  call void @llvm.dbg.value(metadata i64 16, metadata !431, metadata !DIExpression()), !dbg !434
  %29 = add i64 %0, 23, !dbg !435
  %30 = and i64 %29, -16, !dbg !436
  call void @llvm.dbg.value(metadata i64 %30, metadata !331, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i64 %30, metadata !438, metadata !DIExpression()), !dbg !445
  call void @llvm.dbg.value(metadata i64 %30, metadata !447, metadata !DIExpression()), !dbg !454
  %31 = icmp eq i64 %30, 16, !dbg !456
  br i1 %31, label %42, label %32, !dbg !458

; <label>:32:                                     ; preds = %28, %32
  %33 = phi i64 [ %35, %32 ], [ 32, %28 ], !dbg !459
  %34 = phi i32 [ %39, %32 ], [ 1, %28 ], !dbg !459
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i64 %33, metadata !452, metadata !DIExpression()), !dbg !462
  %35 = shl i64 %33, 1, !dbg !463
  %36 = icmp ult i64 %35, %30, !dbg !464
  %37 = icmp ult i32 %34, 14, !dbg !465
  %38 = and i1 %36, %37, !dbg !466
  %39 = add nuw nsw i32 %34, 1, !dbg !467
  call void @llvm.dbg.value(metadata i32 %39, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i64 %35, metadata !452, metadata !DIExpression()), !dbg !462
  br i1 %38, label %32, label %40, !dbg !468, !llvm.loop !469

; <label>:40:                                     ; preds = %32
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !453, metadata !DIExpression()), !dbg !461
  call void @llvm.dbg.value(metadata i32 %34, metadata !441, metadata !DIExpression()), !dbg !472
  call void @llvm.dbg.value(metadata i32 %34, metadata !442, metadata !DIExpression()), !dbg !473
  %41 = icmp ult i32 %34, 15, !dbg !474
  br i1 %41, label %42, label %69, !dbg !475

; <label>:42:                                     ; preds = %40, %28
  %43 = phi i32 [ %34, %40 ], [ 0, %28 ]
  %44 = zext i32 %43 to i64, !dbg !476
  br label %45, !dbg !476

; <label>:45:                                     ; preds = %63, %42
  %46 = phi i64 [ %44, %42 ], [ %64, %63 ]
  call void @llvm.dbg.value(metadata i64 %46, metadata !442, metadata !DIExpression()), !dbg !473
  %47 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %46, !dbg !476
  %48 = load %struct.block*, %struct.block** %47, align 8, !dbg !476, !tbaa !86
  call void @llvm.dbg.value(metadata %struct.block* %48, metadata !443, metadata !DIExpression()), !dbg !477
  %49 = icmp eq %struct.block* %48, null, !dbg !478
  br i1 %49, label %63, label %50, !dbg !480

; <label>:50:                                     ; preds = %45, %59
  %51 = phi %struct.block* [ %61, %59 ], [ %48, %45 ], !dbg !481
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  %52 = getelementptr %struct.block, %struct.block* %51, i64 0, i32 0
  %53 = load i64, i64* %52, align 8, !tbaa !93
  %54 = and i64 %53, 4, !dbg !484
  %55 = icmp eq i64 %54, 0, !dbg !488
  %56 = and i64 %53, -16, !dbg !489
  %57 = select i1 %55, i64 %56, i64 16, !dbg !491
  %58 = icmp ult i64 %57, %30, !dbg !492
  br i1 %58, label %59, label %66, !dbg !493

; <label>:59:                                     ; preds = %50
  %60 = getelementptr inbounds %struct.block, %struct.block* %51, i64 0, i32 1, i32 0, i32 0, !dbg !494
  %61 = load %struct.block*, %struct.block** %60, align 8, !dbg !494, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %61, metadata !443, metadata !DIExpression()), !dbg !477
  %62 = icmp eq %struct.block* %61, %48, !dbg !496
  br i1 %62, label %63, label %50, !dbg !497, !llvm.loop !498

; <label>:63:                                     ; preds = %59, %45
  %64 = add nuw nsw i64 %46, 1, !dbg !501
  call void @llvm.dbg.value(metadata i32 undef, metadata !442, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !473
  %65 = icmp ult i64 %64, 15, !dbg !474
  br i1 %65, label %45, label %69, !dbg !475

; <label>:66:                                     ; preds = %50
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  %67 = getelementptr %struct.block, %struct.block* %51, i64 0, i32 0
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !443, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata %struct.block* %51, metadata !333, metadata !DIExpression()), !dbg !502
  %68 = icmp eq %struct.block* %51, null, !dbg !503
  br i1 %68, label %69, label %99, !dbg !505

; <label>:69:                                     ; preds = %63, %40, %66
  call void @llvm.dbg.value(metadata i64 %30, metadata !506, metadata !DIExpression()), !dbg !510
  call void @llvm.dbg.value(metadata i64 4096, metadata !509, metadata !DIExpression()), !dbg !513
  %70 = icmp ugt i64 %30, 4096, !dbg !514
  %71 = select i1 %70, i64 %30, i64 4096, !dbg !515
  call void @llvm.dbg.value(metadata i64 %71, metadata !332, metadata !DIExpression()), !dbg !516
  call void @llvm.dbg.value(metadata i64 %71, metadata !226, metadata !DIExpression()) #4, !dbg !517
  call void @llvm.dbg.value(metadata i64 %71, metadata !426, metadata !DIExpression()) #4, !dbg !519
  call void @llvm.dbg.value(metadata i64 16, metadata !431, metadata !DIExpression()) #4, !dbg !521
  call void @llvm.dbg.value(metadata i64 %71, metadata !226, metadata !DIExpression()) #4, !dbg !517
  %72 = tail call i8* @mem_sbrk(i64 %71) #4, !dbg !522
  call void @llvm.dbg.value(metadata i8* %72, metadata !231, metadata !DIExpression()) #4, !dbg !523
  %73 = icmp eq i8* %72, inttoptr (i64 -1 to i8*), !dbg !524
  br i1 %73, label %339, label %74, !dbg !525

; <label>:74:                                     ; preds = %69
  call void @llvm.dbg.value(metadata i8* %72, metadata !242, metadata !DIExpression()) #4, !dbg !526
  %75 = getelementptr inbounds i8, i8* %72, i64 -8, !dbg !528
  %76 = bitcast i8* %75 to %struct.block*, !dbg !529
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !232, metadata !DIExpression()) #4, !dbg !530
  %77 = bitcast i8* %75 to i64*
  %78 = load i64, i64* %77, align 8, !tbaa !93
  %79 = and i64 %78, 8, !dbg !531
  %80 = and i64 %78, 2, !dbg !536
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !252, metadata !DIExpression()) #4, !dbg !541
  call void @llvm.dbg.value(metadata i64 %71, metadata !257, metadata !DIExpression()) #4, !dbg !543
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !544
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !545
  call void @llvm.dbg.value(metadata i64 %71, metadata !198, metadata !DIExpression()) #4, !dbg !546
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !548
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !549
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression()) #4, !dbg !550
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression()) #4, !dbg !550
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !550
  %81 = or i64 %80, %71, !dbg !551
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression()) #4, !dbg !550
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression()) #4, !dbg !550
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !550
  %82 = or i64 %81, %79, !dbg !552
  call void @llvm.dbg.value(metadata i64 %82, metadata !207, metadata !DIExpression()) #4, !dbg !550
  store i64 %82, i64* %77, align 8, !dbg !553, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !277, metadata !DIExpression()) #4, !dbg !554
  %83 = getelementptr inbounds i8, i8* %72, i64 %71, !dbg !556
  %84 = getelementptr inbounds i8, i8* %83, i64 -16, !dbg !557
  %85 = bitcast i8* %84 to i64*, !dbg !558
  call void @llvm.dbg.value(metadata i64* %85, metadata !262, metadata !DIExpression()) #4, !dbg !559
  call void @llvm.dbg.value(metadata i64 %71, metadata !198, metadata !DIExpression()) #4, !dbg !560
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !562
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !563
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression()) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression()) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %71, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression()) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression()) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %81, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !564
  call void @llvm.dbg.value(metadata i64 %82, metadata !207, metadata !DIExpression()) #4, !dbg !564
  store i64 %82, i64* %85, align 8, !dbg !565, !tbaa !224
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !157, metadata !DIExpression()) #4, !dbg !566
  %86 = load i64, i64* %77, align 8, !tbaa !93
  %87 = and i64 %86, 4, !dbg !568
  %88 = icmp eq i64 %87, 0, !dbg !571
  %89 = and i64 %86, -16, !dbg !572
  %90 = select i1 %88, i64 %89, i64 16, !dbg !574
  %91 = getelementptr inbounds i8, i8* %75, i64 %90, !dbg !575
  call void @llvm.dbg.value(metadata i8* %91, metadata !233, metadata !DIExpression()) #4, !dbg !576
  call void @llvm.dbg.value(metadata i8* %91, metadata !297, metadata !DIExpression()) #4, !dbg !577
  call void @llvm.dbg.value(metadata i1 false, metadata !302, metadata !DIExpression()) #4, !dbg !579
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !580
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !581
  call void @llvm.dbg.value(metadata i1 false, metadata !203, metadata !DIExpression()) #4, !dbg !583
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !584
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !585
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !586
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !587
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !587
  %92 = bitcast i8* %91 to i64*, !dbg !588
  store i64 1, i64* %92, align 8, !dbg !589, !tbaa !93
  %93 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %76) #4, !dbg !590
  call void @llvm.dbg.value(metadata %struct.block* %93, metadata !232, metadata !DIExpression()) #4, !dbg !530
  call void @llvm.dbg.value(metadata %struct.block* %93, metadata !333, metadata !DIExpression()), !dbg !502
  %94 = icmp eq %struct.block* %93, null, !dbg !591
  br i1 %94, label %339, label %95, !dbg !593

; <label>:95:                                     ; preds = %74
  %96 = getelementptr %struct.block, %struct.block* %93, i64 0, i32 0
  %97 = load i64, i64* %96, align 8, !tbaa !93
  %98 = and i64 %97, -16, !dbg !594
  br label %99, !dbg !593

; <label>:99:                                     ; preds = %95, %66
  %100 = phi i64 [ %98, %95 ], [ %56, %66 ], !dbg !594
  %101 = phi i64* [ %96, %95 ], [ %67, %66 ]
  %102 = phi i64 [ %97, %95 ], [ %53, %66 ]
  %103 = phi %struct.block* [ %93, %95 ], [ %51, %66 ], !dbg !606
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !333, metadata !DIExpression()), !dbg !502
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !601, metadata !DIExpression()), !dbg !607
  %104 = and i64 %102, 4, !dbg !608
  %105 = icmp eq i64 %104, 0, !dbg !610
  %106 = icmp eq i64 %100, 16, !dbg !611
  %107 = xor i1 %105, true, !dbg !611
  %108 = or i1 %106, %107, !dbg !611
  br i1 %108, label %117, label %109, !dbg !613

; <label>:109:                                    ; preds = %99, %109
  %110 = phi i64 [ %112, %109 ], [ 32, %99 ], !dbg !614
  %111 = phi i32 [ %116, %109 ], [ 1, %99 ], !dbg !614
  call void @llvm.dbg.value(metadata i32 %111, metadata !453, metadata !DIExpression()), !dbg !615
  call void @llvm.dbg.value(metadata i64 %110, metadata !452, metadata !DIExpression()), !dbg !616
  %112 = shl i64 %110, 1, !dbg !617
  %113 = icmp ult i64 %112, %100, !dbg !618
  %114 = icmp ult i32 %111, 14, !dbg !619
  %115 = and i1 %113, %114, !dbg !620
  %116 = add nuw nsw i32 %111, 1, !dbg !621
  call void @llvm.dbg.value(metadata i32 %116, metadata !453, metadata !DIExpression()), !dbg !615
  call void @llvm.dbg.value(metadata i64 %112, metadata !452, metadata !DIExpression()), !dbg !616
  br i1 %115, label %109, label %117, !dbg !622, !llvm.loop !469

; <label>:117:                                    ; preds = %109, %99
  %118 = phi i32 [ 0, %99 ], [ %111, %109 ], !dbg !623
  call void @llvm.dbg.value(metadata i32 %118, metadata !603, metadata !DIExpression()), !dbg !624
  %119 = zext i32 %118 to i64, !dbg !625
  %120 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %119, !dbg !625
  %121 = load %struct.block*, %struct.block** %120, align 8, !dbg !625, !tbaa !86
  %122 = icmp eq %struct.block* %121, %103, !dbg !627
  br i1 %122, label %123, label %129, !dbg !628

; <label>:123:                                    ; preds = %117
  %124 = getelementptr inbounds %struct.block, %struct.block* %103, i64 0, i32 1, i32 0, i32 0, !dbg !629
  %125 = load %struct.block*, %struct.block** %124, align 8, !dbg !629, !tbaa !495
  %126 = icmp eq %struct.block* %125, %103, !dbg !632
  br i1 %126, label %127, label %128, !dbg !633

; <label>:127:                                    ; preds = %123
  store %struct.block* null, %struct.block** %120, align 8, !dbg !634, !tbaa !86
  br label %160, !dbg !636

; <label>:128:                                    ; preds = %123
  store %struct.block* %125, %struct.block** %120, align 8, !dbg !637, !tbaa !86
  br label %129, !dbg !639

; <label>:129:                                    ; preds = %128, %117
  br i1 %105, label %133, label %130, !dbg !640

; <label>:130:                                    ; preds = %129
  call void @llvm.dbg.value(metadata i64 %102, metadata !136, metadata !DIExpression()), !dbg !641
  %131 = lshr exact i64 %100, 1, !dbg !645
  %132 = inttoptr i64 %131 to %struct.block*, !dbg !646
  call void @llvm.dbg.value(metadata %struct.block* %132, metadata !604, metadata !DIExpression()), !dbg !647
  br label %136, !dbg !648

; <label>:133:                                    ; preds = %129
  %134 = getelementptr inbounds %struct.block, %struct.block* %103, i64 0, i32 1, i32 0, i32 1, !dbg !649
  %135 = load %struct.block*, %struct.block** %134, align 8, !dbg !649, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %135, metadata !604, metadata !DIExpression()), !dbg !647
  br label %136

; <label>:136:                                    ; preds = %133, %130
  %137 = phi %struct.block* [ %132, %130 ], [ %135, %133 ], !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* %137, metadata !604, metadata !DIExpression()), !dbg !647
  %138 = getelementptr inbounds %struct.block, %struct.block* %103, i64 0, i32 1, i32 0, i32 0, !dbg !652
  %139 = load %struct.block*, %struct.block** %138, align 8, !dbg !652, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %139, metadata !653, metadata !DIExpression()), !dbg !659
  call void @llvm.dbg.value(metadata %struct.block* %137, metadata !658, metadata !DIExpression()), !dbg !661
  %140 = getelementptr %struct.block, %struct.block* %139, i64 0, i32 0
  %141 = load i64, i64* %140, align 8, !tbaa !93
  %142 = and i64 %141, 4, !dbg !662
  %143 = icmp eq i64 %142, 0, !dbg !665
  br i1 %143, label %150, label %144, !dbg !666

; <label>:144:                                    ; preds = %136
  %145 = ptrtoint %struct.block* %137 to i64, !dbg !667
  %146 = shl i64 %145, 1, !dbg !669
  %147 = and i64 %146, -16, !dbg !670
  %148 = and i64 %141, 15, !dbg !671
  %149 = or i64 %148, %147, !dbg !672
  store i64 %149, i64* %140, align 8, !dbg !673, !tbaa !93
  br label %152, !dbg !674

; <label>:150:                                    ; preds = %136
  %151 = getelementptr inbounds %struct.block, %struct.block* %139, i64 0, i32 1, i32 0, i32 1, !dbg !675
  store %struct.block* %137, %struct.block** %151, align 8, !dbg !677, !tbaa !495
  br label %152

; <label>:152:                                    ; preds = %150, %144
  %153 = bitcast %struct.block** %138 to i64*, !dbg !678
  %154 = load i64, i64* %153, align 8, !dbg !678, !tbaa !495
  %155 = getelementptr inbounds %struct.block, %struct.block* %137, i64 0, i32 1, !dbg !679
  %156 = bitcast %union.mem_t* %155 to i64*, !dbg !680
  store i64 %154, i64* %156, align 8, !dbg !680, !tbaa !495
  %157 = load i64, i64* %101, align 8, !tbaa !93
  %158 = and i64 %157, 4, !dbg !681
  %159 = and i64 %157, -16, !dbg !684
  br label %160, !dbg !686

; <label>:160:                                    ; preds = %127, %152
  %161 = phi i64 [ %100, %127 ], [ %159, %152 ], !dbg !684
  %162 = phi i64 [ %104, %127 ], [ %158, %152 ], !dbg !681
  %163 = phi i64 [ %102, %127 ], [ %157, %152 ]
  %164 = icmp eq i64 %162, 0, !dbg !687
  %165 = select i1 %164, i64 %161, i64 16, !dbg !688
  call void @llvm.dbg.value(metadata i64 %165, metadata !335, metadata !DIExpression()), !dbg !689
  %166 = and i64 %163, 8, !dbg !690
  %167 = icmp eq i64 %165, 16, !dbg !692
  %168 = and i64 %163, 2, !dbg !693
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !252, metadata !DIExpression()), !dbg !695
  call void @llvm.dbg.value(metadata i64 %165, metadata !257, metadata !DIExpression()), !dbg !697
  call void @llvm.dbg.value(metadata i1 %167, metadata !259, metadata !DIExpression()), !dbg !698
  call void @llvm.dbg.value(metadata i1 true, metadata !261, metadata !DIExpression()), !dbg !699
  call void @llvm.dbg.value(metadata i64 %165, metadata !198, metadata !DIExpression()), !dbg !700
  call void @llvm.dbg.value(metadata i1 %167, metadata !204, metadata !DIExpression()), !dbg !702
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !703
  call void @llvm.dbg.value(metadata i64 %165, metadata !207, metadata !DIExpression()), !dbg !704
  call void @llvm.dbg.value(metadata i64 %165, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !704
  call void @llvm.dbg.value(metadata i64 %165, metadata !207, metadata !DIExpression(DW_OP_constu, 3, DW_OP_or, DW_OP_stack_value)), !dbg !704
  %169 = or i64 %168, %165, !dbg !705
  call void @llvm.dbg.value(metadata i64 %169, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !704
  %170 = select i1 %167, i64 5, i64 1, !dbg !706
  %171 = or i64 %169, %170, !dbg !706
  call void @llvm.dbg.value(metadata i64 %171, metadata !207, metadata !DIExpression()), !dbg !704
  call void @llvm.dbg.value(metadata i64 %171, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !704
  %172 = or i64 %171, %166, !dbg !707
  call void @llvm.dbg.value(metadata i64 %172, metadata !207, metadata !DIExpression()), !dbg !704
  store i64 %172, i64* %101, align 8, !dbg !708, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !709, metadata !DIExpression()), !dbg !722
  call void @llvm.dbg.value(metadata i64 %30, metadata !714, metadata !DIExpression()), !dbg !724
  %173 = and i64 %170, 4, !dbg !725
  %174 = icmp eq i64 %173, 0, !dbg !728
  %175 = select i1 %174, i64 %165, i64 16, !dbg !729
  call void @llvm.dbg.value(metadata i64 %175, metadata !715, metadata !DIExpression()), !dbg !730
  %176 = sub i64 %175, %30, !dbg !731
  %177 = icmp eq i64 %176, 0, !dbg !732
  br i1 %177, label %178, label %180, !dbg !733

; <label>:178:                                    ; preds = %160
  %179 = bitcast %struct.block* %103 to i8*, !dbg !734
  br label %305, !dbg !733

; <label>:180:                                    ; preds = %160
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !252, metadata !DIExpression()), !dbg !736
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !252, metadata !DIExpression()), !dbg !740
  call void @llvm.dbg.value(metadata i64 %30, metadata !257, metadata !DIExpression()), !dbg !743
  call void @llvm.dbg.value(metadata i64 %30, metadata !257, metadata !DIExpression()), !dbg !744
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !745
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !747
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression(DW_OP_constu, 3, DW_OP_or, DW_OP_stack_value)), !dbg !745
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression(DW_OP_constu, 3, DW_OP_or, DW_OP_stack_value)), !dbg !747
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !747
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !745
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()), !dbg !749
  call void @llvm.dbg.value(metadata i1 true, metadata !261, metadata !DIExpression()), !dbg !750
  call void @llvm.dbg.value(metadata i64 %30, metadata !198, metadata !DIExpression()), !dbg !751
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !752
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !753
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression()), !dbg !747
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !747
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 9, DW_OP_or, DW_OP_stack_value)), !dbg !747
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()), !dbg !754
  call void @llvm.dbg.value(metadata i1 true, metadata !261, metadata !DIExpression()), !dbg !755
  call void @llvm.dbg.value(metadata i64 %30, metadata !198, metadata !DIExpression()), !dbg !756
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()), !dbg !757
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !758
  call void @llvm.dbg.value(metadata i64 %30, metadata !207, metadata !DIExpression()), !dbg !745
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 5, DW_OP_or, DW_OP_stack_value)), !dbg !745
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 13, DW_OP_or, DW_OP_stack_value)), !dbg !745
  %181 = select i1 %31, i64 5, i64 1, !dbg !759
  %182 = or i64 %181, %30, !dbg !759
  %183 = or i64 %182, %168, !dbg !760
  %184 = or i64 %183, %166, !dbg !761
  store i64 %184, i64* %101, align 8, !dbg !762, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !157, metadata !DIExpression()), !dbg !763
  %185 = bitcast %struct.block* %103 to i8*, !dbg !765
  %186 = and i64 %181, 4, !dbg !766
  %187 = icmp eq i64 %186, 0, !dbg !769
  %188 = select i1 %187, i64 %30, i64 16, !dbg !770
  %189 = getelementptr inbounds i8, i8* %185, i64 %188, !dbg !771
  call void @llvm.dbg.value(metadata i8* %189, metadata !716, metadata !DIExpression()), !dbg !772
  %190 = icmp eq i64 %176, 16, !dbg !773
  %191 = bitcast i8* %189 to i64*
  %192 = load i64, i64* %191, align 8, !tbaa !93
  %193 = and i64 %192, 8, !dbg !774
  call void @llvm.dbg.value(metadata i8* %189, metadata !252, metadata !DIExpression()), !dbg !778
  call void @llvm.dbg.value(metadata i8* %189, metadata !252, metadata !DIExpression()), !dbg !781
  call void @llvm.dbg.value(metadata i64 %176, metadata !257, metadata !DIExpression()), !dbg !783
  call void @llvm.dbg.value(metadata i64 %176, metadata !257, metadata !DIExpression()), !dbg !784
  %194 = or i64 %193, %176, !dbg !785
  br i1 %190, label %195, label %197, !dbg !787

; <label>:195:                                    ; preds = %180
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()), !dbg !788
  call void @llvm.dbg.value(metadata i1 true, metadata !260, metadata !DIExpression()), !dbg !789
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()), !dbg !790
  call void @llvm.dbg.value(metadata i64 %176, metadata !198, metadata !DIExpression()), !dbg !791
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()), !dbg !792
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !794
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !795
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !795
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 6, DW_OP_or, DW_OP_stack_value)), !dbg !795
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 14, DW_OP_or, DW_OP_stack_value)), !dbg !795
  %196 = or i64 %194, 6, !dbg !785
  call void @llvm.dbg.value(metadata i64 %196, metadata !207, metadata !DIExpression()), !dbg !795
  store i64 %196, i64* %191, align 8, !dbg !796, !tbaa !93
  br label %204, !dbg !797

; <label>:197:                                    ; preds = %180
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !798
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !798
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !795
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !795
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()), !dbg !800
  call void @llvm.dbg.value(metadata i1 true, metadata !260, metadata !DIExpression()), !dbg !801
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()), !dbg !802
  call void @llvm.dbg.value(metadata i64 %176, metadata !198, metadata !DIExpression()), !dbg !803
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !804
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !805
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !798
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !798
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !798
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 10, DW_OP_or, DW_OP_stack_value)), !dbg !798
  %198 = or i64 %194, 2, !dbg !807
  call void @llvm.dbg.value(metadata i64 %198, metadata !207, metadata !DIExpression()), !dbg !798
  store i64 %198, i64* %191, align 8, !dbg !808, !tbaa !93
  call void @llvm.dbg.value(metadata i8* %189, metadata !277, metadata !DIExpression()), !dbg !809
  %199 = getelementptr inbounds i8, i8* %189, i64 8, !dbg !811
  %200 = getelementptr inbounds i8, i8* %199, i64 %176, !dbg !812
  %201 = getelementptr inbounds i8, i8* %200, i64 -16, !dbg !813
  %202 = bitcast i8* %201 to i64*, !dbg !814
  call void @llvm.dbg.value(metadata i64* %202, metadata !262, metadata !DIExpression()), !dbg !815
  call void @llvm.dbg.value(metadata i64 %176, metadata !198, metadata !DIExpression()), !dbg !816
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !818
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !819
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !820
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !821
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression()), !dbg !821
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !821
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !821
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !821
  call void @llvm.dbg.value(metadata i64 %176, metadata !207, metadata !DIExpression(DW_OP_constu, 10, DW_OP_or, DW_OP_stack_value)), !dbg !821
  call void @llvm.dbg.value(metadata i64 %198, metadata !207, metadata !DIExpression()), !dbg !821
  store i64 %198, i64* %202, align 8, !dbg !822, !tbaa !224
  %203 = load i64, i64* %191, align 8, !tbaa !93
  br label %204

; <label>:204:                                    ; preds = %197, %195
  %205 = phi i64 [ %203, %197 ], [ %196, %195 ]
  call void @llvm.dbg.value(metadata i8* %189, metadata !823, metadata !DIExpression()), !dbg !831
  %206 = and i64 %205, 4, !dbg !833
  %207 = icmp eq i64 %206, 0, !dbg !836
  %208 = and i64 %205, -16, !dbg !837
  %209 = icmp eq i64 %208, 16, !dbg !839
  %210 = xor i1 %207, true, !dbg !839
  %211 = or i1 %209, %210, !dbg !839
  br i1 %211, label %220, label %212, !dbg !841

; <label>:212:                                    ; preds = %204, %212
  %213 = phi i64 [ %215, %212 ], [ 32, %204 ], !dbg !842
  %214 = phi i32 [ %219, %212 ], [ 1, %204 ], !dbg !842
  call void @llvm.dbg.value(metadata i32 %214, metadata !453, metadata !DIExpression()), !dbg !843
  call void @llvm.dbg.value(metadata i64 %213, metadata !452, metadata !DIExpression()), !dbg !844
  %215 = shl i64 %213, 1, !dbg !845
  %216 = icmp ult i64 %215, %208, !dbg !846
  %217 = icmp ult i32 %214, 14, !dbg !847
  %218 = and i1 %216, %217, !dbg !848
  %219 = add nuw nsw i32 %214, 1, !dbg !849
  call void @llvm.dbg.value(metadata i32 %219, metadata !453, metadata !DIExpression()), !dbg !843
  call void @llvm.dbg.value(metadata i64 %215, metadata !452, metadata !DIExpression()), !dbg !844
  br i1 %218, label %212, label %220, !dbg !850, !llvm.loop !469

; <label>:220:                                    ; preds = %212, %204
  %221 = phi i32 [ 0, %204 ], [ %214, %212 ], !dbg !851
  call void @llvm.dbg.value(metadata i32 %221, metadata !827, metadata !DIExpression()), !dbg !852
  %222 = zext i32 %221 to i64, !dbg !853
  %223 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %222, !dbg !853
  %224 = load %struct.block*, %struct.block** %223, align 8, !dbg !853, !tbaa !86
  %225 = icmp eq %struct.block* %224, null, !dbg !854
  %226 = ptrtoint %struct.block* %224 to i64, !dbg !855
  br i1 %225, label %227, label %240, !dbg !855

; <label>:227:                                    ; preds = %220
  %228 = bitcast %struct.block** %223 to i8**, !dbg !856
  store i8* %189, i8** %228, align 8, !dbg !856, !tbaa !86
  %229 = getelementptr inbounds i8, i8* %189, i64 8, !dbg !858
  %230 = bitcast i8* %229 to i8**, !dbg !859
  store i8* %189, i8** %230, align 8, !dbg !859, !tbaa !495
  call void @llvm.dbg.value(metadata i8* %189, metadata !653, metadata !DIExpression()), !dbg !860
  call void @llvm.dbg.value(metadata i8* %189, metadata !658, metadata !DIExpression()), !dbg !862
  br i1 %207, label %237, label %231, !dbg !863

; <label>:231:                                    ; preds = %227
  %232 = ptrtoint i8* %189 to i64, !dbg !864
  %233 = shl i64 %232, 1, !dbg !865
  %234 = and i64 %233, -16, !dbg !866
  %235 = and i64 %205, 15, !dbg !867
  %236 = or i64 %235, %234, !dbg !868
  store i64 %236, i64* %191, align 8, !dbg !869, !tbaa !93
  br label %277, !dbg !870

; <label>:237:                                    ; preds = %227
  %238 = getelementptr inbounds i8, i8* %189, i64 16, !dbg !871
  %239 = bitcast i8* %238 to i8**, !dbg !872
  store i8* %189, i8** %239, align 8, !dbg !872, !tbaa !495
  br label %277

; <label>:240:                                    ; preds = %220
  br i1 %207, label %252, label %241, !dbg !873

; <label>:241:                                    ; preds = %240
  %242 = getelementptr inbounds %struct.block, %struct.block* %224, i64 0, i32 0, !dbg !874
  %243 = load i64, i64* %242, align 8, !dbg !874, !tbaa !93
  call void @llvm.dbg.value(metadata i64 %243, metadata !136, metadata !DIExpression()), !dbg !877
  %244 = lshr i64 %243, 1, !dbg !879
  %245 = and i64 %244, 9223372036854775800, !dbg !879
  %246 = inttoptr i64 %245 to %struct.block*, !dbg !880
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !828, metadata !DIExpression()), !dbg !881
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !828, metadata !DIExpression()), !dbg !881
  %247 = getelementptr inbounds i8, i8* %189, i64 8, !dbg !882
  %248 = bitcast i8* %247 to i64*, !dbg !883
  store i64 %226, i64* %248, align 8, !dbg !883, !tbaa !495
  call void @llvm.dbg.value(metadata i8* %189, metadata !653, metadata !DIExpression()), !dbg !884
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !658, metadata !DIExpression()), !dbg !886
  %249 = and i64 %243, -16, !dbg !887
  %250 = and i64 %205, 15, !dbg !888
  %251 = or i64 %249, %250, !dbg !889
  store i64 %251, i64* %191, align 8, !dbg !890, !tbaa !93
  br label %259, !dbg !891

; <label>:252:                                    ; preds = %240
  %253 = getelementptr inbounds %struct.block, %struct.block* %224, i64 0, i32 1, i32 0, i32 1, !dbg !892
  %254 = load %struct.block*, %struct.block** %253, align 8, !dbg !892, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %254, metadata !828, metadata !DIExpression()), !dbg !881
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !828, metadata !DIExpression()), !dbg !881
  %255 = getelementptr inbounds i8, i8* %189, i64 8, !dbg !882
  %256 = bitcast i8* %255 to i64*, !dbg !883
  store i64 %226, i64* %256, align 8, !dbg !883, !tbaa !495
  call void @llvm.dbg.value(metadata i8* %189, metadata !653, metadata !DIExpression()), !dbg !884
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !658, metadata !DIExpression()), !dbg !886
  %257 = getelementptr inbounds i8, i8* %189, i64 16, !dbg !894
  %258 = bitcast i8* %257 to %struct.block**, !dbg !894
  store %struct.block* %254, %struct.block** %258, align 8, !dbg !895, !tbaa !495
  br label %259

; <label>:259:                                    ; preds = %252, %241
  %260 = phi %struct.block* [ %246, %241 ], [ %254, %252 ]
  %261 = getelementptr inbounds %struct.block, %struct.block* %260, i64 0, i32 1, i32 0, i32 0, !dbg !896
  %262 = bitcast %struct.block** %261 to i8**, !dbg !897
  store i8* %189, i8** %262, align 8, !dbg !897, !tbaa !495
  %263 = load %struct.block*, %struct.block** %223, align 8, !dbg !898, !tbaa !86
  call void @llvm.dbg.value(metadata %struct.block* %263, metadata !653, metadata !DIExpression()), !dbg !899
  call void @llvm.dbg.value(metadata i8* %189, metadata !658, metadata !DIExpression()), !dbg !901
  %264 = getelementptr %struct.block, %struct.block* %263, i64 0, i32 0
  %265 = load i64, i64* %264, align 8, !tbaa !93
  %266 = and i64 %265, 4, !dbg !902
  %267 = icmp eq i64 %266, 0, !dbg !904
  br i1 %267, label %274, label %268, !dbg !905

; <label>:268:                                    ; preds = %259
  %269 = ptrtoint i8* %189 to i64, !dbg !906
  %270 = shl i64 %269, 1, !dbg !907
  %271 = and i64 %270, -16, !dbg !908
  %272 = and i64 %265, 15, !dbg !909
  %273 = or i64 %272, %271, !dbg !910
  store i64 %273, i64* %264, align 8, !dbg !911, !tbaa !93
  br label %277, !dbg !912

; <label>:274:                                    ; preds = %259
  %275 = getelementptr inbounds %struct.block, %struct.block* %263, i64 0, i32 1, i32 0, i32 1, !dbg !913
  %276 = bitcast %struct.block** %275 to i8**, !dbg !914
  store i8* %189, i8** %276, align 8, !dbg !914, !tbaa !495
  br label %277

; <label>:277:                                    ; preds = %274, %268, %237, %231
  call void @llvm.dbg.value(metadata i8* %189, metadata !157, metadata !DIExpression()), !dbg !915
  %278 = load i64, i64* %191, align 8, !tbaa !93
  %279 = and i64 %278, 4, !dbg !917
  %280 = icmp eq i64 %279, 0, !dbg !920
  %281 = and i64 %278, -16, !dbg !921
  %282 = select i1 %280, i64 %281, i64 16, !dbg !923
  %283 = getelementptr inbounds i8, i8* %189, i64 %282, !dbg !924
  call void @llvm.dbg.value(metadata i8* %283, metadata !720, metadata !DIExpression()), !dbg !925
  %284 = bitcast i8* %283 to i64*
  %285 = load i64, i64* %284, align 8, !tbaa !93
  %286 = and i64 %285, -12, !dbg !926
  %287 = icmp eq i64 %286, 0, !dbg !926
  br i1 %287, label %303, label %288, !dbg !928

; <label>:288:                                    ; preds = %277
  call void @llvm.dbg.value(metadata i64 %285, metadata !136, metadata !DIExpression()), !dbg !929
  call void @llvm.dbg.value(metadata i8* %283, metadata !252, metadata !DIExpression()), !dbg !932
  call void @llvm.dbg.value(metadata i64 %285, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !934
  call void @llvm.dbg.value(metadata i1 %190, metadata !258, metadata !DIExpression()), !dbg !935
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %285, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !937
  call void @llvm.dbg.value(metadata i1 %190, metadata !203, metadata !DIExpression()), !dbg !939
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !940
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !941
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !941
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !941
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !941
  %289 = and i64 %285, -11, !dbg !942
  call void @llvm.dbg.value(metadata i64 %289, metadata !207, metadata !DIExpression()), !dbg !941
  %290 = or i64 %289, 8, !dbg !943
  call void @llvm.dbg.value(metadata i64 %290, metadata !207, metadata !DIExpression()), !dbg !941
  %291 = select i1 %190, i64 %290, i64 %289, !dbg !946
  call void @llvm.dbg.value(metadata i64 %291, metadata !207, metadata !DIExpression()), !dbg !941
  store i64 %291, i64* %284, align 8, !dbg !947, !tbaa !93
  %292 = and i64 %285, 5, !dbg !948
  %293 = icmp eq i64 %292, 0, !dbg !948
  br i1 %293, label %294, label %305, !dbg !948

; <label>:294:                                    ; preds = %288
  call void @llvm.dbg.value(metadata i8* %283, metadata !277, metadata !DIExpression()), !dbg !949
  %295 = getelementptr inbounds i8, i8* %283, i64 8, !dbg !951
  %296 = and i64 %291, 4, !dbg !952
  %297 = icmp eq i64 %296, 0, !dbg !955
  %298 = and i64 %291, -16, !dbg !956
  %299 = select i1 %297, i64 %298, i64 16, !dbg !958
  %300 = getelementptr inbounds i8, i8* %295, i64 %299, !dbg !959
  %301 = getelementptr inbounds i8, i8* %300, i64 -16, !dbg !960
  %302 = bitcast i8* %301 to i64*, !dbg !961
  call void @llvm.dbg.value(metadata i64* %302, metadata !262, metadata !DIExpression()), !dbg !962
  call void @llvm.dbg.value(metadata i64 %285, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !963
  call void @llvm.dbg.value(metadata i1 %190, metadata !203, metadata !DIExpression()), !dbg !965
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !966
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !967
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !967
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !967
  call void @llvm.dbg.value(metadata i64 %285, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !967
  call void @llvm.dbg.value(metadata i64 %289, metadata !207, metadata !DIExpression()), !dbg !967
  call void @llvm.dbg.value(metadata i64 %290, metadata !207, metadata !DIExpression()), !dbg !967
  call void @llvm.dbg.value(metadata i64 %291, metadata !207, metadata !DIExpression()), !dbg !967
  store i64 %291, i64* %302, align 8, !dbg !968, !tbaa !224
  br label %305, !dbg !969

; <label>:303:                                    ; preds = %277
  call void @llvm.dbg.value(metadata i8* %283, metadata !297, metadata !DIExpression()), !dbg !970
  call void @llvm.dbg.value(metadata i1 %190, metadata !302, metadata !DIExpression()), !dbg !973
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()), !dbg !974
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !975
  call void @llvm.dbg.value(metadata i1 %190, metadata !203, metadata !DIExpression()), !dbg !977
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !978
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !979
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !980
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()), !dbg !981
  %304 = select i1 %190, i64 9, i64 1, !dbg !982
  call void @llvm.dbg.value(metadata i64 %304, metadata !207, metadata !DIExpression()), !dbg !981
  store i64 %304, i64* %284, align 8, !dbg !983, !tbaa !93
  br label %305

; <label>:305:                                    ; preds = %178, %288, %294, %303
  %306 = phi i8* [ %179, %178 ], [ %185, %288 ], [ %185, %294 ], [ %185, %303 ], !dbg !734
  %307 = load i64, i64* %101, align 8, !tbaa !93
  %308 = and i64 %307, 4, !dbg !984
  %309 = icmp eq i64 %308, 0, !dbg !987
  %310 = and i64 %307, -16, !dbg !988
  %311 = select i1 %309, i64 %310, i64 16, !dbg !990
  call void @llvm.dbg.value(metadata i64 %311, metadata !335, metadata !DIExpression()), !dbg !689
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !157, metadata !DIExpression()), !dbg !991
  %312 = getelementptr inbounds i8, i8* %306, i64 %311, !dbg !992
  call void @llvm.dbg.value(metadata i8* %312, metadata !336, metadata !DIExpression()), !dbg !993
  %313 = bitcast i8* %312 to i64*
  %314 = load i64, i64* %313, align 8, !tbaa !93
  %315 = and i64 %314, -12, !dbg !994
  %316 = icmp eq i64 %315, 0, !dbg !994
  %317 = icmp eq i64 %311, 16, !dbg !996
  br i1 %316, label %334, label %318, !dbg !998

; <label>:318:                                    ; preds = %305
  call void @llvm.dbg.value(metadata i64 %314, metadata !136, metadata !DIExpression()), !dbg !999
  call void @llvm.dbg.value(metadata i8* %312, metadata !252, metadata !DIExpression()), !dbg !1001
  call void @llvm.dbg.value(metadata i64 %314, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1003
  call void @llvm.dbg.value(metadata i1 %317, metadata !258, metadata !DIExpression()), !dbg !1004
  call void @llvm.dbg.value(metadata i1 true, metadata !260, metadata !DIExpression()), !dbg !1005
  call void @llvm.dbg.value(metadata i64 %314, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1006
  call void @llvm.dbg.value(metadata i1 %317, metadata !203, metadata !DIExpression()), !dbg !1008
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !1009
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1010
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1010
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1010
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1010
  %319 = and i64 %314, -11, !dbg !1011
  %320 = or i64 %319, 2, !dbg !1011
  call void @llvm.dbg.value(metadata i64 %320, metadata !207, metadata !DIExpression()), !dbg !1010
  %321 = or i64 %314, 10, !dbg !1012
  call void @llvm.dbg.value(metadata i64 %321, metadata !207, metadata !DIExpression()), !dbg !1010
  %322 = select i1 %317, i64 %321, i64 %320, !dbg !1013
  call void @llvm.dbg.value(metadata i64 %322, metadata !207, metadata !DIExpression()), !dbg !1010
  store i64 %322, i64* %313, align 8, !dbg !1014, !tbaa !93
  %323 = and i64 %314, 5, !dbg !1015
  %324 = icmp eq i64 %323, 0, !dbg !1015
  br i1 %324, label %325, label %336, !dbg !1015

; <label>:325:                                    ; preds = %318
  call void @llvm.dbg.value(metadata i8* %312, metadata !277, metadata !DIExpression()), !dbg !1016
  %326 = getelementptr inbounds i8, i8* %312, i64 8, !dbg !1018
  %327 = and i64 %322, 4, !dbg !1019
  %328 = icmp eq i64 %327, 0, !dbg !1022
  %329 = and i64 %322, -16, !dbg !1023
  %330 = select i1 %328, i64 %329, i64 16, !dbg !1025
  %331 = getelementptr inbounds i8, i8* %326, i64 %330, !dbg !1026
  %332 = getelementptr inbounds i8, i8* %331, i64 -16, !dbg !1027
  %333 = bitcast i8* %332 to i64*, !dbg !1028
  call void @llvm.dbg.value(metadata i64* %333, metadata !262, metadata !DIExpression()), !dbg !1029
  call void @llvm.dbg.value(metadata i64 %314, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1030
  call void @llvm.dbg.value(metadata i1 %317, metadata !203, metadata !DIExpression()), !dbg !1032
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !1033
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %314, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %320, metadata !207, metadata !DIExpression()), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %321, metadata !207, metadata !DIExpression()), !dbg !1034
  call void @llvm.dbg.value(metadata i64 %322, metadata !207, metadata !DIExpression()), !dbg !1034
  store i64 %322, i64* %333, align 8, !dbg !1035, !tbaa !224
  br label %336, !dbg !1036

; <label>:334:                                    ; preds = %305
  call void @llvm.dbg.value(metadata i8* %312, metadata !297, metadata !DIExpression()), !dbg !1037
  call void @llvm.dbg.value(metadata i1 %317, metadata !302, metadata !DIExpression()), !dbg !1040
  call void @llvm.dbg.value(metadata i1 true, metadata !303, metadata !DIExpression()), !dbg !1041
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !1042
  call void @llvm.dbg.value(metadata i1 %317, metadata !203, metadata !DIExpression()), !dbg !1044
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !1045
  call void @llvm.dbg.value(metadata i1 true, metadata !205, metadata !DIExpression()), !dbg !1046
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !1047
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !1048
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1048
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !1048
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !1048
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !1048
  call void @llvm.dbg.value(metadata i64 11, metadata !207, metadata !DIExpression()), !dbg !1048
  %335 = select i1 %317, i64 11, i64 3, !dbg !1049
  call void @llvm.dbg.value(metadata i64 %335, metadata !207, metadata !DIExpression()), !dbg !1048
  store i64 %335, i64* %313, align 8, !dbg !1050, !tbaa !93
  br label %336

; <label>:336:                                    ; preds = %318, %325, %334
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !1051, metadata !DIExpression()), !dbg !1056
  %337 = getelementptr inbounds %struct.block, %struct.block* %103, i64 0, i32 1, !dbg !1058
  %338 = bitcast %union.mem_t* %337 to i8*, !dbg !1059
  call void @llvm.dbg.value(metadata i8* %338, metadata !334, metadata !DIExpression()), !dbg !339
  br label %339

; <label>:339:                                    ; preds = %69, %74, %26, %336
  %340 = phi i8* [ %338, %336 ], [ null, %26 ], [ null, %74 ], [ null, %69 ], !dbg !606
  ret i8* %340, !dbg !1060
}

; Function Attrs: nounwind uwtable
define dso_local void @mm_free(i8*) local_unnamed_addr #0 !dbg !1061 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !1065, metadata !DIExpression()), !dbg !1069
  %2 = icmp eq i8* %0, null, !dbg !1070
  br i1 %2, label %53, label %3, !dbg !1072

; <label>:3:                                      ; preds = %1
  call void @llvm.dbg.value(metadata i8* %0, metadata !242, metadata !DIExpression()), !dbg !1073
  %4 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !1075
  %5 = bitcast i8* %4 to %struct.block*, !dbg !1076
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !1066, metadata !DIExpression()), !dbg !1077
  %6 = bitcast i8* %4 to i64*
  %7 = load i64, i64* %6, align 8, !tbaa !93
  %8 = and i64 %7, 4, !dbg !1078
  %9 = icmp eq i64 %8, 0, !dbg !1081
  %10 = and i64 %7, -16, !dbg !1082
  %11 = select i1 %9, i64 %10, i64 16, !dbg !1084
  call void @llvm.dbg.value(metadata i64 %11, metadata !1067, metadata !DIExpression()), !dbg !1085
  %12 = icmp eq i64 %11, 16, !dbg !1086
  %13 = and i64 %7, 8, !dbg !1088
  %14 = and i64 %7, 2, !dbg !1091
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !252, metadata !DIExpression()), !dbg !1093
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !252, metadata !DIExpression()), !dbg !1096
  call void @llvm.dbg.value(metadata i64 %11, metadata !257, metadata !DIExpression()), !dbg !1098
  call void @llvm.dbg.value(metadata i64 %11, metadata !257, metadata !DIExpression()), !dbg !1099
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1100
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1102
  %15 = or i64 %11, %14, !dbg !1104
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression()), !dbg !1102
  %16 = or i64 %15, %13, !dbg !1105
  br i1 %12, label %17, label %19, !dbg !1106

; <label>:17:                                     ; preds = %3
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()), !dbg !1107
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()), !dbg !1108
  call void @llvm.dbg.value(metadata i64 %11, metadata !198, metadata !DIExpression()), !dbg !1109
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()), !dbg !1110
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !1111
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression(DW_OP_constu, 4, DW_OP_or, DW_OP_stack_value)), !dbg !1100
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression(DW_OP_constu, 12, DW_OP_or, DW_OP_stack_value)), !dbg !1100
  %18 = or i64 %16, 4, !dbg !1105
  call void @llvm.dbg.value(metadata i64 %18, metadata !207, metadata !DIExpression()), !dbg !1100
  store i64 %18, i64* %6, align 8, !dbg !1112, !tbaa !93
  br label %24, !dbg !1113

; <label>:19:                                     ; preds = %3
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()), !dbg !1114
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()), !dbg !1115
  call void @llvm.dbg.value(metadata i64 %11, metadata !198, metadata !DIExpression()), !dbg !1116
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !1117
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !1118
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1102
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1102
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression()), !dbg !1102
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1102
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression()), !dbg !1102
  store i64 %16, i64* %6, align 8, !dbg !1119, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !277, metadata !DIExpression()), !dbg !1120
  %20 = getelementptr inbounds i8, i8* %0, i64 %11, !dbg !1122
  %21 = getelementptr inbounds i8, i8* %20, i64 -16, !dbg !1123
  %22 = bitcast i8* %21 to i64*, !dbg !1124
  call void @llvm.dbg.value(metadata i64* %22, metadata !262, metadata !DIExpression()), !dbg !1125
  call void @llvm.dbg.value(metadata i64 %11, metadata !198, metadata !DIExpression()), !dbg !1126
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !1128
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !1129
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression()), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %11, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression()), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression()), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %15, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1130
  call void @llvm.dbg.value(metadata i64 %16, metadata !207, metadata !DIExpression()), !dbg !1130
  store i64 %16, i64* %22, align 8, !dbg !1131, !tbaa !224
  %23 = load i64, i64* %6, align 8, !tbaa !93
  br label %24

; <label>:24:                                     ; preds = %19, %17
  %25 = phi i64 [ %23, %19 ], [ %18, %17 ]
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !157, metadata !DIExpression()), !dbg !1132
  %26 = and i64 %25, 4, !dbg !1134
  %27 = icmp eq i64 %26, 0, !dbg !1137
  %28 = and i64 %25, -16, !dbg !1138
  %29 = select i1 %27, i64 %28, i64 16, !dbg !1140
  %30 = getelementptr inbounds i8, i8* %4, i64 %29, !dbg !1141
  call void @llvm.dbg.value(metadata i8* %30, metadata !1068, metadata !DIExpression()), !dbg !1142
  %31 = bitcast i8* %30 to i64*
  %32 = load i64, i64* %31, align 8, !tbaa !93
  %33 = and i64 %32, -12, !dbg !1143
  %34 = icmp eq i64 %33, 0, !dbg !1143
  br i1 %34, label %48, label %35, !dbg !1145

; <label>:35:                                     ; preds = %24
  call void @llvm.dbg.value(metadata i64 %32, metadata !136, metadata !DIExpression()), !dbg !1146
  call void @llvm.dbg.value(metadata i8* %30, metadata !252, metadata !DIExpression()), !dbg !1149
  call void @llvm.dbg.value(metadata i64 %32, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1151
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()), !dbg !1152
  call void @llvm.dbg.value(metadata i64 %32, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1153
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1155
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1156
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1156
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1156
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1156
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)), !dbg !1156
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1156
  %36 = and i64 %32, -3, !dbg !1157
  call void @llvm.dbg.value(metadata i64 %36, metadata !207, metadata !DIExpression()), !dbg !1156
  store i64 %36, i64* %31, align 8, !dbg !1158, !tbaa !93
  %37 = and i64 %32, 5, !dbg !1159
  %38 = icmp eq i64 %37, 0, !dbg !1159
  br i1 %38, label %39, label %51, !dbg !1159

; <label>:39:                                     ; preds = %35
  call void @llvm.dbg.value(metadata i8* %30, metadata !277, metadata !DIExpression()), !dbg !1160
  %40 = getelementptr inbounds i8, i8* %30, i64 8, !dbg !1162
  %41 = and i64 %32, 4, !dbg !1163
  %42 = icmp eq i64 %41, 0, !dbg !1166
  %43 = and i64 %32, -16, !dbg !1167
  %44 = select i1 %42, i64 %43, i64 16, !dbg !1169
  %45 = getelementptr inbounds i8, i8* %40, i64 %44, !dbg !1170
  %46 = getelementptr inbounds i8, i8* %45, i64 -16, !dbg !1171
  %47 = bitcast i8* %46 to i64*, !dbg !1172
  call void @llvm.dbg.value(metadata i64* %47, metadata !262, metadata !DIExpression()), !dbg !1173
  call void @llvm.dbg.value(metadata i64 %32, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1174
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1176
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %32, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1177
  call void @llvm.dbg.value(metadata i64 %36, metadata !207, metadata !DIExpression()), !dbg !1177
  store i64 %36, i64* %47, align 8, !dbg !1178, !tbaa !224
  br label %51, !dbg !1179

; <label>:48:                                     ; preds = %24
  %49 = and i64 %32, 8, !dbg !1180
  call void @llvm.dbg.value(metadata i8* %30, metadata !297, metadata !DIExpression()), !dbg !1183
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()), !dbg !1185
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !1186
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !1188
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1189
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !1190
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()), !dbg !1191
  %50 = or i64 %49, 1, !dbg !1192
  call void @llvm.dbg.value(metadata i64 %50, metadata !207, metadata !DIExpression()), !dbg !1191
  store i64 %50, i64* %31, align 8, !dbg !1193, !tbaa !93
  br label %51

; <label>:51:                                     ; preds = %35, %39, %48
  %52 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %5), !dbg !1194
  call void @llvm.dbg.value(metadata %struct.block* %52, metadata !1066, metadata !DIExpression()), !dbg !1077
  br label %53, !dbg !1195

; <label>:53:                                     ; preds = %1, %51
  ret void, !dbg !1195
}

; Function Attrs: nounwind uwtable
define internal fastcc %struct.block* @coalesce_block(%struct.block*) unnamed_addr #0 !dbg !1196 {
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1198, metadata !DIExpression()), !dbg !1212
  %2 = getelementptr %struct.block, %struct.block* %0, i64 0, i32 0
  %3 = load i64, i64* %2, align 8, !tbaa !93
  %4 = and i64 %3, 4, !dbg !1213
  %5 = icmp eq i64 %4, 0, !dbg !1216
  %6 = and i64 %3, -16, !dbg !1217
  %7 = select i1 %5, i64 %6, i64 16, !dbg !1219
  call void @llvm.dbg.value(metadata i64 %7, metadata !1199, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !157, metadata !DIExpression()), !dbg !1221
  %8 = bitcast %struct.block* %0 to i8*, !dbg !1223
  %9 = getelementptr inbounds i8, i8* %8, i64 %7, !dbg !1224
  %10 = bitcast i8* %9 to %struct.block*, !dbg !1225
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !1200, metadata !DIExpression()), !dbg !1226
  %11 = and i64 %3, 2, !dbg !1227
  %12 = icmp ne i64 %11, 0, !dbg !1229
  %13 = bitcast i8* %9 to i64*
  %14 = load i64, i64* %13, align 8, !tbaa !93
  call void @llvm.dbg.value(metadata i64 %14, metadata !1230, metadata !DIExpression()), !dbg !1235
  %15 = and i64 %14, 1, !dbg !1241
  %16 = icmp ne i64 %15, 0, !dbg !1242
  %17 = xor i1 %12, true, !dbg !1243
  %18 = xor i1 %16, true, !dbg !1243
  %19 = or i1 %17, %18, !dbg !1243
  br i1 %19, label %20, label %296, !dbg !1243

; <label>:20:                                     ; preds = %1
  %21 = or i1 %16, %17, !dbg !1244
  br i1 %21, label %82, label %22, !dbg !1244

; <label>:22:                                     ; preds = %20
  %23 = and i64 %14, 4, !dbg !1245
  %24 = icmp eq i64 %23, 0, !dbg !1249
  %25 = and i64 %14, -16, !dbg !1250
  %26 = select i1 %24, i64 %25, i64 16, !dbg !1252
  %27 = add i64 %26, %7, !dbg !1253
  call void @llvm.dbg.value(metadata i64 %27, metadata !1199, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !601, metadata !DIExpression()), !dbg !1254
  %28 = icmp eq i64 %25, 16, !dbg !1256
  %29 = xor i1 %24, true, !dbg !1256
  %30 = or i1 %28, %29, !dbg !1256
  br i1 %30, label %39, label %31, !dbg !1258

; <label>:31:                                     ; preds = %22, %31
  %32 = phi i64 [ %34, %31 ], [ 32, %22 ], !dbg !1259
  %33 = phi i32 [ %38, %31 ], [ 1, %22 ], !dbg !1259
  call void @llvm.dbg.value(metadata i32 %33, metadata !453, metadata !DIExpression()), !dbg !1260
  call void @llvm.dbg.value(metadata i64 %32, metadata !452, metadata !DIExpression()), !dbg !1261
  %34 = shl i64 %32, 1, !dbg !1262
  %35 = icmp ult i64 %34, %25, !dbg !1263
  %36 = icmp ult i32 %33, 14, !dbg !1264
  %37 = and i1 %35, %36, !dbg !1265
  %38 = add nuw nsw i32 %33, 1, !dbg !1266
  call void @llvm.dbg.value(metadata i32 %38, metadata !453, metadata !DIExpression()), !dbg !1260
  call void @llvm.dbg.value(metadata i64 %34, metadata !452, metadata !DIExpression()), !dbg !1261
  br i1 %37, label %31, label %39, !dbg !1267, !llvm.loop !469

; <label>:39:                                     ; preds = %31, %22
  %40 = phi i32 [ 0, %22 ], [ %33, %31 ], !dbg !1268
  call void @llvm.dbg.value(metadata i32 %40, metadata !603, metadata !DIExpression()), !dbg !1269
  %41 = zext i32 %40 to i64, !dbg !1270
  %42 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %41, !dbg !1270
  %43 = load %struct.block*, %struct.block** %42, align 8, !dbg !1270, !tbaa !86
  %44 = icmp eq %struct.block* %43, %10, !dbg !1271
  br i1 %44, label %45, label %52, !dbg !1272

; <label>:45:                                     ; preds = %39
  %46 = getelementptr inbounds i8, i8* %9, i64 8, !dbg !1273
  %47 = bitcast i8* %46 to %struct.block**, !dbg !1273
  %48 = load %struct.block*, %struct.block** %47, align 8, !dbg !1273, !tbaa !495
  %49 = icmp eq %struct.block* %48, %10, !dbg !1274
  br i1 %49, label %50, label %51, !dbg !1275

; <label>:50:                                     ; preds = %45
  store %struct.block* null, %struct.block** %42, align 8, !dbg !1276, !tbaa !86
  br label %296, !dbg !1277

; <label>:51:                                     ; preds = %45
  store %struct.block* %48, %struct.block** %42, align 8, !dbg !1278, !tbaa !86
  br label %52, !dbg !1279

; <label>:52:                                     ; preds = %51, %39
  br i1 %24, label %56, label %53, !dbg !1280

; <label>:53:                                     ; preds = %52
  call void @llvm.dbg.value(metadata i64 %14, metadata !136, metadata !DIExpression()), !dbg !1281
  %54 = lshr exact i64 %25, 1, !dbg !1283
  %55 = inttoptr i64 %54 to %struct.block*, !dbg !1284
  call void @llvm.dbg.value(metadata %struct.block* %55, metadata !604, metadata !DIExpression()), !dbg !1285
  br label %60, !dbg !1286

; <label>:56:                                     ; preds = %52
  %57 = getelementptr inbounds i8, i8* %9, i64 16, !dbg !1287
  %58 = bitcast i8* %57 to %struct.block**, !dbg !1287
  %59 = load %struct.block*, %struct.block** %58, align 8, !dbg !1287, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %59, metadata !604, metadata !DIExpression()), !dbg !1285
  br label %60

; <label>:60:                                     ; preds = %56, %53
  %61 = phi %struct.block* [ %55, %53 ], [ %59, %56 ], !dbg !1288
  call void @llvm.dbg.value(metadata %struct.block* %61, metadata !604, metadata !DIExpression()), !dbg !1285
  %62 = getelementptr inbounds i8, i8* %9, i64 8, !dbg !1289
  %63 = bitcast i8* %62 to %struct.block**, !dbg !1289
  %64 = load %struct.block*, %struct.block** %63, align 8, !dbg !1289, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %64, metadata !653, metadata !DIExpression()), !dbg !1290
  call void @llvm.dbg.value(metadata %struct.block* %61, metadata !658, metadata !DIExpression()), !dbg !1292
  %65 = getelementptr %struct.block, %struct.block* %64, i64 0, i32 0
  %66 = load i64, i64* %65, align 8, !tbaa !93
  %67 = and i64 %66, 4, !dbg !1293
  %68 = icmp eq i64 %67, 0, !dbg !1295
  br i1 %68, label %75, label %69, !dbg !1296

; <label>:69:                                     ; preds = %60
  %70 = ptrtoint %struct.block* %61 to i64, !dbg !1297
  %71 = shl i64 %70, 1, !dbg !1298
  %72 = and i64 %71, -16, !dbg !1299
  %73 = and i64 %66, 15, !dbg !1300
  %74 = or i64 %73, %72, !dbg !1301
  store i64 %74, i64* %65, align 8, !dbg !1302, !tbaa !93
  br label %77, !dbg !1303

; <label>:75:                                     ; preds = %60
  %76 = getelementptr inbounds %struct.block, %struct.block* %64, i64 0, i32 1, i32 0, i32 1, !dbg !1304
  store %struct.block* %61, %struct.block** %76, align 8, !dbg !1305, !tbaa !495
  br label %77

; <label>:77:                                     ; preds = %75, %69
  %78 = bitcast i8* %62 to i64*, !dbg !1306
  %79 = load i64, i64* %78, align 8, !dbg !1306, !tbaa !495
  %80 = getelementptr inbounds %struct.block, %struct.block* %61, i64 0, i32 1, !dbg !1307
  %81 = bitcast %union.mem_t* %80 to i64*, !dbg !1308
  store i64 %79, i64* %81, align 8, !dbg !1308, !tbaa !495
  br label %296, !dbg !1309

; <label>:82:                                     ; preds = %20
  %83 = or i1 %12, %18, !dbg !1310
  br i1 %83, label %159, label %84, !dbg !1310

; <label>:84:                                     ; preds = %82
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1311, metadata !DIExpression()), !dbg !1317
  %85 = and i64 %3, 8, !dbg !1319
  %86 = icmp eq i64 %85, 0, !dbg !1321
  br i1 %86, label %90, label %87, !dbg !1322

; <label>:87:                                     ; preds = %84
  %88 = getelementptr inbounds %struct.block, %struct.block* %0, i64 -1, i32 1, !dbg !1323
  %89 = bitcast %union.mem_t* %88 to %struct.block*, !dbg !1325
  br label %99, !dbg !1326

; <label>:90:                                     ; preds = %84
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1327, metadata !DIExpression()), !dbg !1330
  %91 = getelementptr inbounds i64, i64* %2, i64 -1, !dbg !1332
  call void @llvm.dbg.value(metadata i64* %91, metadata !1314, metadata !DIExpression()), !dbg !1333
  %92 = load i64, i64* %91, align 8, !dbg !1334, !tbaa !224
  call void @llvm.dbg.value(metadata i64 %92, metadata !136, metadata !DIExpression()), !dbg !1336
  %93 = and i64 %92, -16, !dbg !1338
  %94 = icmp eq i64 %93, 0, !dbg !1339
  br i1 %94, label %99, label %95, !dbg !1340

; <label>:95:                                     ; preds = %90
  call void @llvm.dbg.value(metadata i64* %91, metadata !1341, metadata !DIExpression()), !dbg !1347
  call void @llvm.dbg.value(metadata i64 %92, metadata !136, metadata !DIExpression()), !dbg !1349
  call void @llvm.dbg.value(metadata i64 %93, metadata !1346, metadata !DIExpression()), !dbg !1351
  %96 = sub i64 0, %93, !dbg !1352
  %97 = getelementptr inbounds i8, i8* %8, i64 %96, !dbg !1352
  %98 = bitcast i8* %97 to %struct.block*, !dbg !1353
  br label %99, !dbg !1354

; <label>:99:                                     ; preds = %87, %90, %95
  %100 = phi %struct.block* [ %89, %87 ], [ %98, %95 ], [ null, %90 ], !dbg !1355
  call void @llvm.dbg.value(metadata %struct.block* %100, metadata !1203, metadata !DIExpression()), !dbg !1357
  %101 = getelementptr %struct.block, %struct.block* %100, i64 0, i32 0
  %102 = load i64, i64* %101, align 8, !tbaa !93
  %103 = and i64 %102, 4, !dbg !1358
  %104 = icmp eq i64 %103, 0, !dbg !1361
  %105 = and i64 %102, -16, !dbg !1362
  %106 = select i1 %104, i64 %105, i64 16, !dbg !1364
  %107 = add i64 %106, %7, !dbg !1365
  call void @llvm.dbg.value(metadata i64 %107, metadata !1199, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.value(metadata %struct.block* %100, metadata !601, metadata !DIExpression()), !dbg !1366
  %108 = icmp eq i64 %105, 16, !dbg !1368
  %109 = xor i1 %104, true, !dbg !1368
  %110 = or i1 %108, %109, !dbg !1368
  br i1 %110, label %119, label %111, !dbg !1370

; <label>:111:                                    ; preds = %99, %111
  %112 = phi i64 [ %114, %111 ], [ 32, %99 ], !dbg !1371
  %113 = phi i32 [ %118, %111 ], [ 1, %99 ], !dbg !1371
  call void @llvm.dbg.value(metadata i32 %113, metadata !453, metadata !DIExpression()), !dbg !1372
  call void @llvm.dbg.value(metadata i64 %112, metadata !452, metadata !DIExpression()), !dbg !1373
  %114 = shl i64 %112, 1, !dbg !1374
  %115 = icmp ult i64 %114, %105, !dbg !1375
  %116 = icmp ult i32 %113, 14, !dbg !1376
  %117 = and i1 %115, %116, !dbg !1377
  %118 = add nuw nsw i32 %113, 1, !dbg !1378
  call void @llvm.dbg.value(metadata i32 %118, metadata !453, metadata !DIExpression()), !dbg !1372
  call void @llvm.dbg.value(metadata i64 %114, metadata !452, metadata !DIExpression()), !dbg !1373
  br i1 %117, label %111, label %119, !dbg !1379, !llvm.loop !469

; <label>:119:                                    ; preds = %111, %99
  %120 = phi i32 [ 0, %99 ], [ %113, %111 ], !dbg !1380
  call void @llvm.dbg.value(metadata i32 %120, metadata !603, metadata !DIExpression()), !dbg !1381
  %121 = zext i32 %120 to i64, !dbg !1382
  %122 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %121, !dbg !1382
  %123 = load %struct.block*, %struct.block** %122, align 8, !dbg !1382, !tbaa !86
  %124 = icmp eq %struct.block* %123, %100, !dbg !1383
  br i1 %124, label %125, label %131, !dbg !1384

; <label>:125:                                    ; preds = %119
  %126 = getelementptr inbounds %struct.block, %struct.block* %100, i64 0, i32 1, i32 0, i32 0, !dbg !1385
  %127 = load %struct.block*, %struct.block** %126, align 8, !dbg !1385, !tbaa !495
  %128 = icmp eq %struct.block* %127, %100, !dbg !1386
  br i1 %128, label %129, label %130, !dbg !1387

; <label>:129:                                    ; preds = %125
  store %struct.block* null, %struct.block** %122, align 8, !dbg !1388, !tbaa !86
  br label %296, !dbg !1389

; <label>:130:                                    ; preds = %125
  store %struct.block* %127, %struct.block** %122, align 8, !dbg !1390, !tbaa !86
  br label %131, !dbg !1391

; <label>:131:                                    ; preds = %130, %119
  br i1 %104, label %135, label %132, !dbg !1392

; <label>:132:                                    ; preds = %131
  call void @llvm.dbg.value(metadata i64 %102, metadata !136, metadata !DIExpression()), !dbg !1393
  %133 = lshr exact i64 %105, 1, !dbg !1395
  %134 = inttoptr i64 %133 to %struct.block*, !dbg !1396
  call void @llvm.dbg.value(metadata %struct.block* %134, metadata !604, metadata !DIExpression()), !dbg !1397
  br label %138, !dbg !1398

; <label>:135:                                    ; preds = %131
  %136 = getelementptr inbounds %struct.block, %struct.block* %100, i64 0, i32 1, i32 0, i32 1, !dbg !1399
  %137 = load %struct.block*, %struct.block** %136, align 8, !dbg !1399, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %137, metadata !604, metadata !DIExpression()), !dbg !1397
  br label %138

; <label>:138:                                    ; preds = %135, %132
  %139 = phi %struct.block* [ %134, %132 ], [ %137, %135 ], !dbg !1400
  call void @llvm.dbg.value(metadata %struct.block* %139, metadata !604, metadata !DIExpression()), !dbg !1397
  %140 = getelementptr inbounds %struct.block, %struct.block* %100, i64 0, i32 1, i32 0, i32 0, !dbg !1401
  %141 = load %struct.block*, %struct.block** %140, align 8, !dbg !1401, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %141, metadata !653, metadata !DIExpression()), !dbg !1402
  call void @llvm.dbg.value(metadata %struct.block* %139, metadata !658, metadata !DIExpression()), !dbg !1404
  %142 = getelementptr %struct.block, %struct.block* %141, i64 0, i32 0
  %143 = load i64, i64* %142, align 8, !tbaa !93
  %144 = and i64 %143, 4, !dbg !1405
  %145 = icmp eq i64 %144, 0, !dbg !1407
  br i1 %145, label %152, label %146, !dbg !1408

; <label>:146:                                    ; preds = %138
  %147 = ptrtoint %struct.block* %139 to i64, !dbg !1409
  %148 = shl i64 %147, 1, !dbg !1410
  %149 = and i64 %148, -16, !dbg !1411
  %150 = and i64 %143, 15, !dbg !1412
  %151 = or i64 %150, %149, !dbg !1413
  store i64 %151, i64* %142, align 8, !dbg !1414, !tbaa !93
  br label %154, !dbg !1415

; <label>:152:                                    ; preds = %138
  %153 = getelementptr inbounds %struct.block, %struct.block* %141, i64 0, i32 1, i32 0, i32 1, !dbg !1416
  store %struct.block* %139, %struct.block** %153, align 8, !dbg !1417, !tbaa !495
  br label %154

; <label>:154:                                    ; preds = %152, %146
  %155 = bitcast %struct.block** %140 to i64*, !dbg !1418
  %156 = load i64, i64* %155, align 8, !dbg !1418, !tbaa !495
  %157 = getelementptr inbounds %struct.block, %struct.block* %139, i64 0, i32 1, !dbg !1419
  %158 = bitcast %union.mem_t* %157 to i64*, !dbg !1420
  store i64 %156, i64* %158, align 8, !dbg !1420, !tbaa !495
  br label %296, !dbg !1421

; <label>:159:                                    ; preds = %82
  %160 = and i64 %14, 4, !dbg !1422
  %161 = icmp eq i64 %160, 0, !dbg !1425
  %162 = and i64 %14, -16, !dbg !1426
  %163 = select i1 %161, i64 %162, i64 16, !dbg !1428
  %164 = add i64 %163, %7, !dbg !1429
  call void @llvm.dbg.value(metadata i64 %164, metadata !1199, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !601, metadata !DIExpression()), !dbg !1430
  %165 = icmp eq i64 %162, 16, !dbg !1432
  %166 = xor i1 %161, true, !dbg !1432
  %167 = or i1 %165, %166, !dbg !1432
  br i1 %167, label %176, label %168, !dbg !1434

; <label>:168:                                    ; preds = %159, %168
  %169 = phi i64 [ %171, %168 ], [ 32, %159 ], !dbg !1435
  %170 = phi i32 [ %175, %168 ], [ 1, %159 ], !dbg !1435
  call void @llvm.dbg.value(metadata i32 %170, metadata !453, metadata !DIExpression()), !dbg !1436
  call void @llvm.dbg.value(metadata i64 %169, metadata !452, metadata !DIExpression()), !dbg !1437
  %171 = shl i64 %169, 1, !dbg !1438
  %172 = icmp ult i64 %171, %162, !dbg !1439
  %173 = icmp ult i32 %170, 14, !dbg !1440
  %174 = and i1 %172, %173, !dbg !1441
  %175 = add nuw nsw i32 %170, 1, !dbg !1442
  call void @llvm.dbg.value(metadata i32 %175, metadata !453, metadata !DIExpression()), !dbg !1436
  call void @llvm.dbg.value(metadata i64 %171, metadata !452, metadata !DIExpression()), !dbg !1437
  br i1 %174, label %168, label %176, !dbg !1443, !llvm.loop !469

; <label>:176:                                    ; preds = %168, %159
  %177 = phi i32 [ 0, %159 ], [ %170, %168 ], !dbg !1444
  call void @llvm.dbg.value(metadata i32 %177, metadata !603, metadata !DIExpression()), !dbg !1445
  %178 = zext i32 %177 to i64, !dbg !1446
  %179 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %178, !dbg !1446
  %180 = load %struct.block*, %struct.block** %179, align 8, !dbg !1446, !tbaa !86
  %181 = icmp eq %struct.block* %180, %10, !dbg !1447
  br i1 %181, label %182, label %189, !dbg !1448

; <label>:182:                                    ; preds = %176
  %183 = getelementptr inbounds i8, i8* %9, i64 8, !dbg !1449
  %184 = bitcast i8* %183 to %struct.block**, !dbg !1449
  %185 = load %struct.block*, %struct.block** %184, align 8, !dbg !1449, !tbaa !495
  %186 = icmp eq %struct.block* %185, %10, !dbg !1450
  br i1 %186, label %187, label %188, !dbg !1451

; <label>:187:                                    ; preds = %182
  store %struct.block* null, %struct.block** %179, align 8, !dbg !1452, !tbaa !86
  br label %220, !dbg !1453

; <label>:188:                                    ; preds = %182
  store %struct.block* %185, %struct.block** %179, align 8, !dbg !1454, !tbaa !86
  br label %189, !dbg !1455

; <label>:189:                                    ; preds = %188, %176
  br i1 %161, label %193, label %190, !dbg !1456

; <label>:190:                                    ; preds = %189
  call void @llvm.dbg.value(metadata i64 %14, metadata !136, metadata !DIExpression()), !dbg !1457
  %191 = lshr exact i64 %162, 1, !dbg !1459
  %192 = inttoptr i64 %191 to %struct.block*, !dbg !1460
  call void @llvm.dbg.value(metadata %struct.block* %192, metadata !604, metadata !DIExpression()), !dbg !1461
  br label %197, !dbg !1462

; <label>:193:                                    ; preds = %189
  %194 = getelementptr inbounds i8, i8* %9, i64 16, !dbg !1463
  %195 = bitcast i8* %194 to %struct.block**, !dbg !1463
  %196 = load %struct.block*, %struct.block** %195, align 8, !dbg !1463, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %196, metadata !604, metadata !DIExpression()), !dbg !1461
  br label %197

; <label>:197:                                    ; preds = %193, %190
  %198 = phi %struct.block* [ %192, %190 ], [ %196, %193 ], !dbg !1464
  call void @llvm.dbg.value(metadata %struct.block* %198, metadata !604, metadata !DIExpression()), !dbg !1461
  %199 = getelementptr inbounds i8, i8* %9, i64 8, !dbg !1465
  %200 = bitcast i8* %199 to %struct.block**, !dbg !1465
  %201 = load %struct.block*, %struct.block** %200, align 8, !dbg !1465, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %201, metadata !653, metadata !DIExpression()), !dbg !1466
  call void @llvm.dbg.value(metadata %struct.block* %198, metadata !658, metadata !DIExpression()), !dbg !1468
  %202 = getelementptr %struct.block, %struct.block* %201, i64 0, i32 0
  %203 = load i64, i64* %202, align 8, !tbaa !93
  %204 = and i64 %203, 4, !dbg !1469
  %205 = icmp eq i64 %204, 0, !dbg !1471
  br i1 %205, label %212, label %206, !dbg !1472

; <label>:206:                                    ; preds = %197
  %207 = ptrtoint %struct.block* %198 to i64, !dbg !1473
  %208 = shl i64 %207, 1, !dbg !1474
  %209 = and i64 %208, -16, !dbg !1475
  %210 = and i64 %203, 15, !dbg !1476
  %211 = or i64 %210, %209, !dbg !1477
  store i64 %211, i64* %202, align 8, !dbg !1478, !tbaa !93
  br label %214, !dbg !1479

; <label>:212:                                    ; preds = %197
  %213 = getelementptr inbounds %struct.block, %struct.block* %201, i64 0, i32 1, i32 0, i32 1, !dbg !1480
  store %struct.block* %198, %struct.block** %213, align 8, !dbg !1481, !tbaa !495
  br label %214

; <label>:214:                                    ; preds = %212, %206
  %215 = bitcast i8* %199 to i64*, !dbg !1482
  %216 = load i64, i64* %215, align 8, !dbg !1482, !tbaa !495
  %217 = getelementptr inbounds %struct.block, %struct.block* %198, i64 0, i32 1, !dbg !1483
  %218 = bitcast %union.mem_t* %217 to i64*, !dbg !1484
  store i64 %216, i64* %218, align 8, !dbg !1484, !tbaa !495
  %219 = load i64, i64* %2, align 8, !tbaa !93
  br label %220, !dbg !1485

; <label>:220:                                    ; preds = %187, %214
  %221 = phi i64 [ %3, %187 ], [ %219, %214 ]
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1311, metadata !DIExpression()), !dbg !1486
  %222 = and i64 %221, 8, !dbg !1488
  %223 = icmp eq i64 %222, 0, !dbg !1490
  br i1 %223, label %227, label %224, !dbg !1491

; <label>:224:                                    ; preds = %220
  %225 = getelementptr inbounds %struct.block, %struct.block* %0, i64 -1, i32 1, !dbg !1492
  %226 = bitcast %union.mem_t* %225 to %struct.block*, !dbg !1493
  br label %236, !dbg !1494

; <label>:227:                                    ; preds = %220
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1327, metadata !DIExpression()), !dbg !1495
  %228 = getelementptr inbounds i64, i64* %2, i64 -1, !dbg !1497
  call void @llvm.dbg.value(metadata i64* %228, metadata !1314, metadata !DIExpression()), !dbg !1498
  %229 = load i64, i64* %228, align 8, !dbg !1499, !tbaa !224
  call void @llvm.dbg.value(metadata i64 %229, metadata !136, metadata !DIExpression()), !dbg !1500
  %230 = and i64 %229, -16, !dbg !1502
  %231 = icmp eq i64 %230, 0, !dbg !1503
  br i1 %231, label %236, label %232, !dbg !1504

; <label>:232:                                    ; preds = %227
  call void @llvm.dbg.value(metadata i64* %228, metadata !1341, metadata !DIExpression()), !dbg !1505
  call void @llvm.dbg.value(metadata i64 %229, metadata !136, metadata !DIExpression()), !dbg !1507
  call void @llvm.dbg.value(metadata i64 %230, metadata !1346, metadata !DIExpression()), !dbg !1509
  %233 = sub i64 0, %230, !dbg !1510
  %234 = getelementptr inbounds i8, i8* %8, i64 %233, !dbg !1510
  %235 = bitcast i8* %234 to %struct.block*, !dbg !1511
  br label %236, !dbg !1512

; <label>:236:                                    ; preds = %224, %227, %232
  %237 = phi %struct.block* [ %226, %224 ], [ %235, %232 ], [ null, %227 ], !dbg !1513
  call void @llvm.dbg.value(metadata %struct.block* %237, metadata !1208, metadata !DIExpression()), !dbg !1514
  %238 = getelementptr %struct.block, %struct.block* %237, i64 0, i32 0
  %239 = load i64, i64* %238, align 8, !tbaa !93
  %240 = and i64 %239, 4, !dbg !1515
  %241 = icmp eq i64 %240, 0, !dbg !1518
  %242 = and i64 %239, -16, !dbg !1519
  %243 = select i1 %241, i64 %242, i64 16, !dbg !1521
  %244 = add i64 %164, %243, !dbg !1522
  call void @llvm.dbg.value(metadata i64 %244, metadata !1199, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.value(metadata %struct.block* %237, metadata !601, metadata !DIExpression()), !dbg !1523
  %245 = icmp eq i64 %242, 16, !dbg !1525
  %246 = xor i1 %241, true, !dbg !1525
  %247 = or i1 %245, %246, !dbg !1525
  br i1 %247, label %256, label %248, !dbg !1527

; <label>:248:                                    ; preds = %236, %248
  %249 = phi i64 [ %251, %248 ], [ 32, %236 ], !dbg !1528
  %250 = phi i32 [ %255, %248 ], [ 1, %236 ], !dbg !1528
  call void @llvm.dbg.value(metadata i32 %250, metadata !453, metadata !DIExpression()), !dbg !1529
  call void @llvm.dbg.value(metadata i64 %249, metadata !452, metadata !DIExpression()), !dbg !1530
  %251 = shl i64 %249, 1, !dbg !1531
  %252 = icmp ult i64 %251, %242, !dbg !1532
  %253 = icmp ult i32 %250, 14, !dbg !1533
  %254 = and i1 %252, %253, !dbg !1534
  %255 = add nuw nsw i32 %250, 1, !dbg !1535
  call void @llvm.dbg.value(metadata i32 %255, metadata !453, metadata !DIExpression()), !dbg !1529
  call void @llvm.dbg.value(metadata i64 %251, metadata !452, metadata !DIExpression()), !dbg !1530
  br i1 %254, label %248, label %256, !dbg !1536, !llvm.loop !469

; <label>:256:                                    ; preds = %248, %236
  %257 = phi i32 [ 0, %236 ], [ %250, %248 ], !dbg !1537
  call void @llvm.dbg.value(metadata i32 %257, metadata !603, metadata !DIExpression()), !dbg !1538
  %258 = zext i32 %257 to i64, !dbg !1539
  %259 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %258, !dbg !1539
  %260 = load %struct.block*, %struct.block** %259, align 8, !dbg !1539, !tbaa !86
  %261 = icmp eq %struct.block* %260, %237, !dbg !1540
  br i1 %261, label %262, label %268, !dbg !1541

; <label>:262:                                    ; preds = %256
  %263 = getelementptr inbounds %struct.block, %struct.block* %237, i64 0, i32 1, i32 0, i32 0, !dbg !1542
  %264 = load %struct.block*, %struct.block** %263, align 8, !dbg !1542, !tbaa !495
  %265 = icmp eq %struct.block* %264, %237, !dbg !1543
  br i1 %265, label %266, label %267, !dbg !1544

; <label>:266:                                    ; preds = %262
  store %struct.block* null, %struct.block** %259, align 8, !dbg !1545, !tbaa !86
  br label %296, !dbg !1546

; <label>:267:                                    ; preds = %262
  store %struct.block* %264, %struct.block** %259, align 8, !dbg !1547, !tbaa !86
  br label %268, !dbg !1548

; <label>:268:                                    ; preds = %267, %256
  br i1 %241, label %272, label %269, !dbg !1549

; <label>:269:                                    ; preds = %268
  call void @llvm.dbg.value(metadata i64 %239, metadata !136, metadata !DIExpression()), !dbg !1550
  %270 = lshr exact i64 %242, 1, !dbg !1552
  %271 = inttoptr i64 %270 to %struct.block*, !dbg !1553
  call void @llvm.dbg.value(metadata %struct.block* %271, metadata !604, metadata !DIExpression()), !dbg !1554
  br label %275, !dbg !1555

; <label>:272:                                    ; preds = %268
  %273 = getelementptr inbounds %struct.block, %struct.block* %237, i64 0, i32 1, i32 0, i32 1, !dbg !1556
  %274 = load %struct.block*, %struct.block** %273, align 8, !dbg !1556, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %274, metadata !604, metadata !DIExpression()), !dbg !1554
  br label %275

; <label>:275:                                    ; preds = %272, %269
  %276 = phi %struct.block* [ %271, %269 ], [ %274, %272 ], !dbg !1557
  call void @llvm.dbg.value(metadata %struct.block* %276, metadata !604, metadata !DIExpression()), !dbg !1554
  %277 = getelementptr inbounds %struct.block, %struct.block* %237, i64 0, i32 1, i32 0, i32 0, !dbg !1558
  %278 = load %struct.block*, %struct.block** %277, align 8, !dbg !1558, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %278, metadata !653, metadata !DIExpression()), !dbg !1559
  call void @llvm.dbg.value(metadata %struct.block* %276, metadata !658, metadata !DIExpression()), !dbg !1561
  %279 = getelementptr %struct.block, %struct.block* %278, i64 0, i32 0
  %280 = load i64, i64* %279, align 8, !tbaa !93
  %281 = and i64 %280, 4, !dbg !1562
  %282 = icmp eq i64 %281, 0, !dbg !1564
  br i1 %282, label %289, label %283, !dbg !1565

; <label>:283:                                    ; preds = %275
  %284 = ptrtoint %struct.block* %276 to i64, !dbg !1566
  %285 = shl i64 %284, 1, !dbg !1567
  %286 = and i64 %285, -16, !dbg !1568
  %287 = and i64 %280, 15, !dbg !1569
  %288 = or i64 %287, %286, !dbg !1570
  store i64 %288, i64* %279, align 8, !dbg !1571, !tbaa !93
  br label %291, !dbg !1572

; <label>:289:                                    ; preds = %275
  %290 = getelementptr inbounds %struct.block, %struct.block* %278, i64 0, i32 1, i32 0, i32 1, !dbg !1573
  store %struct.block* %276, %struct.block** %290, align 8, !dbg !1574, !tbaa !495
  br label %291

; <label>:291:                                    ; preds = %289, %283
  %292 = bitcast %struct.block** %277 to i64*, !dbg !1575
  %293 = load i64, i64* %292, align 8, !dbg !1575, !tbaa !495
  %294 = getelementptr inbounds %struct.block, %struct.block* %276, i64 0, i32 1, !dbg !1576
  %295 = bitcast %union.mem_t* %294 to i64*, !dbg !1577
  store i64 %293, i64* %295, align 8, !dbg !1577, !tbaa !495
  br label %296, !dbg !1578

; <label>:296:                                    ; preds = %291, %266, %154, %129, %77, %50, %1
  %297 = phi i64* [ %238, %291 ], [ %238, %266 ], [ %101, %154 ], [ %101, %129 ], [ %2, %77 ], [ %2, %50 ], [ %2, %1 ]
  %298 = phi i64 [ %244, %291 ], [ %244, %266 ], [ %107, %154 ], [ %107, %129 ], [ %27, %77 ], [ %27, %50 ], [ %7, %1 ], !dbg !1579
  %299 = phi %struct.block* [ %237, %291 ], [ %237, %266 ], [ %100, %154 ], [ %100, %129 ], [ %0, %77 ], [ %0, %50 ], [ %0, %1 ]
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !1198, metadata !DIExpression()), !dbg !1212
  call void @llvm.dbg.value(metadata i64 %298, metadata !1199, metadata !DIExpression()), !dbg !1220
  %300 = icmp eq i64 %298, 16, !dbg !1580
  %301 = load i64, i64* %297, align 8, !tbaa !93
  %302 = and i64 %301, 8, !dbg !1581
  %303 = and i64 %301, 2, !dbg !1583
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !252, metadata !DIExpression()), !dbg !1585
  call void @llvm.dbg.value(metadata i64 %298, metadata !257, metadata !DIExpression()), !dbg !1587
  call void @llvm.dbg.value(metadata i1 %300, metadata !259, metadata !DIExpression()), !dbg !1588
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()), !dbg !1589
  call void @llvm.dbg.value(metadata i64 %298, metadata !198, metadata !DIExpression()), !dbg !1590
  call void @llvm.dbg.value(metadata i1 %300, metadata !204, metadata !DIExpression()), !dbg !1592
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !1593
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression()), !dbg !1594
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression()), !dbg !1594
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1594
  %304 = or i64 %303, %298, !dbg !1595
  call void @llvm.dbg.value(metadata i64 %304, metadata !207, metadata !DIExpression()), !dbg !1594
  %305 = or i64 %304, 4, !dbg !1596
  %306 = select i1 %300, i64 %305, i64 %304, !dbg !1599
  call void @llvm.dbg.value(metadata i64 %306, metadata !207, metadata !DIExpression()), !dbg !1594
  call void @llvm.dbg.value(metadata i64 %306, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1594
  %307 = or i64 %306, %302, !dbg !1600
  call void @llvm.dbg.value(metadata i64 %307, metadata !207, metadata !DIExpression()), !dbg !1594
  store i64 %307, i64* %297, align 8, !dbg !1601, !tbaa !93
  br i1 %300, label %319, label %308, !dbg !1602

; <label>:308:                                    ; preds = %296
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !277, metadata !DIExpression()), !dbg !1603
  %309 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, !dbg !1605
  %310 = bitcast %union.mem_t* %309 to i8*, !dbg !1606
  %311 = and i64 %306, 4, !dbg !1607
  %312 = icmp eq i64 %311, 0, !dbg !1610
  %313 = and i64 %306, -16, !dbg !1611
  %314 = select i1 %312, i64 %313, i64 16, !dbg !1613
  %315 = getelementptr inbounds i8, i8* %310, i64 %314, !dbg !1614
  %316 = getelementptr inbounds i8, i8* %315, i64 -16, !dbg !1615
  %317 = bitcast i8* %316 to i64*, !dbg !1616
  call void @llvm.dbg.value(metadata i64* %317, metadata !262, metadata !DIExpression()), !dbg !1617
  call void @llvm.dbg.value(metadata i64 %298, metadata !198, metadata !DIExpression()), !dbg !1618
  call void @llvm.dbg.value(metadata i1 %300, metadata !204, metadata !DIExpression()), !dbg !1620
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()), !dbg !1621
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression()), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression()), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %298, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %304, metadata !207, metadata !DIExpression()), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %306, metadata !207, metadata !DIExpression()), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %306, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)), !dbg !1622
  call void @llvm.dbg.value(metadata i64 %307, metadata !207, metadata !DIExpression()), !dbg !1622
  store i64 %307, i64* %317, align 8, !dbg !1623, !tbaa !224
  %318 = load i64, i64* %297, align 8, !tbaa !93
  br label %319, !dbg !1624

; <label>:319:                                    ; preds = %296, %308
  %320 = phi i64 [ %307, %296 ], [ %318, %308 ]
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !823, metadata !DIExpression()), !dbg !1625
  %321 = and i64 %320, 4, !dbg !1627
  %322 = icmp eq i64 %321, 0, !dbg !1630
  %323 = and i64 %320, -16, !dbg !1631
  %324 = icmp eq i64 %323, 16, !dbg !1633
  %325 = xor i1 %322, true, !dbg !1633
  %326 = or i1 %324, %325, !dbg !1633
  br i1 %326, label %335, label %327, !dbg !1635

; <label>:327:                                    ; preds = %319, %327
  %328 = phi i64 [ %330, %327 ], [ 32, %319 ], !dbg !1636
  %329 = phi i32 [ %334, %327 ], [ 1, %319 ], !dbg !1636
  call void @llvm.dbg.value(metadata i32 %329, metadata !453, metadata !DIExpression()), !dbg !1637
  call void @llvm.dbg.value(metadata i64 %328, metadata !452, metadata !DIExpression()), !dbg !1638
  %330 = shl i64 %328, 1, !dbg !1639
  %331 = icmp ult i64 %330, %323, !dbg !1640
  %332 = icmp ult i32 %329, 14, !dbg !1641
  %333 = and i1 %331, %332, !dbg !1642
  %334 = add nuw nsw i32 %329, 1, !dbg !1643
  call void @llvm.dbg.value(metadata i32 %334, metadata !453, metadata !DIExpression()), !dbg !1637
  call void @llvm.dbg.value(metadata i64 %330, metadata !452, metadata !DIExpression()), !dbg !1638
  br i1 %333, label %327, label %335, !dbg !1644, !llvm.loop !469

; <label>:335:                                    ; preds = %327, %319
  %336 = phi i32 [ 0, %319 ], [ %329, %327 ], !dbg !1645
  call void @llvm.dbg.value(metadata i32 %336, metadata !827, metadata !DIExpression()), !dbg !1646
  %337 = zext i32 %336 to i64, !dbg !1647
  %338 = getelementptr inbounds [15 x %struct.block*], [15 x %struct.block*]* @list_head, i64 0, i64 %337, !dbg !1647
  %339 = load %struct.block*, %struct.block** %338, align 8, !dbg !1647, !tbaa !86
  %340 = icmp eq %struct.block* %339, null, !dbg !1648
  %341 = ptrtoint %struct.block* %339 to i64, !dbg !1649
  br i1 %340, label %342, label %352, !dbg !1649

; <label>:342:                                    ; preds = %335
  store %struct.block* %299, %struct.block** %338, align 8, !dbg !1650, !tbaa !86
  %343 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, i32 0, i32 0, !dbg !1651
  store %struct.block* %299, %struct.block** %343, align 8, !dbg !1652, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !653, metadata !DIExpression()), !dbg !1653
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !658, metadata !DIExpression()), !dbg !1655
  br i1 %322, label %350, label %344, !dbg !1656

; <label>:344:                                    ; preds = %342
  %345 = ptrtoint %struct.block* %299 to i64, !dbg !1657
  %346 = shl i64 %345, 1, !dbg !1658
  %347 = and i64 %346, -16, !dbg !1659
  %348 = and i64 %320, 15, !dbg !1660
  %349 = or i64 %348, %347, !dbg !1661
  store i64 %349, i64* %297, align 8, !dbg !1662, !tbaa !93
  br label %386, !dbg !1663

; <label>:350:                                    ; preds = %342
  %351 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, i32 0, i32 1, !dbg !1664
  store %struct.block* %299, %struct.block** %351, align 8, !dbg !1665, !tbaa !495
  br label %386

; <label>:352:                                    ; preds = %335
  br i1 %322, label %364, label %353, !dbg !1666

; <label>:353:                                    ; preds = %352
  %354 = getelementptr inbounds %struct.block, %struct.block* %339, i64 0, i32 0, !dbg !1667
  %355 = load i64, i64* %354, align 8, !dbg !1667, !tbaa !93
  call void @llvm.dbg.value(metadata i64 %355, metadata !136, metadata !DIExpression()), !dbg !1668
  %356 = lshr i64 %355, 1, !dbg !1670
  %357 = and i64 %356, 9223372036854775800, !dbg !1670
  %358 = inttoptr i64 %357 to %struct.block*, !dbg !1671
  call void @llvm.dbg.value(metadata %struct.block* %358, metadata !828, metadata !DIExpression()), !dbg !1672
  call void @llvm.dbg.value(metadata %struct.block* %358, metadata !828, metadata !DIExpression()), !dbg !1672
  %359 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, !dbg !1673
  %360 = bitcast %union.mem_t* %359 to i64*, !dbg !1674
  store i64 %341, i64* %360, align 8, !dbg !1674, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !653, metadata !DIExpression()), !dbg !1675
  call void @llvm.dbg.value(metadata %struct.block* %358, metadata !658, metadata !DIExpression()), !dbg !1677
  %361 = and i64 %355, -16, !dbg !1678
  %362 = and i64 %320, 15, !dbg !1679
  %363 = or i64 %361, %362, !dbg !1680
  store i64 %363, i64* %297, align 8, !dbg !1681, !tbaa !93
  br label %370, !dbg !1682

; <label>:364:                                    ; preds = %352
  %365 = getelementptr inbounds %struct.block, %struct.block* %339, i64 0, i32 1, i32 0, i32 1, !dbg !1683
  %366 = load %struct.block*, %struct.block** %365, align 8, !dbg !1683, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %366, metadata !828, metadata !DIExpression()), !dbg !1672
  call void @llvm.dbg.value(metadata %struct.block* %358, metadata !828, metadata !DIExpression()), !dbg !1672
  %367 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, !dbg !1673
  %368 = bitcast %union.mem_t* %367 to i64*, !dbg !1674
  store i64 %341, i64* %368, align 8, !dbg !1674, !tbaa !495
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !653, metadata !DIExpression()), !dbg !1675
  call void @llvm.dbg.value(metadata %struct.block* %358, metadata !658, metadata !DIExpression()), !dbg !1677
  %369 = getelementptr inbounds %struct.block, %struct.block* %299, i64 0, i32 1, i32 0, i32 1, !dbg !1684
  store %struct.block* %366, %struct.block** %369, align 8, !dbg !1685, !tbaa !495
  br label %370

; <label>:370:                                    ; preds = %364, %353
  %371 = phi %struct.block* [ %358, %353 ], [ %366, %364 ]
  %372 = getelementptr inbounds %struct.block, %struct.block* %371, i64 0, i32 1, i32 0, i32 0, !dbg !1686
  store %struct.block* %299, %struct.block** %372, align 8, !dbg !1687, !tbaa !495
  %373 = load %struct.block*, %struct.block** %338, align 8, !dbg !1688, !tbaa !86
  call void @llvm.dbg.value(metadata %struct.block* %373, metadata !653, metadata !DIExpression()), !dbg !1689
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !658, metadata !DIExpression()), !dbg !1691
  %374 = getelementptr %struct.block, %struct.block* %373, i64 0, i32 0
  %375 = load i64, i64* %374, align 8, !tbaa !93
  %376 = and i64 %375, 4, !dbg !1692
  %377 = icmp eq i64 %376, 0, !dbg !1694
  br i1 %377, label %384, label %378, !dbg !1695

; <label>:378:                                    ; preds = %370
  %379 = ptrtoint %struct.block* %299 to i64, !dbg !1696
  %380 = shl i64 %379, 1, !dbg !1697
  %381 = and i64 %380, -16, !dbg !1698
  %382 = and i64 %375, 15, !dbg !1699
  %383 = or i64 %382, %381, !dbg !1700
  store i64 %383, i64* %374, align 8, !dbg !1701, !tbaa !93
  br label %386, !dbg !1702

; <label>:384:                                    ; preds = %370
  %385 = getelementptr inbounds %struct.block, %struct.block* %373, i64 0, i32 1, i32 0, i32 1, !dbg !1703
  store %struct.block* %299, %struct.block** %385, align 8, !dbg !1704, !tbaa !495
  br label %386

; <label>:386:                                    ; preds = %344, %350, %378, %384
  call void @llvm.dbg.value(metadata %struct.block* %299, metadata !157, metadata !DIExpression()), !dbg !1705
  %387 = bitcast %struct.block* %299 to i8*, !dbg !1707
  %388 = load i64, i64* %297, align 8, !tbaa !93
  %389 = and i64 %388, 4, !dbg !1708
  %390 = icmp eq i64 %389, 0, !dbg !1711
  %391 = and i64 %388, -16, !dbg !1712
  %392 = select i1 %390, i64 %391, i64 16, !dbg !1714
  %393 = getelementptr inbounds i8, i8* %387, i64 %392, !dbg !1715
  call void @llvm.dbg.value(metadata i8* %393, metadata !1200, metadata !DIExpression()), !dbg !1226
  %394 = bitcast i8* %393 to i64*
  %395 = load i64, i64* %394, align 8, !tbaa !93
  %396 = and i64 %395, -12, !dbg !1716
  %397 = icmp eq i64 %396, 0, !dbg !1716
  br i1 %397, label %413, label %398, !dbg !1718

; <label>:398:                                    ; preds = %386
  call void @llvm.dbg.value(metadata i64 %395, metadata !136, metadata !DIExpression()), !dbg !1719
  call void @llvm.dbg.value(metadata i64 %395, metadata !1230, metadata !DIExpression()), !dbg !1722
  call void @llvm.dbg.value(metadata i8* %393, metadata !252, metadata !DIExpression()), !dbg !1725
  call void @llvm.dbg.value(metadata i64 %395, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1727
  call void @llvm.dbg.value(metadata i1 %300, metadata !258, metadata !DIExpression()), !dbg !1728
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()), !dbg !1729
  call void @llvm.dbg.value(metadata i64 %395, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1730
  call void @llvm.dbg.value(metadata i1 %300, metadata !203, metadata !DIExpression()), !dbg !1732
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1733
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1734
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1734
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1734
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1734
  %399 = and i64 %395, -11, !dbg !1735
  call void @llvm.dbg.value(metadata i64 %399, metadata !207, metadata !DIExpression()), !dbg !1734
  %400 = or i64 %399, 8, !dbg !1736
  call void @llvm.dbg.value(metadata i64 %400, metadata !207, metadata !DIExpression()), !dbg !1734
  %401 = select i1 %300, i64 %400, i64 %399, !dbg !1737
  call void @llvm.dbg.value(metadata i64 %401, metadata !207, metadata !DIExpression()), !dbg !1734
  store i64 %401, i64* %394, align 8, !dbg !1738, !tbaa !93
  %402 = and i64 %395, 5, !dbg !1739
  %403 = icmp eq i64 %402, 0, !dbg !1739
  br i1 %403, label %404, label %415, !dbg !1739

; <label>:404:                                    ; preds = %398
  call void @llvm.dbg.value(metadata i8* %393, metadata !277, metadata !DIExpression()), !dbg !1740
  %405 = getelementptr inbounds i8, i8* %393, i64 8, !dbg !1742
  %406 = and i64 %401, 4, !dbg !1743
  %407 = icmp eq i64 %406, 0, !dbg !1746
  %408 = and i64 %401, -16, !dbg !1747
  %409 = select i1 %407, i64 %408, i64 16, !dbg !1749
  %410 = getelementptr inbounds i8, i8* %405, i64 %409, !dbg !1750
  %411 = getelementptr inbounds i8, i8* %410, i64 -16, !dbg !1751
  %412 = bitcast i8* %411 to i64*, !dbg !1752
  call void @llvm.dbg.value(metadata i64* %412, metadata !262, metadata !DIExpression()), !dbg !1753
  call void @llvm.dbg.value(metadata i64 %395, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1754
  call void @llvm.dbg.value(metadata i1 %300, metadata !203, metadata !DIExpression()), !dbg !1756
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1757
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %395, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %399, metadata !207, metadata !DIExpression()), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %400, metadata !207, metadata !DIExpression()), !dbg !1758
  call void @llvm.dbg.value(metadata i64 %401, metadata !207, metadata !DIExpression()), !dbg !1758
  store i64 %401, i64* %412, align 8, !dbg !1759, !tbaa !224
  br label %415, !dbg !1760

; <label>:413:                                    ; preds = %386
  call void @llvm.dbg.value(metadata i8* %393, metadata !297, metadata !DIExpression()), !dbg !1761
  call void @llvm.dbg.value(metadata i1 %300, metadata !302, metadata !DIExpression()), !dbg !1764
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()), !dbg !1765
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !1766
  call void @llvm.dbg.value(metadata i1 %300, metadata !203, metadata !DIExpression()), !dbg !1768
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()), !dbg !1769
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()), !dbg !1770
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()), !dbg !1771
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()), !dbg !1772
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1772
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()), !dbg !1772
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1772
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()), !dbg !1772
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()), !dbg !1772
  %414 = select i1 %300, i64 9, i64 1, !dbg !1773
  call void @llvm.dbg.value(metadata i64 %414, metadata !207, metadata !DIExpression()), !dbg !1772
  store i64 %414, i64* %394, align 8, !dbg !1774, !tbaa !93
  br label %415

; <label>:415:                                    ; preds = %398, %404, %413
  ret %struct.block* %299, !dbg !1775
}

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_realloc(i8*, i64) local_unnamed_addr #0 !dbg !1776 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !1780, metadata !DIExpression()), !dbg !1785
  call void @llvm.dbg.value(metadata i64 %1, metadata !1781, metadata !DIExpression()), !dbg !1786
  call void @llvm.dbg.value(metadata i8* %0, metadata !242, metadata !DIExpression()), !dbg !1787
  %3 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !1789
  %4 = bitcast i8* %3 to %struct.block*, !dbg !1790
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !1782, metadata !DIExpression()), !dbg !1791
  %5 = icmp eq i64 %1, 0, !dbg !1792
  %6 = icmp eq i8* %0, null, !dbg !1794
  br i1 %5, label %7, label %54, !dbg !1796

; <label>:7:                                      ; preds = %2
  call void @llvm.dbg.value(metadata i8* %0, metadata !1065, metadata !DIExpression()) #4, !dbg !1797
  br i1 %6, label %159, label %8, !dbg !1800

; <label>:8:                                      ; preds = %7
  call void @llvm.dbg.value(metadata i8* %0, metadata !242, metadata !DIExpression()) #4, !dbg !1801
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !1066, metadata !DIExpression()) #4, !dbg !1803
  %9 = bitcast i8* %3 to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !93
  %11 = and i64 %10, 4, !dbg !1804
  %12 = icmp eq i64 %11, 0, !dbg !1807
  %13 = and i64 %10, -16, !dbg !1808
  %14 = select i1 %12, i64 %13, i64 16, !dbg !1810
  call void @llvm.dbg.value(metadata i64 %14, metadata !1067, metadata !DIExpression()) #4, !dbg !1811
  %15 = icmp eq i64 %14, 16, !dbg !1812
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !1813
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !1815
  call void @llvm.dbg.value(metadata i64 %14, metadata !257, metadata !DIExpression()) #4, !dbg !1817
  call void @llvm.dbg.value(metadata i64 %14, metadata !257, metadata !DIExpression()) #4, !dbg !1818
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1819
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1821
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1819
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1821
  %16 = and i64 %10, 10, !dbg !1823
  %17 = or i64 %16, %14, !dbg !1824
  br i1 %15, label %18, label %20, !dbg !1825

; <label>:18:                                     ; preds = %8
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()) #4, !dbg !1826
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !1827
  call void @llvm.dbg.value(metadata i64 %14, metadata !198, metadata !DIExpression()) #4, !dbg !1828
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()) #4, !dbg !1829
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1830
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1819
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1819
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 4, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1819
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 12, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1819
  %19 = or i64 %17, 4, !dbg !1824
  call void @llvm.dbg.value(metadata i64 %19, metadata !207, metadata !DIExpression()) #4, !dbg !1819
  store i64 %19, i64* %9, align 8, !dbg !1831, !tbaa !93
  br label %25, !dbg !1832

; <label>:20:                                     ; preds = %8
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !1833
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !1834
  call void @llvm.dbg.value(metadata i64 %14, metadata !198, metadata !DIExpression()) #4, !dbg !1835
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !1836
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1837
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1821
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1821
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1821
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1821
  call void @llvm.dbg.value(metadata i64 %17, metadata !207, metadata !DIExpression()) #4, !dbg !1821
  store i64 %17, i64* %9, align 8, !dbg !1838, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !277, metadata !DIExpression()) #4, !dbg !1839
  %21 = getelementptr inbounds i8, i8* %0, i64 %14, !dbg !1841
  %22 = getelementptr inbounds i8, i8* %21, i64 -16, !dbg !1842
  %23 = bitcast i8* %22 to i64*, !dbg !1843
  call void @llvm.dbg.value(metadata i64* %23, metadata !262, metadata !DIExpression()) #4, !dbg !1844
  call void @llvm.dbg.value(metadata i64 %14, metadata !198, metadata !DIExpression()) #4, !dbg !1845
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !1847
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1848
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression()) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 %14, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1849
  call void @llvm.dbg.value(metadata i64 %17, metadata !207, metadata !DIExpression()) #4, !dbg !1849
  store i64 %17, i64* %23, align 8, !dbg !1850, !tbaa !224
  %24 = load i64, i64* %9, align 8, !tbaa !93
  br label %25

; <label>:25:                                     ; preds = %20, %18
  %26 = phi i64 [ %24, %20 ], [ %19, %18 ]
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !157, metadata !DIExpression()) #4, !dbg !1851
  %27 = and i64 %26, 4, !dbg !1853
  %28 = icmp eq i64 %27, 0, !dbg !1856
  %29 = and i64 %26, -16, !dbg !1857
  %30 = select i1 %28, i64 %29, i64 16, !dbg !1859
  %31 = getelementptr inbounds i8, i8* %3, i64 %30, !dbg !1860
  call void @llvm.dbg.value(metadata i8* %31, metadata !1068, metadata !DIExpression()) #4, !dbg !1861
  %32 = bitcast i8* %31 to i64*
  %33 = load i64, i64* %32, align 8, !tbaa !93
  %34 = and i64 %33, -12, !dbg !1862
  %35 = icmp eq i64 %34, 0, !dbg !1862
  br i1 %35, label %49, label %36, !dbg !1863

; <label>:36:                                     ; preds = %25
  call void @llvm.dbg.value(metadata i64 %33, metadata !136, metadata !DIExpression()) #4, !dbg !1864
  call void @llvm.dbg.value(metadata i8* %31, metadata !252, metadata !DIExpression()) #4, !dbg !1866
  call void @llvm.dbg.value(metadata i64 %33, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1868
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()) #4, !dbg !1869
  call void @llvm.dbg.value(metadata i64 %33, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1870
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !1872
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1873
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1873
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1873
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1873
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1873
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1873
  %37 = and i64 %33, -3, !dbg !1874
  call void @llvm.dbg.value(metadata i64 %37, metadata !207, metadata !DIExpression()) #4, !dbg !1873
  store i64 %37, i64* %32, align 8, !dbg !1875, !tbaa !93
  %38 = and i64 %33, 5, !dbg !1876
  %39 = icmp eq i64 %38, 0, !dbg !1876
  br i1 %39, label %40, label %52, !dbg !1876

; <label>:40:                                     ; preds = %36
  call void @llvm.dbg.value(metadata i8* %31, metadata !277, metadata !DIExpression()) #4, !dbg !1877
  %41 = getelementptr inbounds i8, i8* %31, i64 8, !dbg !1879
  %42 = and i64 %33, 4, !dbg !1880
  %43 = icmp eq i64 %42, 0, !dbg !1883
  %44 = and i64 %33, -16, !dbg !1884
  %45 = select i1 %43, i64 %44, i64 16, !dbg !1886
  %46 = getelementptr inbounds i8, i8* %41, i64 %45, !dbg !1887
  %47 = getelementptr inbounds i8, i8* %46, i64 -16, !dbg !1888
  %48 = bitcast i8* %47 to i64*, !dbg !1889
  call void @llvm.dbg.value(metadata i64* %48, metadata !262, metadata !DIExpression()) #4, !dbg !1890
  call void @llvm.dbg.value(metadata i64 %33, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1891
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !1893
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %33, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1894
  call void @llvm.dbg.value(metadata i64 %37, metadata !207, metadata !DIExpression()) #4, !dbg !1894
  store i64 %37, i64* %48, align 8, !dbg !1895, !tbaa !224
  br label %52, !dbg !1896

; <label>:49:                                     ; preds = %25
  %50 = and i64 %33, 8, !dbg !1897
  call void @llvm.dbg.value(metadata i8* %31, metadata !297, metadata !DIExpression()) #4, !dbg !1899
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !1901
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !1902
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !1904
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !1905
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !1906
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  %51 = or i64 %50, 1, !dbg !1908
  call void @llvm.dbg.value(metadata i64 %51, metadata !207, metadata !DIExpression()) #4, !dbg !1907
  store i64 %51, i64* %32, align 8, !dbg !1909, !tbaa !93
  br label %52

; <label>:52:                                     ; preds = %49, %40, %36
  %53 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #4, !dbg !1910
  call void @llvm.dbg.value(metadata %struct.block* %53, metadata !1066, metadata !DIExpression()) #4, !dbg !1803
  br label %159, !dbg !1911

; <label>:54:                                     ; preds = %2
  %55 = tail call i8* @mm_malloc(i64 %1), !dbg !1912
  br i1 %6, label %159, label %56, !dbg !1913

; <label>:56:                                     ; preds = %54
  call void @llvm.dbg.value(metadata i8* %55, metadata !1784, metadata !DIExpression()), !dbg !1914
  %57 = icmp eq i8* %55, null, !dbg !1915
  br i1 %57, label %159, label %58, !dbg !1917

; <label>:58:                                     ; preds = %56
  %59 = bitcast i8* %3 to i64*
  %60 = load i64, i64* %59, align 8, !tbaa !93
  %61 = and i64 %60, 4, !dbg !1918
  %62 = icmp eq i64 %61, 0, !dbg !1926
  %63 = and i64 %60, -16, !dbg !1927
  %64 = add i64 %63, -8, !dbg !1929
  %65 = select i1 %62, i64 %64, i64 8, !dbg !1929
  call void @llvm.dbg.value(metadata i64 %65, metadata !1783, metadata !DIExpression()), !dbg !1930
  %66 = icmp ugt i64 %65, %1, !dbg !1931
  br i1 %66, label %113, label %67, !dbg !1933

; <label>:67:                                     ; preds = %58
  %68 = tail call i8* @mem_memcpy(i8* nonnull %55, i8* nonnull %0, i64 %65) #4, !dbg !1934
  call void @llvm.dbg.value(metadata i8* %0, metadata !1065, metadata !DIExpression()) #4, !dbg !1935
  call void @llvm.dbg.value(metadata i8* %0, metadata !242, metadata !DIExpression()) #4, !dbg !1937
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !1066, metadata !DIExpression()) #4, !dbg !1939
  %69 = load i64, i64* %59, align 8, !tbaa !93
  %70 = and i64 %69, 4, !dbg !1940
  %71 = icmp eq i64 %70, 0, !dbg !1943
  %72 = and i64 %69, -16, !dbg !1944
  %73 = select i1 %71, i64 %72, i64 16, !dbg !1946
  call void @llvm.dbg.value(metadata i64 %73, metadata !1067, metadata !DIExpression()) #4, !dbg !1947
  %74 = icmp eq i64 %73, 16, !dbg !1948
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !1949
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !1951
  call void @llvm.dbg.value(metadata i64 %73, metadata !257, metadata !DIExpression()) #4, !dbg !1953
  call void @llvm.dbg.value(metadata i64 %73, metadata !257, metadata !DIExpression()) #4, !dbg !1954
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1955
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1957
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1955
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1957
  %75 = and i64 %69, 10, !dbg !1959
  %76 = or i64 %75, %73, !dbg !1960
  br i1 %74, label %77, label %79, !dbg !1961

; <label>:77:                                     ; preds = %67
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()) #4, !dbg !1962
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !1963
  call void @llvm.dbg.value(metadata i64 %73, metadata !198, metadata !DIExpression()) #4, !dbg !1964
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()) #4, !dbg !1965
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1966
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1955
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1955
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 4, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1955
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 12, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1955
  %78 = or i64 %76, 4, !dbg !1960
  call void @llvm.dbg.value(metadata i64 %78, metadata !207, metadata !DIExpression()) #4, !dbg !1955
  store i64 %78, i64* %59, align 8, !dbg !1967, !tbaa !93
  br label %84, !dbg !1968

; <label>:79:                                     ; preds = %67
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !1969
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !1970
  call void @llvm.dbg.value(metadata i64 %73, metadata !198, metadata !DIExpression()) #4, !dbg !1971
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !1972
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1973
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1957
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1957
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1957
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1957
  call void @llvm.dbg.value(metadata i64 %76, metadata !207, metadata !DIExpression()) #4, !dbg !1957
  store i64 %76, i64* %59, align 8, !dbg !1974, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !277, metadata !DIExpression()) #4, !dbg !1975
  %80 = getelementptr inbounds i8, i8* %0, i64 %73, !dbg !1977
  %81 = getelementptr inbounds i8, i8* %80, i64 -16, !dbg !1978
  %82 = bitcast i8* %81 to i64*, !dbg !1979
  call void @llvm.dbg.value(metadata i64* %82, metadata !262, metadata !DIExpression()) #4, !dbg !1980
  call void @llvm.dbg.value(metadata i64 %73, metadata !198, metadata !DIExpression()) #4, !dbg !1981
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !1983
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !1984
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression()) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 %73, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !1985
  call void @llvm.dbg.value(metadata i64 %76, metadata !207, metadata !DIExpression()) #4, !dbg !1985
  store i64 %76, i64* %82, align 8, !dbg !1986, !tbaa !224
  %83 = load i64, i64* %59, align 8, !tbaa !93
  br label %84

; <label>:84:                                     ; preds = %79, %77
  %85 = phi i64 [ %83, %79 ], [ %78, %77 ]
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !157, metadata !DIExpression()) #4, !dbg !1987
  %86 = and i64 %85, 4, !dbg !1989
  %87 = icmp eq i64 %86, 0, !dbg !1992
  %88 = and i64 %85, -16, !dbg !1993
  %89 = select i1 %87, i64 %88, i64 16, !dbg !1995
  %90 = getelementptr inbounds i8, i8* %3, i64 %89, !dbg !1996
  call void @llvm.dbg.value(metadata i8* %90, metadata !1068, metadata !DIExpression()) #4, !dbg !1997
  %91 = bitcast i8* %90 to i64*
  %92 = load i64, i64* %91, align 8, !tbaa !93
  %93 = and i64 %92, -12, !dbg !1998
  %94 = icmp eq i64 %93, 0, !dbg !1998
  br i1 %94, label %108, label %95, !dbg !1999

; <label>:95:                                     ; preds = %84
  call void @llvm.dbg.value(metadata i64 %92, metadata !136, metadata !DIExpression()) #4, !dbg !2000
  call void @llvm.dbg.value(metadata i8* %90, metadata !252, metadata !DIExpression()) #4, !dbg !2002
  call void @llvm.dbg.value(metadata i64 %92, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2004
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()) #4, !dbg !2005
  call void @llvm.dbg.value(metadata i64 %92, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2006
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2008
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2009
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2009
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2009
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2009
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2009
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2009
  %96 = and i64 %92, -3, !dbg !2010
  call void @llvm.dbg.value(metadata i64 %96, metadata !207, metadata !DIExpression()) #4, !dbg !2009
  store i64 %96, i64* %91, align 8, !dbg !2011, !tbaa !93
  %97 = and i64 %92, 5, !dbg !2012
  %98 = icmp eq i64 %97, 0, !dbg !2012
  br i1 %98, label %99, label %111, !dbg !2012

; <label>:99:                                     ; preds = %95
  call void @llvm.dbg.value(metadata i8* %90, metadata !277, metadata !DIExpression()) #4, !dbg !2013
  %100 = getelementptr inbounds i8, i8* %90, i64 8, !dbg !2015
  %101 = and i64 %92, 4, !dbg !2016
  %102 = icmp eq i64 %101, 0, !dbg !2019
  %103 = and i64 %92, -16, !dbg !2020
  %104 = select i1 %102, i64 %103, i64 16, !dbg !2022
  %105 = getelementptr inbounds i8, i8* %100, i64 %104, !dbg !2023
  %106 = getelementptr inbounds i8, i8* %105, i64 -16, !dbg !2024
  %107 = bitcast i8* %106 to i64*, !dbg !2025
  call void @llvm.dbg.value(metadata i64* %107, metadata !262, metadata !DIExpression()) #4, !dbg !2026
  call void @llvm.dbg.value(metadata i64 %92, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2027
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2029
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %92, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2030
  call void @llvm.dbg.value(metadata i64 %96, metadata !207, metadata !DIExpression()) #4, !dbg !2030
  store i64 %96, i64* %107, align 8, !dbg !2031, !tbaa !224
  br label %111, !dbg !2032

; <label>:108:                                    ; preds = %84
  %109 = and i64 %92, 8, !dbg !2033
  call void @llvm.dbg.value(metadata i8* %90, metadata !297, metadata !DIExpression()) #4, !dbg !2035
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !2037
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !2038
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !2040
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2041
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !2042
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  %110 = or i64 %109, 1, !dbg !2044
  call void @llvm.dbg.value(metadata i64 %110, metadata !207, metadata !DIExpression()) #4, !dbg !2043
  store i64 %110, i64* %91, align 8, !dbg !2045, !tbaa !93
  br label %111

; <label>:111:                                    ; preds = %95, %99, %108
  %112 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #4, !dbg !2046
  call void @llvm.dbg.value(metadata %struct.block* %112, metadata !1066, metadata !DIExpression()) #4, !dbg !1939
  br label %159, !dbg !1933

; <label>:113:                                    ; preds = %58
  call void @llvm.dbg.value(metadata i64 %1, metadata !1783, metadata !DIExpression()), !dbg !1930
  %114 = tail call i8* @mem_memcpy(i8* nonnull %55, i8* nonnull %0, i64 %1) #4, !dbg !1934
  call void @llvm.dbg.value(metadata i8* %0, metadata !1065, metadata !DIExpression()) #4, !dbg !2047
  call void @llvm.dbg.value(metadata i8* %0, metadata !242, metadata !DIExpression()) #4, !dbg !2049
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !1066, metadata !DIExpression()) #4, !dbg !2051
  %115 = load i64, i64* %59, align 8, !tbaa !93
  %116 = and i64 %115, 4, !dbg !2052
  %117 = icmp eq i64 %116, 0, !dbg !2055
  %118 = and i64 %115, -16, !dbg !2056
  %119 = select i1 %117, i64 %118, i64 16, !dbg !2058
  call void @llvm.dbg.value(metadata i64 %119, metadata !1067, metadata !DIExpression()) #4, !dbg !2059
  %120 = icmp eq i64 %119, 16, !dbg !2060
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !2061
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !252, metadata !DIExpression()) #4, !dbg !2063
  call void @llvm.dbg.value(metadata i64 %119, metadata !257, metadata !DIExpression()) #4, !dbg !2065
  call void @llvm.dbg.value(metadata i64 %119, metadata !257, metadata !DIExpression()) #4, !dbg !2066
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2067
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2069
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !2067
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !2069
  %121 = and i64 %115, 10, !dbg !2071
  %122 = or i64 %121, %119, !dbg !2072
  br i1 %120, label %123, label %125, !dbg !2073

; <label>:123:                                    ; preds = %113
  call void @llvm.dbg.value(metadata i1 true, metadata !259, metadata !DIExpression()) #4, !dbg !2074
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !2075
  call void @llvm.dbg.value(metadata i64 %119, metadata !198, metadata !DIExpression()) #4, !dbg !2076
  call void @llvm.dbg.value(metadata i1 true, metadata !204, metadata !DIExpression()) #4, !dbg !2077
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !2078
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2067
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2067
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 4, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2067
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 12, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2067
  %124 = or i64 %122, 4, !dbg !2072
  call void @llvm.dbg.value(metadata i64 %124, metadata !207, metadata !DIExpression()) #4, !dbg !2067
  store i64 %124, i64* %59, align 8, !dbg !2079, !tbaa !93
  br label %130, !dbg !2080

; <label>:125:                                    ; preds = %113
  call void @llvm.dbg.value(metadata i1 false, metadata !259, metadata !DIExpression()) #4, !dbg !2081
  call void @llvm.dbg.value(metadata i1 false, metadata !261, metadata !DIExpression()) #4, !dbg !2082
  call void @llvm.dbg.value(metadata i64 %119, metadata !198, metadata !DIExpression()) #4, !dbg !2083
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !2084
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !2085
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2069
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2069
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !2069
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2069
  call void @llvm.dbg.value(metadata i64 %122, metadata !207, metadata !DIExpression()) #4, !dbg !2069
  store i64 %122, i64* %59, align 8, !dbg !2086, !tbaa !93
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !277, metadata !DIExpression()) #4, !dbg !2087
  %126 = getelementptr inbounds i8, i8* %0, i64 %119, !dbg !2089
  %127 = getelementptr inbounds i8, i8* %126, i64 -16, !dbg !2090
  %128 = bitcast i8* %127 to i64*, !dbg !2091
  call void @llvm.dbg.value(metadata i64* %128, metadata !262, metadata !DIExpression()) #4, !dbg !2092
  call void @llvm.dbg.value(metadata i64 %119, metadata !198, metadata !DIExpression()) #4, !dbg !2093
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !2095
  call void @llvm.dbg.value(metadata i1 false, metadata !206, metadata !DIExpression()) #4, !dbg !2096
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression()) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 %119, metadata !207, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression()) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 undef, metadata !207, metadata !DIExpression(DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2097
  call void @llvm.dbg.value(metadata i64 %122, metadata !207, metadata !DIExpression()) #4, !dbg !2097
  store i64 %122, i64* %128, align 8, !dbg !2098, !tbaa !224
  %129 = load i64, i64* %59, align 8, !tbaa !93
  br label %130

; <label>:130:                                    ; preds = %125, %123
  %131 = phi i64 [ %129, %125 ], [ %124, %123 ]
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !157, metadata !DIExpression()) #4, !dbg !2099
  %132 = and i64 %131, 4, !dbg !2101
  %133 = icmp eq i64 %132, 0, !dbg !2104
  %134 = and i64 %131, -16, !dbg !2105
  %135 = select i1 %133, i64 %134, i64 16, !dbg !2107
  %136 = getelementptr inbounds i8, i8* %3, i64 %135, !dbg !2108
  call void @llvm.dbg.value(metadata i8* %136, metadata !1068, metadata !DIExpression()) #4, !dbg !2109
  %137 = bitcast i8* %136 to i64*
  %138 = load i64, i64* %137, align 8, !tbaa !93
  %139 = and i64 %138, -12, !dbg !2110
  %140 = icmp eq i64 %139, 0, !dbg !2110
  br i1 %140, label %154, label %141, !dbg !2111

; <label>:141:                                    ; preds = %130
  call void @llvm.dbg.value(metadata i64 %138, metadata !136, metadata !DIExpression()) #4, !dbg !2112
  call void @llvm.dbg.value(metadata i8* %136, metadata !252, metadata !DIExpression()) #4, !dbg !2114
  call void @llvm.dbg.value(metadata i64 %138, metadata !257, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2116
  call void @llvm.dbg.value(metadata i1 false, metadata !260, metadata !DIExpression()) #4, !dbg !2117
  call void @llvm.dbg.value(metadata i64 %138, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2118
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2120
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2121
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2121
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2121
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2121
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2121
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2121
  %142 = and i64 %138, -3, !dbg !2122
  call void @llvm.dbg.value(metadata i64 %142, metadata !207, metadata !DIExpression()) #4, !dbg !2121
  store i64 %142, i64* %137, align 8, !dbg !2123, !tbaa !93
  %143 = and i64 %138, 5, !dbg !2124
  %144 = icmp eq i64 %143, 0, !dbg !2124
  br i1 %144, label %145, label %157, !dbg !2124

; <label>:145:                                    ; preds = %141
  call void @llvm.dbg.value(metadata i8* %136, metadata !277, metadata !DIExpression()) #4, !dbg !2125
  %146 = getelementptr inbounds i8, i8* %136, i64 8, !dbg !2127
  %147 = and i64 %138, 4, !dbg !2128
  %148 = icmp eq i64 %147, 0, !dbg !2131
  %149 = and i64 %138, -16, !dbg !2132
  %150 = select i1 %148, i64 %149, i64 16, !dbg !2134
  %151 = getelementptr inbounds i8, i8* %146, i64 %150, !dbg !2135
  %152 = getelementptr inbounds i8, i8* %151, i64 -16, !dbg !2136
  %153 = bitcast i8* %152 to i64*, !dbg !2137
  call void @llvm.dbg.value(metadata i64* %153, metadata !262, metadata !DIExpression()) #4, !dbg !2138
  call void @llvm.dbg.value(metadata i64 %138, metadata !198, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2139
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2141
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551601, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %138, metadata !207, metadata !DIExpression(DW_OP_constu, 18446744073709551605, DW_OP_and, DW_OP_constu, 8, DW_OP_or, DW_OP_stack_value)) #4, !dbg !2142
  call void @llvm.dbg.value(metadata i64 %142, metadata !207, metadata !DIExpression()) #4, !dbg !2142
  store i64 %142, i64* %153, align 8, !dbg !2143, !tbaa !224
  br label %157, !dbg !2144

; <label>:154:                                    ; preds = %130
  %155 = and i64 %138, 8, !dbg !2145
  call void @llvm.dbg.value(metadata i8* %136, metadata !297, metadata !DIExpression()) #4, !dbg !2147
  call void @llvm.dbg.value(metadata i1 false, metadata !303, metadata !DIExpression()) #4, !dbg !2149
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()) #4, !dbg !2150
  call void @llvm.dbg.value(metadata i1 false, metadata !204, metadata !DIExpression()) #4, !dbg !2152
  call void @llvm.dbg.value(metadata i1 false, metadata !205, metadata !DIExpression()) #4, !dbg !2153
  call void @llvm.dbg.value(metadata i1 true, metadata !206, metadata !DIExpression()) #4, !dbg !2154
  call void @llvm.dbg.value(metadata i64 0, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  call void @llvm.dbg.value(metadata i64 3, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  call void @llvm.dbg.value(metadata i64 1, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  call void @llvm.dbg.value(metadata i64 9, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  %156 = or i64 %155, 1, !dbg !2156
  call void @llvm.dbg.value(metadata i64 %156, metadata !207, metadata !DIExpression()) #4, !dbg !2155
  store i64 %156, i64* %137, align 8, !dbg !2157, !tbaa !93
  br label %157

; <label>:157:                                    ; preds = %141, %145, %154
  %158 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #4, !dbg !2158
  call void @llvm.dbg.value(metadata %struct.block* %158, metadata !1066, metadata !DIExpression()) #4, !dbg !2051
  br label %159, !dbg !2159

; <label>:159:                                    ; preds = %52, %7, %157, %111, %56, %54
  %160 = phi i8* [ %55, %54 ], [ null, %56 ], [ %55, %111 ], [ %55, %157 ], [ null, %7 ], [ null, %52 ], !dbg !1912
  ret i8* %160, !dbg !2161
}

declare dso_local i8* @mem_memcpy(i8*, i8*, i64) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_calloc(i64, i64) local_unnamed_addr #0 !dbg !2162 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !2166, metadata !DIExpression()), !dbg !2170
  call void @llvm.dbg.value(metadata i64 %1, metadata !2167, metadata !DIExpression()), !dbg !2171
  %3 = mul i64 %1, %0, !dbg !2172
  call void @llvm.dbg.value(metadata i64 %3, metadata !2169, metadata !DIExpression()), !dbg !2173
  %4 = icmp eq i64 %0, 0, !dbg !2174
  br i1 %4, label %13, label %5, !dbg !2176

; <label>:5:                                      ; preds = %2
  %6 = udiv i64 %3, %0, !dbg !2177
  %7 = icmp eq i64 %6, %1, !dbg !2179
  br i1 %7, label %8, label %13, !dbg !2180

; <label>:8:                                      ; preds = %5
  %9 = tail call i8* @mm_malloc(i64 %3), !dbg !2181
  call void @llvm.dbg.value(metadata i8* %9, metadata !2168, metadata !DIExpression()), !dbg !2182
  %10 = icmp eq i8* %9, null, !dbg !2183
  br i1 %10, label %13, label %11, !dbg !2185

; <label>:11:                                     ; preds = %8
  %12 = tail call i8* @mem_memset(i8* nonnull %9, i32 0, i64 %3) #4, !dbg !2186
  br label %13, !dbg !2187

; <label>:13:                                     ; preds = %8, %5, %2, %11
  %14 = phi i8* [ %9, %11 ], [ null, %2 ], [ null, %5 ], [ null, %8 ], !dbg !2188
  ret i8* %14, !dbg !2189
}

declare dso_local i8* @mem_memset(i8*, i32, i64) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #5

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
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
!84 = !DILocation(line: 760, column: 14, scope: !72)
!85 = !DILocation(line: 761, column: 22, scope: !72)
!86 = !{!87, !87, i64 0}
!87 = !{!"any pointer", !88, i64 0}
!88 = !{!"omnipotent char", !89, i64 0}
!89 = !{!"Simple C/C++ TBAA"}
!90 = !DILocation(line: 761, column: 14, scope: !72)
!91 = !DILocation(line: 762, column: 10, scope: !72)
!92 = !DILocation(line: 763, column: 14, scope: !72)
!93 = !{!94, !95, i64 0}
!94 = !{!"block", !95, i64 0, !88, i64 8}
!95 = !{!"long", !88, i64 0}
!96 = !DILocation(line: 764, column: 35, scope: !97)
!97 = distinct !DILexicalBlock(scope: !72, file: !3, line: 764, column: 9)
!98 = !DILocation(line: 770, column: 27, scope: !72)
!99 = !DILocation(line: 770, column: 5, scope: !72)
!100 = !DILocation(line: 786, column: 32, scope: !101)
!101 = distinct !DILexicalBlock(scope: !102, file: !3, line: 786, column: 13)
!102 = distinct !DILexicalBlock(scope: !72, file: !3, line: 771, column: 5)
!103 = !DILocation(line: 766, column: 9, scope: !104)
!104 = distinct !DILexicalBlock(scope: !97, file: !3, line: 765, column: 5)
!105 = !DILocation(line: 767, column: 9, scope: !104)
!106 = !DILocation(line: 786, column: 21, scope: !101)
!107 = !DILocation(line: 786, column: 19, scope: !101)
!108 = !DILocation(line: 786, column: 46, scope: !101)
!109 = !DILocation(line: 786, column: 68, scope: !101)
!110 = !DILocation(line: 786, column: 57, scope: !101)
!111 = !DILocation(line: 786, column: 55, scope: !101)
!112 = !DILocation(line: 786, column: 13, scope: !102)
!113 = !DILocation(line: 788, column: 13, scope: !114)
!114 = distinct !DILexicalBlock(scope: !101, file: !3, line: 787, column: 9)
!115 = !DILocation(line: 789, column: 13, scope: !114)
!116 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !122)
!117 = distinct !DISubprogram(name: "ifmini", scope: !3, file: !3, line: 260, type: !118, isLocal: true, isDefinition: true, scopeLine: 260, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !120)
!118 = !DISubroutineType(types: !119)
!119 = !{!32, !6}
!120 = !{!121}
!121 = !DILocalVariable(name: "block", arg: 1, scope: !117, file: !3, line: 260, type: !6)
!122 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !128)
!123 = distinct !DISubprogram(name: "get_size", scope: !3, file: !3, line: 276, type: !124, isLocal: true, isDefinition: true, scopeLine: 276, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !126)
!124 = !DISubroutineType(types: !125)
!125 = !{!38, !6}
!126 = !{!127}
!127 = !DILocalVariable(name: "block", arg: 1, scope: !123, file: !3, line: 276, type: !6)
!128 = distinct !DILocation(line: 794, column: 13, scope: !129)
!129 = distinct !DILexicalBlock(scope: !102, file: !3, line: 794, column: 13)
!130 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !122)
!131 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !137)
!132 = distinct !DISubprogram(name: "extract_size", scope: !3, file: !3, line: 246, type: !133, isLocal: true, isDefinition: true, scopeLine: 246, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !135)
!133 = !DISubroutineType(types: !134)
!134 = !{!38, !11}
!135 = !{!136}
!136 = !DILocalVariable(name: "word", arg: 1, scope: !132, file: !3, line: 246, type: !11)
!137 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !128)
!138 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !128)
!139 = !DILocation(line: 794, column: 29, scope: !129)
!140 = !DILocation(line: 794, column: 13, scope: !102)
!141 = !DILocation(line: 796, column: 13, scope: !142)
!142 = distinct !DILexicalBlock(scope: !129, file: !3, line: 795, column: 9)
!143 = !DILocation(line: 797, column: 13, scope: !142)
!144 = !DILocation(line: 802, column: 13, scope: !145)
!145 = distinct !DILexicalBlock(scope: !102, file: !3, line: 802, column: 13)
!146 = !DILocation(line: 802, column: 38, scope: !145)
!147 = !DILocation(line: 802, column: 24, scope: !145)
!148 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !149)
!149 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !150)
!150 = distinct !DILocation(line: 802, column: 50, scope: !145)
!151 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !149)
!152 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !153)
!153 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !150)
!154 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !150)
!155 = !DILocation(line: 802, column: 71, scope: !145)
!156 = !DILocation(line: 802, column: 13, scope: !102)
!157 = !DILocalVariable(name: "block", arg: 1, scope: !158, file: !3, line: 418, type: !6)
!158 = distinct !DISubprogram(name: "find_next", scope: !3, file: !3, line: 418, type: !159, isLocal: true, isDefinition: true, scopeLine: 418, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !161)
!159 = !DISubroutineType(types: !160)
!160 = !{!6, !6}
!161 = !{!157}
!162 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !163)
!163 = distinct !DILocation(line: 804, column: 26, scope: !164)
!164 = distinct !DILexicalBlock(scope: !165, file: !3, line: 804, column: 17)
!165 = distinct !DILexicalBlock(scope: !145, file: !3, line: 803, column: 9)
!166 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !163)
!167 = !DILocation(line: 422, column: 12, scope: !158, inlinedAt: !163)
!168 = !DILocation(line: 804, column: 23, scope: !164)
!169 = !DILocation(line: 804, column: 17, scope: !165)
!170 = !DILocation(line: 806, column: 17, scope: !171)
!171 = distinct !DILexicalBlock(scope: !164, file: !3, line: 805, column: 13)
!172 = !DILocation(line: 807, column: 17, scope: !171)
!173 = !DILocation(line: 812, column: 36, scope: !174)
!174 = distinct !DILexicalBlock(scope: !102, file: !3, line: 812, column: 13)
!175 = !DILocation(line: 814, column: 13, scope: !176)
!176 = distinct !DILexicalBlock(scope: !174, file: !3, line: 813, column: 9)
!177 = !DILocation(line: 815, column: 13, scope: !176)
!178 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !179)
!179 = distinct !DILocation(line: 818, column: 17, scope: !102)
!180 = !DILocation(line: 422, column: 24, scope: !158, inlinedAt: !179)
!181 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !179)
!182 = !DILocation(line: 422, column: 12, scope: !158, inlinedAt: !179)
!183 = distinct !{!183, !99, !184}
!184 = !DILocation(line: 819, column: 5, scope: !72)
!185 = !DILocation(line: 0, scope: !72)
!186 = !DILocation(line: 823, column: 1, scope: !72)
!187 = distinct !DISubprogram(name: "mm_init", scope: !3, file: !3, line: 832, type: !188, isLocal: false, isDefinition: true, scopeLine: 832, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !190)
!188 = !DISubroutineType(types: !189)
!189 = !{!32}
!190 = !{!191, !192}
!191 = !DILocalVariable(name: "start", scope: !187, file: !3, line: 834, type: !30)
!192 = !DILocalVariable(name: "i", scope: !187, file: !3, line: 835, type: !49)
!193 = !DILocation(line: 834, column: 32, scope: !187)
!194 = !DILocation(line: 837, column: 15, scope: !195)
!195 = distinct !DILexicalBlock(scope: !187, file: !3, line: 837, column: 9)
!196 = !DILocation(line: 837, column: 9, scope: !187)
!197 = !DILocation(line: 834, column: 13, scope: !187)
!198 = !DILocalVariable(name: "size", arg: 1, scope: !199, file: !3, line: 219, type: !38)
!199 = distinct !DISubprogram(name: "pack", scope: !3, file: !3, line: 219, type: !200, isLocal: true, isDefinition: true, scopeLine: 220, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !202)
!200 = !DISubroutineType(types: !201)
!201 = !{!11, !38, !32, !32, !32, !32}
!202 = !{!198, !203, !204, !205, !206, !207}
!203 = !DILocalVariable(name: "prev_mini", arg: 2, scope: !199, file: !3, line: 219, type: !32)
!204 = !DILocalVariable(name: "mini", arg: 3, scope: !199, file: !3, line: 219, type: !32)
!205 = !DILocalVariable(name: "prev_alloc", arg: 4, scope: !199, file: !3, line: 219, type: !32)
!206 = !DILocalVariable(name: "alloc", arg: 5, scope: !199, file: !3, line: 219, type: !32)
!207 = !DILocalVariable(name: "word", scope: !199, file: !3, line: 221, type: !11)
!208 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !209)
!209 = distinct !DILocation(line: 841, column: 16, scope: !187)
!210 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !209)
!211 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !209)
!212 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !209)
!213 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !209)
!214 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !209)
!215 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !216)
!216 = distinct !DILocation(line: 842, column: 16, scope: !187)
!217 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !216)
!218 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !216)
!219 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !216)
!220 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !216)
!221 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !216)
!222 = !DILocation(line: 842, column: 5, scope: !187)
!223 = !DILocation(line: 841, column: 14, scope: !187)
!224 = !{!95, !95, i64 0}
!225 = !DILocation(line: 845, column: 16, scope: !187)
!226 = !DILocalVariable(name: "size", arg: 1, scope: !227, file: !3, line: 646, type: !38)
!227 = distinct !DISubprogram(name: "extend_heap", scope: !3, file: !3, line: 646, type: !228, isLocal: true, isDefinition: true, scopeLine: 646, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !230)
!228 = !DISubroutineType(types: !229)
!229 = !{!6, !38}
!230 = !{!226, !231, !232, !233}
!231 = !DILocalVariable(name: "bp", scope: !227, file: !3, line: 647, type: !31)
!232 = !DILocalVariable(name: "block", scope: !227, file: !3, line: 656, type: !6)
!233 = !DILocalVariable(name: "block_next", scope: !227, file: !3, line: 659, type: !6)
!234 = !DILocation(line: 646, column: 36, scope: !227, inlinedAt: !235)
!235 = distinct !DILocation(line: 848, column: 9, scope: !236)
!236 = distinct !DILexicalBlock(scope: !187, file: !3, line: 848, column: 9)
!237 = !DILocation(line: 651, column: 15, scope: !238, inlinedAt: !235)
!238 = distinct !DILexicalBlock(scope: !227, file: !3, line: 651, column: 9)
!239 = !DILocation(line: 647, column: 11, scope: !227, inlinedAt: !235)
!240 = !DILocation(line: 651, column: 31, scope: !238, inlinedAt: !235)
!241 = !DILocation(line: 651, column: 9, scope: !227, inlinedAt: !235)
!242 = !DILocalVariable(name: "bp", arg: 1, scope: !243, file: !3, line: 286, type: !31)
!243 = distinct !DISubprogram(name: "payload_to_header", scope: !3, file: !3, line: 286, type: !244, isLocal: true, isDefinition: true, scopeLine: 286, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !246)
!244 = !DISubroutineType(types: !245)
!245 = !{!6, !31}
!246 = !{!242}
!247 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !248)
!248 = distinct !DILocation(line: 656, column: 22, scope: !227, inlinedAt: !235)
!249 = !DILocation(line: 287, column: 35, scope: !243, inlinedAt: !248)
!250 = !DILocation(line: 287, column: 12, scope: !243, inlinedAt: !248)
!251 = !DILocation(line: 656, column: 14, scope: !227, inlinedAt: !235)
!252 = !DILocalVariable(name: "block", arg: 1, scope: !253, file: !3, line: 396, type: !6)
!253 = distinct !DISubprogram(name: "write_block", scope: !3, file: !3, line: 396, type: !254, isLocal: true, isDefinition: true, scopeLine: 397, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !256)
!254 = !DISubroutineType(types: !255)
!255 = !{null, !6, !38, !32, !32, !32, !32}
!256 = !{!252, !257, !258, !259, !260, !261, !262}
!257 = !DILocalVariable(name: "size", arg: 2, scope: !253, file: !3, line: 396, type: !38)
!258 = !DILocalVariable(name: "prev_mini", arg: 3, scope: !253, file: !3, line: 396, type: !32)
!259 = !DILocalVariable(name: "mini", arg: 4, scope: !253, file: !3, line: 396, type: !32)
!260 = !DILocalVariable(name: "prev_alloc", arg: 5, scope: !253, file: !3, line: 397, type: !32)
!261 = !DILocalVariable(name: "alloc", arg: 6, scope: !253, file: !3, line: 397, type: !32)
!262 = !DILocalVariable(name: "footerp", scope: !263, file: !3, line: 403, type: !30)
!263 = distinct !DILexicalBlock(scope: !264, file: !3, line: 402, column: 26)
!264 = distinct !DILexicalBlock(scope: !253, file: !3, line: 402, column: 9)
!265 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !266)
!266 = distinct !DILocation(line: 657, column: 5, scope: !227, inlinedAt: !235)
!267 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !266)
!268 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !266)
!269 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !266)
!270 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !271)
!271 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !266)
!272 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !271)
!273 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !271)
!274 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !271)
!275 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !271)
!276 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !266)
!277 = !DILocalVariable(name: "block", arg: 1, scope: !278, file: !3, line: 310, type: !6)
!278 = distinct !DISubprogram(name: "header_to_footer", scope: !3, file: !3, line: 310, type: !279, isLocal: true, isDefinition: true, scopeLine: 310, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !281)
!279 = !DISubroutineType(types: !280)
!280 = !{!30, !6}
!281 = !{!277}
!282 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !283)
!283 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !266)
!284 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !283)
!285 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !283)
!286 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !266)
!287 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !288)
!288 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !266)
!289 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !288)
!290 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !288)
!291 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !288)
!292 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !266)
!293 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !294)
!294 = distinct !DILocation(line: 659, column: 27, scope: !227, inlinedAt: !235)
!295 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !294)
!296 = !DILocation(line: 659, column: 14, scope: !227, inlinedAt: !235)
!297 = !DILocalVariable(name: "block", arg: 1, scope: !298, file: !3, line: 376, type: !6)
!298 = distinct !DISubprogram(name: "write_epilogue", scope: !3, file: !3, line: 376, type: !299, isLocal: true, isDefinition: true, scopeLine: 376, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !301)
!299 = !DISubroutineType(types: !300)
!300 = !{null, !6, !32, !32}
!301 = !{!297, !302, !303}
!302 = !DILocalVariable(name: "prev_mini", arg: 2, scope: !298, file: !3, line: 376, type: !32)
!303 = !DILocalVariable(name: "prev_alloc", arg: 3, scope: !298, file: !3, line: 376, type: !32)
!304 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !305)
!305 = distinct !DILocation(line: 660, column: 5, scope: !227, inlinedAt: !235)
!306 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !305)
!307 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !305)
!308 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !309)
!309 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !305)
!310 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !309)
!311 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !309)
!312 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !309)
!313 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !309)
!314 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !309)
!315 = !DILocation(line: 379, column: 12, scope: !298, inlinedAt: !305)
!316 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !305)
!317 = !DILocation(line: 663, column: 13, scope: !227, inlinedAt: !235)
!318 = !DILocation(line: 848, column: 32, scope: !236)
!319 = !DILocation(line: 848, column: 9, scope: !187)
!320 = !DILocation(line: 855, column: 22, scope: !321)
!321 = distinct !DILexicalBlock(scope: !322, file: !3, line: 854, column: 5)
!322 = distinct !DILexicalBlock(scope: !323, file: !3, line: 853, column: 5)
!323 = distinct !DILexicalBlock(scope: !187, file: !3, line: 853, column: 5)
!324 = !DILocation(line: 858, column: 1, scope: !187)
!325 = !DILocation(line: 0, scope: !187)
!326 = distinct !DISubprogram(name: "mm_malloc", scope: !3, file: !3, line: 867, type: !327, isLocal: false, isDefinition: true, scopeLine: 867, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !329)
!327 = !DISubroutineType(types: !328)
!328 = !{!31, !38}
!329 = !{!330, !331, !332, !333, !334, !335, !336, !337}
!330 = !DILocalVariable(name: "size", arg: 1, scope: !326, file: !3, line: 867, type: !38)
!331 = !DILocalVariable(name: "asize", scope: !326, file: !3, line: 870, type: !38)
!332 = !DILocalVariable(name: "extendsize", scope: !326, file: !3, line: 871, type: !38)
!333 = !DILocalVariable(name: "block", scope: !326, file: !3, line: 872, type: !6)
!334 = !DILocalVariable(name: "bp", scope: !326, file: !3, line: 873, type: !31)
!335 = !DILocalVariable(name: "block_size", scope: !326, file: !3, line: 908, type: !38)
!336 = !DILocalVariable(name: "block_next", scope: !326, file: !3, line: 918, type: !6)
!337 = !DILocalVariable(name: "block_next_size", scope: !326, file: !3, line: 919, type: !38)
!338 = !DILocation(line: 867, column: 21, scope: !326)
!339 = !DILocation(line: 873, column: 11, scope: !326)
!340 = !DILocation(line: 876, column: 9, scope: !341)
!341 = distinct !DILexicalBlock(scope: !326, file: !3, line: 876, column: 9)
!342 = !DILocation(line: 876, column: 20, scope: !341)
!343 = !DILocation(line: 876, column: 9, scope: !326)
!344 = !DILocation(line: 834, column: 32, scope: !187, inlinedAt: !345)
!345 = distinct !DILocation(line: 877, column: 9, scope: !346)
!346 = distinct !DILexicalBlock(scope: !341, file: !3, line: 876, column: 29)
!347 = !DILocation(line: 837, column: 15, scope: !195, inlinedAt: !345)
!348 = !DILocation(line: 837, column: 9, scope: !187, inlinedAt: !345)
!349 = !DILocation(line: 834, column: 13, scope: !187, inlinedAt: !345)
!350 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !351)
!351 = distinct !DILocation(line: 841, column: 16, scope: !187, inlinedAt: !345)
!352 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !351)
!353 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !351)
!354 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !351)
!355 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !351)
!356 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !351)
!357 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !358)
!358 = distinct !DILocation(line: 842, column: 16, scope: !187, inlinedAt: !345)
!359 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !358)
!360 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !358)
!361 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !358)
!362 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !358)
!363 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !358)
!364 = !DILocation(line: 842, column: 5, scope: !187, inlinedAt: !345)
!365 = !DILocation(line: 841, column: 14, scope: !187, inlinedAt: !345)
!366 = !DILocation(line: 845, column: 16, scope: !187, inlinedAt: !345)
!367 = !DILocation(line: 646, column: 36, scope: !227, inlinedAt: !368)
!368 = distinct !DILocation(line: 848, column: 9, scope: !236, inlinedAt: !345)
!369 = !DILocation(line: 651, column: 15, scope: !238, inlinedAt: !368)
!370 = !DILocation(line: 647, column: 11, scope: !227, inlinedAt: !368)
!371 = !DILocation(line: 651, column: 31, scope: !238, inlinedAt: !368)
!372 = !DILocation(line: 651, column: 9, scope: !227, inlinedAt: !368)
!373 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !374)
!374 = distinct !DILocation(line: 656, column: 22, scope: !227, inlinedAt: !368)
!375 = !DILocation(line: 287, column: 35, scope: !243, inlinedAt: !374)
!376 = !DILocation(line: 287, column: 12, scope: !243, inlinedAt: !374)
!377 = !DILocation(line: 656, column: 14, scope: !227, inlinedAt: !368)
!378 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !379)
!379 = distinct !DILocation(line: 657, column: 5, scope: !227, inlinedAt: !368)
!380 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !379)
!381 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !379)
!382 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !379)
!383 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !384)
!384 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !379)
!385 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !384)
!386 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !384)
!387 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !384)
!388 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !384)
!389 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !379)
!390 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !391)
!391 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !379)
!392 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !391)
!393 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !391)
!394 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !379)
!395 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !396)
!396 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !379)
!397 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !396)
!398 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !396)
!399 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !396)
!400 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !379)
!401 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !402)
!402 = distinct !DILocation(line: 659, column: 27, scope: !227, inlinedAt: !368)
!403 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !402)
!404 = !DILocation(line: 659, column: 14, scope: !227, inlinedAt: !368)
!405 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !406)
!406 = distinct !DILocation(line: 660, column: 5, scope: !227, inlinedAt: !368)
!407 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !406)
!408 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !406)
!409 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !410)
!410 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !406)
!411 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !410)
!412 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !410)
!413 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !410)
!414 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !410)
!415 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !410)
!416 = !DILocation(line: 379, column: 12, scope: !298, inlinedAt: !406)
!417 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !406)
!418 = !DILocation(line: 663, column: 13, scope: !227, inlinedAt: !368)
!419 = !DILocation(line: 848, column: 32, scope: !236, inlinedAt: !345)
!420 = !DILocation(line: 848, column: 9, scope: !187, inlinedAt: !345)
!421 = !DILocation(line: 855, column: 22, scope: !321, inlinedAt: !345)
!422 = !DILocation(line: 858, column: 1, scope: !187, inlinedAt: !345)
!423 = !DILocation(line: 881, column: 14, scope: !424)
!424 = distinct !DILexicalBlock(scope: !326, file: !3, line: 881, column: 9)
!425 = !DILocation(line: 881, column: 9, scope: !326)
!426 = !DILocalVariable(name: "size", arg: 1, scope: !427, file: !3, line: 203, type: !38)
!427 = distinct !DISubprogram(name: "round_up", scope: !3, file: !3, line: 203, type: !428, isLocal: true, isDefinition: true, scopeLine: 203, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !430)
!428 = !DISubroutineType(types: !429)
!429 = !{!38, !38, !38}
!430 = !{!426, !431}
!431 = !DILocalVariable(name: "n", arg: 2, scope: !427, file: !3, line: 203, type: !38)
!432 = !DILocation(line: 203, column: 31, scope: !427, inlinedAt: !433)
!433 = distinct !DILocation(line: 887, column: 13, scope: !326)
!434 = !DILocation(line: 203, column: 44, scope: !427, inlinedAt: !433)
!435 = !DILocation(line: 204, column: 23, scope: !427, inlinedAt: !433)
!436 = !DILocation(line: 204, column: 14, scope: !427, inlinedAt: !433)
!437 = !DILocation(line: 870, column: 12, scope: !326)
!438 = !DILocalVariable(name: "asize", arg: 1, scope: !439, file: !3, line: 727, type: !38)
!439 = distinct !DISubprogram(name: "find_fit", scope: !3, file: !3, line: 727, type: !228, isLocal: true, isDefinition: true, scopeLine: 727, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !440)
!440 = !{!438, !441, !442, !443}
!441 = !DILocalVariable(name: "index", scope: !439, file: !3, line: 728, type: !49)
!442 = !DILocalVariable(name: "i", scope: !439, file: !3, line: 729, type: !49)
!443 = !DILocalVariable(name: "block", scope: !444, file: !3, line: 733, type: !6)
!444 = distinct !DILexicalBlock(scope: !439, file: !3, line: 732, column: 5)
!445 = !DILocation(line: 727, column: 33, scope: !439, inlinedAt: !446)
!446 = distinct !DILocation(line: 890, column: 13, scope: !326)
!447 = !DILocalVariable(name: "size", arg: 1, scope: !448, file: !3, line: 472, type: !38)
!448 = distinct !DISubprogram(name: "findlist", scope: !3, file: !3, line: 472, type: !449, isLocal: true, isDefinition: true, scopeLine: 472, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !451)
!449 = !DISubroutineType(types: !450)
!450 = !{!49, !38}
!451 = !{!447, !452, !453}
!452 = !DILocalVariable(name: "block_size", scope: !448, file: !3, line: 477, type: !38)
!453 = !DILocalVariable(name: "i", scope: !448, file: !3, line: 478, type: !49)
!454 = !DILocation(line: 472, column: 28, scope: !448, inlinedAt: !455)
!455 = distinct !DILocation(line: 728, column: 17, scope: !439, inlinedAt: !446)
!456 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !455)
!457 = distinct !DILexicalBlock(scope: !448, file: !3, line: 473, column: 9)
!458 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !455)
!459 = !DILocation(line: 0, scope: !460, inlinedAt: !455)
!460 = distinct !DILexicalBlock(scope: !448, file: !3, line: 480, column: 5)
!461 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !455)
!462 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !455)
!463 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !455)
!464 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !455)
!465 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !455)
!466 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !455)
!467 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !455)
!468 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !455)
!469 = distinct !{!469, !470, !471}
!470 = !DILocation(line: 479, column: 5, scope: !448)
!471 = !DILocation(line: 483, column: 5, scope: !448)
!472 = !DILocation(line: 728, column: 9, scope: !439, inlinedAt: !446)
!473 = !DILocation(line: 729, column: 9, scope: !439, inlinedAt: !446)
!474 = !DILocation(line: 731, column: 14, scope: !439, inlinedAt: !446)
!475 = !DILocation(line: 731, column: 5, scope: !439, inlinedAt: !446)
!476 = !DILocation(line: 733, column: 26, scope: !444, inlinedAt: !446)
!477 = !DILocation(line: 733, column: 18, scope: !444, inlinedAt: !446)
!478 = !DILocation(line: 734, column: 19, scope: !479, inlinedAt: !446)
!479 = distinct !DILexicalBlock(scope: !444, file: !3, line: 734, column: 13)
!480 = !DILocation(line: 734, column: 13, scope: !444, inlinedAt: !446)
!481 = !DILocation(line: 0, scope: !482, inlinedAt: !446)
!482 = distinct !DILexicalBlock(scope: !483, file: !3, line: 737, column: 13)
!483 = distinct !DILexicalBlock(scope: !479, file: !3, line: 735, column: 9)
!484 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !485)
!485 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !486)
!486 = distinct !DILocation(line: 738, column: 30, scope: !487, inlinedAt: !446)
!487 = distinct !DILexicalBlock(scope: !482, file: !3, line: 738, column: 21)
!488 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !485)
!489 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !490)
!490 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !486)
!491 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !486)
!492 = !DILocation(line: 738, column: 27, scope: !487, inlinedAt: !446)
!493 = !DILocation(line: 738, column: 21, scope: !482, inlinedAt: !446)
!494 = !DILocation(line: 742, column: 44, scope: !482, inlinedAt: !446)
!495 = !{!88, !88, i64 0}
!496 = !DILocation(line: 743, column: 28, scope: !483, inlinedAt: !446)
!497 = !DILocation(line: 743, column: 13, scope: !482, inlinedAt: !446)
!498 = distinct !{!498, !499, !500}
!499 = !DILocation(line: 736, column: 13, scope: !483)
!500 = !DILocation(line: 743, column: 43, scope: !483)
!501 = !DILocation(line: 745, column: 10, scope: !444, inlinedAt: !446)
!502 = !DILocation(line: 872, column: 14, scope: !326)
!503 = !DILocation(line: 893, column: 15, scope: !504)
!504 = distinct !DILexicalBlock(scope: !326, file: !3, line: 893, column: 9)
!505 = !DILocation(line: 893, column: 9, scope: !326)
!506 = !DILocalVariable(name: "x", arg: 1, scope: !507, file: !3, line: 193, type: !38)
!507 = distinct !DISubprogram(name: "max", scope: !3, file: !3, line: 193, type: !428, isLocal: true, isDefinition: true, scopeLine: 193, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !508)
!508 = !{!506, !509}
!509 = !DILocalVariable(name: "y", arg: 2, scope: !507, file: !3, line: 193, type: !38)
!510 = !DILocation(line: 193, column: 26, scope: !507, inlinedAt: !511)
!511 = distinct !DILocation(line: 895, column: 22, scope: !512)
!512 = distinct !DILexicalBlock(scope: !504, file: !3, line: 893, column: 24)
!513 = !DILocation(line: 193, column: 36, scope: !507, inlinedAt: !511)
!514 = !DILocation(line: 194, column: 15, scope: !507, inlinedAt: !511)
!515 = !DILocation(line: 194, column: 12, scope: !507, inlinedAt: !511)
!516 = !DILocation(line: 871, column: 12, scope: !326)
!517 = !DILocation(line: 646, column: 36, scope: !227, inlinedAt: !518)
!518 = distinct !DILocation(line: 896, column: 17, scope: !512)
!519 = !DILocation(line: 203, column: 31, scope: !427, inlinedAt: !520)
!520 = distinct !DILocation(line: 650, column: 12, scope: !227, inlinedAt: !518)
!521 = !DILocation(line: 203, column: 44, scope: !427, inlinedAt: !520)
!522 = !DILocation(line: 651, column: 15, scope: !238, inlinedAt: !518)
!523 = !DILocation(line: 647, column: 11, scope: !227, inlinedAt: !518)
!524 = !DILocation(line: 651, column: 31, scope: !238, inlinedAt: !518)
!525 = !DILocation(line: 651, column: 9, scope: !227, inlinedAt: !518)
!526 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !527)
!527 = distinct !DILocation(line: 656, column: 22, scope: !227, inlinedAt: !518)
!528 = !DILocation(line: 287, column: 35, scope: !243, inlinedAt: !527)
!529 = !DILocation(line: 287, column: 12, scope: !243, inlinedAt: !527)
!530 = !DILocation(line: 656, column: 14, scope: !227, inlinedAt: !518)
!531 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !535)
!532 = distinct !DISubprogram(name: "ifpremini", scope: !3, file: !3, line: 267, type: !118, isLocal: true, isDefinition: true, scopeLine: 267, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !533)
!533 = !{!534}
!534 = !DILocalVariable(name: "block", arg: 1, scope: !532, file: !3, line: 267, type: !6)
!535 = distinct !DILocation(line: 657, column: 30, scope: !227, inlinedAt: !518)
!536 = !DILocation(line: 254, column: 33, scope: !537, inlinedAt: !540)
!537 = distinct !DISubprogram(name: "ifprealloc", scope: !3, file: !3, line: 253, type: !118, isLocal: true, isDefinition: true, scopeLine: 253, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !538)
!538 = !{!539}
!539 = !DILocalVariable(name: "block", arg: 1, scope: !537, file: !3, line: 253, type: !6)
!540 = distinct !DILocation(line: 657, column: 55, scope: !227, inlinedAt: !518)
!541 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !542)
!542 = distinct !DILocation(line: 657, column: 5, scope: !227, inlinedAt: !518)
!543 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !542)
!544 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !542)
!545 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !542)
!546 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !547)
!547 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !542)
!548 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !547)
!549 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !547)
!550 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !547)
!551 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !547)
!552 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !547)
!553 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !542)
!554 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !555)
!555 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !542)
!556 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !555)
!557 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !555)
!558 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !555)
!559 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !542)
!560 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !561)
!561 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !542)
!562 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !561)
!563 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !561)
!564 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !561)
!565 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !542)
!566 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !567)
!567 = distinct !DILocation(line: 659, column: 27, scope: !227, inlinedAt: !518)
!568 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !569)
!569 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !570)
!570 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !567)
!571 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !569)
!572 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !573)
!573 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !570)
!574 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !570)
!575 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !567)
!576 = !DILocation(line: 659, column: 14, scope: !227, inlinedAt: !518)
!577 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !578)
!578 = distinct !DILocation(line: 660, column: 5, scope: !227, inlinedAt: !518)
!579 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !578)
!580 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !578)
!581 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !582)
!582 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !578)
!583 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !582)
!584 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !582)
!585 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !582)
!586 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !582)
!587 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !582)
!588 = !DILocation(line: 379, column: 12, scope: !298, inlinedAt: !578)
!589 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !578)
!590 = !DILocation(line: 663, column: 13, scope: !227, inlinedAt: !518)
!591 = !DILocation(line: 898, column: 19, scope: !592)
!592 = distinct !DILexicalBlock(scope: !512, file: !3, line: 898, column: 13)
!593 = !DILocation(line: 898, column: 13, scope: !512)
!594 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !595)
!595 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !596)
!596 = distinct !DILocation(line: 504, column: 25, scope: !597, inlinedAt: !605)
!597 = distinct !DISubprogram(name: "remove_list", scope: !3, file: !3, line: 502, type: !598, isLocal: true, isDefinition: true, scopeLine: 503, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !600)
!598 = !DISubroutineType(types: !599)
!599 = !{null, !6}
!600 = !{!601, !602, !603, !604}
!601 = !DILocalVariable(name: "block", arg: 1, scope: !597, file: !3, line: 502, type: !6)
!602 = !DILocalVariable(name: "block_size", scope: !597, file: !3, line: 504, type: !38)
!603 = !DILocalVariable(name: "index", scope: !597, file: !3, line: 505, type: !49)
!604 = !DILocalVariable(name: "prev_block", scope: !597, file: !3, line: 518, type: !6)
!605 = distinct !DILocation(line: 905, column: 5, scope: !326)
!606 = !DILocation(line: 0, scope: !326)
!607 = !DILocation(line: 502, column: 34, scope: !597, inlinedAt: !605)
!608 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !609)
!609 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !596)
!610 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !609)
!611 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !612)
!612 = distinct !DILocation(line: 505, column: 17, scope: !597, inlinedAt: !605)
!613 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !612)
!614 = !DILocation(line: 0, scope: !460, inlinedAt: !612)
!615 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !612)
!616 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !612)
!617 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !612)
!618 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !612)
!619 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !612)
!620 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !612)
!621 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !612)
!622 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !612)
!623 = !DILocation(line: 0, scope: !448, inlinedAt: !612)
!624 = !DILocation(line: 505, column: 9, scope: !597, inlinedAt: !605)
!625 = !DILocation(line: 506, column: 9, scope: !626, inlinedAt: !605)
!626 = distinct !DILexicalBlock(scope: !597, file: !3, line: 506, column: 9)
!627 = !DILocation(line: 506, column: 26, scope: !626, inlinedAt: !605)
!628 = !DILocation(line: 506, column: 9, scope: !597, inlinedAt: !605)
!629 = !DILocation(line: 508, column: 32, scope: !630, inlinedAt: !605)
!630 = distinct !DILexicalBlock(scope: !631, file: !3, line: 508, column: 13)
!631 = distinct !DILexicalBlock(scope: !626, file: !3, line: 507, column: 5)
!632 = !DILocation(line: 508, column: 37, scope: !630, inlinedAt: !605)
!633 = !DILocation(line: 508, column: 13, scope: !631, inlinedAt: !605)
!634 = !DILocation(line: 510, column: 30, scope: !635, inlinedAt: !605)
!635 = distinct !DILexicalBlock(scope: !630, file: !3, line: 509, column: 9)
!636 = !DILocation(line: 511, column: 13, scope: !635, inlinedAt: !605)
!637 = !DILocation(line: 515, column: 30, scope: !638, inlinedAt: !605)
!638 = distinct !DILexicalBlock(scope: !630, file: !3, line: 514, column: 9)
!639 = !DILocation(line: 517, column: 5, scope: !631, inlinedAt: !605)
!640 = !DILocation(line: 519, column: 9, scope: !597, inlinedAt: !605)
!641 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !642)
!642 = distinct !DILocation(line: 522, column: 35, scope: !643, inlinedAt: !605)
!643 = distinct !DILexicalBlock(scope: !644, file: !3, line: 520, column: 5)
!644 = distinct !DILexicalBlock(scope: !597, file: !3, line: 519, column: 9)
!645 = !DILocation(line: 522, column: 85, scope: !643, inlinedAt: !605)
!646 = !DILocation(line: 522, column: 22, scope: !643, inlinedAt: !605)
!647 = !DILocation(line: 518, column: 14, scope: !597, inlinedAt: !605)
!648 = !DILocation(line: 523, column: 5, scope: !643, inlinedAt: !605)
!649 = !DILocation(line: 526, column: 41, scope: !650, inlinedAt: !605)
!650 = distinct !DILexicalBlock(scope: !644, file: !3, line: 525, column: 5)
!651 = !DILocation(line: 0, scope: !650, inlinedAt: !605)
!652 = !DILocation(line: 528, column: 36, scope: !597, inlinedAt: !605)
!653 = !DILocalVariable(name: "block", arg: 1, scope: !654, file: !3, line: 491, type: !6)
!654 = distinct !DISubprogram(name: "set_pointer", scope: !3, file: !3, line: 491, type: !655, isLocal: true, isDefinition: true, scopeLine: 491, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !657)
!655 = !DISubroutineType(types: !656)
!656 = !{null, !6, !6}
!657 = !{!653, !658}
!658 = !DILocalVariable(name: "prev_block", arg: 2, scope: !654, file: !3, line: 491, type: !6)
!659 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !660)
!660 = distinct !DILocation(line: 528, column: 5, scope: !597, inlinedAt: !605)
!661 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !660)
!662 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !663)
!663 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !660)
!664 = distinct !DILexicalBlock(scope: !654, file: !3, line: 492, column: 9)
!665 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !663)
!666 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !660)
!667 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !660)
!668 = distinct !DILexicalBlock(scope: !664, file: !3, line: 492, column: 24)
!669 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !660)
!670 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !660)
!671 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !660)
!672 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !660)
!673 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !660)
!674 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !660)
!675 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !660)
!676 = distinct !DILexicalBlock(scope: !664, file: !3, line: 494, column: 12)
!677 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !660)
!678 = !DILocation(line: 529, column: 55, scope: !597, inlinedAt: !605)
!679 = !DILocation(line: 529, column: 17, scope: !597, inlinedAt: !605)
!680 = !DILocation(line: 529, column: 34, scope: !597, inlinedAt: !605)
!681 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !682)
!682 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !683)
!683 = distinct !DILocation(line: 908, column: 25, scope: !326)
!684 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !685)
!685 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !683)
!686 = !DILocation(line: 530, column: 1, scope: !597, inlinedAt: !605)
!687 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !682)
!688 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !683)
!689 = !DILocation(line: 908, column: 12, scope: !326)
!690 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !691)
!691 = distinct !DILocation(line: 909, column: 36, scope: !326)
!692 = !DILocation(line: 909, column: 66, scope: !326)
!693 = !DILocation(line: 254, column: 33, scope: !537, inlinedAt: !694)
!694 = distinct !DILocation(line: 909, column: 87, scope: !326)
!695 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !696)
!696 = distinct !DILocation(line: 909, column: 5, scope: !326)
!697 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !696)
!698 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !696)
!699 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !696)
!700 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !701)
!701 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !696)
!702 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !701)
!703 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !701)
!704 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !701)
!705 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !701)
!706 = !DILocation(line: 228, column: 9, scope: !199, inlinedAt: !701)
!707 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !701)
!708 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !696)
!709 = !DILocalVariable(name: "block", arg: 1, scope: !710, file: !3, line: 675, type: !6)
!710 = distinct !DISubprogram(name: "split_block", scope: !3, file: !3, line: 675, type: !711, isLocal: true, isDefinition: true, scopeLine: 675, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !713)
!711 = !DISubroutineType(types: !712)
!712 = !{null, !6, !38}
!713 = !{!709, !714, !715, !716, !719, !720, !721}
!714 = !DILocalVariable(name: "asize", arg: 2, scope: !710, file: !3, line: 675, type: !38)
!715 = !DILocalVariable(name: "block_size", scope: !710, file: !3, line: 678, type: !38)
!716 = !DILocalVariable(name: "block_next", scope: !717, file: !3, line: 681, type: !6)
!717 = distinct !DILexicalBlock(scope: !718, file: !3, line: 680, column: 50)
!718 = distinct !DILexicalBlock(scope: !710, file: !3, line: 680, column: 9)
!719 = !DILocalVariable(name: "mini", scope: !717, file: !3, line: 692, type: !32)
!720 = !DILocalVariable(name: "block_next_next", scope: !717, file: !3, line: 703, type: !6)
!721 = !DILocalVariable(name: "block_next_size", scope: !717, file: !3, line: 704, type: !38)
!722 = !DILocation(line: 675, column: 34, scope: !710, inlinedAt: !723)
!723 = distinct !DILocation(line: 912, column: 5, scope: !326)
!724 = !DILocation(line: 675, column: 48, scope: !710, inlinedAt: !723)
!725 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !726)
!726 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !727)
!727 = distinct !DILocation(line: 678, column: 25, scope: !710, inlinedAt: !723)
!728 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !726)
!729 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !727)
!730 = !DILocation(line: 678, column: 12, scope: !710, inlinedAt: !723)
!731 = !DILocation(line: 680, column: 21, scope: !718, inlinedAt: !723)
!732 = !DILocation(line: 680, column: 30, scope: !718, inlinedAt: !723)
!733 = !DILocation(line: 680, column: 9, scope: !710, inlinedAt: !723)
!734 = !DILocation(line: 422, column: 24, scope: !158, inlinedAt: !735)
!735 = distinct !DILocation(line: 918, column: 27, scope: !326)
!736 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !737)
!737 = distinct !DILocation(line: 684, column: 13, scope: !738, inlinedAt: !723)
!738 = distinct !DILexicalBlock(scope: !739, file: !3, line: 683, column: 9)
!739 = distinct !DILexicalBlock(scope: !717, file: !3, line: 682, column: 12)
!740 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !741)
!741 = distinct !DILocation(line: 688, column: 13, scope: !742, inlinedAt: !723)
!742 = distinct !DILexicalBlock(scope: !739, file: !3, line: 687, column: 9)
!743 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !737)
!744 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !741)
!745 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !746)
!746 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !737)
!747 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !748)
!748 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !741)
!749 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !741)
!750 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !741)
!751 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !748)
!752 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !748)
!753 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !748)
!754 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !737)
!755 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !737)
!756 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !746)
!757 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !746)
!758 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !746)
!759 = !DILocation(line: 682, column: 12, scope: !717, inlinedAt: !723)
!760 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !746)
!761 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !748)
!762 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !741)
!763 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !764)
!764 = distinct !DILocation(line: 691, column: 22, scope: !717, inlinedAt: !723)
!765 = !DILocation(line: 422, column: 24, scope: !158, inlinedAt: !764)
!766 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !767)
!767 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !768)
!768 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !764)
!769 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !767)
!770 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !768)
!771 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !764)
!772 = !DILocation(line: 681, column: 18, scope: !717, inlinedAt: !723)
!773 = !DILocation(line: 692, column: 43, scope: !717, inlinedAt: !723)
!774 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !775)
!775 = distinct !DILocation(line: 0, scope: !776, inlinedAt: !723)
!776 = distinct !DILexicalBlock(scope: !777, file: !3, line: 698, column: 9)
!777 = distinct !DILexicalBlock(scope: !717, file: !3, line: 693, column: 12)
!778 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !779)
!779 = distinct !DILocation(line: 695, column: 13, scope: !780, inlinedAt: !723)
!780 = distinct !DILexicalBlock(scope: !777, file: !3, line: 694, column: 9)
!781 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !782)
!782 = distinct !DILocation(line: 699, column: 13, scope: !776, inlinedAt: !723)
!783 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !779)
!784 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !782)
!785 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !786)
!786 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !779)
!787 = !DILocation(line: 693, column: 12, scope: !717, inlinedAt: !723)
!788 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !779)
!789 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !779)
!790 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !779)
!791 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !786)
!792 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !786)
!793 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !786)
!794 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !786)
!795 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !786)
!796 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !779)
!797 = !DILocation(line: 696, column: 9, scope: !780, inlinedAt: !723)
!798 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !799)
!799 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !782)
!800 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !782)
!801 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !782)
!802 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !782)
!803 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !799)
!804 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !799)
!805 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !799)
!806 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !799)
!807 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !799)
!808 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !782)
!809 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !810)
!810 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !782)
!811 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !810)
!812 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !810)
!813 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !810)
!814 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !810)
!815 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !782)
!816 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !817)
!817 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !782)
!818 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !817)
!819 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !817)
!820 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !817)
!821 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !817)
!822 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !782)
!823 = !DILocalVariable(name: "block", arg: 1, scope: !824, file: !3, line: 535, type: !6)
!824 = distinct !DISubprogram(name: "insert_free_block", scope: !3, file: !3, line: 535, type: !598, isLocal: true, isDefinition: true, scopeLine: 536, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !825)
!825 = !{!823, !826, !827, !828}
!826 = !DILocalVariable(name: "block_size", scope: !824, file: !3, line: 537, type: !38)
!827 = !DILocalVariable(name: "index", scope: !824, file: !3, line: 538, type: !49)
!828 = !DILocalVariable(name: "prev_block", scope: !829, file: !3, line: 547, type: !6)
!829 = distinct !DILexicalBlock(scope: !830, file: !3, line: 546, column: 10)
!830 = distinct !DILexicalBlock(scope: !824, file: !3, line: 540, column: 9)
!831 = !DILocation(line: 535, column: 40, scope: !824, inlinedAt: !832)
!832 = distinct !DILocation(line: 701, column: 9, scope: !717, inlinedAt: !723)
!833 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !834)
!834 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !835)
!835 = distinct !DILocation(line: 537, column: 25, scope: !824, inlinedAt: !832)
!836 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !834)
!837 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !838)
!838 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !835)
!839 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !840)
!840 = distinct !DILocation(line: 538, column: 17, scope: !824, inlinedAt: !832)
!841 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !840)
!842 = !DILocation(line: 0, scope: !460, inlinedAt: !840)
!843 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !840)
!844 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !840)
!845 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !840)
!846 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !840)
!847 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !840)
!848 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !840)
!849 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !840)
!850 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !840)
!851 = !DILocation(line: 0, scope: !448, inlinedAt: !840)
!852 = !DILocation(line: 538, column: 9, scope: !824, inlinedAt: !832)
!853 = !DILocation(line: 540, column: 9, scope: !830, inlinedAt: !832)
!854 = !DILocation(line: 540, column: 26, scope: !830, inlinedAt: !832)
!855 = !DILocation(line: 540, column: 9, scope: !824, inlinedAt: !832)
!856 = !DILocation(line: 542, column: 26, scope: !857, inlinedAt: !832)
!857 = distinct !DILexicalBlock(scope: !830, file: !3, line: 541, column: 5)
!858 = !DILocation(line: 543, column: 39, scope: !857, inlinedAt: !832)
!859 = !DILocation(line: 543, column: 44, scope: !857, inlinedAt: !832)
!860 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !861)
!861 = distinct !DILocation(line: 544, column: 9, scope: !857, inlinedAt: !832)
!862 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !861)
!863 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !861)
!864 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !861)
!865 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !861)
!866 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !861)
!867 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !861)
!868 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !861)
!869 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !861)
!870 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !861)
!871 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !861)
!872 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !861)
!873 = !DILocation(line: 549, column: 13, scope: !829, inlinedAt: !832)
!874 = !DILocation(line: 552, column: 70, scope: !875, inlinedAt: !832)
!875 = distinct !DILexicalBlock(scope: !876, file: !3, line: 550, column: 9)
!876 = distinct !DILexicalBlock(scope: !829, file: !3, line: 549, column: 13)
!877 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !878)
!878 = distinct !DILocation(line: 552, column: 39, scope: !875, inlinedAt: !832)
!879 = !DILocation(line: 552, column: 100, scope: !875, inlinedAt: !832)
!880 = !DILocation(line: 552, column: 26, scope: !875, inlinedAt: !832)
!881 = !DILocation(line: 547, column: 18, scope: !829, inlinedAt: !832)
!882 = !DILocation(line: 558, column: 16, scope: !829, inlinedAt: !832)
!883 = !DILocation(line: 558, column: 33, scope: !829, inlinedAt: !832)
!884 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !885)
!885 = distinct !DILocation(line: 559, column: 9, scope: !829, inlinedAt: !832)
!886 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !885)
!887 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !885)
!888 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !885)
!889 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !885)
!890 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !885)
!891 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !885)
!892 = !DILocation(line: 556, column: 58, scope: !893, inlinedAt: !832)
!893 = distinct !DILexicalBlock(scope: !876, file: !3, line: 555, column: 9)
!894 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !885)
!895 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !885)
!896 = !DILocation(line: 560, column: 33, scope: !829, inlinedAt: !832)
!897 = !DILocation(line: 560, column: 38, scope: !829, inlinedAt: !832)
!898 = !DILocation(line: 561, column: 21, scope: !829, inlinedAt: !832)
!899 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !900)
!900 = distinct !DILocation(line: 561, column: 9, scope: !829, inlinedAt: !832)
!901 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !900)
!902 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !903)
!903 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !900)
!904 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !903)
!905 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !900)
!906 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !900)
!907 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !900)
!908 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !900)
!909 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !900)
!910 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !900)
!911 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !900)
!912 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !900)
!913 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !900)
!914 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !900)
!915 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !916)
!916 = distinct !DILocation(line: 703, column: 36, scope: !717, inlinedAt: !723)
!917 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !918)
!918 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !919)
!919 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !916)
!920 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !918)
!921 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !922)
!922 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !919)
!923 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !919)
!924 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !916)
!925 = !DILocation(line: 703, column: 18, scope: !717, inlinedAt: !723)
!926 = !DILocation(line: 705, column: 29, scope: !927, inlinedAt: !723)
!927 = distinct !DILexicalBlock(scope: !717, file: !3, line: 705, column: 13)
!928 = !DILocation(line: 705, column: 13, scope: !717, inlinedAt: !723)
!929 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !930)
!930 = distinct !DILocation(line: 707, column: 42, scope: !931, inlinedAt: !723)
!931 = distinct !DILexicalBlock(scope: !927, file: !3, line: 706, column: 9)
!932 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !933)
!933 = distinct !DILocation(line: 707, column: 13, scope: !931, inlinedAt: !723)
!934 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !933)
!935 = !DILocation(line: 396, column: 59, scope: !253, inlinedAt: !933)
!936 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !933)
!937 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !938)
!938 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !933)
!939 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !938)
!940 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !938)
!941 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !938)
!942 = !DILocation(line: 228, column: 9, scope: !199, inlinedAt: !938)
!943 = !DILocation(line: 232, column: 14, scope: !944, inlinedAt: !938)
!944 = distinct !DILexicalBlock(scope: !945, file: !3, line: 231, column: 20)
!945 = distinct !DILexicalBlock(scope: !199, file: !3, line: 231, column: 9)
!946 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !938)
!947 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !933)
!948 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !933)
!949 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !950)
!950 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !933)
!951 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !950)
!952 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !953)
!953 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !954)
!954 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !950)
!955 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !953)
!956 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !957)
!957 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !954)
!958 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !954)
!959 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !950)
!960 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !950)
!961 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !950)
!962 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !933)
!963 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !964)
!964 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !933)
!965 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !964)
!966 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !964)
!967 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !964)
!968 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !933)
!969 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !933)
!970 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !971)
!971 = distinct !DILocation(line: 711, column: 13, scope: !972, inlinedAt: !723)
!972 = distinct !DILexicalBlock(scope: !927, file: !3, line: 710, column: 9)
!973 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !971)
!974 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !971)
!975 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !976)
!976 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !971)
!977 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !976)
!978 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !976)
!979 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !976)
!980 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !976)
!981 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !976)
!982 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !976)
!983 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !971)
!984 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !985)
!985 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !986)
!986 = distinct !DILocation(line: 915, column: 18, scope: !326)
!987 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !985)
!988 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !989)
!989 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !986)
!990 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !986)
!991 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !735)
!992 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !735)
!993 = !DILocation(line: 918, column: 14, scope: !326)
!994 = !DILocation(line: 920, column: 25, scope: !995)
!995 = distinct !DILexicalBlock(scope: !326, file: !3, line: 920, column: 9)
!996 = !DILocation(line: 0, scope: !997)
!997 = distinct !DILexicalBlock(scope: !995, file: !3, line: 921, column: 5)
!998 = !DILocation(line: 920, column: 9, scope: !326)
!999 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1000)
!1000 = distinct !DILocation(line: 922, column: 33, scope: !997)
!1001 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1002)
!1002 = distinct !DILocation(line: 922, column: 9, scope: !997)
!1003 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1002)
!1004 = !DILocation(line: 396, column: 59, scope: !253, inlinedAt: !1002)
!1005 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !1002)
!1006 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1007)
!1007 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1002)
!1008 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1007)
!1009 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1007)
!1010 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1007)
!1011 = !DILocation(line: 228, column: 9, scope: !199, inlinedAt: !1007)
!1012 = !DILocation(line: 232, column: 14, scope: !944, inlinedAt: !1007)
!1013 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1007)
!1014 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1002)
!1015 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !1002)
!1016 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1017)
!1017 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1002)
!1018 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !1017)
!1019 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1020)
!1020 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1021)
!1021 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !1017)
!1022 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1020)
!1023 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1024)
!1024 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1021)
!1025 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1021)
!1026 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1017)
!1027 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1017)
!1028 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1017)
!1029 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1002)
!1030 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1031)
!1031 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1002)
!1032 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1031)
!1033 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1031)
!1034 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1031)
!1035 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1002)
!1036 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !1002)
!1037 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !1038)
!1038 = distinct !DILocation(line: 926, column: 9, scope: !1039)
!1039 = distinct !DILexicalBlock(scope: !995, file: !3, line: 925, column: 5)
!1040 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !1038)
!1041 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !1038)
!1042 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1043)
!1043 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !1038)
!1044 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1043)
!1045 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1043)
!1046 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1043)
!1047 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1043)
!1048 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1043)
!1049 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1043)
!1050 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !1038)
!1051 = !DILocalVariable(name: "block", arg: 1, scope: !1052, file: !3, line: 298, type: !6)
!1052 = distinct !DISubprogram(name: "header_to_payload", scope: !3, file: !3, line: 298, type: !1053, isLocal: true, isDefinition: true, scopeLine: 298, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1055)
!1053 = !DISubroutineType(types: !1054)
!1054 = !{!31, !6}
!1055 = !{!1051}
!1056 = !DILocation(line: 298, column: 41, scope: !1052, inlinedAt: !1057)
!1057 = distinct !DILocation(line: 929, column: 10, scope: !326)
!1058 = !DILocation(line: 300, column: 28, scope: !1052, inlinedAt: !1057)
!1059 = !DILocation(line: 300, column: 20, scope: !1052, inlinedAt: !1057)
!1060 = !DILocation(line: 933, column: 1, scope: !326)
!1061 = distinct !DISubprogram(name: "mm_free", scope: !3, file: !3, line: 942, type: !1062, isLocal: false, isDefinition: true, scopeLine: 942, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1064)
!1062 = !DISubroutineType(types: !1063)
!1063 = !{null, !31}
!1064 = !{!1065, !1066, !1067, !1068}
!1065 = !DILocalVariable(name: "bp", arg: 1, scope: !1061, file: !3, line: 942, type: !31)
!1066 = !DILocalVariable(name: "block", scope: !1061, file: !3, line: 949, type: !6)
!1067 = !DILocalVariable(name: "size", scope: !1061, file: !3, line: 950, type: !38)
!1068 = !DILocalVariable(name: "block_next", scope: !1061, file: !3, line: 965, type: !6)
!1069 = !DILocation(line: 942, column: 17, scope: !1061)
!1070 = !DILocation(line: 945, column: 12, scope: !1071)
!1071 = distinct !DILexicalBlock(scope: !1061, file: !3, line: 945, column: 9)
!1072 = !DILocation(line: 945, column: 9, scope: !1061)
!1073 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !1074)
!1074 = distinct !DILocation(line: 949, column: 22, scope: !1061)
!1075 = !DILocation(line: 287, column: 35, scope: !243, inlinedAt: !1074)
!1076 = !DILocation(line: 287, column: 12, scope: !243, inlinedAt: !1074)
!1077 = !DILocation(line: 949, column: 14, scope: !1061)
!1078 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1079)
!1079 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1080)
!1080 = distinct !DILocation(line: 950, column: 19, scope: !1061)
!1081 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1079)
!1082 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1083)
!1083 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1080)
!1084 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1080)
!1085 = !DILocation(line: 950, column: 12, scope: !1061)
!1086 = !DILocation(line: 956, column: 13, scope: !1087)
!1087 = distinct !DILexicalBlock(scope: !1061, file: !3, line: 956, column: 8)
!1088 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1089)
!1089 = distinct !DILocation(line: 0, scope: !1090)
!1090 = distinct !DILexicalBlock(scope: !1087, file: !3, line: 961, column: 5)
!1091 = !DILocation(line: 254, column: 33, scope: !537, inlinedAt: !1092)
!1092 = distinct !DILocation(line: 0, scope: !1090)
!1093 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1094)
!1094 = distinct !DILocation(line: 958, column: 9, scope: !1095)
!1095 = distinct !DILexicalBlock(scope: !1087, file: !3, line: 957, column: 5)
!1096 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1097)
!1097 = distinct !DILocation(line: 962, column: 9, scope: !1090)
!1098 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1094)
!1099 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1097)
!1100 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1101)
!1101 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1094)
!1102 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1103)
!1103 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1097)
!1104 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !1101)
!1105 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1101)
!1106 = !DILocation(line: 956, column: 8, scope: !1061)
!1107 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1094)
!1108 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1094)
!1109 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1101)
!1110 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1101)
!1111 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1101)
!1112 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1094)
!1113 = !DILocation(line: 959, column: 5, scope: !1095)
!1114 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1097)
!1115 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1097)
!1116 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1103)
!1117 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1103)
!1118 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1103)
!1119 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1097)
!1120 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1121)
!1121 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1097)
!1122 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1121)
!1123 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1121)
!1124 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1121)
!1125 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1097)
!1126 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1127)
!1127 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1097)
!1128 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1127)
!1129 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1127)
!1130 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1127)
!1131 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1097)
!1132 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !1133)
!1133 = distinct !DILocation(line: 965, column: 27, scope: !1061)
!1134 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1135)
!1135 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1136)
!1136 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !1133)
!1137 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1135)
!1138 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1139)
!1139 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1136)
!1140 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1136)
!1141 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !1133)
!1142 = !DILocation(line: 965, column: 14, scope: !1061)
!1143 = !DILocation(line: 966, column: 30, scope: !1144)
!1144 = distinct !DILexicalBlock(scope: !1061, file: !3, line: 966, column: 9)
!1145 = !DILocation(line: 966, column: 9, scope: !1061)
!1146 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1147)
!1147 = distinct !DILocation(line: 968, column: 33, scope: !1148)
!1148 = distinct !DILexicalBlock(scope: !1144, file: !3, line: 967, column: 5)
!1149 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1150)
!1150 = distinct !DILocation(line: 968, column: 9, scope: !1148)
!1151 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1150)
!1152 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !1150)
!1153 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1154)
!1154 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1150)
!1155 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1154)
!1156 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1154)
!1157 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1154)
!1158 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1150)
!1159 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !1150)
!1160 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1161)
!1161 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1150)
!1162 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !1161)
!1163 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1164)
!1164 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1165)
!1165 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !1161)
!1166 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1164)
!1167 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1168)
!1168 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1165)
!1169 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1165)
!1170 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1161)
!1171 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1161)
!1172 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1161)
!1173 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1150)
!1174 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1175)
!1175 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1150)
!1176 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1175)
!1177 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1175)
!1178 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1150)
!1179 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !1150)
!1180 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1181)
!1181 = distinct !DILocation(line: 972, column: 36, scope: !1182)
!1182 = distinct !DILexicalBlock(scope: !1144, file: !3, line: 971, column: 5)
!1183 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !1184)
!1184 = distinct !DILocation(line: 972, column: 9, scope: !1182)
!1185 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !1184)
!1186 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1187)
!1187 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !1184)
!1188 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1187)
!1189 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1187)
!1190 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1187)
!1191 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1187)
!1192 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1187)
!1193 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !1184)
!1194 = !DILocation(line: 976, column: 13, scope: !1061)
!1195 = !DILocation(line: 979, column: 1, scope: !1061)
!1196 = distinct !DISubprogram(name: "coalesce_block", scope: !3, file: !3, line: 586, type: !159, isLocal: true, isDefinition: true, scopeLine: 586, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1197)
!1197 = !{!1198, !1199, !1200, !1201, !1202, !1203, !1208, !1210, !1211}
!1198 = !DILocalVariable(name: "block", arg: 1, scope: !1196, file: !3, line: 586, type: !6)
!1199 = !DILocalVariable(name: "block_size", scope: !1196, file: !3, line: 587, type: !38)
!1200 = !DILocalVariable(name: "block_next", scope: !1196, file: !3, line: 588, type: !6)
!1201 = !DILocalVariable(name: "prev_alloc", scope: !1196, file: !3, line: 590, type: !32)
!1202 = !DILocalVariable(name: "next_alloc", scope: !1196, file: !3, line: 591, type: !32)
!1203 = !DILocalVariable(name: "block_prev", scope: !1204, file: !3, line: 603, type: !6)
!1204 = distinct !DILexicalBlock(scope: !1205, file: !3, line: 602, column: 5)
!1205 = distinct !DILexicalBlock(scope: !1206, file: !3, line: 601, column: 14)
!1206 = distinct !DILexicalBlock(scope: !1207, file: !3, line: 596, column: 14)
!1207 = distinct !DILexicalBlock(scope: !1196, file: !3, line: 593, column: 9)
!1208 = !DILocalVariable(name: "block_prev", scope: !1209, file: !3, line: 612, type: !6)
!1209 = distinct !DILexicalBlock(scope: !1205, file: !3, line: 609, column: 5)
!1210 = !DILocalVariable(name: "mini", scope: !1196, file: !3, line: 618, type: !32)
!1211 = !DILocalVariable(name: "block_next_size", scope: !1196, file: !3, line: 623, type: !38)
!1212 = !DILocation(line: 586, column: 41, scope: !1196)
!1213 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1214)
!1214 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1215)
!1215 = distinct !DILocation(line: 587, column: 25, scope: !1196)
!1216 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1214)
!1217 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1218)
!1218 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1215)
!1219 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1215)
!1220 = !DILocation(line: 587, column: 12, scope: !1196)
!1221 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !1222)
!1222 = distinct !DILocation(line: 588, column: 27, scope: !1196)
!1223 = !DILocation(line: 422, column: 24, scope: !158, inlinedAt: !1222)
!1224 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !1222)
!1225 = !DILocation(line: 422, column: 12, scope: !158, inlinedAt: !1222)
!1226 = !DILocation(line: 588, column: 14, scope: !1196)
!1227 = !DILocation(line: 254, column: 33, scope: !537, inlinedAt: !1228)
!1228 = distinct !DILocation(line: 590, column: 23, scope: !1196)
!1229 = !DILocation(line: 254, column: 12, scope: !537, inlinedAt: !1228)
!1230 = !DILocalVariable(name: "word", arg: 1, scope: !1231, file: !3, line: 351, type: !11)
!1231 = distinct !DISubprogram(name: "extract_alloc", scope: !3, file: !3, line: 351, type: !1232, isLocal: true, isDefinition: true, scopeLine: 351, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1234)
!1232 = !DISubroutineType(types: !1233)
!1233 = !{!32, !11}
!1234 = !{!1230}
!1235 = !DILocation(line: 351, column: 34, scope: !1231, inlinedAt: !1236)
!1236 = distinct !DILocation(line: 361, column: 12, scope: !1237, inlinedAt: !1240)
!1237 = distinct !DISubprogram(name: "get_alloc", scope: !3, file: !3, line: 360, type: !118, isLocal: true, isDefinition: true, scopeLine: 360, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1238)
!1238 = !{!1239}
!1239 = !DILocalVariable(name: "block", arg: 1, scope: !1237, file: !3, line: 360, type: !6)
!1240 = distinct !DILocation(line: 591, column: 23, scope: !1196)
!1241 = !DILocation(line: 352, column: 24, scope: !1231, inlinedAt: !1236)
!1242 = !DILocation(line: 352, column: 12, scope: !1231, inlinedAt: !1236)
!1243 = !DILocation(line: 593, column: 20, scope: !1207)
!1244 = !DILocation(line: 596, column: 25, scope: !1206)
!1245 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1246)
!1246 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1247)
!1247 = distinct !DILocation(line: 598, column: 23, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1206, file: !3, line: 597, column: 5)
!1249 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1246)
!1250 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1251)
!1251 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1247)
!1252 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1247)
!1253 = !DILocation(line: 598, column: 20, scope: !1248)
!1254 = !DILocation(line: 502, column: 34, scope: !597, inlinedAt: !1255)
!1255 = distinct !DILocation(line: 599, column: 9, scope: !1248)
!1256 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !1257)
!1257 = distinct !DILocation(line: 505, column: 17, scope: !597, inlinedAt: !1255)
!1258 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !1257)
!1259 = !DILocation(line: 0, scope: !460, inlinedAt: !1257)
!1260 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !1257)
!1261 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !1257)
!1262 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !1257)
!1263 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !1257)
!1264 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !1257)
!1265 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !1257)
!1266 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !1257)
!1267 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !1257)
!1268 = !DILocation(line: 0, scope: !448, inlinedAt: !1257)
!1269 = !DILocation(line: 505, column: 9, scope: !597, inlinedAt: !1255)
!1270 = !DILocation(line: 506, column: 9, scope: !626, inlinedAt: !1255)
!1271 = !DILocation(line: 506, column: 26, scope: !626, inlinedAt: !1255)
!1272 = !DILocation(line: 506, column: 9, scope: !597, inlinedAt: !1255)
!1273 = !DILocation(line: 508, column: 32, scope: !630, inlinedAt: !1255)
!1274 = !DILocation(line: 508, column: 37, scope: !630, inlinedAt: !1255)
!1275 = !DILocation(line: 508, column: 13, scope: !631, inlinedAt: !1255)
!1276 = !DILocation(line: 510, column: 30, scope: !635, inlinedAt: !1255)
!1277 = !DILocation(line: 511, column: 13, scope: !635, inlinedAt: !1255)
!1278 = !DILocation(line: 515, column: 30, scope: !638, inlinedAt: !1255)
!1279 = !DILocation(line: 517, column: 5, scope: !631, inlinedAt: !1255)
!1280 = !DILocation(line: 519, column: 9, scope: !597, inlinedAt: !1255)
!1281 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1282)
!1282 = distinct !DILocation(line: 522, column: 35, scope: !643, inlinedAt: !1255)
!1283 = !DILocation(line: 522, column: 85, scope: !643, inlinedAt: !1255)
!1284 = !DILocation(line: 522, column: 22, scope: !643, inlinedAt: !1255)
!1285 = !DILocation(line: 518, column: 14, scope: !597, inlinedAt: !1255)
!1286 = !DILocation(line: 523, column: 5, scope: !643, inlinedAt: !1255)
!1287 = !DILocation(line: 526, column: 41, scope: !650, inlinedAt: !1255)
!1288 = !DILocation(line: 0, scope: !650, inlinedAt: !1255)
!1289 = !DILocation(line: 528, column: 36, scope: !597, inlinedAt: !1255)
!1290 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1291)
!1291 = distinct !DILocation(line: 528, column: 5, scope: !597, inlinedAt: !1255)
!1292 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1291)
!1293 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1294)
!1294 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !1291)
!1295 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1294)
!1296 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1291)
!1297 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1291)
!1298 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1291)
!1299 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1291)
!1300 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1291)
!1301 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1291)
!1302 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1291)
!1303 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1291)
!1304 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1291)
!1305 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1291)
!1306 = !DILocation(line: 529, column: 55, scope: !597, inlinedAt: !1255)
!1307 = !DILocation(line: 529, column: 17, scope: !597, inlinedAt: !1255)
!1308 = !DILocation(line: 529, column: 34, scope: !597, inlinedAt: !1255)
!1309 = !DILocation(line: 530, column: 1, scope: !597, inlinedAt: !1255)
!1310 = !DILocation(line: 601, column: 26, scope: !1205)
!1311 = !DILocalVariable(name: "block", arg: 1, scope: !1312, file: !3, line: 450, type: !6)
!1312 = distinct !DISubprogram(name: "find_prev", scope: !3, file: !3, line: 450, type: !159, isLocal: true, isDefinition: true, scopeLine: 450, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1313)
!1313 = !{!1311, !1314}
!1314 = !DILocalVariable(name: "footerp", scope: !1315, file: !3, line: 460, type: !30)
!1315 = distinct !DILexicalBlock(scope: !1316, file: !3, line: 458, column: 5)
!1316 = distinct !DILexicalBlock(scope: !1312, file: !3, line: 452, column: 9)
!1317 = !DILocation(line: 450, column: 36, scope: !1312, inlinedAt: !1318)
!1318 = distinct !DILocation(line: 603, column: 31, scope: !1204)
!1319 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1320)
!1320 = distinct !DILocation(line: 452, column: 9, scope: !1316, inlinedAt: !1318)
!1321 = !DILocation(line: 268, column: 12, scope: !532, inlinedAt: !1320)
!1322 = !DILocation(line: 452, column: 9, scope: !1312, inlinedAt: !1318)
!1323 = !DILocation(line: 455, column: 42, scope: !1324, inlinedAt: !1318)
!1324 = distinct !DILexicalBlock(scope: !1316, file: !3, line: 453, column: 5)
!1325 = !DILocation(line: 455, column: 16, scope: !1324, inlinedAt: !1318)
!1326 = !DILocation(line: 455, column: 9, scope: !1324, inlinedAt: !1318)
!1327 = !DILocalVariable(name: "block", arg: 1, scope: !1328, file: !3, line: 430, type: !6)
!1328 = distinct !DISubprogram(name: "find_prev_footer", scope: !3, file: !3, line: 430, type: !279, isLocal: true, isDefinition: true, scopeLine: 430, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1329)
!1329 = !{!1327}
!1330 = !DILocation(line: 430, column: 42, scope: !1328, inlinedAt: !1331)
!1331 = distinct !DILocation(line: 460, column: 27, scope: !1315, inlinedAt: !1318)
!1332 = !DILocation(line: 432, column: 29, scope: !1328, inlinedAt: !1331)
!1333 = !DILocation(line: 460, column: 17, scope: !1315, inlinedAt: !1318)
!1334 = !DILocation(line: 461, column: 26, scope: !1335, inlinedAt: !1318)
!1335 = distinct !DILexicalBlock(scope: !1315, file: !3, line: 461, column: 13)
!1336 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1337)
!1337 = distinct !DILocation(line: 461, column: 13, scope: !1335, inlinedAt: !1318)
!1338 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1337)
!1339 = !DILocation(line: 461, column: 36, scope: !1335, inlinedAt: !1318)
!1340 = !DILocation(line: 461, column: 13, scope: !1315, inlinedAt: !1318)
!1341 = !DILocalVariable(name: "footer", arg: 1, scope: !1342, file: !3, line: 323, type: !30)
!1342 = distinct !DISubprogram(name: "footer_to_header", scope: !3, file: !3, line: 323, type: !1343, isLocal: true, isDefinition: true, scopeLine: 323, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1345)
!1343 = !DISubroutineType(types: !1344)
!1344 = !{!6, !30}
!1345 = !{!1341, !1346}
!1346 = !DILocalVariable(name: "size", scope: !1342, file: !3, line: 324, type: !38)
!1347 = !DILocation(line: 323, column: 42, scope: !1342, inlinedAt: !1348)
!1348 = distinct !DILocation(line: 464, column: 16, scope: !1315, inlinedAt: !1318)
!1349 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1350)
!1350 = distinct !DILocation(line: 324, column: 19, scope: !1342, inlinedAt: !1348)
!1351 = !DILocation(line: 324, column: 12, scope: !1342, inlinedAt: !1348)
!1352 = !DILocation(line: 326, column: 47, scope: !1342, inlinedAt: !1348)
!1353 = !DILocation(line: 326, column: 12, scope: !1342, inlinedAt: !1348)
!1354 = !DILocation(line: 464, column: 9, scope: !1315, inlinedAt: !1318)
!1355 = !DILocation(line: 0, scope: !1356, inlinedAt: !1318)
!1356 = distinct !DILexicalBlock(scope: !1335, file: !3, line: 461, column: 42)
!1357 = !DILocation(line: 603, column: 18, scope: !1204)
!1358 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1359)
!1359 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1360)
!1360 = distinct !DILocation(line: 604, column: 23, scope: !1204)
!1361 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1359)
!1362 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1363)
!1363 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1360)
!1364 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1360)
!1365 = !DILocation(line: 604, column: 20, scope: !1204)
!1366 = !DILocation(line: 502, column: 34, scope: !597, inlinedAt: !1367)
!1367 = distinct !DILocation(line: 605, column: 9, scope: !1204)
!1368 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !1369)
!1369 = distinct !DILocation(line: 505, column: 17, scope: !597, inlinedAt: !1367)
!1370 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !1369)
!1371 = !DILocation(line: 0, scope: !460, inlinedAt: !1369)
!1372 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !1369)
!1373 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !1369)
!1374 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !1369)
!1375 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !1369)
!1376 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !1369)
!1377 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !1369)
!1378 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !1369)
!1379 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !1369)
!1380 = !DILocation(line: 0, scope: !448, inlinedAt: !1369)
!1381 = !DILocation(line: 505, column: 9, scope: !597, inlinedAt: !1367)
!1382 = !DILocation(line: 506, column: 9, scope: !626, inlinedAt: !1367)
!1383 = !DILocation(line: 506, column: 26, scope: !626, inlinedAt: !1367)
!1384 = !DILocation(line: 506, column: 9, scope: !597, inlinedAt: !1367)
!1385 = !DILocation(line: 508, column: 32, scope: !630, inlinedAt: !1367)
!1386 = !DILocation(line: 508, column: 37, scope: !630, inlinedAt: !1367)
!1387 = !DILocation(line: 508, column: 13, scope: !631, inlinedAt: !1367)
!1388 = !DILocation(line: 510, column: 30, scope: !635, inlinedAt: !1367)
!1389 = !DILocation(line: 511, column: 13, scope: !635, inlinedAt: !1367)
!1390 = !DILocation(line: 515, column: 30, scope: !638, inlinedAt: !1367)
!1391 = !DILocation(line: 517, column: 5, scope: !631, inlinedAt: !1367)
!1392 = !DILocation(line: 519, column: 9, scope: !597, inlinedAt: !1367)
!1393 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1394)
!1394 = distinct !DILocation(line: 522, column: 35, scope: !643, inlinedAt: !1367)
!1395 = !DILocation(line: 522, column: 85, scope: !643, inlinedAt: !1367)
!1396 = !DILocation(line: 522, column: 22, scope: !643, inlinedAt: !1367)
!1397 = !DILocation(line: 518, column: 14, scope: !597, inlinedAt: !1367)
!1398 = !DILocation(line: 523, column: 5, scope: !643, inlinedAt: !1367)
!1399 = !DILocation(line: 526, column: 41, scope: !650, inlinedAt: !1367)
!1400 = !DILocation(line: 0, scope: !650, inlinedAt: !1367)
!1401 = !DILocation(line: 528, column: 36, scope: !597, inlinedAt: !1367)
!1402 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1403)
!1403 = distinct !DILocation(line: 528, column: 5, scope: !597, inlinedAt: !1367)
!1404 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1403)
!1405 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1406)
!1406 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !1403)
!1407 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1406)
!1408 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1403)
!1409 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1403)
!1410 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1403)
!1411 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1403)
!1412 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1403)
!1413 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1403)
!1414 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1403)
!1415 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1403)
!1416 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1403)
!1417 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1403)
!1418 = !DILocation(line: 529, column: 55, scope: !597, inlinedAt: !1367)
!1419 = !DILocation(line: 529, column: 17, scope: !597, inlinedAt: !1367)
!1420 = !DILocation(line: 529, column: 34, scope: !597, inlinedAt: !1367)
!1421 = !DILocation(line: 530, column: 1, scope: !597, inlinedAt: !1367)
!1422 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1423)
!1423 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1424)
!1424 = distinct !DILocation(line: 610, column: 23, scope: !1209)
!1425 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1423)
!1426 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1427)
!1427 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1424)
!1428 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1424)
!1429 = !DILocation(line: 610, column: 20, scope: !1209)
!1430 = !DILocation(line: 502, column: 34, scope: !597, inlinedAt: !1431)
!1431 = distinct !DILocation(line: 611, column: 9, scope: !1209)
!1432 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !1433)
!1433 = distinct !DILocation(line: 505, column: 17, scope: !597, inlinedAt: !1431)
!1434 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !1433)
!1435 = !DILocation(line: 0, scope: !460, inlinedAt: !1433)
!1436 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !1433)
!1437 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !1433)
!1438 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !1433)
!1439 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !1433)
!1440 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !1433)
!1441 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !1433)
!1442 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !1433)
!1443 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !1433)
!1444 = !DILocation(line: 0, scope: !448, inlinedAt: !1433)
!1445 = !DILocation(line: 505, column: 9, scope: !597, inlinedAt: !1431)
!1446 = !DILocation(line: 506, column: 9, scope: !626, inlinedAt: !1431)
!1447 = !DILocation(line: 506, column: 26, scope: !626, inlinedAt: !1431)
!1448 = !DILocation(line: 506, column: 9, scope: !597, inlinedAt: !1431)
!1449 = !DILocation(line: 508, column: 32, scope: !630, inlinedAt: !1431)
!1450 = !DILocation(line: 508, column: 37, scope: !630, inlinedAt: !1431)
!1451 = !DILocation(line: 508, column: 13, scope: !631, inlinedAt: !1431)
!1452 = !DILocation(line: 510, column: 30, scope: !635, inlinedAt: !1431)
!1453 = !DILocation(line: 511, column: 13, scope: !635, inlinedAt: !1431)
!1454 = !DILocation(line: 515, column: 30, scope: !638, inlinedAt: !1431)
!1455 = !DILocation(line: 517, column: 5, scope: !631, inlinedAt: !1431)
!1456 = !DILocation(line: 519, column: 9, scope: !597, inlinedAt: !1431)
!1457 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1458)
!1458 = distinct !DILocation(line: 522, column: 35, scope: !643, inlinedAt: !1431)
!1459 = !DILocation(line: 522, column: 85, scope: !643, inlinedAt: !1431)
!1460 = !DILocation(line: 522, column: 22, scope: !643, inlinedAt: !1431)
!1461 = !DILocation(line: 518, column: 14, scope: !597, inlinedAt: !1431)
!1462 = !DILocation(line: 523, column: 5, scope: !643, inlinedAt: !1431)
!1463 = !DILocation(line: 526, column: 41, scope: !650, inlinedAt: !1431)
!1464 = !DILocation(line: 0, scope: !650, inlinedAt: !1431)
!1465 = !DILocation(line: 528, column: 36, scope: !597, inlinedAt: !1431)
!1466 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1467)
!1467 = distinct !DILocation(line: 528, column: 5, scope: !597, inlinedAt: !1431)
!1468 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1467)
!1469 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1470)
!1470 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !1467)
!1471 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1470)
!1472 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1467)
!1473 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1467)
!1474 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1467)
!1475 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1467)
!1476 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1467)
!1477 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1467)
!1478 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1467)
!1479 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1467)
!1480 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1467)
!1481 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1467)
!1482 = !DILocation(line: 529, column: 55, scope: !597, inlinedAt: !1431)
!1483 = !DILocation(line: 529, column: 17, scope: !597, inlinedAt: !1431)
!1484 = !DILocation(line: 529, column: 34, scope: !597, inlinedAt: !1431)
!1485 = !DILocation(line: 530, column: 1, scope: !597, inlinedAt: !1431)
!1486 = !DILocation(line: 450, column: 36, scope: !1312, inlinedAt: !1487)
!1487 = distinct !DILocation(line: 612, column: 31, scope: !1209)
!1488 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1489)
!1489 = distinct !DILocation(line: 452, column: 9, scope: !1316, inlinedAt: !1487)
!1490 = !DILocation(line: 268, column: 12, scope: !532, inlinedAt: !1489)
!1491 = !DILocation(line: 452, column: 9, scope: !1312, inlinedAt: !1487)
!1492 = !DILocation(line: 455, column: 42, scope: !1324, inlinedAt: !1487)
!1493 = !DILocation(line: 455, column: 16, scope: !1324, inlinedAt: !1487)
!1494 = !DILocation(line: 455, column: 9, scope: !1324, inlinedAt: !1487)
!1495 = !DILocation(line: 430, column: 42, scope: !1328, inlinedAt: !1496)
!1496 = distinct !DILocation(line: 460, column: 27, scope: !1315, inlinedAt: !1487)
!1497 = !DILocation(line: 432, column: 29, scope: !1328, inlinedAt: !1496)
!1498 = !DILocation(line: 460, column: 17, scope: !1315, inlinedAt: !1487)
!1499 = !DILocation(line: 461, column: 26, scope: !1335, inlinedAt: !1487)
!1500 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1501)
!1501 = distinct !DILocation(line: 461, column: 13, scope: !1335, inlinedAt: !1487)
!1502 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1501)
!1503 = !DILocation(line: 461, column: 36, scope: !1335, inlinedAt: !1487)
!1504 = !DILocation(line: 461, column: 13, scope: !1315, inlinedAt: !1487)
!1505 = !DILocation(line: 323, column: 42, scope: !1342, inlinedAt: !1506)
!1506 = distinct !DILocation(line: 464, column: 16, scope: !1315, inlinedAt: !1487)
!1507 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1508)
!1508 = distinct !DILocation(line: 324, column: 19, scope: !1342, inlinedAt: !1506)
!1509 = !DILocation(line: 324, column: 12, scope: !1342, inlinedAt: !1506)
!1510 = !DILocation(line: 326, column: 47, scope: !1342, inlinedAt: !1506)
!1511 = !DILocation(line: 326, column: 12, scope: !1342, inlinedAt: !1506)
!1512 = !DILocation(line: 464, column: 9, scope: !1315, inlinedAt: !1487)
!1513 = !DILocation(line: 0, scope: !1356, inlinedAt: !1487)
!1514 = !DILocation(line: 612, column: 18, scope: !1209)
!1515 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1516)
!1516 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1517)
!1517 = distinct !DILocation(line: 613, column: 23, scope: !1209)
!1518 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1516)
!1519 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1520)
!1520 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1517)
!1521 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1517)
!1522 = !DILocation(line: 613, column: 20, scope: !1209)
!1523 = !DILocation(line: 502, column: 34, scope: !597, inlinedAt: !1524)
!1524 = distinct !DILocation(line: 614, column: 9, scope: !1209)
!1525 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !1526)
!1526 = distinct !DILocation(line: 505, column: 17, scope: !597, inlinedAt: !1524)
!1527 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !1526)
!1528 = !DILocation(line: 0, scope: !460, inlinedAt: !1526)
!1529 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !1526)
!1530 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !1526)
!1531 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !1526)
!1532 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !1526)
!1533 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !1526)
!1534 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !1526)
!1535 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !1526)
!1536 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !1526)
!1537 = !DILocation(line: 0, scope: !448, inlinedAt: !1526)
!1538 = !DILocation(line: 505, column: 9, scope: !597, inlinedAt: !1524)
!1539 = !DILocation(line: 506, column: 9, scope: !626, inlinedAt: !1524)
!1540 = !DILocation(line: 506, column: 26, scope: !626, inlinedAt: !1524)
!1541 = !DILocation(line: 506, column: 9, scope: !597, inlinedAt: !1524)
!1542 = !DILocation(line: 508, column: 32, scope: !630, inlinedAt: !1524)
!1543 = !DILocation(line: 508, column: 37, scope: !630, inlinedAt: !1524)
!1544 = !DILocation(line: 508, column: 13, scope: !631, inlinedAt: !1524)
!1545 = !DILocation(line: 510, column: 30, scope: !635, inlinedAt: !1524)
!1546 = !DILocation(line: 511, column: 13, scope: !635, inlinedAt: !1524)
!1547 = !DILocation(line: 515, column: 30, scope: !638, inlinedAt: !1524)
!1548 = !DILocation(line: 517, column: 5, scope: !631, inlinedAt: !1524)
!1549 = !DILocation(line: 519, column: 9, scope: !597, inlinedAt: !1524)
!1550 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1551)
!1551 = distinct !DILocation(line: 522, column: 35, scope: !643, inlinedAt: !1524)
!1552 = !DILocation(line: 522, column: 85, scope: !643, inlinedAt: !1524)
!1553 = !DILocation(line: 522, column: 22, scope: !643, inlinedAt: !1524)
!1554 = !DILocation(line: 518, column: 14, scope: !597, inlinedAt: !1524)
!1555 = !DILocation(line: 523, column: 5, scope: !643, inlinedAt: !1524)
!1556 = !DILocation(line: 526, column: 41, scope: !650, inlinedAt: !1524)
!1557 = !DILocation(line: 0, scope: !650, inlinedAt: !1524)
!1558 = !DILocation(line: 528, column: 36, scope: !597, inlinedAt: !1524)
!1559 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1560)
!1560 = distinct !DILocation(line: 528, column: 5, scope: !597, inlinedAt: !1524)
!1561 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1560)
!1562 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1563)
!1563 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !1560)
!1564 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1563)
!1565 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1560)
!1566 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1560)
!1567 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1560)
!1568 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1560)
!1569 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1560)
!1570 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1560)
!1571 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1560)
!1572 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1560)
!1573 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1560)
!1574 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1560)
!1575 = !DILocation(line: 529, column: 55, scope: !597, inlinedAt: !1524)
!1576 = !DILocation(line: 529, column: 17, scope: !597, inlinedAt: !1524)
!1577 = !DILocation(line: 529, column: 34, scope: !597, inlinedAt: !1524)
!1578 = !DILocation(line: 530, column: 1, scope: !597, inlinedAt: !1524)
!1579 = !DILocation(line: 0, scope: !1248)
!1580 = !DILocation(line: 618, column: 29, scope: !1196)
!1581 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1582)
!1582 = distinct !DILocation(line: 619, column: 36, scope: !1196)
!1583 = !DILocation(line: 254, column: 33, scope: !537, inlinedAt: !1584)
!1584 = distinct !DILocation(line: 620, column: 17, scope: !1196)
!1585 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1586)
!1586 = distinct !DILocation(line: 619, column: 5, scope: !1196)
!1587 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1586)
!1588 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1586)
!1589 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1586)
!1590 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1591)
!1591 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1586)
!1592 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1591)
!1593 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1591)
!1594 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1591)
!1595 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !1591)
!1596 = !DILocation(line: 229, column: 14, scope: !1597, inlinedAt: !1591)
!1597 = distinct !DILexicalBlock(scope: !1598, file: !3, line: 228, column: 15)
!1598 = distinct !DILexicalBlock(scope: !199, file: !3, line: 228, column: 9)
!1599 = !DILocation(line: 228, column: 9, scope: !199, inlinedAt: !1591)
!1600 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1591)
!1601 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1586)
!1602 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !1586)
!1603 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1604)
!1604 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1586)
!1605 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !1604)
!1606 = !DILocation(line: 313, column: 23, scope: !278, inlinedAt: !1604)
!1607 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1608)
!1608 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1609)
!1609 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !1604)
!1610 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1608)
!1611 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1612)
!1612 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1609)
!1613 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1609)
!1614 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1604)
!1615 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1604)
!1616 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1604)
!1617 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1586)
!1618 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1619)
!1619 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1586)
!1620 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1619)
!1621 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1619)
!1622 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1619)
!1623 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1586)
!1624 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !1586)
!1625 = !DILocation(line: 535, column: 40, scope: !824, inlinedAt: !1626)
!1626 = distinct !DILocation(line: 621, column: 5, scope: !1196)
!1627 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1628)
!1628 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1629)
!1629 = distinct !DILocation(line: 537, column: 25, scope: !824, inlinedAt: !1626)
!1630 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1628)
!1631 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1632)
!1632 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1629)
!1633 = !DILocation(line: 473, column: 14, scope: !457, inlinedAt: !1634)
!1634 = distinct !DILocation(line: 538, column: 17, scope: !824, inlinedAt: !1626)
!1635 = !DILocation(line: 473, column: 9, scope: !448, inlinedAt: !1634)
!1636 = !DILocation(line: 0, scope: !460, inlinedAt: !1634)
!1637 = !DILocation(line: 478, column: 9, scope: !448, inlinedAt: !1634)
!1638 = !DILocation(line: 477, column: 12, scope: !448, inlinedAt: !1634)
!1639 = !DILocation(line: 479, column: 30, scope: !448, inlinedAt: !1634)
!1640 = !DILocation(line: 479, column: 17, scope: !448, inlinedAt: !1634)
!1641 = !DILocation(line: 479, column: 40, scope: !448, inlinedAt: !1634)
!1642 = !DILocation(line: 479, column: 35, scope: !448, inlinedAt: !1634)
!1643 = !DILocation(line: 481, column: 10, scope: !460, inlinedAt: !1634)
!1644 = !DILocation(line: 479, column: 5, scope: !448, inlinedAt: !1634)
!1645 = !DILocation(line: 0, scope: !448, inlinedAt: !1634)
!1646 = !DILocation(line: 538, column: 9, scope: !824, inlinedAt: !1626)
!1647 = !DILocation(line: 540, column: 9, scope: !830, inlinedAt: !1626)
!1648 = !DILocation(line: 540, column: 26, scope: !830, inlinedAt: !1626)
!1649 = !DILocation(line: 540, column: 9, scope: !824, inlinedAt: !1626)
!1650 = !DILocation(line: 542, column: 26, scope: !857, inlinedAt: !1626)
!1651 = !DILocation(line: 543, column: 39, scope: !857, inlinedAt: !1626)
!1652 = !DILocation(line: 543, column: 44, scope: !857, inlinedAt: !1626)
!1653 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1654)
!1654 = distinct !DILocation(line: 544, column: 9, scope: !857, inlinedAt: !1626)
!1655 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1654)
!1656 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1654)
!1657 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1654)
!1658 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1654)
!1659 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1654)
!1660 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1654)
!1661 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1654)
!1662 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1654)
!1663 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1654)
!1664 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1654)
!1665 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1654)
!1666 = !DILocation(line: 549, column: 13, scope: !829, inlinedAt: !1626)
!1667 = !DILocation(line: 552, column: 70, scope: !875, inlinedAt: !1626)
!1668 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1669)
!1669 = distinct !DILocation(line: 552, column: 39, scope: !875, inlinedAt: !1626)
!1670 = !DILocation(line: 552, column: 100, scope: !875, inlinedAt: !1626)
!1671 = !DILocation(line: 552, column: 26, scope: !875, inlinedAt: !1626)
!1672 = !DILocation(line: 547, column: 18, scope: !829, inlinedAt: !1626)
!1673 = !DILocation(line: 558, column: 16, scope: !829, inlinedAt: !1626)
!1674 = !DILocation(line: 558, column: 33, scope: !829, inlinedAt: !1626)
!1675 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1676)
!1676 = distinct !DILocation(line: 559, column: 9, scope: !829, inlinedAt: !1626)
!1677 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1676)
!1678 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1676)
!1679 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1676)
!1680 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1676)
!1681 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1676)
!1682 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1676)
!1683 = !DILocation(line: 556, column: 58, scope: !893, inlinedAt: !1626)
!1684 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1676)
!1685 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1676)
!1686 = !DILocation(line: 560, column: 33, scope: !829, inlinedAt: !1626)
!1687 = !DILocation(line: 560, column: 38, scope: !829, inlinedAt: !1626)
!1688 = !DILocation(line: 561, column: 21, scope: !829, inlinedAt: !1626)
!1689 = !DILocation(line: 491, column: 34, scope: !654, inlinedAt: !1690)
!1690 = distinct !DILocation(line: 561, column: 9, scope: !829, inlinedAt: !1626)
!1691 = !DILocation(line: 491, column: 50, scope: !654, inlinedAt: !1690)
!1692 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1693)
!1693 = distinct !DILocation(line: 492, column: 9, scope: !664, inlinedAt: !1690)
!1694 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1693)
!1695 = !DILocation(line: 492, column: 9, scope: !654, inlinedAt: !1690)
!1696 = !DILocation(line: 493, column: 27, scope: !668, inlinedAt: !1690)
!1697 = !DILocation(line: 493, column: 46, scope: !668, inlinedAt: !1690)
!1698 = !DILocation(line: 493, column: 52, scope: !668, inlinedAt: !1690)
!1699 = !DILocation(line: 493, column: 82, scope: !668, inlinedAt: !1690)
!1700 = !DILocation(line: 493, column: 65, scope: !668, inlinedAt: !1690)
!1701 = !DILocation(line: 493, column: 23, scope: !668, inlinedAt: !1690)
!1702 = !DILocation(line: 494, column: 5, scope: !668, inlinedAt: !1690)
!1703 = !DILocation(line: 495, column: 28, scope: !676, inlinedAt: !1690)
!1704 = !DILocation(line: 495, column: 33, scope: !676, inlinedAt: !1690)
!1705 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !1706)
!1706 = distinct !DILocation(line: 622, column: 18, scope: !1196)
!1707 = !DILocation(line: 422, column: 24, scope: !158, inlinedAt: !1706)
!1708 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1709)
!1709 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1710)
!1710 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !1706)
!1711 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1709)
!1712 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1713)
!1713 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1710)
!1714 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1710)
!1715 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !1706)
!1716 = !DILocation(line: 624, column: 25, scope: !1717)
!1717 = distinct !DILexicalBlock(scope: !1196, file: !3, line: 624, column: 9)
!1718 = !DILocation(line: 624, column: 9, scope: !1196)
!1719 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1720)
!1720 = distinct !DILocation(line: 625, column: 33, scope: !1721)
!1721 = distinct !DILexicalBlock(scope: !1717, file: !3, line: 624, column: 30)
!1722 = !DILocation(line: 351, column: 34, scope: !1231, inlinedAt: !1723)
!1723 = distinct !DILocation(line: 361, column: 12, scope: !1237, inlinedAt: !1724)
!1724 = distinct !DILocation(line: 626, column: 48, scope: !1721)
!1725 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1726)
!1726 = distinct !DILocation(line: 625, column: 9, scope: !1721)
!1727 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1726)
!1728 = !DILocation(line: 396, column: 59, scope: !253, inlinedAt: !1726)
!1729 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !1726)
!1730 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1731)
!1731 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1726)
!1732 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1731)
!1733 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1731)
!1734 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1731)
!1735 = !DILocation(line: 228, column: 9, scope: !199, inlinedAt: !1731)
!1736 = !DILocation(line: 232, column: 14, scope: !944, inlinedAt: !1731)
!1737 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1731)
!1738 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1726)
!1739 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !1726)
!1740 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1741)
!1741 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1726)
!1742 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !1741)
!1743 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1744)
!1744 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1745)
!1745 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !1741)
!1746 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1744)
!1747 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1748)
!1748 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1745)
!1749 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1745)
!1750 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1741)
!1751 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1741)
!1752 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1741)
!1753 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1726)
!1754 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1755)
!1755 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1726)
!1756 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1755)
!1757 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1755)
!1758 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1755)
!1759 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1726)
!1760 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !1726)
!1761 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !1762)
!1762 = distinct !DILocation(line: 629, column: 9, scope: !1763)
!1763 = distinct !DILexicalBlock(scope: !1717, file: !3, line: 628, column: 10)
!1764 = !DILocation(line: 376, column: 49, scope: !298, inlinedAt: !1762)
!1765 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !1762)
!1766 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1767)
!1767 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !1762)
!1768 = !DILocation(line: 219, column: 38, scope: !199, inlinedAt: !1767)
!1769 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1767)
!1770 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1767)
!1771 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1767)
!1772 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1767)
!1773 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1767)
!1774 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !1762)
!1775 = !DILocation(line: 632, column: 5, scope: !1196)
!1776 = distinct !DISubprogram(name: "mm_realloc", scope: !3, file: !3, line: 987, type: !1777, isLocal: false, isDefinition: true, scopeLine: 987, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1779)
!1777 = !DISubroutineType(types: !1778)
!1778 = !{!31, !31, !38}
!1779 = !{!1780, !1781, !1782, !1783, !1784}
!1780 = !DILocalVariable(name: "ptr", arg: 1, scope: !1776, file: !3, line: 987, type: !31)
!1781 = !DILocalVariable(name: "size", arg: 2, scope: !1776, file: !3, line: 987, type: !38)
!1782 = !DILocalVariable(name: "block", scope: !1776, file: !3, line: 988, type: !6)
!1783 = !DILocalVariable(name: "copysize", scope: !1776, file: !3, line: 989, type: !38)
!1784 = !DILocalVariable(name: "newptr", scope: !1776, file: !3, line: 990, type: !31)
!1785 = !DILocation(line: 987, column: 21, scope: !1776)
!1786 = !DILocation(line: 987, column: 33, scope: !1776)
!1787 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !1788)
!1788 = distinct !DILocation(line: 988, column: 22, scope: !1776)
!1789 = !DILocation(line: 287, column: 35, scope: !243, inlinedAt: !1788)
!1790 = !DILocation(line: 287, column: 12, scope: !243, inlinedAt: !1788)
!1791 = !DILocation(line: 988, column: 14, scope: !1776)
!1792 = !DILocation(line: 993, column: 14, scope: !1793)
!1793 = distinct !DILexicalBlock(scope: !1776, file: !3, line: 993, column: 9)
!1794 = !DILocation(line: 0, scope: !1795)
!1795 = distinct !DILexicalBlock(scope: !1776, file: !3, line: 999, column: 9)
!1796 = !DILocation(line: 993, column: 9, scope: !1776)
!1797 = !DILocation(line: 942, column: 17, scope: !1061, inlinedAt: !1798)
!1798 = distinct !DILocation(line: 994, column: 9, scope: !1799)
!1799 = distinct !DILexicalBlock(scope: !1793, file: !3, line: 993, column: 20)
!1800 = !DILocation(line: 945, column: 9, scope: !1061, inlinedAt: !1798)
!1801 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !1802)
!1802 = distinct !DILocation(line: 949, column: 22, scope: !1061, inlinedAt: !1798)
!1803 = !DILocation(line: 949, column: 14, scope: !1061, inlinedAt: !1798)
!1804 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1805)
!1805 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1806)
!1806 = distinct !DILocation(line: 950, column: 19, scope: !1061, inlinedAt: !1798)
!1807 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1805)
!1808 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1809)
!1809 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1806)
!1810 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1806)
!1811 = !DILocation(line: 950, column: 12, scope: !1061, inlinedAt: !1798)
!1812 = !DILocation(line: 956, column: 13, scope: !1087, inlinedAt: !1798)
!1813 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1814)
!1814 = distinct !DILocation(line: 958, column: 9, scope: !1095, inlinedAt: !1798)
!1815 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1816)
!1816 = distinct !DILocation(line: 962, column: 9, scope: !1090, inlinedAt: !1798)
!1817 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1814)
!1818 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1816)
!1819 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1820)
!1820 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1814)
!1821 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1822)
!1822 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1816)
!1823 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !1820)
!1824 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1820)
!1825 = !DILocation(line: 956, column: 8, scope: !1061, inlinedAt: !1798)
!1826 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1814)
!1827 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1814)
!1828 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1820)
!1829 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1820)
!1830 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1820)
!1831 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1814)
!1832 = !DILocation(line: 959, column: 5, scope: !1095, inlinedAt: !1798)
!1833 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1816)
!1834 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1816)
!1835 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1822)
!1836 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1822)
!1837 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1822)
!1838 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1816)
!1839 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1840)
!1840 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1816)
!1841 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1840)
!1842 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1840)
!1843 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1840)
!1844 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1816)
!1845 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1846)
!1846 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1816)
!1847 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1846)
!1848 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1846)
!1849 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1846)
!1850 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1816)
!1851 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !1852)
!1852 = distinct !DILocation(line: 965, column: 27, scope: !1061, inlinedAt: !1798)
!1853 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1854)
!1854 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1855)
!1855 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !1852)
!1856 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1854)
!1857 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1858)
!1858 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1855)
!1859 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1855)
!1860 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !1852)
!1861 = !DILocation(line: 965, column: 14, scope: !1061, inlinedAt: !1798)
!1862 = !DILocation(line: 966, column: 30, scope: !1144, inlinedAt: !1798)
!1863 = !DILocation(line: 966, column: 9, scope: !1061, inlinedAt: !1798)
!1864 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !1865)
!1865 = distinct !DILocation(line: 968, column: 33, scope: !1148, inlinedAt: !1798)
!1866 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1867)
!1867 = distinct !DILocation(line: 968, column: 9, scope: !1148, inlinedAt: !1798)
!1868 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1867)
!1869 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !1867)
!1870 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1871)
!1871 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1867)
!1872 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1871)
!1873 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1871)
!1874 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1871)
!1875 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1867)
!1876 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !1867)
!1877 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1878)
!1878 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1867)
!1879 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !1878)
!1880 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1881)
!1881 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1882)
!1882 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !1878)
!1883 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1881)
!1884 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1885)
!1885 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1882)
!1886 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1882)
!1887 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1878)
!1888 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1878)
!1889 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1878)
!1890 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1867)
!1891 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1892)
!1892 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1867)
!1893 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1892)
!1894 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1892)
!1895 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1867)
!1896 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !1867)
!1897 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !1898)
!1898 = distinct !DILocation(line: 972, column: 36, scope: !1182, inlinedAt: !1798)
!1899 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !1900)
!1900 = distinct !DILocation(line: 972, column: 9, scope: !1182, inlinedAt: !1798)
!1901 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !1900)
!1902 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1903)
!1903 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !1900)
!1904 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1903)
!1905 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !1903)
!1906 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1903)
!1907 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1903)
!1908 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1903)
!1909 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !1900)
!1910 = !DILocation(line: 976, column: 13, scope: !1061, inlinedAt: !1798)
!1911 = !DILocation(line: 979, column: 1, scope: !1061, inlinedAt: !1798)
!1912 = !DILocation(line: 0, scope: !1776)
!1913 = !DILocation(line: 999, column: 9, scope: !1776)
!1914 = !DILocation(line: 990, column: 11, scope: !1776)
!1915 = !DILocation(line: 1007, column: 16, scope: !1916)
!1916 = distinct !DILexicalBlock(scope: !1776, file: !3, line: 1007, column: 9)
!1917 = !DILocation(line: 1007, column: 9, scope: !1776)
!1918 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1919)
!1919 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1920)
!1920 = distinct !DILocation(line: 339, column: 20, scope: !1921, inlinedAt: !1925)
!1921 = distinct !DISubprogram(name: "get_payload_size", scope: !3, file: !3, line: 338, type: !124, isLocal: true, isDefinition: true, scopeLine: 338, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1922)
!1922 = !{!1923, !1924}
!1923 = !DILocalVariable(name: "block", arg: 1, scope: !1921, file: !3, line: 338, type: !6)
!1924 = !DILocalVariable(name: "asize", scope: !1921, file: !3, line: 339, type: !38)
!1925 = distinct !DILocation(line: 1012, column: 16, scope: !1776)
!1926 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1919)
!1927 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1928)
!1928 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1920)
!1929 = !DILocation(line: 340, column: 18, scope: !1921, inlinedAt: !1925)
!1930 = !DILocation(line: 989, column: 12, scope: !1776)
!1931 = !DILocation(line: 1013, column: 14, scope: !1932)
!1932 = distinct !DILexicalBlock(scope: !1776, file: !3, line: 1013, column: 9)
!1933 = !DILocation(line: 1013, column: 9, scope: !1776)
!1934 = !DILocation(line: 1016, column: 5, scope: !1776)
!1935 = !DILocation(line: 942, column: 17, scope: !1061, inlinedAt: !1936)
!1936 = distinct !DILocation(line: 1019, column: 5, scope: !1776)
!1937 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !1938)
!1938 = distinct !DILocation(line: 949, column: 22, scope: !1061, inlinedAt: !1936)
!1939 = !DILocation(line: 949, column: 14, scope: !1061, inlinedAt: !1936)
!1940 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1941)
!1941 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1942)
!1942 = distinct !DILocation(line: 950, column: 19, scope: !1061, inlinedAt: !1936)
!1943 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1941)
!1944 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1945)
!1945 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1942)
!1946 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1942)
!1947 = !DILocation(line: 950, column: 12, scope: !1061, inlinedAt: !1936)
!1948 = !DILocation(line: 956, column: 13, scope: !1087, inlinedAt: !1936)
!1949 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1950)
!1950 = distinct !DILocation(line: 958, column: 9, scope: !1095, inlinedAt: !1936)
!1951 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !1952)
!1952 = distinct !DILocation(line: 962, column: 9, scope: !1090, inlinedAt: !1936)
!1953 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1950)
!1954 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !1952)
!1955 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1956)
!1956 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1950)
!1957 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1958)
!1958 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !1952)
!1959 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !1956)
!1960 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !1956)
!1961 = !DILocation(line: 956, column: 8, scope: !1061, inlinedAt: !1936)
!1962 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1950)
!1963 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1950)
!1964 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1956)
!1965 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1956)
!1966 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1956)
!1967 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1950)
!1968 = !DILocation(line: 959, column: 5, scope: !1095, inlinedAt: !1936)
!1969 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !1952)
!1970 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !1952)
!1971 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1958)
!1972 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1958)
!1973 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1958)
!1974 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !1952)
!1975 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !1976)
!1976 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !1952)
!1977 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !1976)
!1978 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !1976)
!1979 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !1976)
!1980 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !1952)
!1981 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !1982)
!1982 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !1952)
!1983 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !1982)
!1984 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !1982)
!1985 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !1982)
!1986 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !1952)
!1987 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !1988)
!1988 = distinct !DILocation(line: 965, column: 27, scope: !1061, inlinedAt: !1936)
!1989 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !1990)
!1990 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1991)
!1991 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !1988)
!1992 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !1990)
!1993 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !1994)
!1994 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !1991)
!1995 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !1991)
!1996 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !1988)
!1997 = !DILocation(line: 965, column: 14, scope: !1061, inlinedAt: !1936)
!1998 = !DILocation(line: 966, column: 30, scope: !1144, inlinedAt: !1936)
!1999 = !DILocation(line: 966, column: 9, scope: !1061, inlinedAt: !1936)
!2000 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !2001)
!2001 = distinct !DILocation(line: 968, column: 33, scope: !1148, inlinedAt: !1936)
!2002 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !2003)
!2003 = distinct !DILocation(line: 968, column: 9, scope: !1148, inlinedAt: !1936)
!2004 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !2003)
!2005 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !2003)
!2006 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2007)
!2007 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !2003)
!2008 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2007)
!2009 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2007)
!2010 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !2007)
!2011 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !2003)
!2012 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !2003)
!2013 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !2014)
!2014 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !2003)
!2015 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !2014)
!2016 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !2017)
!2017 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2018)
!2018 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !2014)
!2019 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !2017)
!2020 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !2021)
!2021 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !2018)
!2022 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2018)
!2023 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !2014)
!2024 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !2014)
!2025 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !2014)
!2026 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !2003)
!2027 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2028)
!2028 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !2003)
!2029 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2028)
!2030 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2028)
!2031 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !2003)
!2032 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !2003)
!2033 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !2034)
!2034 = distinct !DILocation(line: 972, column: 36, scope: !1182, inlinedAt: !1936)
!2035 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !2036)
!2036 = distinct !DILocation(line: 972, column: 9, scope: !1182, inlinedAt: !1936)
!2037 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !2036)
!2038 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2039)
!2039 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !2036)
!2040 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !2039)
!2041 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2039)
!2042 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !2039)
!2043 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2039)
!2044 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !2039)
!2045 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !2036)
!2046 = !DILocation(line: 976, column: 13, scope: !1061, inlinedAt: !1936)
!2047 = !DILocation(line: 942, column: 17, scope: !1061, inlinedAt: !2048)
!2048 = distinct !DILocation(line: 1019, column: 5, scope: !1776)
!2049 = !DILocation(line: 286, column: 41, scope: !243, inlinedAt: !2050)
!2050 = distinct !DILocation(line: 949, column: 22, scope: !1061, inlinedAt: !2048)
!2051 = !DILocation(line: 949, column: 14, scope: !1061, inlinedAt: !2048)
!2052 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !2053)
!2053 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2054)
!2054 = distinct !DILocation(line: 950, column: 19, scope: !1061, inlinedAt: !2048)
!2055 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !2053)
!2056 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !2057)
!2057 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !2054)
!2058 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2054)
!2059 = !DILocation(line: 950, column: 12, scope: !1061, inlinedAt: !2048)
!2060 = !DILocation(line: 956, column: 13, scope: !1087, inlinedAt: !2048)
!2061 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !2062)
!2062 = distinct !DILocation(line: 958, column: 9, scope: !1095, inlinedAt: !2048)
!2063 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !2064)
!2064 = distinct !DILocation(line: 962, column: 9, scope: !1090, inlinedAt: !2048)
!2065 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !2062)
!2066 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !2064)
!2067 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2068)
!2068 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !2062)
!2069 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2070)
!2070 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !2064)
!2071 = !DILocation(line: 225, column: 9, scope: !199, inlinedAt: !2068)
!2072 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !2068)
!2073 = !DILocation(line: 956, column: 8, scope: !1061, inlinedAt: !2048)
!2074 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !2062)
!2075 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !2062)
!2076 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2068)
!2077 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !2068)
!2078 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !2068)
!2079 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !2062)
!2080 = !DILocation(line: 959, column: 5, scope: !1095, inlinedAt: !2048)
!2081 = !DILocation(line: 396, column: 75, scope: !253, inlinedAt: !2064)
!2082 = !DILocation(line: 397, column: 47, scope: !253, inlinedAt: !2064)
!2083 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2070)
!2084 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !2070)
!2085 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !2070)
!2086 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !2064)
!2087 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !2088)
!2088 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !2064)
!2089 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !2088)
!2090 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !2088)
!2091 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !2088)
!2092 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !2064)
!2093 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2094)
!2094 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !2064)
!2095 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !2094)
!2096 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !2094)
!2097 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2094)
!2098 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !2064)
!2099 = !DILocation(line: 418, column: 36, scope: !158, inlinedAt: !2100)
!2100 = distinct !DILocation(line: 965, column: 27, scope: !1061, inlinedAt: !2048)
!2101 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !2102)
!2102 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2103)
!2103 = distinct !DILocation(line: 422, column: 40, scope: !158, inlinedAt: !2100)
!2104 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !2102)
!2105 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !2106)
!2106 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !2103)
!2107 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2103)
!2108 = !DILocation(line: 422, column: 38, scope: !158, inlinedAt: !2100)
!2109 = !DILocation(line: 965, column: 14, scope: !1061, inlinedAt: !2048)
!2110 = !DILocation(line: 966, column: 30, scope: !1144, inlinedAt: !2048)
!2111 = !DILocation(line: 966, column: 9, scope: !1061, inlinedAt: !2048)
!2112 = !DILocation(line: 246, column: 35, scope: !132, inlinedAt: !2113)
!2113 = distinct !DILocation(line: 968, column: 33, scope: !1148, inlinedAt: !2048)
!2114 = !DILocation(line: 396, column: 34, scope: !253, inlinedAt: !2115)
!2115 = distinct !DILocation(line: 968, column: 9, scope: !1148, inlinedAt: !2048)
!2116 = !DILocation(line: 396, column: 48, scope: !253, inlinedAt: !2115)
!2117 = !DILocation(line: 397, column: 30, scope: !253, inlinedAt: !2115)
!2118 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2119)
!2119 = distinct !DILocation(line: 400, column: 21, scope: !253, inlinedAt: !2115)
!2120 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2119)
!2121 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2119)
!2122 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !2119)
!2123 = !DILocation(line: 400, column: 19, scope: !253, inlinedAt: !2115)
!2124 = !DILocation(line: 402, column: 16, scope: !264, inlinedAt: !2115)
!2125 = !DILocation(line: 310, column: 42, scope: !278, inlinedAt: !2126)
!2126 = distinct !DILocation(line: 403, column: 27, scope: !263, inlinedAt: !2115)
!2127 = !DILocation(line: 313, column: 30, scope: !278, inlinedAt: !2126)
!2128 = !DILocation(line: 261, column: 33, scope: !117, inlinedAt: !2129)
!2129 = distinct !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2130)
!2130 = distinct !DILocation(line: 313, column: 47, scope: !278, inlinedAt: !2126)
!2131 = !DILocation(line: 261, column: 12, scope: !117, inlinedAt: !2129)
!2132 = !DILocation(line: 247, column: 18, scope: !132, inlinedAt: !2133)
!2133 = distinct !DILocation(line: 277, column: 46, scope: !123, inlinedAt: !2130)
!2134 = !DILocation(line: 277, column: 12, scope: !123, inlinedAt: !2130)
!2135 = !DILocation(line: 313, column: 45, scope: !278, inlinedAt: !2126)
!2136 = !DILocation(line: 313, column: 63, scope: !278, inlinedAt: !2126)
!2137 = !DILocation(line: 313, column: 12, scope: !278, inlinedAt: !2126)
!2138 = !DILocation(line: 403, column: 17, scope: !263, inlinedAt: !2115)
!2139 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2140)
!2140 = distinct !DILocation(line: 404, column: 20, scope: !263, inlinedAt: !2115)
!2141 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2140)
!2142 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2140)
!2143 = !DILocation(line: 404, column: 18, scope: !263, inlinedAt: !2115)
!2144 = !DILocation(line: 405, column: 5, scope: !263, inlinedAt: !2115)
!2145 = !DILocation(line: 268, column: 33, scope: !532, inlinedAt: !2146)
!2146 = distinct !DILocation(line: 972, column: 36, scope: !1182, inlinedAt: !2048)
!2147 = !DILocation(line: 376, column: 37, scope: !298, inlinedAt: !2148)
!2148 = distinct !DILocation(line: 972, column: 9, scope: !1182, inlinedAt: !2048)
!2149 = !DILocation(line: 376, column: 65, scope: !298, inlinedAt: !2148)
!2150 = !DILocation(line: 219, column: 27, scope: !199, inlinedAt: !2151)
!2151 = distinct !DILocation(line: 379, column: 21, scope: !298, inlinedAt: !2148)
!2152 = !DILocation(line: 219, column: 54, scope: !199, inlinedAt: !2151)
!2153 = !DILocation(line: 219, column: 65, scope: !199, inlinedAt: !2151)
!2154 = !DILocation(line: 219, column: 82, scope: !199, inlinedAt: !2151)
!2155 = !DILocation(line: 221, column: 12, scope: !199, inlinedAt: !2151)
!2156 = !DILocation(line: 231, column: 9, scope: !199, inlinedAt: !2151)
!2157 = !DILocation(line: 379, column: 19, scope: !298, inlinedAt: !2148)
!2158 = !DILocation(line: 976, column: 13, scope: !1061, inlinedAt: !2048)
!2159 = !DILocation(line: 1015, column: 5, scope: !2160)
!2160 = distinct !DILexicalBlock(scope: !1932, file: !3, line: 1013, column: 26)
!2161 = !DILocation(line: 1022, column: 1, scope: !1776)
!2162 = distinct !DISubprogram(name: "mm_calloc", scope: !3, file: !3, line: 1030, type: !2163, isLocal: false, isDefinition: true, scopeLine: 1030, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !2165)
!2163 = !DISubroutineType(types: !2164)
!2164 = !{!31, !38, !38}
!2165 = !{!2166, !2167, !2168, !2169}
!2166 = !DILocalVariable(name: "elements", arg: 1, scope: !2162, file: !3, line: 1030, type: !38)
!2167 = !DILocalVariable(name: "size", arg: 2, scope: !2162, file: !3, line: 1030, type: !38)
!2168 = !DILocalVariable(name: "bp", scope: !2162, file: !3, line: 1031, type: !31)
!2169 = !DILocalVariable(name: "asize", scope: !2162, file: !3, line: 1032, type: !38)
!2170 = !DILocation(line: 1030, column: 21, scope: !2162)
!2171 = !DILocation(line: 1030, column: 38, scope: !2162)
!2172 = !DILocation(line: 1032, column: 29, scope: !2162)
!2173 = !DILocation(line: 1032, column: 12, scope: !2162)
!2174 = !DILocation(line: 1034, column: 18, scope: !2175)
!2175 = distinct !DILexicalBlock(scope: !2162, file: !3, line: 1034, column: 9)
!2176 = !DILocation(line: 1034, column: 9, scope: !2162)
!2177 = !DILocation(line: 1037, column: 15, scope: !2178)
!2178 = distinct !DILexicalBlock(scope: !2162, file: !3, line: 1037, column: 9)
!2179 = !DILocation(line: 1037, column: 26, scope: !2178)
!2180 = !DILocation(line: 1037, column: 9, scope: !2162)
!2181 = !DILocation(line: 1042, column: 10, scope: !2162)
!2182 = !DILocation(line: 1031, column: 11, scope: !2162)
!2183 = !DILocation(line: 1043, column: 12, scope: !2184)
!2184 = distinct !DILexicalBlock(scope: !2162, file: !3, line: 1043, column: 9)
!2185 = !DILocation(line: 1043, column: 9, scope: !2162)
!2186 = !DILocation(line: 1048, column: 5, scope: !2162)
!2187 = !DILocation(line: 1050, column: 5, scope: !2162)
!2188 = !DILocation(line: 0, scope: !2162)
!2189 = !DILocation(line: 1051, column: 1, scope: !2162)
