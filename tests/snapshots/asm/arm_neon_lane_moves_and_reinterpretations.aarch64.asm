
arm_neon_lane_moves_and_reinterpretations.aarch64:	file format elf64-littleaarch64

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

<at_same>:
               	ret

<at_lane>:
               	mov	x0, x2
               	ret

<at_offset>:
               	add	x0, x2, x0
               	ret

<at_set>:
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x0, x1
               	ret
               	mov	x1, x0
               	b	<addr>

<at_st1>:
               	cbnz	w0, <addr>
               	mov	x0, x2
               	ret
               	add	x2, x1, x0
               	b	<addr>

<at_rev>:
               	sdiv	w1, w0, w2
               	mul	x1, x1, x2
               	add	x2, x1, x2
               	sub	x2, x2, #0x1
               	sub	x0, x0, x1
               	sub	x0, x2, x0
               	ret

<at_zip1>:
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	and	x3, x0, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0, asr #1
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>

<at_zip2>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	and	x3, x0, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	mov	x2, x1
               	add	x1, x1, x1, lsr #63
               	add	x1, x2, x1, asr #1
               	add	x0, x1, x0, asr #1
               	ret
               	mov	x2, #0x0                // =0
               	b	<addr>

<at_uzp1>:
               	lsl	x0, x0, #1
               	ret

<at_uzp2>:
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	ret

<at_trn1>:
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x3, x0, x2
               	and	x3, x3, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0
               	sub	x0, x0, #0x1
               	ret

<at_trn2>:
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x3, x0, x2
               	and	x3, x3, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0
               	ret
               	add	x0, x0, #0x1
               	b	<addr>

<at_zip>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	w0, w1
               	b.ge	<addr>
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	and	x3, x0, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0, asr #1
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	and	x3, x0, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	mov	x2, x1
               	add	x1, x1, x1, lsr #63
               	add	x1, x2, x1, asr #1
               	add	x0, x1, x0, asr #1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>

<at_uzp>:
               	cmp	w0, w1
               	b.ge	<addr>
               	lsl	x0, x0, #1
               	ret
               	sub	x0, x0, x1
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	b	<addr>

<at_trn>:
               	sxtw	x0, w0
               	cmp	w0, w1
               	b.ge	<addr>
               	lsr	x2, x0, #63
               	add	x3, x0, x2
               	and	x3, x3, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0
               	sub	x0, x0, #0x1
               	ret
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x3, x0, x2
               	and	x3, x3, #0x1
               	sub	x2, x3, x2
               	cbz	x2, <addr>
               	add	x0, x1, x0
               	b	<addr>
               	add	x0, x0, #0x1
               	b	<addr>

<w_vld1_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_s8>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.8b }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.b }[7], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.b }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_s8>:
               	ld1r	{ v0.16b }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.b }[15], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.b }[15], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_u8>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.8b }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.b }[7], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.b }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_u8>:
               	ld1r	{ v0.16b }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.b }[15], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.b }[15], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_p8>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.8b }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.b }[7], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.b }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_p8>:
               	ld1r	{ v0.16b }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.b }[15], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.b }[15], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_s16>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.4h }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.h }[3], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.h }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_s16>:
               	ld1r	{ v0.8h }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.h }[7], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.h }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_u16>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.4h }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.h }[3], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.h }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_u16>:
               	ld1r	{ v0.8h }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.h }[7], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.h }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_p16>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.4h }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.h }[3], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.h }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_p16>:
               	ld1r	{ v0.8h }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.h }[7], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.h }[7], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_s32>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.2s }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.s }[1], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.s }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_s32>:
               	ld1r	{ v0.4s }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.s }[3], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.s }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_u32>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.2s }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.s }[1], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.s }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_u32>:
               	ld1r	{ v0.4s }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.s }[3], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.s }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_f32>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ld1r	{ v0.2s }, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.s }[1], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.s }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_f32>:
               	ld1r	{ v0.4s }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.s }[3], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.s }[3], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_s64>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.d }[0], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.d }[0], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_s64>:
               	ld1r	{ v0.2d }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.d }[1], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.d }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_u64>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.d }[0], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.d }[0], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_u64>:
               	ld1r	{ v0.2d }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.d }[1], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.d }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_p64>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.d }[0], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.d }[0], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_p64>:
               	ld1r	{ v0.2d }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.d }[1], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.d }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_f64>:
               	ldr	d0, [x1]
               	str	d0, [x0]
               	ret

