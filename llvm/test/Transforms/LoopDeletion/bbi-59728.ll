; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -verify-memoryssa -passes='loop-mssa(loop-deletion,loop-simplifycfg)' -S | FileCheck %s

; This is a case where we failed to update memory SSA correctly in
; loop-deletion which escapes local verification, but causes a crash
; in loop-simplifycfg.
define void @func_45() {
; CHECK-LABEL: @func_45(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY45:%.*]]
; CHECK:       for.body45:
; CHECK-NEXT:    store i32 433429641, ptr undef, align 1
; CHECK-NEXT:    br label [[FOR_BODY45]]
;
entry:
  br label %for.body45

for.body45:                                       ; preds = %for.end72, %entry
  br label %for.body48

for.body48:                                       ; preds = %for.body48, %for.body45
  store i32 433429641, ptr undef, align 1
  br i1 false, label %for.body48, label %for.end72

for.end72:                                        ; preds = %for.body48
  br label %for.body45
}
