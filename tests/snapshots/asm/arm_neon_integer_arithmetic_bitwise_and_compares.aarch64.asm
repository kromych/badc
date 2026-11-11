
arm_neon_integer_arithmetic_bitwise_and_compares.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<w_vadd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vaddq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vadd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vaddq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vadd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vaddq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vadd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vaddq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vadd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vaddq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vadd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vaddq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vadd_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vaddq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vadd_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vaddq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	add	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vsub_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vsubq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vsub_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vsubq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vsub_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vsubq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vsub_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vsubq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vsub_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vsubq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vsub_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vsubq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vsub_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vsubq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vsub_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sub	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vsubq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vmul_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vmulq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmul_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vmulq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmul_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vmulq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmul_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vmulq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmul_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vmulq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmul_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mul	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vmulq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mul	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmla_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmla_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmla_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmla_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmla_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmla_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mla	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlaq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mla	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmls_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	mls	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	mls	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vqadd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqaddq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqadd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqaddq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqadd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqaddq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqadd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqaddq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqadd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqaddq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqadd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqaddq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqadd_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqadd	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqaddq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqadd	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vqadd_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqadd	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqaddq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqadd	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vqsub_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqsub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqsubq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqsub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqsub_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqsub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqsubq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqsub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqsub_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqsub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqsubq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqsub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqsub_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqsub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqsubq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqsub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqsub_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqsub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqsubq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqsub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqsub_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqsub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqsubq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqsub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqsub_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqsub	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqsubq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqsub	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vqsub_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqsub	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqsubq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqsub	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vneg_s8>:
               	ldr	d0, [x1]
               	neg	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vnegq_s8>:
               	ldr	q0, [x1]
               	neg	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vneg_s16>:
               	ldr	d0, [x1]
               	neg	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vnegq_s16>:
               	ldr	q0, [x1]
               	neg	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vneg_s32>:
               	ldr	d0, [x1]
               	neg	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vnegq_s32>:
               	ldr	q0, [x1]
               	neg	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vneg_s64>:
               	ldr	d0, [x1]
               	neg	d0, d0
               	str	d0, [x0]
               	ret

<w_vnegq_s64>:
               	ldr	q0, [x1]
               	neg	v0.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vabs_s8>:
               	ldr	d0, [x1]
               	abs	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vabsq_s8>:
               	ldr	q0, [x1]
               	abs	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vabs_s16>:
               	ldr	d0, [x1]
               	abs	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vabsq_s16>:
               	ldr	q0, [x1]
               	abs	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vabs_s32>:
               	ldr	d0, [x1]
               	abs	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vabsq_s32>:
               	ldr	q0, [x1]
               	abs	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vabs_s64>:
               	ldr	d0, [x1]
               	abs	d0, d0
               	str	d0, [x0]
               	ret

<w_vabsq_s64>:
               	ldr	q0, [x1]
               	abs	v0.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqneg_s8>:
               	ldr	d0, [x1]
               	sqneg	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vqnegq_s8>:
               	ldr	q0, [x1]
               	sqneg	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vqneg_s16>:
               	ldr	d0, [x1]
               	sqneg	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vqnegq_s16>:
               	ldr	q0, [x1]
               	sqneg	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vqneg_s32>:
               	ldr	d0, [x1]
               	sqneg	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vqnegq_s32>:
               	ldr	q0, [x1]
               	sqneg	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vqneg_s64>:
               	ldr	d0, [x1]
               	sqneg	d0, d0
               	str	d0, [x0]
               	ret

<w_vqnegq_s64>:
               	ldr	q0, [x1]
               	sqneg	v0.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqabs_s8>:
               	ldr	d0, [x1]
               	sqabs	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vqabsq_s8>:
               	ldr	q0, [x1]
               	sqabs	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vqabs_s16>:
               	ldr	d0, [x1]
               	sqabs	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vqabsq_s16>:
               	ldr	q0, [x1]
               	sqabs	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vqabs_s32>:
               	ldr	d0, [x1]
               	sqabs	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vqabsq_s32>:
               	ldr	q0, [x1]
               	sqabs	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vqabs_s64>:
               	ldr	d0, [x1]
               	sqabs	d0, d0
               	str	d0, [x0]
               	ret