<w_vld1_dup_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	str	d0, [sp]
               	str	x2, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	ld1	{ v0.d }[0], [x0]
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	st1	{ v0.d }[0], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vld1q_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vst1q_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_dup_f64>:
               	ld1r	{ v0.2d }, [x1]
               	str	q0, [x0]
               	ret

<w_vld1q_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	str	q0, [sp]
               	str	x2, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	ld1	{ v0.d }[1], [x0]
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vst1q_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	st1	{ v0.d }[1], [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vdup_n_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrb	w1, [x1]
               	sxtb	x1, w1
               	dup	v0.8b, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_s8>:
               	ldrb	w1, [x1]
               	sxtb	x1, w1
               	dup	v0.16b, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_s8>:
               	ldr	d0, [x1]
               	dup	v0.8b, v0.b[7]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_s8>:
               	ldr	d0, [x1]
               	dup	v0.16b, v0.b[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_s8>:
               	ldr	q0, [x1]
               	dup	v0.8b, v0.b[15]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_s8>:
               	ldr	q0, [x1]
               	dup	v0.16b, v0.b[8]
               	str	q0, [x0]
               	ret

<w_vdup_n_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrb	w1, [x1]
               	dup	v0.8b, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_u8>:
               	ldrb	w1, [x1]
               	dup	v0.16b, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_u8>:
               	ldr	d0, [x1]
               	dup	v0.8b, v0.b[7]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_u8>:
               	ldr	d0, [x1]
               	dup	v0.16b, v0.b[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_u8>:
               	ldr	q0, [x1]
               	dup	v0.8b, v0.b[15]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_u8>:
               	ldr	q0, [x1]
               	dup	v0.16b, v0.b[8]
               	str	q0, [x0]
               	ret

<w_vdup_n_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrb	w1, [x1]
               	dup	v0.8b, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_p8>:
               	ldrb	w1, [x1]
               	dup	v0.16b, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_p8>:
               	ldr	d0, [x1]
               	dup	v0.8b, v0.b[7]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_p8>:
               	ldr	d0, [x1]
               	dup	v0.16b, v0.b[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_p8>:
               	ldr	q0, [x1]
               	dup	v0.8b, v0.b[15]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_p8>:
               	ldr	q0, [x1]
               	dup	v0.16b, v0.b[8]
               	str	q0, [x0]
               	ret

<w_vdup_n_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrh	w1, [x1]
               	sxth	x1, w1
               	dup	v0.4h, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_s16>:
               	ldrh	w1, [x1]
               	sxth	x1, w1
               	dup	v0.8h, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_s16>:
               	ldr	d0, [x1]
               	dup	v0.4h, v0.h[3]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_s16>:
               	ldr	d0, [x1]
               	dup	v0.8h, v0.h[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_s16>:
               	ldr	q0, [x1]
               	dup	v0.4h, v0.h[7]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_s16>:
               	ldr	q0, [x1]
               	dup	v0.8h, v0.h[4]
               	str	q0, [x0]
               	ret

<w_vdup_n_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrh	w1, [x1]
               	dup	v0.4h, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_u16>:
               	ldrh	w1, [x1]
               	dup	v0.8h, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_u16>:
               	ldr	d0, [x1]
               	dup	v0.4h, v0.h[3]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_u16>:
               	ldr	d0, [x1]
               	dup	v0.8h, v0.h[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_u16>:
               	ldr	q0, [x1]
               	dup	v0.4h, v0.h[7]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_u16>:
               	ldr	q0, [x1]
               	dup	v0.8h, v0.h[4]
               	str	q0, [x0]
               	ret

<w_vdup_n_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrh	w1, [x1]
               	dup	v0.4h, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_p16>:
               	ldrh	w1, [x1]
               	dup	v0.8h, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_p16>:
               	ldr	d0, [x1]
               	dup	v0.4h, v0.h[3]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_p16>:
               	ldr	d0, [x1]
               	dup	v0.8h, v0.h[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_p16>:
               	ldr	q0, [x1]
               	dup	v0.4h, v0.h[7]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_p16>:
               	ldr	q0, [x1]
               	dup	v0.8h, v0.h[4]
               	str	q0, [x0]
               	ret

<w_vdup_n_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	w1, [x1]
               	sxtw	x1, w1
               	dup	v0.2s, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_s32>:
               	ldr	w1, [x1]
               	sxtw	x1, w1
               	dup	v0.4s, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_s32>:
               	ldr	d0, [x1]
               	dup	v0.2s, v0.s[1]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_s32>:
               	ldr	d0, [x1]
               	dup	v0.4s, v0.s[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_s32>:
               	ldr	q0, [x1]
               	dup	v0.2s, v0.s[3]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_s32>:
               	ldr	q0, [x1]
               	dup	v0.4s, v0.s[2]
               	str	q0, [x0]
               	ret

<w_vdup_n_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	w1, [x1]
               	dup	v0.2s, w1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_u32>:
               	ldr	w1, [x1]
               	dup	v0.4s, w1
               	str	q0, [x0]
               	ret

<w_vdup_lane_u32>:
               	ldr	d0, [x1]
               	dup	v0.2s, v0.s[1]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_u32>:
               	ldr	d0, [x1]
               	dup	v0.4s, v0.s[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_u32>:
               	ldr	q0, [x1]
               	dup	v0.2s, v0.s[3]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_u32>:
               	ldr	q0, [x1]
               	dup	v0.4s, v0.s[2]
               	str	q0, [x0]
               	ret

<w_vdup_n_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldur	s0, [x29, #-0x8]
               	dup	v0.2s, v0.s[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldur	s0, [x29, #-0x10]
               	dup	v0.4s, v0.s[0]
               	str	q0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vdup_lane_f32>:
               	ldr	d0, [x1]
               	dup	v0.2s, v0.s[1]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_f32>:
               	ldr	d0, [x1]
               	dup	v0.4s, v0.s[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_f32>:
               	ldr	q0, [x1]
               	dup	v0.2s, v0.s[3]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_f32>:
               	ldr	q0, [x1]
               	dup	v0.4s, v0.s[2]
               	str	q0, [x0]
               	ret

<w_vdup_n_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	x1, [x1]
               	fmov	d0, x1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_s64>:
               	ldr	x1, [x1]
               	dup	v0.2d, x1
               	str	q0, [x0]
               	ret

<w_vdup_lane_s64>:
               	ldr	d0, [x1]
               	mov	d0, v0.d[0]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_s64>:
               	ldr	d0, [x1]
               	dup	v0.2d, v0.d[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_s64>:
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_s64>:
               	ldr	q0, [x1]
               	dup	v0.2d, v0.d[1]
               	str	q0, [x0]
               	ret

<w_vdup_n_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	x1, [x1]
               	fmov	d0, x1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_u64>:
               	ldr	x1, [x1]
               	dup	v0.2d, x1
               	str	q0, [x0]
               	ret

<w_vdup_lane_u64>:
               	ldr	d0, [x1]
               	mov	d0, v0.d[0]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_u64>:
               	ldr	d0, [x1]
               	dup	v0.2d, v0.d[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_u64>:
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_u64>:
               	ldr	q0, [x1]
               	dup	v0.2d, v0.d[1]
               	str	q0, [x0]
               	ret

<w_vdup_n_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	x1, [x1]
               	fmov	d0, x1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_p64>:
               	ldr	x1, [x1]
               	dup	v0.2d, x1
               	str	q0, [x0]
               	ret

<w_vdup_lane_p64>:
               	ldr	d0, [x1]
               	mov	d0, v0.d[0]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_p64>:
               	ldr	d0, [x1]
               	dup	v0.2d, v0.d[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_p64>:
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_p64>:
               	ldr	q0, [x1]
               	dup	v0.2d, v0.d[1]
               	str	q0, [x0]
               	ret

<w_vdup_n_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	fmov	d0, d0
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovq_n_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldur	d0, [x29, #-0x10]
               	dup	v0.2d, v0.d[0]
               	str	q0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vdup_lane_f64>:
               	ldr	d0, [x1]
               	mov	d0, v0.d[0]
               	str	d0, [x0]
               	ret

<w_vdupq_lane_f64>:
               	ldr	d0, [x1]
               	dup	v0.2d, v0.d[0]
               	str	q0, [x0]
               	ret

<w_vdup_laneq_f64>:
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	str	d0, [x0]
               	ret

<w_vdupq_laneq_f64>:
               	ldr	q0, [x1]
               	dup	v0.2d, v0.d[1]
               	str	q0, [x0]
               	ret

<w_vget_low_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_s8>:
               	ldr	d0, [x1]
               	umov	w1, v0.b[7]
               	strb	w1, [x0]
               	ret

<w_vgetq_lane_s8>:
               	ldr	q0, [x1]
               	umov	w1, v0.b[1]
               	strb	w1, [x0]
               	ret

<w_vset_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrb	w0, [x2]
               	sxtb	x0, w0
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.b[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrb	w0, [x2]
               	sxtb	x0, w0
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.b[15], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_u8>:
               	ldr	d0, [x1]
               	umov	w1, v0.b[7]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vgetq_lane_u8>:
               	ldr	q0, [x1]
               	umov	w1, v0.b[1]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vset_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrb	w0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.b[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrb	w0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.b[15], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_p8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_p8>:
               	ldr	d0, [x1]
               	umov	w1, v0.b[7]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vgetq_lane_p8>:
               	ldr	q0, [x1]
               	umov	w1, v0.b[1]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vset_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrb	w0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.b[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrb	w0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.b[15], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_s16>:
               	ldr	d0, [x1]
               	umov	w1, v0.h[3]
               	strh	w1, [x0]
               	ret

<w_vgetq_lane_s16>:
               	ldr	q0, [x1]
               	umov	w1, v0.h[1]
               	strh	w1, [x0]
               	ret

<w_vset_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrh	w0, [x2]
               	sxth	x0, w0
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.h[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrh	w0, [x2]
               	sxth	x0, w0
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.h[7], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_u16>:
               	ldr	d0, [x1]
               	umov	w1, v0.h[3]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vgetq_lane_u16>:
               	ldr	q0, [x1]
               	umov	w1, v0.h[1]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vset_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrh	w0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.h[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrh	w0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.h[7], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_p16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_p16>:
               	ldr	d0, [x1]
               	umov	w1, v0.h[3]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vgetq_lane_p16>:
               	ldr	q0, [x1]
               	umov	w1, v0.h[1]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vset_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldrh	w0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.h[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldrh	w0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.h[7], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_s32>:
               	ldr	d0, [x1]
               	mov	w1, v0.s[1]
               	str	w1, [x0]
               	ret

<w_vgetq_lane_s32>:
               	ldr	q0, [x1]
               	mov	w1, v0.s[1]
               	str	w1, [x0]
               	ret

<w_vset_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldr	w0, [x2]
               	sxtw	x0, w0
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.s[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldr	w0, [x2]
               	sxtw	x0, w0
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.s[3], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_u32>:
               	ldr	d0, [x1]
               	mov	w1, v0.s[1]
               	str	w1, [x0]
               	ret

<w_vgetq_lane_u32>:
               	ldr	q0, [x1]
               	mov	w1, v0.s[1]
               	str	w1, [x0]
               	ret

<w_vset_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldr	w0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.s[0], w0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldr	w0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.s[3], w0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_f32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_f32>:
               	ldr	d0, [x1]
               	mov	s0, v0.s[1]
               	str	s0, [x0]
               	ret

<w_vgetq_lane_f32>:
               	ldr	q0, [x1]
               	mov	s0, v0.s[1]
               	str	s0, [x0]
               	ret

<w_vset_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d0, [x1]
               	sub	x1, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	s1, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	mov	v0.s[0], v1.s[0]
               	str	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldur	s1, [x29, #-0x30]
               	str	q0, [sp, #0x10]
               	str	d1, [sp, #0x20]
               	ldr	q0, [sp, #0x10]
               	ldr	d1, [sp, #0x20]
               	mov	v0.s[3], v1.s[0]
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_s64>:
               	ldr	d0, [x1]
               	mov	x1, v0.d[0]
               	str	x1, [x0]
               	ret

<w_vgetq_lane_s64>:
               	ldr	q0, [x1]
               	mov	x1, v0.d[1]
               	str	x1, [x0]
               	ret

<w_vset_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldr	x0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.d[0], x0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_s64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldr	x0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.d[1], x0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_u64>:
               	ldr	d0, [x1]
               	mov	x1, v0.d[0]
               	str	x1, [x0]
               	ret

<w_vgetq_lane_u64>:
               	ldr	q0, [x1]
               	mov	x1, v0.d[1]
               	str	x1, [x0]
               	ret

<w_vset_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldr	x0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.d[0], x0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldr	x0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.d[1], x0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_p64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_p64>:
               	ldr	d0, [x1]
               	mov	x1, v0.d[0]
               	str	x1, [x0]
               	ret

<w_vgetq_lane_p64>:
               	ldr	q0, [x1]
               	mov	x1, v0.d[1]
               	str	x1, [x0]
               	ret

<w_vset_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	ldr	d0, [x1]
               	ldr	x0, [x2]
               	str	d0, [sp]
               	str	x0, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	x0, [sp, #0x8]
               	mov	v0.d[0], x0
               	str	d0, [x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	ldr	q0, [x1]
               	ldr	x0, [x2]
               	str	q0, [sp]
               	str	x0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	x0, [sp, #0x10]
               	mov	v0.d[1], x0
               	str	q0, [x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_low_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vget_high_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vcombine_f64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vget_lane_f64>:
               	ldr	d0, [x1]
               	mov	d0, v0.d[0]
               	str	d0, [x0]
               	ret

<w_vgetq_lane_f64>:
               	ldr	q0, [x1]
               	mov	d0, v0.d[1]
               	str	d0, [x0]
               	ret

<w_vset_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	mov	v0.d[0], v1.d[0]
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsetq_lane_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q0, [x1]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldur	d1, [x29, #-0x30]
               	str	q0, [sp, #0x10]
               	str	d1, [sp, #0x20]
               	ldr	q0, [sp, #0x10]
               	ldr	d1, [sp, #0x20]
               	mov	v0.d[1], v1.d[0]
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vreinterpret_s8_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u8_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u8_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p8_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p8_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s16_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s16_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u16_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u16_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p16_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s8_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_s8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s8_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_s8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s8_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p8_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p8_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s16_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s16_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u16_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u16_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p16_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u8_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_u8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u8_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_u8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u8_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s16_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s16_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u16_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u16_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p16_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p8_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_p8>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p8_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_p8>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p8_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u16_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u16_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p16_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s16_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_s16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s16_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_s16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s16_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p16_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u16_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_u16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u16_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_u16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u16_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s32_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p16_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_p16>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p16_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_p16>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p16_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u32_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s32_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_s32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s32_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_s32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s32_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u32_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f32_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u32_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u32_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u32_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u32_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u32_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u32_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u32_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u32_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_u32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u32_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_u32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u32_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_f32_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_s64_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_f32_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_f32_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_f32_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_f32_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_f32_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_f32_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_f32>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_f32_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_f32>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f32_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s64_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_u64_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s64_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s64_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s64_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_s64_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_s64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_s64_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_s64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_s64_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u64_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_p64_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u64_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_u64_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_u64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_u64_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_u64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_u64_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpret_p64_f64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpret_f64_p64>:
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ret

<w_vreinterpretq_p64_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_p64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p64_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_p128_f64>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vreinterpretq_f64_p128>:
               	ldr	q0, [x1]
               	str	q0, [x0]
               	ret

<w_vzip1q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip2q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp1q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp2q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn1q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn2q_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip1_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	zip2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip2q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp1q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp2q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn1q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn2q_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip1_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	zip2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip2q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp1q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vuzp2q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn1q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vtrn2q_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vzip1_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	zip2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip2q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp1q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp2q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn1q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn2q_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip1_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	zip2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip2q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp1q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp2q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn1q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn2q_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip1_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	zip2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip2q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp1q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vuzp2q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn1q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vtrn2q_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vzip1_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	zip2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip2q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp1q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp2q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn1q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn2q_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip1_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	zip2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip2q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp1q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp2q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn1q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn2q_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip1_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	zip2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip2q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp1q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vuzp2q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn1q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vtrn2q_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vzip1_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip2_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp1_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp2_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn1_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn2_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzipq_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	zip2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzp_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vuzpq_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	uzp2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrn_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vtrnq_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vzip1q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip2q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp1q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp2q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn1q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn2q_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip1q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip2q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp1q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp2q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn1q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn2q_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip1q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip2q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp1q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp2q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn1q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn2q_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip1q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vzip2q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp1q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vuzp2q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn1q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn1	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vtrn2q_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	trn2	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vext_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vextq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vext_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vextq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vext_p8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vextq_p8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vext_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x6
               	str	d0, [x0]
               	ret

<w_vextq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x2
               	str	q0, [x0]
               	ret

<w_vext_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x6
               	str	d0, [x0]
               	ret

<w_vextq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x2
               	str	q0, [x0]
               	ret

<w_vext_p16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x6
               	str	d0, [x0]
               	ret

<w_vextq_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x2
               	str	q0, [x0]
               	ret

<w_vext_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x4
               	str	d0, [x0]
               	ret

<w_vextq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x4
               	str	q0, [x0]
               	ret

<w_vext_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x4
               	str	d0, [x0]
               	ret

<w_vextq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x4
               	str	q0, [x0]
               	ret

<w_vext_f32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x4
               	str	d0, [x0]
               	ret

<w_vextq_f32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x4
               	str	q0, [x0]
               	ret

<w_vext_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vextq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vext_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vextq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vext_p64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vextq_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vext_f64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ext	v0.8b, v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vextq_f64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vbsl_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_p8>:
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
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_p16>:
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
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_f32>:
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
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
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

<w_vbsl_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_p64>:
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

<w_vbsl_f64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x4]
               	ldr	d1, [x2]
               	ldr	d2, [x3]
               	sub	x1, x29, #0x8
               	ldr	x16, [x4]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	str	d2, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	bsl	v0.8b, v1.8b, v2.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vbslq_f64>:
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

<w_vrev16_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev16	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev16q_s8>:
               	ldr	q0, [x1]
               	rev16	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev16_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev16	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev16q_u8>:
               	ldr	q0, [x1]
               	rev16	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev16_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev16	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev16q_p8>:
               	ldr	q0, [x1]
               	rev16	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev32_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_s8>:
               	ldr	q0, [x1]
               	rev32	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev32_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_u8>:
               	ldr	q0, [x1]
               	rev32	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev32_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_p8>:
               	ldr	q0, [x1]
               	rev32	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev32_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_s16>:
               	ldr	q0, [x1]
               	rev32	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev32_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_u16>:
               	ldr	q0, [x1]
               	rev32	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev32_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev32	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev32q_p16>:
               	ldr	q0, [x1]
               	rev32	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev64_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_s8>:
               	ldr	q0, [x1]
               	rev64	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev64_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_u8>:
               	ldr	q0, [x1]
               	rev64	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev64_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_p8>:
               	ldr	q0, [x1]
               	rev64	v0.16b, v0.16b
               	str	q0, [x0]
               	ret

<w_vrev64_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_s16>:
               	ldr	q0, [x1]
               	rev64	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev64_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_u16>:
               	ldr	q0, [x1]
               	rev64	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev64_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.4h, v0.4h
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_p16>:
               	ldr	q0, [x1]
               	rev64	v0.8h, v0.8h
               	str	q0, [x0]
               	ret

<w_vrev64_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.2s, v0.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_s32>:
               	ldr	q0, [x1]
               	rev64	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vrev64_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.2s, v0.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_u32>:
               	ldr	q0, [x1]
               	rev64	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<w_vrev64_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	rev64	v0.2s, v0.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrev64q_f32>:
               	ldr	q0, [x1]
               	rev64	v0.4s, v0.4s
               	str	q0, [x0]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x1, #0xe667             // =58983
               	movk	x1, #0x6a09, lsl #16
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x1, lsl #13
               	mov	w1, w1
               	eor	x1, x1, x1, lsr #17
               	eor	x1, x1, x1, lsl #5
               	mov	w2, w1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ubfx	x2, x2, #7, #8
               	strb	w2, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	mov	x28, #0x0               // =0
               	mov	x22, x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x28              // =40
               	mul	x1, x28, x17
               	add	x21, x0, x1
               	mov	x27, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x23, x0, x27, lsl #4
               	add	x1, x27, #0x1
               	and	x1, x1, #0x3
               	add	x24, x0, x1, lsl #4
               	add	x1, x27, #0x2
               	and	x1, x1, #0x3
               	add	x25, x0, x1, lsl #4
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	ldr	x4, [x21]
               	mov	x1, x23
               	mov	x3, x25
               	mov	x2, x24
               	blr	x4
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x21, #0x1c]
               	ldrsw	x2, [x21, #0x20]
               	mul	x1, x1, x2
               	sxtw	x2, w1
               	mov	x1, x23
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x21, #0x1c]
               	ldrsw	x2, [x21, #0x20]
               	mul	x3, x1, x2
               	sxtw	x3, w3
               	add	x0, x0, x3
               	mul	x1, x1, x2
               	sxtw	x2, w1
               	mov	x1, x24
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	ldrsw	x0, [x21, #0x18]
               	ldrsw	x1, [x21, #0x20]
               	mul	x0, x0, x1
               	cmp	w20, w0
               	b.ge	<addr>
               	ldr	x0, [x21, #0x8]
               	cbz	x0, <addr>
               	sub	x26, x29, #0x20
               	ldr	x3, [x21, #0x8]
               	ldrsw	x0, [x21, #0x20]
               	sdiv	w0, w20, w0
               	ldrsw	x1, [x21, #0x1c]
               	ldrsw	x2, [x21, #0x14]
               	blr	x3
               	ldrsw	x1, [x21, #0x20]
               	sdiv	w17, w20, w1
               	msub	w2, w17, w1, w20
               	madd	x0, x0, x1, x2
               	ldrb	w0, [x26, w0, sxtw]
               	sub	x1, x29, #0x40
               	ldrb	w1, [x1, x20]
               	cmp	w1, w0
               	b.eq	<addr>
               	ldrsw	x0, [x21, #0x10]
               	orr	x22, x22, x0
               	b	<addr>
               	ldrb	w0, [x23, x20]
               	ldrb	w1, [x24, x20]
               	and	x1, x0, x1
               	mvn	x0, x0
               	ldrb	w2, [x25, x20]
               	and	x0, x0, x2
               	orr	x0, x1, x0
               	b	<addr>
               	add	x20, x20, #0x1
               	ldrsw	x0, [x21, #0x18]
               	ldrsw	x1, [x21, #0x20]
               	mul	x0, x0, x1
               	cmp	w20, w0
               	b.lt	<addr>
               	add	x27, x27, #0x1
               	cmp	w27, #0x4
               	b.lt	<addr>
               	add	x28, x28, #0x1
               	cmp	w28, #0x38f
               	b.lo	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
