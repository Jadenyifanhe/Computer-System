; ModuleID = 'trans.c'
source_filename = "trans.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"Transpose submission\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Basic transpose\00", align 1
@.str.2 = private unnamed_addr constant [36 x i8] c"Transpose using the temporary array\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @registerFunctions() local_unnamed_addr #0 !dbg !7 {
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @transpose_submit, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #3, !dbg !10
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_basic, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0)) #3, !dbg !11
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_tmp, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.2, i64 0, i64 0)) #3, !dbg !12
  ret void, !dbg !13
}

declare dso_local void @registerTransFunction(void (i64, i64, double*, double*, double*)*, i8*) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define internal void @transpose_submit(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !27, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.value(metadata i64 %1, metadata !28, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.value(metadata double* %2, metadata !29, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.value(metadata double* %3, metadata !30, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.value(metadata double* %4, metadata !31, metadata !DIExpression()), !dbg !36
  %6 = icmp eq i64 %0, 32, !dbg !37
  %7 = icmp eq i64 %1, 32, !dbg !39
  %8 = and i1 %6, %7, !dbg !40
  br i1 %8, label %9, label %52, !dbg !40

; <label>:9:                                      ; preds = %5, %49
  %10 = phi i64 [ %50, %49 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !41, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata i32 0, metadata !56, metadata !DIExpression()), !dbg !59
  br label %11, !dbg !60

; <label>:11:                                     ; preds = %46, %9
  %12 = phi i64 [ 0, %9 ], [ %47, %46 ]
  call void @llvm.dbg.value(metadata i64 %12, metadata !56, metadata !DIExpression()), !dbg !59
  call void @llvm.dbg.value(metadata i32 0, metadata !53, metadata !DIExpression()), !dbg !65
  br label %13, !dbg !66

; <label>:13:                                     ; preds = %43, %11
  %14 = phi i64 [ 0, %11 ], [ %44, %43 ]
  call void @llvm.dbg.value(metadata i64 %14, metadata !53, metadata !DIExpression()), !dbg !65
  call void @llvm.dbg.value(metadata i64 %14, metadata !55, metadata !DIExpression()), !dbg !70
  %15 = add nuw nsw i64 %14, %12
  %16 = shl nsw i64 %15, 5
  %17 = getelementptr inbounds double, double* %3, i64 %16
  %18 = getelementptr inbounds double, double* %2, i64 %15
  br label %21, !dbg !71

; <label>:19:                                     ; preds = %21
  %20 = icmp eq i64 %14, 0, !dbg !75
  br i1 %20, label %43, label %32, !dbg !78

; <label>:21:                                     ; preds = %21, %13
  %22 = phi i64 [ %14, %13 ], [ %30, %21 ]
  call void @llvm.dbg.value(metadata i64 %22, metadata !55, metadata !DIExpression()), !dbg !70
  %23 = add nuw nsw i64 %22, %10, !dbg !79
  %24 = shl nsw i64 %23, 5, !dbg !81
  %25 = getelementptr inbounds double, double* %18, i64 %24, !dbg !81
  %26 = bitcast double* %25 to i64*, !dbg !81
  %27 = load i64, i64* %26, align 8, !dbg !81, !tbaa !82
  %28 = getelementptr inbounds double, double* %17, i64 %23, !dbg !86
  %29 = bitcast double* %28 to i64*, !dbg !87
  store i64 %27, i64* %29, align 8, !dbg !87, !tbaa !82
  %30 = add nuw nsw i64 %22, 1, !dbg !88
  call void @llvm.dbg.value(metadata i32 undef, metadata !55, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !70
  %31 = icmp eq i64 %30, 8, !dbg !89
  br i1 %31, label %19, label %21, !dbg !71, !llvm.loop !90

; <label>:32:                                     ; preds = %19, %32
  %33 = phi i64 [ %34, %32 ], [ %14, %19 ]
  %34 = add nsw i64 %33, -1, !dbg !93
  %35 = add nsw i64 %34, %10, !dbg !94
  %36 = shl nsw i64 %35, 5, !dbg !95
  %37 = getelementptr inbounds double, double* %18, i64 %36, !dbg !95
  %38 = bitcast double* %37 to i64*, !dbg !95
  %39 = load i64, i64* %38, align 8, !dbg !95, !tbaa !82
  %40 = getelementptr inbounds double, double* %17, i64 %35, !dbg !96
  %41 = bitcast double* %40 to i64*, !dbg !97
  store i64 %39, i64* %41, align 8, !dbg !97, !tbaa !82
  call void @llvm.dbg.value(metadata i32 undef, metadata !55, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !70
  call void @llvm.dbg.value(metadata i32 undef, metadata !55, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !70
  %42 = icmp sgt i64 %33, 1, !dbg !75
  br i1 %42, label %32, label %43, !dbg !78, !llvm.loop !98

; <label>:43:                                     ; preds = %32, %19
  %44 = add nuw nsw i64 %14, 1, !dbg !101
  call void @llvm.dbg.value(metadata i32 undef, metadata !53, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !65
  %45 = icmp eq i64 %44, 8, !dbg !102
  br i1 %45, label %46, label %13, !dbg !66, !llvm.loop !103

; <label>:46:                                     ; preds = %43
  %47 = add nuw nsw i64 %12, 8, !dbg !106
  call void @llvm.dbg.value(metadata i32 undef, metadata !56, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !59
  %48 = icmp ult i64 %47, 32, !dbg !107
  br i1 %48, label %11, label %49, !dbg !60, !llvm.loop !108

; <label>:49:                                     ; preds = %46
  %50 = add nuw nsw i64 %10, 8, !dbg !111
  call void @llvm.dbg.value(metadata i32 undef, metadata !41, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !57
  %51 = icmp ult i64 %50, 32, !dbg !112
  br i1 %51, label %9, label %148, !dbg !113, !llvm.loop !114

; <label>:52:                                     ; preds = %5
  %53 = icmp eq i64 %0, 1024, !dbg !117
  %54 = icmp eq i64 %1, 1024, !dbg !119
  %55 = and i1 %53, %54, !dbg !120
  br i1 %55, label %56, label %99, !dbg !120

; <label>:56:                                     ; preds = %52, %96
  %57 = phi i64 [ %97, %96 ], [ 0, %52 ]
  call void @llvm.dbg.value(metadata i64 %57, metadata !121, metadata !DIExpression()), !dbg !131
  call void @llvm.dbg.value(metadata i32 0, metadata !130, metadata !DIExpression()), !dbg !133
  br label %58, !dbg !134

; <label>:58:                                     ; preds = %93, %56
  %59 = phi i64 [ 0, %56 ], [ %94, %93 ]
  call void @llvm.dbg.value(metadata i64 %59, metadata !130, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 0, metadata !128, metadata !DIExpression()), !dbg !139
  br label %60, !dbg !140

; <label>:60:                                     ; preds = %90, %58
  %61 = phi i64 [ 0, %58 ], [ %91, %90 ]
  call void @llvm.dbg.value(metadata i64 %61, metadata !128, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata i64 %61, metadata !129, metadata !DIExpression()), !dbg !144
  %62 = add nuw nsw i64 %61, %59
  %63 = shl nsw i64 %62, 10
  %64 = getelementptr inbounds double, double* %3, i64 %63
  %65 = getelementptr inbounds double, double* %2, i64 %62
  br label %68, !dbg !145

; <label>:66:                                     ; preds = %68
  %67 = icmp eq i64 %61, 0, !dbg !149
  br i1 %67, label %90, label %79, !dbg !152

; <label>:68:                                     ; preds = %68, %60
  %69 = phi i64 [ %61, %60 ], [ %77, %68 ]
  call void @llvm.dbg.value(metadata i64 %69, metadata !129, metadata !DIExpression()), !dbg !144
  %70 = add nuw nsw i64 %69, %57, !dbg !153
  %71 = shl nsw i64 %70, 10, !dbg !155
  %72 = getelementptr inbounds double, double* %65, i64 %71, !dbg !155
  %73 = bitcast double* %72 to i64*, !dbg !155
  %74 = load i64, i64* %73, align 8, !dbg !155, !tbaa !82
  %75 = getelementptr inbounds double, double* %64, i64 %70, !dbg !156
  %76 = bitcast double* %75 to i64*, !dbg !157
  store i64 %74, i64* %76, align 8, !dbg !157, !tbaa !82
  %77 = add nuw nsw i64 %69, 1, !dbg !158
  call void @llvm.dbg.value(metadata i32 undef, metadata !129, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !144
  %78 = icmp eq i64 %77, 8, !dbg !159
  br i1 %78, label %66, label %68, !dbg !145, !llvm.loop !160

; <label>:79:                                     ; preds = %66, %79
  %80 = phi i64 [ %81, %79 ], [ %61, %66 ]
  %81 = add nsw i64 %80, -1, !dbg !163
  %82 = add nsw i64 %81, %57, !dbg !164
  %83 = shl nsw i64 %82, 10, !dbg !165
  %84 = getelementptr inbounds double, double* %65, i64 %83, !dbg !165
  %85 = bitcast double* %84 to i64*, !dbg !165
  %86 = load i64, i64* %85, align 8, !dbg !165, !tbaa !82
  %87 = getelementptr inbounds double, double* %64, i64 %82, !dbg !166
  %88 = bitcast double* %87 to i64*, !dbg !167
  store i64 %86, i64* %88, align 8, !dbg !167, !tbaa !82
  call void @llvm.dbg.value(metadata i32 undef, metadata !129, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !144
  call void @llvm.dbg.value(metadata i32 undef, metadata !129, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !144
  %89 = icmp sgt i64 %80, 1, !dbg !149
  br i1 %89, label %79, label %90, !dbg !152, !llvm.loop !168

; <label>:90:                                     ; preds = %79, %66
  %91 = add nuw nsw i64 %61, 1, !dbg !171
  call void @llvm.dbg.value(metadata i32 undef, metadata !128, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !139
  %92 = icmp eq i64 %91, 8, !dbg !172
  br i1 %92, label %93, label %60, !dbg !140, !llvm.loop !173

; <label>:93:                                     ; preds = %90
  %94 = add nuw nsw i64 %59, 8, !dbg !176
  call void @llvm.dbg.value(metadata i32 undef, metadata !130, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !133
  %95 = icmp ult i64 %94, 1024, !dbg !177
  br i1 %95, label %58, label %96, !dbg !134, !llvm.loop !178

; <label>:96:                                     ; preds = %93
  %97 = add nuw nsw i64 %57, 8, !dbg !181
  call void @llvm.dbg.value(metadata i32 undef, metadata !121, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !131
  %98 = icmp ult i64 %97, 1024, !dbg !182
  br i1 %98, label %56, label %148, !dbg !183, !llvm.loop !184

; <label>:99:                                     ; preds = %52
  %100 = icmp eq i64 %0, %1, !dbg !187
  %101 = icmp eq i64 %1, 0, !dbg !189
  %102 = icmp eq i64 %0, 0
  %103 = or i1 %102, %101, !dbg !189
  br i1 %100, label %104, label %123, !dbg !190

; <label>:104:                                    ; preds = %99
  call void @llvm.dbg.value(metadata i64 %0, metadata !191, metadata !DIExpression()), !dbg !204
  call void @llvm.dbg.value(metadata i64 %1, metadata !194, metadata !DIExpression()), !dbg !206
  call void @llvm.dbg.value(metadata double* %2, metadata !195, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata double* %3, metadata !196, metadata !DIExpression()), !dbg !208
  call void @llvm.dbg.value(metadata double* %4, metadata !197, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !210
  br i1 %103, label %148, label %105, !dbg !211

; <label>:105:                                    ; preds = %104, %120
  %106 = phi i64 [ %121, %120 ], [ 0, %104 ]
  call void @llvm.dbg.value(metadata i64 %106, metadata !198, metadata !DIExpression()), !dbg !210
  call void @llvm.dbg.value(metadata i64 0, metadata !200, metadata !DIExpression()), !dbg !212
  %107 = mul nsw i64 %106, %0
  %108 = getelementptr inbounds double, double* %2, i64 %107
  %109 = getelementptr inbounds double, double* %3, i64 %106
  br label %110, !dbg !213

; <label>:110:                                    ; preds = %110, %105
  %111 = phi i64 [ 0, %105 ], [ %118, %110 ]
  call void @llvm.dbg.value(metadata i64 %111, metadata !200, metadata !DIExpression()), !dbg !212
  %112 = getelementptr inbounds double, double* %108, i64 %111, !dbg !214
  %113 = bitcast double* %112 to i64*, !dbg !214
  %114 = load i64, i64* %113, align 8, !dbg !214, !tbaa !82
  %115 = mul nsw i64 %111, %0, !dbg !217
  %116 = getelementptr inbounds double, double* %109, i64 %115, !dbg !217
  %117 = bitcast double* %116 to i64*, !dbg !218
  store i64 %114, i64* %117, align 8, !dbg !218, !tbaa !82
  %118 = add nuw i64 %111, 1, !dbg !219
  call void @llvm.dbg.value(metadata i64 %118, metadata !200, metadata !DIExpression()), !dbg !212
  %119 = icmp eq i64 %118, %0, !dbg !220
  br i1 %119, label %120, label %110, !dbg !213, !llvm.loop !221

; <label>:120:                                    ; preds = %110
  %121 = add nuw i64 %106, 1, !dbg !224
  call void @llvm.dbg.value(metadata i64 %121, metadata !198, metadata !DIExpression()), !dbg !210
  %122 = icmp eq i64 %121, %0, !dbg !225
  br i1 %122, label %148, label %105, !dbg !211, !llvm.loop !226

; <label>:123:                                    ; preds = %99
  call void @llvm.dbg.value(metadata i64 %0, metadata !229, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i64 %1, metadata !232, metadata !DIExpression()), !dbg !248
  call void @llvm.dbg.value(metadata double* %2, metadata !233, metadata !DIExpression()), !dbg !249
  call void @llvm.dbg.value(metadata double* %3, metadata !234, metadata !DIExpression()), !dbg !250
  call void @llvm.dbg.value(metadata double* %4, metadata !235, metadata !DIExpression()), !dbg !251
  call void @llvm.dbg.value(metadata i64 0, metadata !236, metadata !DIExpression()), !dbg !252
  br i1 %103, label %148, label %124, !dbg !253

; <label>:124:                                    ; preds = %123, %145
  %125 = phi i64 [ %146, %145 ], [ 0, %123 ]
  call void @llvm.dbg.value(metadata i64 %125, metadata !236, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 0, metadata !238, metadata !DIExpression()), !dbg !254
  %126 = mul nsw i64 %125, %0
  %127 = getelementptr inbounds double, double* %2, i64 %126
  %128 = shl i64 %125, 1
  %129 = and i64 %128, 2
  %130 = getelementptr inbounds double, double* %3, i64 %125
  br label %131, !dbg !255

; <label>:131:                                    ; preds = %131, %124
  %132 = phi i64 [ 0, %124 ], [ %143, %131 ]
  call void @llvm.dbg.value(metadata i64 %132, metadata !238, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 %125, metadata !242, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !256
  %133 = and i64 %132, 1, !dbg !257
  call void @llvm.dbg.value(metadata i64 %133, metadata !245, metadata !DIExpression()), !dbg !258
  %134 = getelementptr inbounds double, double* %127, i64 %132, !dbg !259
  %135 = bitcast double* %134 to i64*, !dbg !259
  %136 = load i64, i64* %135, align 8, !dbg !259, !tbaa !82
  %137 = or i64 %133, %129, !dbg !260
  %138 = getelementptr inbounds double, double* %4, i64 %137, !dbg !261
  %139 = bitcast double* %138 to i64*, !dbg !262
  store i64 %136, i64* %139, align 8, !dbg !262, !tbaa !82
  %140 = mul nsw i64 %132, %1, !dbg !263
  %141 = getelementptr inbounds double, double* %130, i64 %140, !dbg !263
  %142 = bitcast double* %141 to i64*, !dbg !264
  store i64 %136, i64* %142, align 8, !dbg !264, !tbaa !82
  %143 = add nuw i64 %132, 1, !dbg !265
  call void @llvm.dbg.value(metadata i64 %143, metadata !238, metadata !DIExpression()), !dbg !254
  %144 = icmp eq i64 %143, %0, !dbg !266
  br i1 %144, label %145, label %131, !dbg !255, !llvm.loop !267

; <label>:145:                                    ; preds = %131
  %146 = add nuw i64 %125, 1, !dbg !270
  call void @llvm.dbg.value(metadata i64 %146, metadata !236, metadata !DIExpression()), !dbg !252
  %147 = icmp eq i64 %146, %1, !dbg !271
  br i1 %147, label %148, label %124, !dbg !253, !llvm.loop !272

; <label>:148:                                    ; preds = %145, %120, %96, %49, %123, %104
  ret void, !dbg !275
}

; Function Attrs: nounwind uwtable
define internal void @trans_basic(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !192 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !191, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata i64 %1, metadata !194, metadata !DIExpression()), !dbg !277
  call void @llvm.dbg.value(metadata double* %2, metadata !195, metadata !DIExpression()), !dbg !278
  call void @llvm.dbg.value(metadata double* %3, metadata !196, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.value(metadata double* %4, metadata !197, metadata !DIExpression()), !dbg !280
  call void @llvm.dbg.value(metadata i64 0, metadata !198, metadata !DIExpression()), !dbg !281
  %6 = icmp eq i64 %1, 0, !dbg !282
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !227
  br i1 %8, label %27, label %9, !dbg !227

; <label>:9:                                      ; preds = %5, %24
  %10 = phi i64 [ %25, %24 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !198, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata i64 0, metadata !200, metadata !DIExpression()), !dbg !283
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = getelementptr inbounds double, double* %3, i64 %10
  br label %14, !dbg !222

; <label>:14:                                     ; preds = %14, %9
  %15 = phi i64 [ 0, %9 ], [ %22, %14 ]
  call void @llvm.dbg.value(metadata i64 %15, metadata !200, metadata !DIExpression()), !dbg !283
  %16 = getelementptr inbounds double, double* %12, i64 %15, !dbg !284
  %17 = bitcast double* %16 to i64*, !dbg !284
  %18 = load i64, i64* %17, align 8, !dbg !284, !tbaa !82
  %19 = mul nsw i64 %15, %1, !dbg !285
  %20 = getelementptr inbounds double, double* %13, i64 %19, !dbg !285
  %21 = bitcast double* %20 to i64*, !dbg !286
  store i64 %18, i64* %21, align 8, !dbg !286, !tbaa !82
  %22 = add nuw i64 %15, 1, !dbg !287
  call void @llvm.dbg.value(metadata i64 %22, metadata !200, metadata !DIExpression()), !dbg !283
  %23 = icmp eq i64 %22, %0, !dbg !288
  br i1 %23, label %24, label %14, !dbg !222, !llvm.loop !221

; <label>:24:                                     ; preds = %14
  %25 = add nuw i64 %10, 1, !dbg !289
  call void @llvm.dbg.value(metadata i64 %25, metadata !198, metadata !DIExpression()), !dbg !281
  %26 = icmp eq i64 %25, %1, !dbg !282
  br i1 %26, label %27, label %9, !dbg !227, !llvm.loop !226

; <label>:27:                                     ; preds = %24, %5
  ret void, !dbg !290
}

; Function Attrs: nounwind uwtable
define internal void @trans_tmp(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !230 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !229, metadata !DIExpression()), !dbg !291
  call void @llvm.dbg.value(metadata i64 %1, metadata !232, metadata !DIExpression()), !dbg !292
  call void @llvm.dbg.value(metadata double* %2, metadata !233, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata double* %3, metadata !234, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata double* %4, metadata !235, metadata !DIExpression()), !dbg !295
  call void @llvm.dbg.value(metadata i64 0, metadata !236, metadata !DIExpression()), !dbg !296
  %6 = icmp eq i64 %1, 0, !dbg !297
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !273
  br i1 %8, label %33, label %9, !dbg !273

; <label>:9:                                      ; preds = %5, %30
  %10 = phi i64 [ %31, %30 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !236, metadata !DIExpression()), !dbg !296
  call void @llvm.dbg.value(metadata i64 0, metadata !238, metadata !DIExpression()), !dbg !298
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = shl i64 %10, 1
  %14 = and i64 %13, 2
  %15 = getelementptr inbounds double, double* %3, i64 %10
  br label %16, !dbg !268

; <label>:16:                                     ; preds = %16, %9
  %17 = phi i64 [ 0, %9 ], [ %28, %16 ]
  call void @llvm.dbg.value(metadata i64 %17, metadata !238, metadata !DIExpression()), !dbg !298
  call void @llvm.dbg.value(metadata i64 %10, metadata !242, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !299
  %18 = and i64 %17, 1, !dbg !300
  call void @llvm.dbg.value(metadata i64 %18, metadata !245, metadata !DIExpression()), !dbg !301
  %19 = getelementptr inbounds double, double* %12, i64 %17, !dbg !302
  %20 = bitcast double* %19 to i64*, !dbg !302
  %21 = load i64, i64* %20, align 8, !dbg !302, !tbaa !82
  %22 = or i64 %18, %14, !dbg !303
  %23 = getelementptr inbounds double, double* %4, i64 %22, !dbg !304
  %24 = bitcast double* %23 to i64*, !dbg !305
  store i64 %21, i64* %24, align 8, !dbg !305, !tbaa !82
  %25 = mul nsw i64 %17, %1, !dbg !306
  %26 = getelementptr inbounds double, double* %15, i64 %25, !dbg !306
  %27 = bitcast double* %26 to i64*, !dbg !307
  store i64 %21, i64* %27, align 8, !dbg !307, !tbaa !82
  %28 = add nuw i64 %17, 1, !dbg !308
  call void @llvm.dbg.value(metadata i64 %28, metadata !238, metadata !DIExpression()), !dbg !298
  %29 = icmp eq i64 %28, %0, !dbg !309
  br i1 %29, label %30, label %16, !dbg !268, !llvm.loop !267

; <label>:30:                                     ; preds = %16
  %31 = add nuw i64 %10, 1, !dbg !310
  call void @llvm.dbg.value(metadata i64 %31, metadata !236, metadata !DIExpression()), !dbg !296
  %32 = icmp eq i64 %31, %1, !dbg !297
  br i1 %32, label %33, label %9, !dbg !273, !llvm.loop !272

; <label>:33:                                     ; preds = %30, %5
  ret void, !dbg !311
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "trans.c", directory: "/afs/andrew.cmu.edu/usr20/yuchenwu/private/18213/cache-lab-Chibadaisuki")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!7 = distinct !DISubprogram(name: "registerFunctions", scope: !1, file: !1, line: 172, type: !8, isLocal: false, isDefinition: true, scopeLine: 172, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 174, column: 5, scope: !7)
!11 = !DILocation(line: 177, column: 5, scope: !7)
!12 = !DILocation(line: 178, column: 5, scope: !7)
!13 = !DILocation(line: 179, column: 1, scope: !7)
!14 = distinct !DISubprogram(name: "transpose_submit", scope: !1, file: !1, line: 153, type: !15, isLocal: true, isDefinition: true, scopeLine: 154, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !26)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !17, !20, !20, !25}
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !18, line: 62, baseType: !19)
!18 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr20/yuchenwu/private/18213/cache-lab-Chibadaisuki")
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, elements: !23)
!22 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!23 = !{!24}
!24 = !DISubrange(count: -1)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!26 = !{!27, !28, !29, !30, !31}
!27 = !DILocalVariable(name: "M", arg: 1, scope: !14, file: !1, line: 153, type: !17)
!28 = !DILocalVariable(name: "N", arg: 2, scope: !14, file: !1, line: 153, type: !17)
!29 = !DILocalVariable(name: "A", arg: 3, scope: !14, file: !1, line: 153, type: !20)
!30 = !DILocalVariable(name: "B", arg: 4, scope: !14, file: !1, line: 153, type: !20)
!31 = !DILocalVariable(name: "tmp", arg: 5, scope: !14, file: !1, line: 154, type: !25)
!32 = !DILocation(line: 153, column: 37, scope: !14)
!33 = !DILocation(line: 153, column: 47, scope: !14)
!34 = !DILocation(line: 153, column: 57, scope: !14)
!35 = !DILocation(line: 153, column: 73, scope: !14)
!36 = !DILocation(line: 154, column: 37, scope: !14)
!37 = !DILocation(line: 155, column: 11, scope: !38)
!38 = distinct !DILexicalBlock(scope: !14, file: !1, line: 155, column: 9)
!39 = !DILocation(line: 155, column: 22, scope: !38)
!40 = !DILocation(line: 155, column: 17, scope: !38)
!41 = !DILocalVariable(name: "kk", scope: !42, file: !1, line: 119, type: !54)
!42 = distinct !DISubprogram(name: "trans_1", scope: !1, file: !1, line: 118, type: !43, isLocal: true, isDefinition: true, scopeLine: 118, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !48)
!43 = !DISubroutineType(types: !44)
!44 = !{null, !17, !17, !45, !20}
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, elements: !23)
!47 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !22)
!48 = !{!49, !50, !51, !52, !53, !55, !41, !56}
!49 = !DILocalVariable(name: "M", arg: 1, scope: !42, file: !1, line: 118, type: !17)
!50 = !DILocalVariable(name: "N", arg: 2, scope: !42, file: !1, line: 118, type: !17)
!51 = !DILocalVariable(name: "A", arg: 3, scope: !42, file: !1, line: 118, type: !45)
!52 = !DILocalVariable(name: "B", arg: 4, scope: !42, file: !1, line: 118, type: !20)
!53 = !DILocalVariable(name: "j", scope: !42, file: !1, line: 119, type: !54)
!54 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!55 = !DILocalVariable(name: "k", scope: !42, file: !1, line: 119, type: !54)
!56 = !DILocalVariable(name: "jj", scope: !42, file: !1, line: 119, type: !54)
!57 = !DILocation(line: 119, column: 15, scope: !42, inlinedAt: !58)
!58 = distinct !DILocation(line: 156, column: 9, scope: !38)
!59 = !DILocation(line: 119, column: 19, scope: !42, inlinedAt: !58)
!60 = !DILocation(line: 121, column: 9, scope: !61, inlinedAt: !58)
!61 = distinct !DILexicalBlock(scope: !62, file: !1, line: 121, column: 9)
!62 = distinct !DILexicalBlock(scope: !63, file: !1, line: 120, column: 36)
!63 = distinct !DILexicalBlock(scope: !64, file: !1, line: 120, column: 5)
!64 = distinct !DILexicalBlock(scope: !42, file: !1, line: 120, column: 5)
!65 = !DILocation(line: 119, column: 9, scope: !42, inlinedAt: !58)
!66 = !DILocation(line: 122, column: 13, scope: !67, inlinedAt: !58)
!67 = distinct !DILexicalBlock(scope: !68, file: !1, line: 122, column: 13)
!68 = distinct !DILexicalBlock(scope: !69, file: !1, line: 121, column: 40)
!69 = distinct !DILexicalBlock(scope: !61, file: !1, line: 121, column: 9)
!70 = !DILocation(line: 119, column: 12, scope: !42, inlinedAt: !58)
!71 = !DILocation(line: 123, column: 17, scope: !72, inlinedAt: !58)
!72 = distinct !DILexicalBlock(scope: !73, file: !1, line: 123, column: 17)
!73 = distinct !DILexicalBlock(scope: !74, file: !1, line: 122, column: 37)
!74 = distinct !DILexicalBlock(scope: !67, file: !1, line: 122, column: 13)
!75 = !DILocation(line: 125, column: 35, scope: !76, inlinedAt: !58)
!76 = distinct !DILexicalBlock(scope: !77, file: !1, line: 125, column: 17)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 125, column: 17)
!78 = !DILocation(line: 125, column: 17, scope: !77, inlinedAt: !58)
!79 = !DILocation(line: 124, column: 46, scope: !80, inlinedAt: !58)
!80 = distinct !DILexicalBlock(scope: !72, file: !1, line: 123, column: 17)
!81 = !DILocation(line: 124, column: 41, scope: !80, inlinedAt: !58)
!82 = !{!83, !83, i64 0}
!83 = !{!"double", !84, i64 0}
!84 = !{!"omnipotent char", !85, i64 0}
!85 = !{!"Simple C/C++ TBAA"}
!86 = !DILocation(line: 124, column: 21, scope: !80, inlinedAt: !58)
!87 = !DILocation(line: 124, column: 39, scope: !80, inlinedAt: !58)
!88 = !DILocation(line: 123, column: 37, scope: !80, inlinedAt: !58)
!89 = !DILocation(line: 123, column: 31, scope: !80, inlinedAt: !58)
!90 = distinct !{!90, !91, !92}
!91 = !DILocation(line: 123, column: 17, scope: !72)
!92 = !DILocation(line: 124, column: 57, scope: !72)
!93 = !DILocation(line: 0, scope: !76, inlinedAt: !58)
!94 = !DILocation(line: 126, column: 46, scope: !76, inlinedAt: !58)
!95 = !DILocation(line: 126, column: 41, scope: !76, inlinedAt: !58)
!96 = !DILocation(line: 126, column: 21, scope: !76, inlinedAt: !58)
!97 = !DILocation(line: 126, column: 39, scope: !76, inlinedAt: !58)
!98 = distinct !{!98, !99, !100}
!99 = !DILocation(line: 125, column: 17, scope: !77)
!100 = !DILocation(line: 126, column: 57, scope: !77)
!101 = !DILocation(line: 122, column: 33, scope: !74, inlinedAt: !58)
!102 = !DILocation(line: 122, column: 27, scope: !74, inlinedAt: !58)
!103 = distinct !{!103, !104, !105}
!104 = !DILocation(line: 122, column: 13, scope: !67)
!105 = !DILocation(line: 127, column: 13, scope: !67)
!106 = !DILocation(line: 121, column: 34, scope: !69, inlinedAt: !58)
!107 = !DILocation(line: 121, column: 25, scope: !69, inlinedAt: !58)
!108 = distinct !{!108, !109, !110}
!109 = !DILocation(line: 121, column: 9, scope: !61)
!110 = !DILocation(line: 128, column: 9, scope: !61)
!111 = !DILocation(line: 120, column: 30, scope: !63, inlinedAt: !58)
!112 = !DILocation(line: 120, column: 21, scope: !63, inlinedAt: !58)
!113 = !DILocation(line: 120, column: 5, scope: !64, inlinedAt: !58)
!114 = distinct !{!114, !115, !116}
!115 = !DILocation(line: 120, column: 5, scope: !64)
!116 = !DILocation(line: 129, column: 5, scope: !64)
!117 = !DILocation(line: 157, column: 16, scope: !118)
!118 = distinct !DILexicalBlock(scope: !38, file: !1, line: 157, column: 14)
!119 = !DILocation(line: 157, column: 29, scope: !118)
!120 = !DILocation(line: 157, column: 24, scope: !118)
!121 = !DILocalVariable(name: "kk", scope: !122, file: !1, line: 133, type: !54)
!122 = distinct !DISubprogram(name: "trans_2", scope: !1, file: !1, line: 132, type: !43, isLocal: true, isDefinition: true, scopeLine: 132, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !123)
!123 = !{!124, !125, !126, !127, !128, !129, !121, !130}
!124 = !DILocalVariable(name: "M", arg: 1, scope: !122, file: !1, line: 132, type: !17)
!125 = !DILocalVariable(name: "N", arg: 2, scope: !122, file: !1, line: 132, type: !17)
!126 = !DILocalVariable(name: "A", arg: 3, scope: !122, file: !1, line: 132, type: !45)
!127 = !DILocalVariable(name: "B", arg: 4, scope: !122, file: !1, line: 132, type: !20)
!128 = !DILocalVariable(name: "j", scope: !122, file: !1, line: 133, type: !54)
!129 = !DILocalVariable(name: "k", scope: !122, file: !1, line: 133, type: !54)
!130 = !DILocalVariable(name: "jj", scope: !122, file: !1, line: 133, type: !54)
!131 = !DILocation(line: 133, column: 15, scope: !122, inlinedAt: !132)
!132 = distinct !DILocation(line: 158, column: 9, scope: !118)
!133 = !DILocation(line: 133, column: 19, scope: !122, inlinedAt: !132)
!134 = !DILocation(line: 135, column: 9, scope: !135, inlinedAt: !132)
!135 = distinct !DILexicalBlock(scope: !136, file: !1, line: 135, column: 9)
!136 = distinct !DILexicalBlock(scope: !137, file: !1, line: 134, column: 38)
!137 = distinct !DILexicalBlock(scope: !138, file: !1, line: 134, column: 5)
!138 = distinct !DILexicalBlock(scope: !122, file: !1, line: 134, column: 5)
!139 = !DILocation(line: 133, column: 9, scope: !122, inlinedAt: !132)
!140 = !DILocation(line: 136, column: 13, scope: !141, inlinedAt: !132)
!141 = distinct !DILexicalBlock(scope: !142, file: !1, line: 136, column: 13)
!142 = distinct !DILexicalBlock(scope: !143, file: !1, line: 135, column: 42)
!143 = distinct !DILexicalBlock(scope: !135, file: !1, line: 135, column: 9)
!144 = !DILocation(line: 133, column: 12, scope: !122, inlinedAt: !132)
!145 = !DILocation(line: 137, column: 17, scope: !146, inlinedAt: !132)
!146 = distinct !DILexicalBlock(scope: !147, file: !1, line: 137, column: 17)
!147 = distinct !DILexicalBlock(scope: !148, file: !1, line: 136, column: 37)
!148 = distinct !DILexicalBlock(scope: !141, file: !1, line: 136, column: 13)
!149 = !DILocation(line: 139, column: 35, scope: !150, inlinedAt: !132)
!150 = distinct !DILexicalBlock(scope: !151, file: !1, line: 139, column: 17)
!151 = distinct !DILexicalBlock(scope: !147, file: !1, line: 139, column: 17)
!152 = !DILocation(line: 139, column: 17, scope: !151, inlinedAt: !132)
!153 = !DILocation(line: 138, column: 46, scope: !154, inlinedAt: !132)
!154 = distinct !DILexicalBlock(scope: !146, file: !1, line: 137, column: 17)
!155 = !DILocation(line: 138, column: 41, scope: !154, inlinedAt: !132)
!156 = !DILocation(line: 138, column: 21, scope: !154, inlinedAt: !132)
!157 = !DILocation(line: 138, column: 39, scope: !154, inlinedAt: !132)
!158 = !DILocation(line: 137, column: 37, scope: !154, inlinedAt: !132)
!159 = !DILocation(line: 137, column: 31, scope: !154, inlinedAt: !132)
!160 = distinct !{!160, !161, !162}
!161 = !DILocation(line: 137, column: 17, scope: !146)
!162 = !DILocation(line: 138, column: 57, scope: !146)
!163 = !DILocation(line: 0, scope: !150, inlinedAt: !132)
!164 = !DILocation(line: 140, column: 46, scope: !150, inlinedAt: !132)
!165 = !DILocation(line: 140, column: 41, scope: !150, inlinedAt: !132)
!166 = !DILocation(line: 140, column: 21, scope: !150, inlinedAt: !132)
!167 = !DILocation(line: 140, column: 39, scope: !150, inlinedAt: !132)
!168 = distinct !{!168, !169, !170}
!169 = !DILocation(line: 139, column: 17, scope: !151)
!170 = !DILocation(line: 140, column: 57, scope: !151)
!171 = !DILocation(line: 136, column: 33, scope: !148, inlinedAt: !132)
!172 = !DILocation(line: 136, column: 27, scope: !148, inlinedAt: !132)
!173 = distinct !{!173, !174, !175}
!174 = !DILocation(line: 136, column: 13, scope: !141)
!175 = !DILocation(line: 141, column: 13, scope: !141)
!176 = !DILocation(line: 135, column: 36, scope: !143, inlinedAt: !132)
!177 = !DILocation(line: 135, column: 25, scope: !143, inlinedAt: !132)
!178 = distinct !{!178, !179, !180}
!179 = !DILocation(line: 135, column: 9, scope: !135)
!180 = !DILocation(line: 142, column: 9, scope: !135)
!181 = !DILocation(line: 134, column: 32, scope: !137, inlinedAt: !132)
!182 = !DILocation(line: 134, column: 21, scope: !137, inlinedAt: !132)
!183 = !DILocation(line: 134, column: 5, scope: !138, inlinedAt: !132)
!184 = distinct !{!184, !185, !186}
!185 = !DILocation(line: 134, column: 5, scope: !138)
!186 = !DILocation(line: 143, column: 5, scope: !138)
!187 = !DILocation(line: 159, column: 16, scope: !188)
!188 = distinct !DILexicalBlock(scope: !118, file: !1, line: 159, column: 14)
!189 = !DILocation(line: 0, scope: !188)
!190 = !DILocation(line: 159, column: 14, scope: !118)
!191 = !DILocalVariable(name: "M", arg: 1, scope: !192, file: !1, line: 81, type: !17)
!192 = distinct !DISubprogram(name: "trans_basic", scope: !1, file: !1, line: 81, type: !15, isLocal: true, isDefinition: true, scopeLine: 82, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !193)
!193 = !{!191, !194, !195, !196, !197, !198, !200}
!194 = !DILocalVariable(name: "N", arg: 2, scope: !192, file: !1, line: 81, type: !17)
!195 = !DILocalVariable(name: "A", arg: 3, scope: !192, file: !1, line: 81, type: !20)
!196 = !DILocalVariable(name: "B", arg: 4, scope: !192, file: !1, line: 81, type: !20)
!197 = !DILocalVariable(name: "tmp", arg: 5, scope: !192, file: !1, line: 82, type: !25)
!198 = !DILocalVariable(name: "i", scope: !199, file: !1, line: 86, type: !17)
!199 = distinct !DILexicalBlock(scope: !192, file: !1, line: 86, column: 5)
!200 = !DILocalVariable(name: "j", scope: !201, file: !1, line: 87, type: !17)
!201 = distinct !DILexicalBlock(scope: !202, file: !1, line: 87, column: 9)
!202 = distinct !DILexicalBlock(scope: !203, file: !1, line: 86, column: 36)
!203 = distinct !DILexicalBlock(scope: !199, file: !1, line: 86, column: 5)
!204 = !DILocation(line: 81, column: 32, scope: !192, inlinedAt: !205)
!205 = distinct !DILocation(line: 160, column: 9, scope: !188)
!206 = !DILocation(line: 81, column: 42, scope: !192, inlinedAt: !205)
!207 = !DILocation(line: 81, column: 52, scope: !192, inlinedAt: !205)
!208 = !DILocation(line: 81, column: 68, scope: !192, inlinedAt: !205)
!209 = !DILocation(line: 82, column: 32, scope: !192, inlinedAt: !205)
!210 = !DILocation(line: 86, column: 17, scope: !199, inlinedAt: !205)
!211 = !DILocation(line: 86, column: 5, scope: !199, inlinedAt: !205)
!212 = !DILocation(line: 87, column: 21, scope: !201, inlinedAt: !205)
!213 = !DILocation(line: 87, column: 9, scope: !201, inlinedAt: !205)
!214 = !DILocation(line: 88, column: 23, scope: !215, inlinedAt: !205)
!215 = distinct !DILexicalBlock(scope: !216, file: !1, line: 87, column: 40)
!216 = distinct !DILexicalBlock(scope: !201, file: !1, line: 87, column: 9)
!217 = !DILocation(line: 88, column: 13, scope: !215, inlinedAt: !205)
!218 = !DILocation(line: 88, column: 21, scope: !215, inlinedAt: !205)
!219 = !DILocation(line: 87, column: 36, scope: !216, inlinedAt: !205)
!220 = !DILocation(line: 87, column: 30, scope: !216, inlinedAt: !205)
!221 = distinct !{!221, !222, !223}
!222 = !DILocation(line: 87, column: 9, scope: !201)
!223 = !DILocation(line: 89, column: 9, scope: !201)
!224 = !DILocation(line: 86, column: 32, scope: !203, inlinedAt: !205)
!225 = !DILocation(line: 86, column: 26, scope: !203, inlinedAt: !205)
!226 = distinct !{!226, !227, !228}
!227 = !DILocation(line: 86, column: 5, scope: !199)
!228 = !DILocation(line: 90, column: 5, scope: !199)
!229 = !DILocalVariable(name: "M", arg: 1, scope: !230, file: !1, line: 101, type: !17)
!230 = distinct !DISubprogram(name: "trans_tmp", scope: !1, file: !1, line: 101, type: !15, isLocal: true, isDefinition: true, scopeLine: 102, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !231)
!231 = !{!229, !232, !233, !234, !235, !236, !238, !242, !245}
!232 = !DILocalVariable(name: "N", arg: 2, scope: !230, file: !1, line: 101, type: !17)
!233 = !DILocalVariable(name: "A", arg: 3, scope: !230, file: !1, line: 101, type: !20)
!234 = !DILocalVariable(name: "B", arg: 4, scope: !230, file: !1, line: 101, type: !20)
!235 = !DILocalVariable(name: "tmp", arg: 5, scope: !230, file: !1, line: 102, type: !25)
!236 = !DILocalVariable(name: "i", scope: !237, file: !1, line: 106, type: !17)
!237 = distinct !DILexicalBlock(scope: !230, file: !1, line: 106, column: 5)
!238 = !DILocalVariable(name: "j", scope: !239, file: !1, line: 107, type: !17)
!239 = distinct !DILexicalBlock(scope: !240, file: !1, line: 107, column: 9)
!240 = distinct !DILexicalBlock(scope: !241, file: !1, line: 106, column: 36)
!241 = distinct !DILexicalBlock(scope: !237, file: !1, line: 106, column: 5)
!242 = !DILocalVariable(name: "di", scope: !243, file: !1, line: 108, type: !17)
!243 = distinct !DILexicalBlock(scope: !244, file: !1, line: 107, column: 40)
!244 = distinct !DILexicalBlock(scope: !239, file: !1, line: 107, column: 9)
!245 = !DILocalVariable(name: "dj", scope: !243, file: !1, line: 109, type: !17)
!246 = !DILocation(line: 101, column: 30, scope: !230, inlinedAt: !247)
!247 = distinct !DILocation(line: 162, column: 9, scope: !188)
!248 = !DILocation(line: 101, column: 40, scope: !230, inlinedAt: !247)
!249 = !DILocation(line: 101, column: 50, scope: !230, inlinedAt: !247)
!250 = !DILocation(line: 101, column: 66, scope: !230, inlinedAt: !247)
!251 = !DILocation(line: 102, column: 30, scope: !230, inlinedAt: !247)
!252 = !DILocation(line: 106, column: 17, scope: !237, inlinedAt: !247)
!253 = !DILocation(line: 106, column: 5, scope: !237, inlinedAt: !247)
!254 = !DILocation(line: 107, column: 21, scope: !239, inlinedAt: !247)
!255 = !DILocation(line: 107, column: 9, scope: !239, inlinedAt: !247)
!256 = !DILocation(line: 108, column: 20, scope: !243, inlinedAt: !247)
!257 = !DILocation(line: 109, column: 27, scope: !243, inlinedAt: !247)
!258 = !DILocation(line: 109, column: 20, scope: !243, inlinedAt: !247)
!259 = !DILocation(line: 110, column: 32, scope: !243, inlinedAt: !247)
!260 = !DILocation(line: 110, column: 24, scope: !243, inlinedAt: !247)
!261 = !DILocation(line: 110, column: 13, scope: !243, inlinedAt: !247)
!262 = !DILocation(line: 110, column: 30, scope: !243, inlinedAt: !247)
!263 = !DILocation(line: 111, column: 13, scope: !243, inlinedAt: !247)
!264 = !DILocation(line: 111, column: 21, scope: !243, inlinedAt: !247)
!265 = !DILocation(line: 107, column: 36, scope: !244, inlinedAt: !247)
!266 = !DILocation(line: 107, column: 30, scope: !244, inlinedAt: !247)
!267 = distinct !{!267, !268, !269}
!268 = !DILocation(line: 107, column: 9, scope: !239)
!269 = !DILocation(line: 112, column: 9, scope: !239)
!270 = !DILocation(line: 106, column: 32, scope: !241, inlinedAt: !247)
!271 = !DILocation(line: 106, column: 26, scope: !241, inlinedAt: !247)
!272 = distinct !{!272, !273, !274}
!273 = !DILocation(line: 106, column: 5, scope: !237)
!274 = !DILocation(line: 113, column: 5, scope: !237)
!275 = !DILocation(line: 163, column: 1, scope: !14)
!276 = !DILocation(line: 81, column: 32, scope: !192)
!277 = !DILocation(line: 81, column: 42, scope: !192)
!278 = !DILocation(line: 81, column: 52, scope: !192)
!279 = !DILocation(line: 81, column: 68, scope: !192)
!280 = !DILocation(line: 82, column: 32, scope: !192)
!281 = !DILocation(line: 86, column: 17, scope: !199)
!282 = !DILocation(line: 86, column: 26, scope: !203)
!283 = !DILocation(line: 87, column: 21, scope: !201)
!284 = !DILocation(line: 88, column: 23, scope: !215)
!285 = !DILocation(line: 88, column: 13, scope: !215)
!286 = !DILocation(line: 88, column: 21, scope: !215)
!287 = !DILocation(line: 87, column: 36, scope: !216)
!288 = !DILocation(line: 87, column: 30, scope: !216)
!289 = !DILocation(line: 86, column: 32, scope: !203)
!290 = !DILocation(line: 93, column: 1, scope: !192)
!291 = !DILocation(line: 101, column: 30, scope: !230)
!292 = !DILocation(line: 101, column: 40, scope: !230)
!293 = !DILocation(line: 101, column: 50, scope: !230)
!294 = !DILocation(line: 101, column: 66, scope: !230)
!295 = !DILocation(line: 102, column: 30, scope: !230)
!296 = !DILocation(line: 106, column: 17, scope: !237)
!297 = !DILocation(line: 106, column: 26, scope: !241)
!298 = !DILocation(line: 107, column: 21, scope: !239)
!299 = !DILocation(line: 108, column: 20, scope: !243)
!300 = !DILocation(line: 109, column: 27, scope: !243)
!301 = !DILocation(line: 109, column: 20, scope: !243)
!302 = !DILocation(line: 110, column: 32, scope: !243)
!303 = !DILocation(line: 110, column: 24, scope: !243)
!304 = !DILocation(line: 110, column: 13, scope: !243)
!305 = !DILocation(line: 110, column: 30, scope: !243)
!306 = !DILocation(line: 111, column: 13, scope: !243)
!307 = !DILocation(line: 111, column: 21, scope: !243)
!308 = !DILocation(line: 107, column: 36, scope: !244)
!309 = !DILocation(line: 107, column: 30, scope: !244)
!310 = !DILocation(line: 106, column: 32, scope: !241)
!311 = !DILocation(line: 116, column: 1, scope: !230)