<w_vqabsq_s64>:
               	ldr	q0, [x1]
               	sqabs	v0.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vhadd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vhaddq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vhadd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vhaddq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vhadd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vhaddq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vhadd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vhaddq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vhadd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vhaddq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vhadd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vhaddq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vrhadd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srhadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vrhaddq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srhadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vrhadd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srhadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vrhaddq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srhadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vrhadd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srhadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vrhaddq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srhadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vrhadd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urhadd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vrhaddq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urhadd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vrhadd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urhadd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vrhaddq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urhadd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vrhadd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urhadd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vrhaddq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urhadd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vhsub_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shsub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vhsubq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shsub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vhsub_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shsub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vhsubq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shsub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vhsub_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	shsub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vhsubq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	shsub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vhsub_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhsub	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vhsubq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhsub	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vhsub_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhsub	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vhsubq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhsub	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vhsub_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uhsub	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vhsubq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uhsub	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vabd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sabd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vabdq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sabd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vabd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sabd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vabdq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sabd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vabd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sabd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vabdq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sabd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vabd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uabd	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vabdq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uabd	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vabd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uabd	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vabdq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uabd	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vabd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uabd	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vabdq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uabd	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vaba_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	saba	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	saba	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaba_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	saba	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	saba	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaba_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	saba	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	saba	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaba_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	uaba	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	uaba	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaba_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	uaba	v0.4h, v1.4h, v2.4h
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	uaba	v0.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaba_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	uaba	v0.2s, v1.2s, v2.2s
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vabaq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	uaba	v0.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmax_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smax	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vmaxq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smax	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmax_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smax	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vmaxq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smax	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmax_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smax	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vmaxq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smax	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmax_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umax	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vmaxq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umax	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmax_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umax	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vmaxq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umax	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmax_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umax	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vmaxq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umax	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmin_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smin	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vminq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smin	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmin_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smin	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vminq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smin	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmin_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smin	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vminq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smin	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmin_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umin	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vminq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umin	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmin_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umin	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vminq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umin	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmin_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umin	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vminq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umin	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpadd_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpaddq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpadd_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpaddq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpadd_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpaddq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpadd_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpaddq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpadd_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpaddq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpadd_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	addp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpaddq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpaddq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vpaddq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	addp	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vpmax_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smaxp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpmaxq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smaxp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpmax_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smaxp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpmaxq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smaxp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpmax_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smaxp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpmaxq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smaxp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpmax_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umaxp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpmaxq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umaxp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpmax_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umaxp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpmaxq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umaxp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpmax_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umaxp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpmaxq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umaxp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpmin_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sminp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpminq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sminp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpmin_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sminp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpminq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sminp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpmin_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sminp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpminq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sminp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vpmin_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uminp	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vpminq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uminp	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vpmin_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uminp	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vpminq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uminp	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vpmin_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uminp	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vpminq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uminp	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vand_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vand_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	and	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vandq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	and	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorr_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orr	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vorrq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orr	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_veor_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	eor	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_veorq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	eor	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vbic_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	bic	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vbicq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	bic	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vorn_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	orn	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vornq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	orn	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmvn_s8>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_s8>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vmvn_s16>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_s16>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vmvn_s32>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_s32>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vmvn_u8>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_u8>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vmvn_u16>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_u16>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vmvn_u32>:
               	ldr	d0, [x1]
               	mvn	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vmvnq_u32>:
               	ldr	q0, [x1]
               	mvn	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vbsl_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbsl_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcnt_s8>:
               	ldr	d0, [x1]
               	cnt	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vcntq_u8>:
               	ldr	q0, [x1]
               	cnt	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vcnt_p8>:
               	ldr	d0, [x1]
               	cnt	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vclz_s8>:
               	ldr	d0, [x1]
               	clz	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vclzq_s8>:
               	ldr	q0, [x1]
               	clz	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vclz_s16>:
               	ldr	d0, [x1]
               	clz	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vclzq_s16>:
               	ldr	q0, [x1]
               	clz	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vclz_s32>:
               	ldr	d0, [x1]
               	clz	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vclzq_s32>:
               	ldr	q0, [x1]
               	clz	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vclz_u8>:
               	ldr	d0, [x1]
               	clz	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vclzq_u8>:
               	ldr	q0, [x1]
               	clz	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vclz_u16>:
               	ldr	d0, [x1]
               	clz	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vclzq_u16>:
               	ldr	q0, [x1]
               	clz	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vclz_u32>:
               	ldr	d0, [x1]
               	clz	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vclzq_u32>:
               	ldr	q0, [x1]
               	clz	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vcls_s8>:
               	ldr	d0, [x1]
               	cls	v0.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vclsq_s8>:
               	ldr	q0, [x1]
               	cls	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vcls_s16>:
               	ldr	d0, [x1]
               	cls	v0.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vclsq_s16>:
               	ldr	q0, [x1]
               	cls	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vcls_s32>:
               	ldr	d0, [x1]
               	cls	v0.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vclsq_s32>:
               	ldr	q0, [x1]
               	cls	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vceq_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vceqq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vceq_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vceqq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vceq_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vceqq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vceq_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vceqq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vceq_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vceqq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vceq_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vceqq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vceq_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vceqq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vceq_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmeq	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vceqq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmeq	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vcge_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vcgeq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vcge_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vcgeq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vcge_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vcgeq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vcge_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vcgeq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vcge_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vcgeq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vcge_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vcgeq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vcge_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vcgeq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vcge_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vcgeq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vcgt_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vcgtq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vcgt_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vcgtq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vcgt_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vcgtq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vcgt_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vcgtq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vcgt_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vcgtq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vcgt_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vcgtq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vcgt_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vcgtq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vcgt_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vcgtq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vcle_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.8b, v1.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vcleq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.16b, v1.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vcle_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.4h, v1.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vcleq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.8h, v1.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vcle_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	v0.2s, v1.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vcleq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.4s, v1.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vcle_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.8b, v1.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vcleq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.16b, v1.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vcle_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.4h, v1.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vcleq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.8h, v1.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vcle_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	v0.2s, v1.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vcleq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.4s, v1.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vcle_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmge	d0, d1, d0
               	str	d0, [x0]
               	ret

<w_vcleq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmge	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vcle_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhs	d0, d1, d0
               	str	d0, [x0]
               	ret

<w_vcleq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhs	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vclt_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.8b, v1.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vcltq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.16b, v1.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vclt_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.4h, v1.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vcltq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.8h, v1.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vclt_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	v0.2s, v1.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vcltq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.4s, v1.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vclt_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.8b, v1.8b, v0.8b
               	str	d0, [x0]
               	ret

<w_vcltq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.16b, v1.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vclt_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.4h, v1.4h, v0.4h
               	str	d0, [x0]
               	ret

<w_vcltq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.8h, v1.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vclt_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	v0.2s, v1.2s, v0.2s
               	str	d0, [x0]
               	ret

<w_vcltq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.4s, v1.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vclt_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmgt	d0, d1, d0
               	str	d0, [x0]
               	ret

<w_vcltq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmgt	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vclt_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmhi	d0, d1, d0
               	str	d0, [x0]
               	ret

<w_vcltq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmhi	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vtst_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vtstq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtst_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vtstq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtst_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vtstq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtst_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vtstq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtst_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vtstq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtst_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vtstq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtst_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vtstq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtst_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	cmtst	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vtstq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	cmtst	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<lane>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w2
               	sxtw	x21, w3
               	sub	x3, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	mul	x1, x1, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	add	x1, x0, x1, asr #3
               	add	x0, x20, x20, lsr #61
               	asr	x2, x0, #3
               	mov	x0, x3
               	bl	<addr>
               	cbz	x21, <addr>
               	ldur	x4, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	sub	x0, x20, #0x1
               	and	x3, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x2, #0x3f               // =63
               	sub	x5, x2, x0
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x6, x3
               	lsr	x7, x1, x0
               	lsl	x1, x1, x5
               	lsr	x0, x4, x0
               	orr	x0, x0, x1, lsl #1
               	and	x0, x0, x6
               	and	x1, x7, x3
               	orr	x0, x0, x1
               	tbz	w0, #0x0, <addr>
               	ldur	x4, [x29, #-0x10]
               	ldur	x5, [x29, #-0x8]
               	mov	x1, #-0x1               // =-1
               	and	x3, x20, #0x7f
               	and	x0, x20, #0x3f
               	sub	x6, x2, x0
               	lsr	x2, x3, #6
               	neg	x2, x2
               	mvn	x3, x2
               	lsl	x0, x1, x0
               	lsr	x1, x1, x6
               	orr	x1, x0, x1, lsr #1
               	and	x6, x0, x3
               	and	x1, x1, x3
               	and	x0, x0, x2
               	orr	x0, x1, x0
               	orr	x1, x4, x6
               	orr	x0, x5, x0
               	stur	x1, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret

<model>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	sxtw	x0, w0
               	str	x2, [sp]
               	str	x3, [sp, #0x8]
               	str	x4, [sp, #0x10]
               	str	x5, [sp, #0x18]
               	stur	x6, [x29, #-0x100]
               	stur	x7, [x29, #-0xf8]
               	ldrsw	x1, [x29, #0x18]
               	cbz	x1, <addr>
               	mov	x2, #0x1                // =1
               	mov	x6, #0x0                // =0
               	ldrsw	x1, [x29, #0x10]
               	sub	x1, x1, #0x1
               	and	x3, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x7, x4, x1
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x4, x3
               	lsl	x5, x2, x1
               	lsr	x2, x2, x7
               	lsl	x1, x6, x1
               	orr	x2, x1, x2, lsr #1
               	and	x1, x5, x4
               	and	x2, x2, x4
               	and	x3, x5, x3
               	orr	x2, x2, x3
               	cmp	x1, #0x0
               	cset	x3, hi
               	neg	x4, x1
               	neg	x1, x2
               	sub	x2, x1, x3
               	sub	x1, x29, #0xd0
               	stur	x4, [x29, #-0xd0]
               	stur	x2, [x29, #-0xc8]
               	sub	x2, x29, #0xf0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrsw	x1, [x29, #0x18]
               	cbz	x1, <addr>
               	mov	x2, #0x1                // =1
               	mov	x6, #0x0                // =0
               	ldrsw	x1, [x29, #0x10]
               	sub	x1, x1, #0x1
               	and	x3, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x7, x4, x1
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x4, x3
               	lsl	x5, x2, x1
               	lsr	x2, x2, x7
               	lsl	x1, x6, x1
               	orr	x2, x1, x2, lsr #1
               	and	x1, x5, x4
               	and	x2, x2, x4
               	and	x3, x5, x3
               	orr	x2, x2, x3
               	cmp	x1, #0x1
               	cset	x3, lo
               	sub	x1, x1, #0x1
               	sub	x3, x2, x3
               	sub	x2, x29, #0xb0
               	stur	x1, [x29, #-0xb0]
               	stur	x3, [x29, #-0xa8]
               	sub	x1, x29, #0xe0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	cmp	x0, #0x24
               	b.hs	<addr>
               	adrp	x17, <addr>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x0, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	add	x0, x1, x0
               	cmp	x0, x1
               	cset	x1, lo
               	add	x2, x2, x3
               	add	x1, x2, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	cmp	x0, x1
               	cset	x4, lo
               	sub	x0, x0, x1
               	sub	x1, x2, x3
               	sub	x1, x1, x4
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x4, [sp, #0x18]
               	mul	x0, x1, x2
               	umulh	x5, x1, x2
               	madd	x1, x1, x4, x5
               	madd	x1, x3, x2, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x0, [sp, #0x10]
               	ldr	x4, [sp, #0x18]
               	ldur	x1, [x29, #-0x100]
               	ldur	x5, [x29, #-0xf8]
               	umulh	x6, x0, x1
               	madd	x5, x0, x5, x6
               	madd	x4, x4, x1, x5
               	madd	x0, x0, x1, x2
               	cmp	x0, x2
               	cset	x1, lo
               	add	x2, x3, x4
               	add	x1, x2, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x4, [sp, #0x8]
               	ldr	x0, [sp, #0x10]
               	ldr	x5, [sp, #0x18]
               	ldur	x1, [x29, #-0x100]
               	ldur	x6, [x29, #-0xf8]
               	mul	x3, x0, x1
               	umulh	x7, x0, x1
               	madd	x0, x0, x6, x7
               	madd	x1, x5, x1, x0
               	cmp	x2, x3
               	cset	x5, lo
               	sub	x0, x2, x3
               	sub	x1, x4, x1
               	sub	x1, x1, x5
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x0, [sp, #0x10]
               	ldr	x4, [sp, #0x18]
               	add	x0, x2, x0
               	cmp	x0, x2
               	cset	x2, lo
               	add	x3, x3, x4
               	add	x3, x3, x2
               	sub	x5, x29, #0x90
               	stur	x0, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	sub	x2, x29, #0xf0
               	ldur	x6, [x29, #-0xf0]
               	ldur	x4, [x29, #-0xe8]
               	cmp	x3, x4
               	cset	x7, lt
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x0, x6
               	cset	x0, lo
               	and	x0, x3, x0
               	orr	x0, x7, x0
               	cbz	x0, <addr>
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x90]
               	ldur	x0, [x29, #-0x88]
               	ldur	x4, [x29, #-0xe0]
               	ldur	x2, [x29, #-0xd8]
               	cmp	x2, x0
               	cset	x6, lt
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	csel	x2, x1, x5, ne
               	b	<addr>
               	ldr	x0, [sp]
               	ldr	x4, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x5, [sp, #0x18]
               	cmp	x0, x2
               	cset	x6, lo
               	sub	x3, x0, x2
               	sub	x0, x4, x5
               	sub	x0, x0, x6
               	sub	x5, x29, #0x80
               	stur	x3, [x29, #-0x80]
               	stur	x0, [x29, #-0x78]
               	sub	x2, x29, #0xf0
               	ldur	x6, [x29, #-0xf0]
               	ldur	x4, [x29, #-0xe8]
               	cmp	x0, x4
               	cset	x7, lt
               	cmp	x0, x4
               	cset	x0, eq
               	cmp	x3, x6
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x7, x0
               	cbz	x0, <addr>
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x80]
               	ldur	x0, [x29, #-0x78]
               	ldur	x4, [x29, #-0xe0]
               	ldur	x2, [x29, #-0xd8]
               	cmp	x2, x0
               	cset	x6, lt
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	csel	x2, x1, x5, ne
               	b	<addr>
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	cmp	x0, #0x0
               	cset	x2, hi
               	neg	x0, x0
               	neg	x1, x1
               	sub	x1, x1, x2
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x120
               	ldr	x0, [sp, #0x8]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	cmp	x0, #0x0
               	cset	x2, hi
               	neg	x0, x0
               	neg	x1, x1
               	sub	x2, x1, x2
               	sub	x1, x29, #0x70
               	stur	x0, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x2, [sp, #0x8]
               	cmp	x0, #0x0
               	cset	x4, hi
               	neg	x3, x0
               	neg	x0, x2
               	sub	x0, x0, x4
               	sub	x5, x29, #0x60
               	stur	x3, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	sub	x2, x29, #0xf0
               	ldur	x6, [x29, #-0xf0]
               	ldur	x4, [x29, #-0xe8]
               	cmp	x0, x4
               	cset	x7, lt
               	cmp	x0, x4
               	cset	x0, eq
               	cmp	x3, x6
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x7, x0
               	cbz	x0, <addr>
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x60]
               	ldur	x0, [x29, #-0x58]
               	ldur	x4, [x29, #-0xe0]
               	ldur	x2, [x29, #-0xd8]
               	cmp	x2, x0
               	cset	x6, lt
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	csel	x2, x1, x5, ne
               	b	<addr>
               	sub	x0, x29, #0x120
               	ldr	x2, [sp, #0x8]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	ldr	x0, [sp]
               	ldr	x2, [sp, #0x8]
               	cmp	x0, #0x0
               	cset	x3, hi
               	neg	x4, x0
               	neg	x0, x2
               	sub	x2, x0, x3
               	sub	x0, x29, #0x50
               	stur	x4, [x29, #-0x50]
               	stur	x2, [x29, #-0x48]
               	sub	x2, x29, #0xf0
               	ldr	x5, [x0]
               	ldr	x3, [x0, #0x8]
               	ldur	x6, [x29, #-0xf0]
               	ldur	x4, [x29, #-0xe8]
               	cmp	x3, x4
               	cset	x7, lt
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x5, x6
               	cset	x4, lo
               	and	x3, x3, x4
               	orr	x3, x7, x3
               	cbz	x3, <addr>
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0]
               	ldr	x2, [x0, #0x8]
               	ldur	x5, [x29, #-0xe0]
               	ldur	x3, [x29, #-0xd8]
               	cmp	x3, x2
               	cset	x6, lt
               	cmp	x3, x2
               	cset	x2, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x2, x2, x3
               	orr	x2, x6, x2
               	cmp	x2, #0x0
               	csel	x2, x1, x0, ne
               	b	<addr>
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	add	x2, x0, x2
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x3
               	add	x0, x1, x0
               	asr	x1, x0, #1
               	lsr	x2, x2, #1
               	orr	x0, x2, x0, lsl #63
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x0, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	add	x0, x1, x0
               	cmp	x0, x1
               	cset	x1, lo
               	add	x2, x2, x3
               	add	x1, x2, x1
               	add	x2, x0, #0x1
               	cmp	x2, x0
               	cset	x0, lo
               	add	x0, x1, x0
               	asr	x1, x0, #1
               	lsr	x2, x2, #1
               	orr	x0, x2, x0, lsl #63
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	cmp	x0, x1
               	cset	x4, lo
               	sub	x5, x0, x1
               	sub	x0, x2, x3
               	sub	x0, x0, x4
               	asr	x1, x0, #1
               	lsr	x2, x5, #1
               	orr	x0, x2, x0, lsl #63
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x0, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x1, x0
               	cset	x4, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cbz	x0, <addr>
               	ldr	x0, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	cmp	x0, x1
               	cset	x4, lo
               	sub	x0, x0, x1
               	sub	x1, x2, x3
               	sub	x2, x1, x4
               	sub	x1, x29, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x2, [x29, #-0x38]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x10]
               	ldr	x2, [sp, #0x18]
               	ldr	x1, [sp]
               	ldr	x3, [sp, #0x8]
               	cmp	x0, x1
               	cset	x4, lo
               	sub	x0, x0, x1
               	sub	x1, x2, x3
               	sub	x2, x1, x4
               	sub	x1, x29, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x2, [x29, #-0x28]
               	b	<addr>
               	ldr	x1, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x4, [sp, #0x10]
               	ldr	x0, [sp, #0x18]
               	ldur	x5, [x29, #-0x100]
               	ldur	x2, [x29, #-0xf8]
               	cmp	x2, x0
               	cset	x6, lt
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x6, x0
               	cbz	x0, <addr>
               	ldr	x0, [sp, #0x10]
               	ldr	x4, [sp, #0x18]
               	ldur	x2, [x29, #-0x100]
               	ldur	x5, [x29, #-0xf8]
               	cmp	x0, x2
               	cset	x6, lo
               	sub	x2, x0, x2
               	sub	x0, x4, x5
               	sub	x4, x0, x6
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x4, [x29, #-0x18]
               	ldr	x2, [x0]
               	ldr	x4, [x0, #0x8]
               	add	x0, x1, x2
               	cmp	x0, x1
               	cset	x1, lo
               	add	x2, x3, x4
               	add	x1, x2, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x100]
               	ldur	x4, [x29, #-0xf8]
               	ldr	x2, [sp, #0x10]
               	ldr	x5, [sp, #0x18]
               	cmp	x0, x2
               	cset	x6, lo
               	sub	x2, x0, x2
               	sub	x0, x4, x5
               	sub	x4, x0, x6
               	sub	x0, x29, #0x10
               	stur	x2, [x29, #-0x10]
               	stur	x4, [x29, #-0x8]
               	b	<addr>
               	sub	x2, x29, #0x120
               	ldr	x3, [sp]
               	ldr	x0, [sp, #0x8]
               	sub	x4, x29, #0x110
               	ldr	x5, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x1, x0
               	cset	x6, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x5, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	csel	x1, x2, x4, ne
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x120
               	ldr	x3, [sp]
               	ldr	x0, [sp, #0x8]
               	sub	x4, x29, #0x110
               	ldr	x5, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x0, x1
               	cset	x6, lt
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x3, x5
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	csel	x1, x2, x4, ne
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	and	x0, x0, x2
               	and	x1, x1, x3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	orr	x0, x0, x2
               	orr	x1, x1, x3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	mvn	x2, x2
               	mvn	x3, x3
               	and	x0, x0, x2
               	and	x1, x1, x3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	mvn	x2, x2
               	mvn	x3, x3
               	orr	x0, x0, x2
               	orr	x1, x1, x3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	mvn	x0, x0
               	mvn	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	and	x2, x0, x2
               	and	x3, x1, x3
               	mvn	x0, x0
               	mvn	x1, x1
               	ldur	x4, [x29, #-0x100]
               	ldur	x5, [x29, #-0xf8]
               	and	x0, x0, x4
               	and	x1, x1, x5
               	orr	x0, x2, x0
               	orr	x1, x3, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	and	x0, x0, #0xff
               	fmov	s16, w0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w0, s16
               	mov	x1, #0x0                // =0
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x29, #0x10]
               	ldr	x5, [sp]
               	ldr	x3, [sp, #0x8]
               	mov	x1, #0x0                // =0
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	and	x4, x0, #0x7f
               	and	x2, x0, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x6, x6, x2
               	lsr	x4, x4, #6
               	neg	x4, x4
               	mvn	x7, x4
               	asr	x8, x3, x2
               	lsl	x6, x3, x6
               	lsr	x2, x5, x2
               	orr	x2, x2, x6, lsl #1
               	and	x2, x2, x7
               	and	x4, x8, x4
               	orr	x2, x2, x4
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x0, w1
               	asr	x1, x0, #63
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [sp]
               	ldr	x0, [sp, #0x8]
               	lsr	x2, x1, #1
               	orr	x2, x2, x0, lsl #63
               	eor	x5, x1, x2
               	eor	x3, x0, x0, asr #1
               	ldrsw	x0, [x29, #0x10]
               	mov	x1, #0x0                // =0
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	and	x4, x0, #0x7f
               	and	x2, x0, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x6, x6, x2
               	lsr	x4, x4, #6
               	neg	x4, x4
               	mvn	x7, x4
               	asr	x8, x3, x2
               	lsl	x6, x3, x6
               	lsr	x2, x5, x2
               	orr	x2, x2, x6, lsl #1
               	and	x2, x2, x7
               	and	x4, x8, x4
               	orr	x2, x2, x4
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sub	x0, x1, #0x1
               	sxtw	x0, w0
               	asr	x1, x0, #63
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x0, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x0, x1
               	cset	x4, lt
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x2, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	eor	x0, x0, #0x1
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x0, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x1, x0
               	cset	x4, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x0, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x1, x0
               	cset	x4, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	eor	x0, x0, #0x1
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [sp]
               	ldr	x0, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	cmp	x0, x1
               	cset	x4, lt
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x2, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	and	x0, x0, x2
               	and	x1, x1, x3
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x0
               	cset	x1, hi
               	neg	x0, x0
               	neg	x1, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x6, #0x0                // =0
               	ldrsw	x1, [x29, #0x10]
               	and	x3, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x7, x4, x1
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x4, x3
               	lsl	x5, x2, x1
               	lsr	x2, x2, x7
               	lsl	x1, x6, x1
               	orr	x2, x1, x2, lsr #1
               	and	x1, x5, x4
               	and	x2, x2, x4
               	and	x3, x5, x3
               	orr	x2, x2, x3
               	cmp	x1, #0x1
               	cset	x3, lo
               	sub	x1, x1, #0x1
               	sub	x3, x2, x3
               	sub	x2, x29, #0xa0
               	stur	x1, [x29, #-0xa0]
               	stur	x3, [x29, #-0x98]
               	b	<addr>
               	sub	x1, x29, #0xc0
               	stur	xzr, [x29, #-0xc0]
               	stur	xzr, [x29, #-0xb8]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x26, x27, [sp, #0x40]
               	str	x28, [sp, #0x50]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	mov	x1, #0x79b9             // =31161
               	movk	x1, #0x9e37, lsl #16
               	mov	x0, #0x20               // =32
               	eor	x1, x1, x1, lsl #13
               	mov	w1, w1
               	eor	x1, x1, x1, lsr #17
               	eor	x1, x1, x1, lsl #5
               	mov	w3, w1
               	ubfx	x3, x3, #3, #8
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x60
               	b.lo	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xf8]
               	ldr	x22, [sp, #0xf8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x17, [sp, #0xf8]
               	add	x20, x0, x17, lsl #5
               	ldrsw	x0, [x20, #0xc]
               	mov	x26, #0x1               // =1
               	cmp	w0, #0x13
               	cset	x1, eq
               	cmp	w0, #0x12
               	csel	x0, x26, x1, eq
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x14
               	cset	x26, eq
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x100]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x108]
               	ldr	x0, [sp, #0x108]
               	cmp	w0, #0x6
               	b.ge	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [sp, #0x100]
               	add	x23, x1, x2, lsl #4
               	add	x24, x1, x0, lsl #4
               	add	x0, x2, x0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x2, x0, x17
               	lsr	x2, x2, #32
               	mov	x17, #0x6               // =6
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	add	x25, x1, x0, lsl #4
               	ldr	x4, [x20]
               	sub	x0, x29, #0xf0
               	mov	x1, x23
               	mov	x3, x25
               	mov	x2, x24
               	blr	x4
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x20, #0x18]
               	ldrsw	x2, [x20, #0x10]
               	mul	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x2, x1, #3
               	mov	x1, x23
               	bl	<addr>
               	sub	x3, x29, #0x20
               	ldrsw	x1, [x20, #0x18]
               	ldrsw	x2, [x20, #0x10]
               	mul	x0, x1, x2
               	sxtw	x0, w0
               	add	x0, x0, x0, lsr #61
               	add	x0, x3, x0, asr #3
               	mul	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x2, x1, #3
               	mov	x1, x24
               	bl	<addr>
               	mov	x21, #0x0               // =0
               	ldrsw	x0, [x20, #0x18]
               	cmp	w21, w0
               	b.ge	<addr>
               	cbz	x26, <addr>
               	ldrsw	x27, [x20, #0xc]
               	sub	x0, x29, #0x20
               	lsl	x1, x21, #1
               	ldrsw	x2, [x20, #0x10]
               	ldrsw	x3, [x20, #0x14]
               	bl	<addr>
               	stur	x0, [x29, #-0xe0]
               	sub	x28, x29, #0xe0
               	stur	x1, [x29, #-0xd8]
               	sub	x0, x29, #0x20
               	lsl	x1, x21, #1
               	add	x1, x1, #0x1
               	ldrsw	x2, [x20, #0x10]
               	ldrsw	x3, [x20, #0x14]
               	bl	<addr>
               	stur	x0, [x29, #-0xd0]
               	sub	x4, x29, #0xd0
               	stur	x1, [x29, #-0xc8]
               	sub	x6, x29, #0x30
               	stur	xzr, [x29, #-0x30]
               	stur	xzr, [x29, #-0x28]
               	ldrsw	x0, [x20, #0x10]
               	ldrsw	x1, [x20, #0x14]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	mov	x0, x27
               	mov	x2, x28
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	sub	x0, x29, #0xc0
               	stur	x1, [x29, #-0xb8]
               	ldr	x27, [x0]
               	ldr	x28, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	mov	x3, #0x0                // =0
               	ldrsw	x0, [x20, #0x10]
               	and	x2, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x6, x4, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsl	x5, x1, x0
               	lsr	x1, x1, x6
               	lsl	x0, x3, x0
               	orr	x1, x0, x1, lsr #1
               	and	x0, x5, x4
               	and	x1, x1, x4
               	and	x2, x5, x2
               	orr	x1, x1, x2
               	cmp	x0, #0x1
               	cset	x2, lo
               	sub	x16, x0, #0x1
               	str	x16, [sp, #0x118]
               	sub	x16, x1, x2
               	str	x16, [sp, #0x110]
               	sub	x0, x29, #0xf0
               	ldrsw	x2, [x20, #0x10]
               	mov	x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	eor	x0, x27, x0
               	eor	x1, x28, x1
               	ldr	x17, [sp, #0x118]
               	and	x0, x0, x17
               	ldr	x17, [sp, #0x110]
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	ldrsw	x0, [x20, #0x8]
               	orr	x22, x22, x0
               	b	<addr>
               	ldrsw	x27, [x20, #0xc]
               	ldrsw	x2, [x20, #0x10]
               	ldrsw	x3, [x20, #0x14]
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	sub	x28, x29, #0xb0
               	stur	x1, [x29, #-0xa8]
               	ldrsw	x2, [x20, #0x10]
               	ldrsw	x3, [x20, #0x14]
               	mov	x0, x24
               	mov	x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0xa0]
               	sub	x16, x29, #0xa0
               	str	x16, [sp, #0x118]
               	stur	x1, [x29, #-0x98]
               	ldrsw	x2, [x20, #0x10]
               	ldrsw	x3, [x20, #0x14]
               	mov	x0, x25
               	mov	x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x90]
               	sub	x6, x29, #0x90
               	stur	x1, [x29, #-0x88]
               	ldrsw	x0, [x20, #0x10]
               	ldrsw	x1, [x20, #0x14]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	mov	x0, x27
               	mov	x2, x28
               	ldr	x4, [sp, #0x118]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	stur	x1, [x29, #-0x78]
               	b	<addr>
               	add	x21, x21, #0x1
               	ldrsw	x0, [x20, #0x18]
               	cmp	w21, w0
               	b.lt	<addr>
               	ldr	x16, [sp, #0x108]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0x108]
               	ldr	x0, [sp, #0x108]
               	cmp	w0, #0x6
               	b.lt	<addr>
               	ldr	x16, [sp, #0x100]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0x100]
               	ldr	x16, [sp, #0x100]
               	cmp	w16, #0x6
               	b.lt	<addr>
               	ldr	x16, [sp, #0xf8]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0xf8]
               	ldr	x16, [sp, #0xf8]
               	cmp	w16, #0x1df
               	b.lo	<addr>
               	mov	x0, x22
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
