
arm_neon_integer_shifts_widening_and_reductions.aarch64:	file format elf64-littleaarch64

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

<w_vshl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sshl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vshlq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vrshl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srshl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vrshlq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqshl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqshl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqshlq_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vshl_n_s8_lo>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_s8_mid>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_s8_hi>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vshlq_n_s8_lo>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_s8_mid>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_s8_hi>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x7
               	str	q0, [x0]
               	ret

<w_vqshl_n_s8_lo>:
               	ldr	d0, [x1]
               	sqshl	v0.8b, v0.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_s8_mid>:
               	ldr	d0, [x1]
               	sqshl	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_s8_hi>:
               	ldr	d0, [x1]
               	sqshl	v0.8b, v0.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vqshlq_n_s8_lo>:
               	ldr	q0, [x1]
               	sqshl	v0.16b, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s8_mid>:
               	ldr	q0, [x1]
               	sqshl	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s8_hi>:
               	ldr	q0, [x1]
               	sqshl	v0.16b, v0.16b, #0x7
               	str	q0, [x0]
               	ret

<w_vshr_n_s8_lo>:
               	ldr	d0, [x1]
               	sshr	v0.8b, v0.8b, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_s8_mid>:
               	ldr	d0, [x1]
               	sshr	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_s8_hi>:
               	ldr	d0, [x1]
               	sshr	v0.8b, v0.8b, #0x8
               	str	d0, [x0]
               	ret

<w_vshrq_n_s8_lo>:
               	ldr	q0, [x1]
               	sshr	v0.16b, v0.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_s8_mid>:
               	ldr	q0, [x1]
               	sshr	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_s8_hi>:
               	ldr	q0, [x1]
               	sshr	v0.16b, v0.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vrshr_n_s8_lo>:
               	ldr	d0, [x1]
               	srshr	v0.8b, v0.8b, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_s8_mid>:
               	ldr	d0, [x1]
               	srshr	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_s8_hi>:
               	ldr	d0, [x1]
               	srshr	v0.8b, v0.8b, #0x8
               	str	d0, [x0]
               	ret

<w_vrshrq_n_s8_lo>:
               	ldr	q0, [x1]
               	srshr	v0.16b, v0.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s8_mid>:
               	ldr	q0, [x1]
               	srshr	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s8_hi>:
               	ldr	q0, [x1]
               	srshr	v0.16b, v0.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vsra_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x7
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x7
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ushl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vshlq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vrshl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urshl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vrshlq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vqshl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqshl	v0.8b, v0.8b, v1.8b
               	str	d0, [x0]
               	ret

<w_vqshlq_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vshl_n_u8_lo>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_u8_mid>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_u8_hi>:
               	ldr	d0, [x1]
               	shl	v0.8b, v0.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vshlq_n_u8_lo>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_u8_mid>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_u8_hi>:
               	ldr	q0, [x1]
               	shl	v0.16b, v0.16b, #0x7
               	str	q0, [x0]
               	ret

<w_vqshl_n_u8_lo>:
               	ldr	d0, [x1]
               	uqshl	v0.8b, v0.8b, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_u8_mid>:
               	ldr	d0, [x1]
               	uqshl	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_u8_hi>:
               	ldr	d0, [x1]
               	uqshl	v0.8b, v0.8b, #0x7
               	str	d0, [x0]
               	ret

<w_vqshlq_n_u8_lo>:
               	ldr	q0, [x1]
               	uqshl	v0.16b, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u8_mid>:
               	ldr	q0, [x1]
               	uqshl	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u8_hi>:
               	ldr	q0, [x1]
               	uqshl	v0.16b, v0.16b, #0x7
               	str	q0, [x0]
               	ret

<w_vshr_n_u8_lo>:
               	ldr	d0, [x1]
               	ushr	v0.8b, v0.8b, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_u8_mid>:
               	ldr	d0, [x1]
               	ushr	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_u8_hi>:
               	ldr	d0, [x1]
               	ushr	v0.8b, v0.8b, #0x8
               	str	d0, [x0]
               	ret

<w_vshrq_n_u8_lo>:
               	ldr	q0, [x1]
               	ushr	v0.16b, v0.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_u8_mid>:
               	ldr	q0, [x1]
               	ushr	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_u8_hi>:
               	ldr	q0, [x1]
               	ushr	v0.16b, v0.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vrshr_n_u8_lo>:
               	ldr	d0, [x1]
               	urshr	v0.8b, v0.8b, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_u8_mid>:
               	ldr	d0, [x1]
               	urshr	v0.8b, v0.8b, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_u8_hi>:
               	ldr	d0, [x1]
               	urshr	v0.8b, v0.8b, #0x8
               	str	d0, [x0]
               	ret

<w_vrshrq_n_u8_lo>:
               	ldr	q0, [x1]
               	urshr	v0.16b, v0.16b, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u8_mid>:
               	ldr	q0, [x1]
               	urshr	v0.16b, v0.16b, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u8_hi>:
               	ldr	q0, [x1]
               	urshr	v0.16b, v0.16b, #0x8
               	str	q0, [x0]
               	ret

<w_vsra_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x7
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.16b, v1.16b, #0x7
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.8b, v1.8b, #0x8
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u8_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u8_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u8_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.16b, v1.16b, #0x8
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sshl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vshlq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vrshl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srshl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vrshlq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqshl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqshl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqshlq_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vshl_n_s16_lo>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_s16_mid>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_s16_hi>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0xf
               	str	d0, [x0]
               	ret

<w_vshlq_n_s16_lo>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_s16_mid>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_s16_hi>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0xf
               	str	q0, [x0]
               	ret

<w_vqshl_n_s16_lo>:
               	ldr	d0, [x1]
               	sqshl	v0.4h, v0.4h, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_s16_mid>:
               	ldr	d0, [x1]
               	sqshl	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_s16_hi>:
               	ldr	d0, [x1]
               	sqshl	v0.4h, v0.4h, #0xf
               	str	d0, [x0]
               	ret

<w_vqshlq_n_s16_lo>:
               	ldr	q0, [x1]
               	sqshl	v0.8h, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s16_mid>:
               	ldr	q0, [x1]
               	sqshl	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s16_hi>:
               	ldr	q0, [x1]
               	sqshl	v0.8h, v0.8h, #0xf
               	str	q0, [x0]
               	ret

<w_vshr_n_s16_lo>:
               	ldr	d0, [x1]
               	sshr	v0.4h, v0.4h, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_s16_mid>:
               	ldr	d0, [x1]
               	sshr	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_s16_hi>:
               	ldr	d0, [x1]
               	sshr	v0.4h, v0.4h, #0x10
               	str	d0, [x0]
               	ret

<w_vshrq_n_s16_lo>:
               	ldr	q0, [x1]
               	sshr	v0.8h, v0.8h, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_s16_mid>:
               	ldr	q0, [x1]
               	sshr	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_s16_hi>:
               	ldr	q0, [x1]
               	sshr	v0.8h, v0.8h, #0x10
               	str	q0, [x0]
               	ret

<w_vrshr_n_s16_lo>:
               	ldr	d0, [x1]
               	srshr	v0.4h, v0.4h, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_s16_mid>:
               	ldr	d0, [x1]
               	srshr	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_s16_hi>:
               	ldr	d0, [x1]
               	srshr	v0.4h, v0.4h, #0x10
               	str	d0, [x0]
               	ret

<w_vrshrq_n_s16_lo>:
               	ldr	q0, [x1]
               	srshr	v0.8h, v0.8h, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s16_mid>:
               	ldr	q0, [x1]
               	srshr	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s16_hi>:
               	ldr	q0, [x1]
               	srshr	v0.8h, v0.8h, #0x10
               	str	q0, [x0]
               	ret

<w_vsra_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0xf
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0xf
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ushl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vshlq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vrshl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urshl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vrshlq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vqshl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqshl	v0.4h, v0.4h, v1.4h
               	str	d0, [x0]
               	ret

<w_vqshlq_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vshl_n_u16_lo>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_u16_mid>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_u16_hi>:
               	ldr	d0, [x1]
               	shl	v0.4h, v0.4h, #0xf
               	str	d0, [x0]
               	ret

<w_vshlq_n_u16_lo>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_u16_mid>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_u16_hi>:
               	ldr	q0, [x1]
               	shl	v0.8h, v0.8h, #0xf
               	str	q0, [x0]
               	ret

<w_vqshl_n_u16_lo>:
               	ldr	d0, [x1]
               	uqshl	v0.4h, v0.4h, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_u16_mid>:
               	ldr	d0, [x1]
               	uqshl	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_u16_hi>:
               	ldr	d0, [x1]
               	uqshl	v0.4h, v0.4h, #0xf
               	str	d0, [x0]
               	ret

<w_vqshlq_n_u16_lo>:
               	ldr	q0, [x1]
               	uqshl	v0.8h, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u16_mid>:
               	ldr	q0, [x1]
               	uqshl	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u16_hi>:
               	ldr	q0, [x1]
               	uqshl	v0.8h, v0.8h, #0xf
               	str	q0, [x0]
               	ret

<w_vshr_n_u16_lo>:
               	ldr	d0, [x1]
               	ushr	v0.4h, v0.4h, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_u16_mid>:
               	ldr	d0, [x1]
               	ushr	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_u16_hi>:
               	ldr	d0, [x1]
               	ushr	v0.4h, v0.4h, #0x10
               	str	d0, [x0]
               	ret

<w_vshrq_n_u16_lo>:
               	ldr	q0, [x1]
               	ushr	v0.8h, v0.8h, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_u16_mid>:
               	ldr	q0, [x1]
               	ushr	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_u16_hi>:
               	ldr	q0, [x1]
               	ushr	v0.8h, v0.8h, #0x10
               	str	q0, [x0]
               	ret

<w_vrshr_n_u16_lo>:
               	ldr	d0, [x1]
               	urshr	v0.4h, v0.4h, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_u16_mid>:
               	ldr	d0, [x1]
               	urshr	v0.4h, v0.4h, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_u16_hi>:
               	ldr	d0, [x1]
               	urshr	v0.4h, v0.4h, #0x10
               	str	d0, [x0]
               	ret

<w_vrshrq_n_u16_lo>:
               	ldr	q0, [x1]
               	urshr	v0.8h, v0.8h, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u16_mid>:
               	ldr	q0, [x1]
               	urshr	v0.8h, v0.8h, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u16_hi>:
               	ldr	q0, [x1]
               	urshr	v0.8h, v0.8h, #0x10
               	str	q0, [x0]
               	ret

<w_vsra_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.4h, v1.4h, #0xf
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.8h, v1.8h, #0xf
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.4h, v1.4h, #0x10
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u16_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u16_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u16_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sshl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vshlq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sshl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vrshl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srshl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vrshlq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srshl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqshl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqshl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqshlq_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqshl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vshl_n_s32_lo>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_s32_mid>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_s32_hi>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x1f
               	str	d0, [x0]
               	ret

<w_vshlq_n_s32_lo>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_s32_mid>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_s32_hi>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x1f
               	str	q0, [x0]
               	ret

<w_vqshl_n_s32_lo>:
               	ldr	d0, [x1]
               	sqshl	v0.2s, v0.2s, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_s32_mid>:
               	ldr	d0, [x1]
               	sqshl	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_s32_hi>:
               	ldr	d0, [x1]
               	sqshl	v0.2s, v0.2s, #0x1f
               	str	d0, [x0]
               	ret

<w_vqshlq_n_s32_lo>:
               	ldr	q0, [x1]
               	sqshl	v0.4s, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s32_mid>:
               	ldr	q0, [x1]
               	sqshl	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s32_hi>:
               	ldr	q0, [x1]
               	sqshl	v0.4s, v0.4s, #0x1f
               	str	q0, [x0]
               	ret

<w_vshr_n_s32_lo>:
               	ldr	d0, [x1]
               	sshr	v0.2s, v0.2s, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_s32_mid>:
               	ldr	d0, [x1]
               	sshr	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_s32_hi>:
               	ldr	d0, [x1]
               	sshr	v0.2s, v0.2s, #0x20
               	str	d0, [x0]
               	ret

<w_vshrq_n_s32_lo>:
               	ldr	q0, [x1]
               	sshr	v0.4s, v0.4s, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_s32_mid>:
               	ldr	q0, [x1]
               	sshr	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_s32_hi>:
               	ldr	q0, [x1]
               	sshr	v0.4s, v0.4s, #0x20
               	str	q0, [x0]
               	ret

<w_vrshr_n_s32_lo>:
               	ldr	d0, [x1]
               	srshr	v0.2s, v0.2s, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_s32_mid>:
               	ldr	d0, [x1]
               	srshr	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_s32_hi>:
               	ldr	d0, [x1]
               	srshr	v0.2s, v0.2s, #0x20
               	str	d0, [x0]
               	ret

<w_vrshrq_n_s32_lo>:
               	ldr	q0, [x1]
               	srshr	v0.4s, v0.4s, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s32_mid>:
               	ldr	q0, [x1]
               	srshr	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s32_hi>:
               	ldr	q0, [x1]
               	srshr	v0.4s, v0.4s, #0x20
               	str	q0, [x0]
               	ret

<w_vsra_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x1f
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x1f
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ushl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vshlq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vrshl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urshl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vrshlq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urshl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vqshl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqshl	v0.2s, v0.2s, v1.2s
               	str	d0, [x0]
               	ret

<w_vqshlq_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqshl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vshl_n_u32_lo>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_u32_mid>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_u32_hi>:
               	ldr	d0, [x1]
               	shl	v0.2s, v0.2s, #0x1f
               	str	d0, [x0]
               	ret

<w_vshlq_n_u32_lo>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_u32_mid>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_u32_hi>:
               	ldr	q0, [x1]
               	shl	v0.4s, v0.4s, #0x1f
               	str	q0, [x0]
               	ret

<w_vqshl_n_u32_lo>:
               	ldr	d0, [x1]
               	uqshl	v0.2s, v0.2s, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_u32_mid>:
               	ldr	d0, [x1]
               	uqshl	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_u32_hi>:
               	ldr	d0, [x1]
               	uqshl	v0.2s, v0.2s, #0x1f
               	str	d0, [x0]
               	ret

<w_vqshlq_n_u32_lo>:
               	ldr	q0, [x1]
               	uqshl	v0.4s, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u32_mid>:
               	ldr	q0, [x1]
               	uqshl	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u32_hi>:
               	ldr	q0, [x1]
               	uqshl	v0.4s, v0.4s, #0x1f
               	str	q0, [x0]
               	ret

<w_vshr_n_u32_lo>:
               	ldr	d0, [x1]
               	ushr	v0.2s, v0.2s, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_u32_mid>:
               	ldr	d0, [x1]
               	ushr	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_u32_hi>:
               	ldr	d0, [x1]
               	ushr	v0.2s, v0.2s, #0x20
               	str	d0, [x0]
               	ret

<w_vshrq_n_u32_lo>:
               	ldr	q0, [x1]
               	ushr	v0.4s, v0.4s, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_u32_mid>:
               	ldr	q0, [x1]
               	ushr	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_u32_hi>:
               	ldr	q0, [x1]
               	ushr	v0.4s, v0.4s, #0x20
               	str	q0, [x0]
               	ret

<w_vrshr_n_u32_lo>:
               	ldr	d0, [x1]
               	urshr	v0.2s, v0.2s, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_u32_mid>:
               	ldr	d0, [x1]
               	urshr	v0.2s, v0.2s, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_u32_hi>:
               	ldr	d0, [x1]
               	urshr	v0.2s, v0.2s, #0x20
               	str	d0, [x0]
               	ret

<w_vrshrq_n_u32_lo>:
               	ldr	q0, [x1]
               	urshr	v0.4s, v0.4s, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u32_mid>:
               	ldr	q0, [x1]
               	urshr	v0.4s, v0.4s, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u32_hi>:
               	ldr	q0, [x1]
               	urshr	v0.4s, v0.4s, #0x20
               	str	q0, [x0]
               	ret

<w_vsra_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.2s, v1.2s, #0x1f
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.4s, v1.4s, #0x1f
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	v0.2s, v1.2s, #0x20
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u32_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u32_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u32_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.4s, v1.4s, #0x20
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sshl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vshlq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vrshl_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	srshl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vrshlq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	srshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vqshl_s64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	sqshl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqshlq_s64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	sqshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vshl_n_s64_lo>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_s64_mid>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_s64_hi>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x3f
               	str	d0, [x0]
               	ret

<w_vshlq_n_s64_lo>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_s64_mid>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_s64_hi>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x3f
               	str	q0, [x0]
               	ret

<w_vqshl_n_s64_lo>:
               	ldr	d0, [x1]
               	sqshl	d0, d0, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_s64_mid>:
               	ldr	d0, [x1]
               	sqshl	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_s64_hi>:
               	ldr	d0, [x1]
               	sqshl	d0, d0, #0x3f
               	str	d0, [x0]
               	ret

<w_vqshlq_n_s64_lo>:
               	ldr	q0, [x1]
               	sqshl	v0.2d, v0.2d, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s64_mid>:
               	ldr	q0, [x1]
               	sqshl	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_s64_hi>:
               	ldr	q0, [x1]
               	sqshl	v0.2d, v0.2d, #0x3f
               	str	q0, [x0]
               	ret

<w_vshr_n_s64_lo>:
               	ldr	d0, [x1]
               	sshr	d0, d0, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_s64_mid>:
               	ldr	d0, [x1]
               	sshr	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_s64_hi>:
               	ldr	d0, [x1]
               	sshr	d0, d0, #0x40
               	str	d0, [x0]
               	ret

<w_vshrq_n_s64_lo>:
               	ldr	q0, [x1]
               	sshr	v0.2d, v0.2d, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_s64_mid>:
               	ldr	q0, [x1]
               	sshr	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_s64_hi>:
               	ldr	q0, [x1]
               	sshr	v0.2d, v0.2d, #0x40
               	str	q0, [x0]
               	ret

<w_vrshr_n_s64_lo>:
               	ldr	d0, [x1]
               	srshr	d0, d0, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_s64_mid>:
               	ldr	d0, [x1]
               	srshr	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_s64_hi>:
               	ldr	d0, [x1]
               	srshr	d0, d0, #0x40
               	str	d0, [x0]
               	ret

<w_vrshrq_n_s64_lo>:
               	ldr	q0, [x1]
               	srshr	v0.2d, v0.2d, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s64_mid>:
               	ldr	q0, [x1]
               	srshr	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_s64_hi>:
               	ldr	q0, [x1]
               	srshr	v0.2d, v0.2d, #0x40
               	str	q0, [x0]
               	ret

<w_vsra_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ssra	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ssra	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	srsra	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	srsra	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x3f
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x3f
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_s64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vshl_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ushl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vshlq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vrshl_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	urshl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vrshlq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	urshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vqshl_u64>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uqshl	d0, d0, d1
               	str	d0, [x0]
               	ret

<w_vqshlq_u64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uqshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0]
               	ret

<w_vshl_n_u64_lo>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x0
               	str	d0, [x0]
               	ret

<w_vshl_n_u64_mid>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vshl_n_u64_hi>:
               	ldr	d0, [x1]
               	shl	d0, d0, #0x3f
               	str	d0, [x0]
               	ret

<w_vshlq_n_u64_lo>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x0
               	str	q0, [x0]
               	ret

<w_vshlq_n_u64_mid>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vshlq_n_u64_hi>:
               	ldr	q0, [x1]
               	shl	v0.2d, v0.2d, #0x3f
               	str	q0, [x0]
               	ret

<w_vqshl_n_u64_lo>:
               	ldr	d0, [x1]
               	uqshl	d0, d0, #0x0
               	str	d0, [x0]
               	ret

<w_vqshl_n_u64_mid>:
               	ldr	d0, [x1]
               	uqshl	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vqshl_n_u64_hi>:
               	ldr	d0, [x1]
               	uqshl	d0, d0, #0x3f
               	str	d0, [x0]
               	ret

<w_vqshlq_n_u64_lo>:
               	ldr	q0, [x1]
               	uqshl	v0.2d, v0.2d, #0x0
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u64_mid>:
               	ldr	q0, [x1]
               	uqshl	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vqshlq_n_u64_hi>:
               	ldr	q0, [x1]
               	uqshl	v0.2d, v0.2d, #0x3f
               	str	q0, [x0]
               	ret

<w_vshr_n_u64_lo>:
               	ldr	d0, [x1]
               	ushr	d0, d0, #0x1
               	str	d0, [x0]
               	ret

<w_vshr_n_u64_mid>:
               	ldr	d0, [x1]
               	ushr	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vshr_n_u64_hi>:
               	ldr	d0, [x1]
               	ushr	d0, d0, #0x40
               	str	d0, [x0]
               	ret

<w_vshrq_n_u64_lo>:
               	ldr	q0, [x1]
               	ushr	v0.2d, v0.2d, #0x1
               	str	q0, [x0]
               	ret

<w_vshrq_n_u64_mid>:
               	ldr	q0, [x1]
               	ushr	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vshrq_n_u64_hi>:
               	ldr	q0, [x1]
               	ushr	v0.2d, v0.2d, #0x40
               	str	q0, [x0]
               	ret

<w_vrshr_n_u64_lo>:
               	ldr	d0, [x1]
               	urshr	d0, d0, #0x1
               	str	d0, [x0]
               	ret

<w_vrshr_n_u64_mid>:
               	ldr	d0, [x1]
               	urshr	d0, d0, #0x3
               	str	d0, [x0]
               	ret

<w_vrshr_n_u64_hi>:
               	ldr	d0, [x1]
               	urshr	d0, d0, #0x40
               	str	d0, [x0]
               	ret

<w_vrshrq_n_u64_lo>:
               	ldr	q0, [x1]
               	urshr	v0.2d, v0.2d, #0x1
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u64_mid>:
               	ldr	q0, [x1]
               	urshr	v0.2d, v0.2d, #0x5
               	str	q0, [x0]
               	ret

<w_vrshrq_n_u64_hi>:
               	ldr	q0, [x1]
               	urshr	v0.2d, v0.2d, #0x40
               	str	q0, [x0]
               	ret

<w_vsra_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsra_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	usra	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsraq_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	usra	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsra_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ursra	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vrsraq_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ursra	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x0
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	d0, d1, #0x3f
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x0
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x3f
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x1
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsri_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sri	d0, d1, #0x40
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u64_lo>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x1
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u64_mid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x5
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_u64_hi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.2d, v1.2d, #0x40
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsli_n_p8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d1, [x1]
               	ldr	d0, [x2]
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	sli	v0.8b, v1.8b, #0x3
               	str	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsriq_n_p16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sri	v0.8h, v1.8h, #0x10
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vsliq_n_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	q1, [x1]
               	ldr	q0, [x2]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sli	v0.2d, v1.2d, #0x3f
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmovn_s16>:
               	ldr	q0, [x1]
               	xtn	v0.8b, v0.8h
               	str	d0, [x0]
               	ret

<w_vqmovn_s16>:
               	ldr	q0, [x1]
               	sqxtn	v0.8b, v0.8h
               	str	d0, [x0]
               	ret

<w_vshrn_n_s16_3>:
               	ldr	q0, [x1]
               	shrn	v0.8b, v0.8h, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_s16_w>:
               	ldr	q0, [x1]
               	shrn	v0.8b, v0.8h, #0x8
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s16_1>:
               	ldr	q0, [x1]
               	rshrn	v0.8b, v0.8h, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s16_w>:
               	ldr	q0, [x1]
               	rshrn	v0.8b, v0.8h, #0x8
               	str	d0, [x0]
               	ret

<w_vmovn_high_s16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.8b, v0.8h
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_s16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtn	v0.8b, v0.8h
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vmovn_u16>:
               	ldr	q0, [x1]
               	xtn	v0.8b, v0.8h
               	str	d0, [x0]
               	ret

<w_vqmovn_u16>:
               	ldr	q0, [x1]
               	uqxtn	v0.8b, v0.8h
               	str	d0, [x0]
               	ret

<w_vshrn_n_u16_3>:
               	ldr	q0, [x1]
               	shrn	v0.8b, v0.8h, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_u16_w>:
               	ldr	q0, [x1]
               	shrn	v0.8b, v0.8h, #0x8
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u16_1>:
               	ldr	q0, [x1]
               	rshrn	v0.8b, v0.8h, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u16_w>:
               	ldr	q0, [x1]
               	rshrn	v0.8b, v0.8h, #0x8
               	str	d0, [x0]
               	ret

<w_vmovn_high_u16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.8b, v0.8h
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_u16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uqxtn	v0.8b, v0.8h
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vmovn_s32>:
               	ldr	q0, [x1]
               	xtn	v0.4h, v0.4s
               	str	d0, [x0]
               	ret

<w_vqmovn_s32>:
               	ldr	q0, [x1]
               	sqxtn	v0.4h, v0.4s
               	str	d0, [x0]
               	ret

<w_vshrn_n_s32_3>:
               	ldr	q0, [x1]
               	shrn	v0.4h, v0.4s, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_s32_w>:
               	ldr	q0, [x1]
               	shrn	v0.4h, v0.4s, #0x10
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s32_1>:
               	ldr	q0, [x1]
               	rshrn	v0.4h, v0.4s, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s32_w>:
               	ldr	q0, [x1]
               	rshrn	v0.4h, v0.4s, #0x10
               	str	d0, [x0]
               	ret

<w_vmovn_high_s32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.4h, v0.4s
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_s32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtn	v0.4h, v0.4s
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vmovn_u32>:
               	ldr	q0, [x1]
               	xtn	v0.4h, v0.4s
               	str	d0, [x0]
               	ret

<w_vqmovn_u32>:
               	ldr	q0, [x1]
               	uqxtn	v0.4h, v0.4s
               	str	d0, [x0]
               	ret

<w_vshrn_n_u32_3>:
               	ldr	q0, [x1]
               	shrn	v0.4h, v0.4s, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_u32_w>:
               	ldr	q0, [x1]
               	shrn	v0.4h, v0.4s, #0x10
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u32_1>:
               	ldr	q0, [x1]
               	rshrn	v0.4h, v0.4s, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u32_w>:
               	ldr	q0, [x1]
               	rshrn	v0.4h, v0.4s, #0x10
               	str	d0, [x0]
               	ret

<w_vmovn_high_u32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.4h, v0.4s
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_u32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uqxtn	v0.4h, v0.4s
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vmovn_s64>:
               	ldr	q0, [x1]
               	xtn	v0.2s, v0.2d
               	str	d0, [x0]
               	ret

<w_vqmovn_s64>:
               	ldr	q0, [x1]
               	sqxtn	v0.2s, v0.2d
               	str	d0, [x0]
               	ret

<w_vshrn_n_s64_3>:
               	ldr	q0, [x1]
               	shrn	v0.2s, v0.2d, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_s64_w>:
               	ldr	q0, [x1]
               	shrn	v0.2s, v0.2d, #0x20
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s64_1>:
               	ldr	q0, [x1]
               	rshrn	v0.2s, v0.2d, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_s64_w>:
               	ldr	q0, [x1]
               	rshrn	v0.2s, v0.2d, #0x20
               	str	d0, [x0]
               	ret

<w_vmovn_high_s64>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.2s, v0.2d
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_s64>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtn	v0.2s, v0.2d
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vmovn_u64>:
               	ldr	q0, [x1]
               	xtn	v0.2s, v0.2d
               	str	d0, [x0]
               	ret

<w_vqmovn_u64>:
               	ldr	q0, [x1]
               	uqxtn	v0.2s, v0.2d
               	str	d0, [x0]
               	ret

<w_vshrn_n_u64_3>:
               	ldr	q0, [x1]
               	shrn	v0.2s, v0.2d, #0x3
               	str	d0, [x0]
               	ret

<w_vshrn_n_u64_w>:
               	ldr	q0, [x1]
               	shrn	v0.2s, v0.2d, #0x20
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u64_1>:
               	ldr	q0, [x1]
               	rshrn	v0.2s, v0.2d, #0x1
               	str	d0, [x0]
               	ret

<w_vrshrn_n_u64_w>:
               	ldr	q0, [x1]
               	rshrn	v0.2s, v0.2d, #0x20
               	str	d0, [x0]
               	ret

<w_vmovn_high_u64>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	xtn	v0.2s, v0.2d
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovn_high_u64>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uqxtn	v0.2s, v0.2d
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovun_s16>:
               	ldr	q0, [x1]
               	sqxtun	v0.8b, v0.8h
               	str	d0, [x0]
               	ret

<w_vqmovun_high_s16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtun	v0.8b, v0.8h
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovun_s32>:
               	ldr	q0, [x1]
               	sqxtun	v0.4h, v0.4s
               	str	d0, [x0]
               	ret

<w_vqmovun_high_s32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtun	v0.4h, v0.4s
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vqmovun_s64>:
               	ldr	q0, [x1]
               	sqxtun	v0.2s, v0.2d
               	str	d0, [x0]
               	ret

<w_vqmovun_high_s64>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	sqxtun	v0.2s, v0.2d
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [x0]
               	ret

<w_vaddl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	saddl	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vaddl_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddl2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vaddl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uaddl	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vaddl_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddl2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vaddl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	saddl	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vaddl_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddl2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vaddl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uaddl	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vaddl_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddl2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vaddl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	saddl	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vaddl_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddl2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vaddl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	uaddl	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vaddl_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddl2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vsubl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ssubl	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vsubl_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubl2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vsubl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	usubl	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vsubl_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubl2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vsubl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ssubl	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vsubl_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubl2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vsubl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	usubl	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vsubl_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubl2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vsubl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ssubl	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vsubl_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubl2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vsubl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	usubl	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vsubl_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubl2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmull_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smull	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vmull_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smull2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmull_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umull	v0.8h, v0.8b, v1.8b
               	str	q0, [x0]
               	ret

<w_vmull_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umull2	v0.8h, v0.16b, v1.16b
               	str	q0, [x0]
               	ret

<w_vmull_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smull	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vmull_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smull2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmull_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umull	v0.4s, v0.4h, v1.4h
               	str	q0, [x0]
               	ret

<w_vmull_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umull2	v0.4s, v0.8h, v1.8h
               	str	q0, [x0]
               	ret

<w_vmull_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	smull	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vmull_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	smull2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmull_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	umull	v0.2d, v0.2s, v1.2s
               	str	q0, [x0]
               	ret

<w_vmull_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	umull2	v0.2d, v0.4s, v1.4s
               	str	q0, [x0]
               	ret

<w_vmlal_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlal	v0.8h, v1.8b, v2.8b
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlal2	v0.8h, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlal	v0.8h, v1.8b, v2.8b
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlal2	v0.8h, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlal	v0.4s, v1.4h, v2.4h
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlal2	v0.4s, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlal	v0.4s, v1.4h, v2.4h
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlal2	v0.4s, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlal	v0.2d, v1.2s, v2.2s
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlal2	v0.2d, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlal	v0.2d, v1.2s, v2.2s
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlal_high_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlal2	v0.2d, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlsl	v0.8h, v1.8b, v2.8b
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlsl2	v0.8h, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlsl	v0.8h, v1.8b, v2.8b
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlsl2	v0.8h, v1.16b, v2.16b
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlsl	v0.4s, v1.4h, v2.4h
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlsl2	v0.4s, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlsl	v0.4s, v1.4h, v2.4h
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlsl2	v0.4s, v1.8h, v2.8h
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	smlsl	v0.2d, v1.2s, v2.2s
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	smlsl2	v0.2d, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	ldr	d2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	umlsl	v0.2d, v1.2s, v2.2s
               	str	q0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmlsl_high_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	ldr	q0, [x3]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	umlsl2	v0.2d, v1.4s, v2.4s
               	str	q0, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddw_s8>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	saddw	v0.8h, v0.8h, v1.8b
               	str	q0, [x0]
               	ret

<w_vaddw_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddw2	v0.8h, v0.8h, v1.16b
               	str	q0, [x0]
               	ret

<w_vaddw_u8>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uaddw	v0.8h, v0.8h, v1.8b
               	str	q0, [x0]
               	ret

<w_vaddw_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddw2	v0.8h, v0.8h, v1.16b
               	str	q0, [x0]
               	ret

<w_vaddw_s16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	saddw	v0.4s, v0.4s, v1.4h
               	str	q0, [x0]
               	ret

<w_vaddw_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddw2	v0.4s, v0.4s, v1.8h
               	str	q0, [x0]
               	ret

<w_vaddw_u16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uaddw	v0.4s, v0.4s, v1.4h
               	str	q0, [x0]
               	ret

<w_vaddw_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddw2	v0.4s, v0.4s, v1.8h
               	str	q0, [x0]
               	ret

<w_vaddw_s32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	saddw	v0.2d, v0.2d, v1.2s
               	str	q0, [x0]
               	ret

<w_vaddw_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	saddw2	v0.2d, v0.2d, v1.4s
               	str	q0, [x0]
               	ret

<w_vaddw_u32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	uaddw	v0.2d, v0.2d, v1.2s
               	str	q0, [x0]
               	ret

<w_vaddw_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	uaddw2	v0.2d, v0.2d, v1.4s
               	str	q0, [x0]
               	ret

<w_vsubw_s8>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	ssubw	v0.8h, v0.8h, v1.8b
               	str	q0, [x0]
               	ret

<w_vsubw_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubw2	v0.8h, v0.8h, v1.16b
               	str	q0, [x0]
               	ret

<w_vsubw_u8>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	usubw	v0.8h, v0.8h, v1.8b
               	str	q0, [x0]
               	ret

<w_vsubw_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubw2	v0.8h, v0.8h, v1.16b
               	str	q0, [x0]
               	ret

<w_vsubw_s16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	ssubw	v0.4s, v0.4s, v1.4h
               	str	q0, [x0]
               	ret

<w_vsubw_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubw2	v0.4s, v0.4s, v1.8h
               	str	q0, [x0]
               	ret

<w_vsubw_u16>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	usubw	v0.4s, v0.4s, v1.4h
               	str	q0, [x0]
               	ret

<w_vsubw_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubw2	v0.4s, v0.4s, v1.8h
               	str	q0, [x0]
               	ret

<w_vsubw_s32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	ssubw	v0.2d, v0.2d, v1.2s
               	str	q0, [x0]
               	ret

<w_vsubw_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ssubw2	v0.2d, v0.2d, v1.4s
               	str	q0, [x0]
               	ret

<w_vsubw_u32>:
               	ldr	q0, [x1]
               	ldr	d1, [x2]
               	usubw	v0.2d, v0.2d, v1.2s
               	str	q0, [x0]
               	ret

<w_vsubw_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	usubw2	v0.2d, v0.2d, v1.4s
               	str	q0, [x0]
               	ret

<w_vmovl_s8>:
               	ldr	d0, [x1]
               	sshll	v0.8h, v0.8b, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_s8>:
               	ldr	q0, [x1]
               	sshll2	v0.8h, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_s8>:
               	ldr	d0, [x1]
               	saddlp	v0.4h, v0.8b
               	str	d0, [x0]
               	ret

<w_vpaddlq_s8>:
               	ldr	q0, [x1]
               	saddlp	v0.8h, v0.16b
               	str	q0, [x0]
               	ret

<w_vmovl_u8>:
               	ldr	d0, [x1]
               	ushll	v0.8h, v0.8b, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_u8>:
               	ldr	q0, [x1]
               	ushll2	v0.8h, v0.16b, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_u8>:
               	ldr	d0, [x1]
               	uaddlp	v0.4h, v0.8b
               	str	d0, [x0]
               	ret

<w_vpaddlq_u8>:
               	ldr	q0, [x1]
               	uaddlp	v0.8h, v0.16b
               	str	q0, [x0]
               	ret

<w_vmovl_s16>:
               	ldr	d0, [x1]
               	sshll	v0.4s, v0.4h, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_s16>:
               	ldr	q0, [x1]
               	sshll2	v0.4s, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_s16>:
               	ldr	d0, [x1]
               	saddlp	v0.2s, v0.4h
               	str	d0, [x0]
               	ret

<w_vpaddlq_s16>:
               	ldr	q0, [x1]
               	saddlp	v0.4s, v0.8h
               	str	q0, [x0]
               	ret

<w_vmovl_u16>:
               	ldr	d0, [x1]
               	ushll	v0.4s, v0.4h, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_u16>:
               	ldr	q0, [x1]
               	ushll2	v0.4s, v0.8h, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_u16>:
               	ldr	d0, [x1]
               	uaddlp	v0.2s, v0.4h
               	str	d0, [x0]
               	ret

<w_vpaddlq_u16>:
               	ldr	q0, [x1]
               	uaddlp	v0.4s, v0.8h
               	str	q0, [x0]
               	ret

<w_vmovl_s32>:
               	ldr	d0, [x1]
               	sshll	v0.2d, v0.2s, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_s32>:
               	ldr	q0, [x1]
               	sshll2	v0.2d, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_s32>:
               	ldr	d0, [x1]
               	saddlp	v0.1d, v0.2s
               	str	d0, [x0]
               	ret

<w_vpaddlq_s32>:
               	ldr	q0, [x1]
               	saddlp	v0.2d, v0.4s
               	str	q0, [x0]
               	ret

<w_vmovl_u32>:
               	ldr	d0, [x1]
               	ushll	v0.2d, v0.2s, #0x0
               	str	q0, [x0]
               	ret

<w_vmovl_high_u32>:
               	ldr	q0, [x1]
               	ushll2	v0.2d, v0.4s, #0x0
               	str	q0, [x0]
               	ret

<w_vpaddl_u32>:
               	ldr	d0, [x1]
               	uaddlp	v0.1d, v0.2s
               	str	d0, [x0]
               	ret

<w_vpaddlq_u32>:
               	ldr	q0, [x1]
               	uaddlp	v0.2d, v0.4s
               	str	q0, [x0]
               	ret

<w_vaddv_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	addv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	addv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	saddlv	h0, v1.8b
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlvq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	saddlv	h0, v1.16b
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxv_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	smaxv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	smaxv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	sminv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	sminv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldursb	x1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddv_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	addv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	addv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	uaddlv	h0, v1.8b
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlvq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	uaddlv	h0, v1.16b
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxv_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	umaxv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	umaxv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	uminv	b0, v1.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	uminv	b0, v1.16b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddv_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	addv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	addv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	saddlv	s0, v0.4h
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlvq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	saddlv	s0, v0.8h
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxv_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	smaxv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	smaxv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	sminv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	sminv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddv_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	addv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	addv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	uaddlv	s0, v0.4h
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlvq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	uaddlv	s0, v0.8h
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxv_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	umaxv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	umaxv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldr	d1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d1, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	uminv	h0, v1.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	ldr	q1, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldur	q1, [sp, #0x8]
               	uminv	h0, v1.8h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldurh	w1, [x29, #-0x8]
               	strh	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddv_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	addp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	addv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_s32>:
               	ldr	d0, [x1]
               	saddlp	v0.1d, v0.2s
               	str	d0, [x0]
               	ret

<w_vaddlvq_s32>:
               	ldr	q0, [x1]
               	saddlv	d0, v0.4s
               	str	d0, [x0]
               	ret

<w_vmaxv_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	smaxp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	smaxv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	sminp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	sminv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddv_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	addp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	addv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddlv_u32>:
               	ldr	d0, [x1]
               	uaddlp	v0.1d, v0.2s
               	str	d0, [x0]
               	ret

<w_vaddlvq_u32>:
               	ldr	q0, [x1]
               	uaddlv	d0, v0.4s
               	str	d0, [x0]
               	ret

<w_vmaxv_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	umaxp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vmaxvq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	umaxv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminv_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	d0, [x1]
               	uminp	v0.2s, v0.2s, v0.2s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vminvq_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldr	q0, [x1]
               	uminv	s0, v0.4s
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	str	w1, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<w_vaddvq_s64>:
               	ldr	q0, [x1]
               	addp	d0, v0.2d
               	str	d0, [x0]
               	ret

<w_vaddvq_u64>:
               	ldr	q0, [x1]
               	addp	d0, v0.2d
               	str	d0, [x0]
               	ret

<lane>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w2
               	mov	x21, x3
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
               	cbz	w21, <addr>
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

<sat>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x0, [x29, #-0x70]
               	sub	x7, x29, #0x70
               	stur	x1, [x29, #-0x68]
               	cbz	w3, <addr>
               	mov	x1, #0x1                // =1
               	mov	x8, #0x0                // =0
               	sub	x0, x2, #0x1
               	and	x4, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x5, #0x3f               // =63
               	sub	x9, x5, x0
               	lsr	x4, x4, #6
               	neg	x4, x4
               	mvn	x5, x4
               	lsl	x6, x1, x0
               	lsr	x1, x1, x9
               	lsl	x0, x8, x0
               	orr	x1, x0, x1, lsr #1
               	and	x0, x6, x5
               	and	x1, x1, x5
               	and	x4, x6, x4
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, hi
               	neg	x5, x0
               	neg	x0, x1
               	sub	x1, x0, x4
               	sub	x0, x29, #0x40
               	stur	x5, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	cbz	w3, <addr>
               	mov	x3, #0x1                // =1
               	mov	x6, #0x0                // =0
               	sub	x0, x2, #0x1
               	and	x2, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x8, x4, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsl	x5, x3, x0
               	lsr	x3, x3, x8
               	lsl	x0, x6, x0
               	orr	x3, x0, x3, lsr #1
               	and	x0, x5, x4
               	and	x3, x3, x4
               	and	x2, x5, x2
               	orr	x2, x3, x2
               	cmp	x0, #0x1
               	cset	x3, lo
               	sub	x4, x0, #0x1
               	sub	x2, x2, x3
               	sub	x0, x29, #0x20
               	stur	x4, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldur	x3, [x29, #-0x70]
               	ldur	x0, [x29, #-0x68]
               	ldur	x5, [x29, #-0x60]
               	ldur	x4, [x29, #-0x58]
               	cmp	x0, x4
               	cset	x6, lt
               	cmp	x0, x4
               	cset	x4, eq
               	cmp	x3, x5
               	cset	x5, lo
               	and	x4, x4, x5
               	orr	x4, x6, x4
               	cbz	x4, <addr>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x4, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	cmp	x1, x0
               	cset	x5, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x5, x0
               	cmp	x0, #0x0
               	csel	x1, x2, x7, ne
               	b	<addr>
               	mov	x3, #0x1                // =1
               	mov	x6, #0x0                // =0
               	and	x4, x2, #0x7f
               	and	x0, x2, #0x3f
               	mov	x2, #0x3f               // =63
               	sub	x8, x2, x0
               	lsr	x2, x4, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsl	x5, x3, x0
               	lsr	x3, x3, x8
               	lsl	x0, x6, x0
               	orr	x3, x0, x3, lsr #1
               	and	x0, x5, x4
               	and	x3, x3, x4
               	and	x2, x5, x2
               	orr	x2, x3, x2
               	cmp	x0, #0x1
               	cset	x3, lo
               	sub	x4, x0, #0x1
               	sub	x2, x2, x3
               	sub	x0, x29, #0x10
               	stur	x4, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	b	<addr>
               	sub	x0, x29, #0x30
               	stur	xzr, [x29, #-0x30]
               	stur	xzr, [x29, #-0x28]
               	b	<addr>

<shift_by>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	cbz	w5, <addr>
               	mov	x4, #0x1                // =1
               	mov	x8, #0x0                // =0
               	mvn	x3, x2
               	and	x5, x3, #0x7f
               	and	x3, x3, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x3
               	lsr	x5, x5, #6
               	neg	x5, x5
               	mvn	x6, x5
               	lsl	x7, x4, x3
               	lsr	x4, x4, x9
               	lsl	x3, x8, x3
               	orr	x3, x3, x4, lsr #1
               	and	x4, x7, x6
               	and	x3, x3, x6
               	and	x5, x7, x5
               	orr	x5, x3, x5
               	sub	x3, x29, #0x70
               	stur	x4, [x29, #-0x70]
               	stur	x5, [x29, #-0x68]
               	ldr	x4, [x3]
               	ldr	x5, [x3, #0x8]
               	add	x3, x0, x4
               	cmp	x3, x0
               	cset	x0, lo
               	add	x1, x1, x5
               	add	x0, x1, x0
               	neg	x1, x2
               	and	x2, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x6, x4, x1
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x4, x2
               	asr	x5, x0, x1
               	lsl	x6, x0, x6
               	lsr	x1, x3, x1
               	orr	x1, x1, x6, lsl #1
               	and	x1, x1, x4
               	and	x3, x5, x2
               	orr	x1, x1, x3
               	and	x3, x5, x4
               	and	x0, x2, x0, asr #63
               	orr	x0, x3, x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	stur	xzr, [x29, #-0x60]
               	stur	xzr, [x29, #-0x58]
               	b	<addr>
               	cbz	w6, <addr>
               	orr	x5, x0, x1
               	cbnz	x5, <addr>
               	sub	x0, x29, #0x50
               	stur	xzr, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, w3
               	b.lt	<addr>
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x3, #0x7f
               	and	x0, x3, #0x3f
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x5, x2
               	lsl	x6, x1, x0
               	lsr	x1, x1, x8
               	lsl	x0, x7, x0
               	orr	x1, x0, x1, lsr #1
               	and	x0, x6, x5
               	and	x1, x1, x5
               	and	x2, x6, x2
               	orr	x1, x1, x2
               	cmp	x0, #0x0
               	cset	x2, hi
               	neg	x5, x0
               	neg	x0, x1
               	sub	x1, x0, x2
               	sub	x0, x29, #0x40
               	stur	x5, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	mov	x2, x3
               	mov	x3, x4
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0xa0]
               	sub	x0, x29, #0xa0
               	stur	x1, [x29, #-0x98]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x3, #0x7f
               	and	x0, x3, #0x3f
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x5, x2
               	lsl	x6, x1, x0
               	lsr	x1, x1, x8
               	lsl	x0, x7, x0
               	orr	x0, x0, x1, lsr #1
               	and	x1, x6, x5
               	and	x0, x0, x5
               	and	x2, x6, x2
               	orr	x2, x0, x2
               	sub	x0, x29, #0x30
               	stur	x1, [x29, #-0x30]
               	stur	x2, [x29, #-0x28]
               	b	<addr>
               	mov	x5, #0x1                // =1
               	mov	x9, #0x0                // =0
               	and	x6, x2, #0x7f
               	and	x2, x2, #0x3f
               	mov	x7, #0x3f               // =63
               	sub	x10, x7, x2
               	lsr	x6, x6, #6
               	neg	x6, x6
               	mvn	x7, x6
               	lsl	x8, x5, x2
               	lsr	x5, x5, x10
               	lsl	x2, x9, x2
               	orr	x5, x2, x5, lsr #1
               	and	x2, x8, x7
               	and	x5, x5, x7
               	and	x6, x8, x6
               	orr	x5, x5, x6
               	mul	x6, x0, x2
               	umulh	x7, x0, x2
               	madd	x0, x0, x5, x7
               	madd	x1, x1, x2, x0
               	sub	x0, x29, #0x80
               	stur	x6, [x29, #-0x80]
               	stur	x1, [x29, #-0x78]
               	mov	x2, x3
               	mov	x3, x4
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x90]
               	sub	x0, x29, #0x90
               	stur	x1, [x29, #-0x88]
               	b	<addr>
               	cmp	w2, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x3, x2, #0x7f
               	and	x2, x2, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x6, x4, x2
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x4, x3
               	lsl	x5, x0, x2
               	lsr	x0, x0, x6
               	lsl	x1, x1, x2
               	orr	x0, x1, x0, lsr #1
               	and	x1, x5, x4
               	and	x0, x0, x4
               	and	x2, x5, x3
               	orr	x2, x0, x2
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2f0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	mov	x1, #0xf491             // =62609
               	movk	x1, #0x2545, lsl #16
               	mov	x0, #0x20               // =32
               	eor	x1, x1, x1, lsl #13
               	mov	w1, w1
               	eor	x1, x1, x1, lsr #17
               	eor	x1, x1, x1, lsl #5
               	mov	w3, w1
               	ubfx	x3, x3, #5, #8
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x60
               	b.lo	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x278]
               	ldr	x17, [sp, #0x278]
               	str	x17, [sp, #0x2d8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [sp, #0x278]
               	mov	x17, #0x28              // =40
               	mul	x1, x16, x17
               	add	x22, x0, x1
               	ldrsw	x20, [x22, #0x10]
               	ldrsw	x23, [x22, #0x14]
               	ldrsw	x27, [x22, #0x18]
               	ldrsw	x25, [x22, #0x1c]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x280]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x288]
               	ldr	x0, [sp, #0x288]
               	cmp	w0, #0x6
               	b.ge	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [sp, #0x280]
               	add	x26, x1, x2, lsl #4
               	add	x2, x2, x0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x6               // =6
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	add	x16, x1, x2, lsl #4
               	str	x16, [sp, #0x290]
               	sub	x2, x29, #0x2a0
               	add	x0, x1, x0, lsl #4
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x2
               	b.gt	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w27
               	b.ge	<addr>
               	mul	x1, x0, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x1, x1, #3
               	ldr	x16, [sp, #0x288]
               	mov	x17, #0x7               // =7
               	mul	x3, x16, x17
               	mov	x17, #0x5               // =5
               	mul	x4, x0, x17
               	add	x3, x3, x4
               	lsl	x4, x20, #1
               	add	x4, x4, #0x5
               	sdiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	add	x4, x20, #0x2
               	sub	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x1]
               	add	x0, x0, #0x1
               	cmp	w0, w27
               	b.lt	<addr>
               	ldr	x4, [x22]
               	sub	x0, x29, #0x290
               	sub	x2, x29, #0x2a0
               	mov	x1, x26
               	ldr	x3, [sp, #0x290]
               	blr	x4
               	mov	x24, #0x0               // =0
               	cmp	w24, w27
               	b.ge	<addr>
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x24
               	bl	<addr>
               	str	x0, [sp, #0xa0]
               	sub	x0, x29, #0x250
               	str	x1, [sp, #0xa8]
               	sub	x1, x29, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x2a0
               	mov	x1, x24
               	mov	x3, x23
               	mov	x2, x20
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x2c0]
               	mov	x16, x1
               	str	x16, [sp, #0x2b8]
               	ldr	x16, [sp, #0x2c0]
               	str	x16, [sp, #0xb0]
               	ldr	x16, [sp, #0x2b8]
               	str	x16, [sp, #0xb8]
               	mov	x3, #0x0                // =0
               	str	x3, [sp, #0x80]
               	str	x3, [sp, #0x88]
               	mov	x0, x26
               	mov	x2, x20
               	mov	x1, x24
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x2b0]
               	mov	x16, x1
               	str	x16, [sp, #0x2a8]
               	ldr	x16, [sp, #0x2b0]
               	str	x16, [sp, #0xc0]
               	ldr	x16, [sp, #0x2a8]
               	str	x16, [sp, #0xc8]
               	sub	x0, x29, #0x2a0
               	mov	x3, #0x0                // =0
               	mov	x1, x24
               	mov	x2, x20
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x2a0]
               	mov	x16, x1
               	str	x16, [sp, #0x298]
               	ldr	x16, [sp, #0x2a0]
               	str	x16, [sp, #0xd0]
               	ldr	x16, [sp, #0x298]
               	str	x16, [sp, #0xd8]
               	ldrsw	x0, [x22, #0x20]
               	madd	x1, x0, x27, x24
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	bl	<addr>
               	mov	x28, x0
               	mov	x16, x1
               	str	x16, [sp, #0x2c8]
               	str	x28, [sp, #0xe0]
               	ldr	x16, [sp, #0x2c8]
               	str	x16, [sp, #0xe8]
               	sub	x0, x29, #0x2a0
               	ldrsw	x1, [x22, #0x20]
               	madd	x1, x1, x27, x24
               	mov	x2, x20
               	mov	x3, x23
               	bl	<addr>
               	mov	x21, x0
               	mov	x16, x1
               	str	x16, [sp, #0x2d0]
               	str	x21, [sp, #0xf0]
               	ldr	x16, [sp, #0x2d0]
               	str	x16, [sp, #0xf8]
               	ldrsw	x0, [x22, #0xc]
               	cmp	x0, #0x1c
               	b.hs	<addr>
               	adrp	x17, <addr>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	sub	x2, x29, #0x2a0
               	mul	x1, x24, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x1, x1, #3
               	ldrb	w1, [x2, x1]
               	sxtb	x2, w1
               	mov	x5, #0x0                // =0
               	mov	x3, x20
               	mov	x6, x5
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x100]
               	sub	x0, x29, #0x1f0
               	str	x1, [sp, #0x108]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0xb
               	b.lt	<addr>
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x12
               	b.gt	<addr>
               	add	x1, x20, x20, lsr #63
               	asr	x21, x1, #1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x0, x27, x27, lsr #63
               	asr	x28, x0, #1
               	sub	x0, x27, x28
               	cmp	w24, w0
               	b.ge	<addr>
               	cbz	x28, <addr>
               	sub	x0, x29, #0x290
               	mov	x3, #0x0                // =0
               	mov	x1, x24
               	mov	x2, x21
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x2d0]
               	mov	x16, x1
               	str	x16, [sp, #0x2c8]
               	ldr	x16, [sp, #0x2d0]
               	stur	x16, [x29, #-0xc0]
               	ldr	x16, [sp, #0x2c8]
               	stur	x16, [x29, #-0xb8]
               	sub	x0, x29, #0x2a0
               	mov	x3, #0x0                // =0
               	mov	x1, x24
               	mov	x2, x21
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldr	x16, [sp, #0x2d0]
               	eor	x0, x16, x0
               	ldr	x16, [sp, #0x2c8]
               	eor	x1, x16, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	ldrsw	x0, [x22, #0x8]
               	ldr	x16, [sp, #0x2d8]
               	orr	x16, x16, x0
               	str	x16, [sp, #0x2d8]
               	ldr	x17, [sp, #0x80]
               	str	x17, [sp, #0x2d0]
               	ldr	x17, [sp, #0x88]
               	str	x17, [sp, #0x2c8]
               	sub	x0, x29, #0x290
               	add	x1, x28, x24
               	mov	x3, #0x0                // =0
               	mov	x2, x21
               	bl	<addr>
               	stur	x0, [x29, #-0xa0]
               	stur	x1, [x29, #-0x98]
               	ldr	x16, [sp, #0x2d0]
               	eor	x5, x16, x0
               	ldr	x16, [sp, #0x2c8]
               	eor	x6, x16, x1
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x21, #0x7f
               	and	x0, x21, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x8, x3, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	lsl	x4, x1, x0
               	lsr	x1, x1, x8
               	lsl	x0, x7, x0
               	orr	x1, x0, x1, lsr #1
               	and	x0, x4, x3
               	and	x1, x1, x3
               	and	x2, x4, x2
               	orr	x1, x1, x2
               	cmp	x0, #0x1
               	cset	x2, lo
               	sub	x0, x0, #0x1
               	sub	x1, x1, x2
               	and	x0, x5, x0
               	and	x1, x6, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	ldrsw	x0, [x22, #0x8]
               	ldr	x16, [sp, #0x2d8]
               	orr	x16, x16, x0
               	str	x16, [sp, #0x2d8]
               	b	<addr>
               	mov	x28, #0x0               // =0
               	b	<addr>
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x13
               	b.lt	<addr>
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x1b
               	b.gt	<addr>
               	lsl	x21, x20, #1
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x1c
               	b.lt	<addr>
               	lsl	x1, x20, #1
               	cmp	w0, #0x1d
               	csel	x21, x1, x20, eq
               	cbnz	x24, <addr>
               	ldr	x28, [sp, #0x80]
               	ldr	x17, [sp, #0x88]
               	str	x17, [sp, #0x2d0]
               	sub	x0, x29, #0x290
               	mov	x3, #0x0                // =0
               	mov	x1, x24
               	mov	x2, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x90]
               	stur	x1, [x29, #-0x88]
               	eor	x5, x28, x0
               	ldr	x16, [sp, #0x2d0]
               	eor	x6, x16, x1
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x21, #0x7f
               	and	x0, x21, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x8, x3, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	lsl	x4, x1, x0
               	lsr	x1, x1, x8
               	lsl	x0, x7, x0
               	orr	x1, x0, x1, lsr #1
               	and	x0, x4, x3
               	and	x1, x1, x3
               	and	x2, x4, x2
               	orr	x1, x1, x2
               	cmp	x0, #0x1
               	cset	x2, lo
               	sub	x0, x0, #0x1
               	sub	x1, x1, x2
               	and	x0, x5, x0
               	and	x1, x6, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	ldrsw	x0, [x22, #0x8]
               	ldr	x16, [sp, #0x2d8]
               	orr	x16, x16, x0
               	str	x16, [sp, #0x2d8]
               	b	<addr>
               	mov	x21, x20
               	b	<addr>
               	mov	x21, x20
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	sub	x2, x29, #0x2a0
               	mul	x1, x24, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x1, x1, #3
               	ldrb	w1, [x2, x1]
               	sxtb	x2, w1
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	mov	x3, x20
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x110]
               	sub	x0, x29, #0x1e0
               	str	x1, [sp, #0x118]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	sub	x2, x29, #0x2a0
               	mul	x1, x24, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x1, x1, #3
               	ldrb	w1, [x2, x1]
               	sxtb	x2, w1
               	mov	x5, #0x0                // =0
               	mov	x6, #0x1                // =1
               	mov	x3, x20
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x120]
               	sub	x0, x29, #0x1d0
               	str	x1, [sp, #0x128]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	mov	x5, #0x0                // =0
               	mov	x2, x25
               	mov	x6, x5
               	mov	x4, x23
               	mov	x3, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x130]
               	sub	x0, x29, #0x1c0
               	str	x1, [sp, #0x138]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	mov	x5, #0x0                // =0
               	mov	x6, #0x1                // =1
               	mov	x2, x25
               	mov	x4, x23
               	mov	x3, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x140]
               	sub	x0, x29, #0x1b0
               	str	x1, [sp, #0x148]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	neg	x2, x25
               	mov	x5, #0x0                // =0
               	mov	x3, x20
               	mov	x6, x5
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x150]
               	sub	x0, x29, #0x1a0
               	str	x1, [sp, #0x158]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	neg	x2, x25
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	mov	x3, x20
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x160]
               	sub	x0, x29, #0x190
               	str	x1, [sp, #0x168]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x0, x29, #0x280
               	neg	x2, x25
               	mov	x5, #0x0                // =0
               	mov	x3, x20
               	mov	x6, x5
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x170]
               	str	x1, [sp, #0x178]
               	ldr	x2, [sp, #0x2c0]
               	add	x0, x2, x0
               	cmp	x0, x2
               	cset	x2, lo
               	ldr	x16, [sp, #0x2b8]
               	add	x1, x16, x1
               	add	x1, x1, x2
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	sub	x0, x29, #0x280
               	neg	x2, x25
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	mov	x3, x20
               	mov	x4, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x180]
               	str	x1, [sp, #0x188]
               	ldr	x2, [sp, #0x2c0]
               	add	x0, x2, x0
               	cmp	x0, x2
               	cset	x2, lo
               	ldr	x16, [sp, #0x2b8]
               	add	x1, x16, x1
               	add	x1, x1, x2
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	and	x2, x25, #0x7f
               	and	x0, x25, #0x3f
               	mov	x1, #0x3f               // =63
               	sub	x6, x1, x0
               	lsr	x2, x2, #6
               	mov	x7, #0x0                // =0
               	neg	x2, x2
               	mvn	x3, x2
               	ldr	x4, [sp, #0x2b0]
               	lsl	x5, x4, x0
               	lsr	x4, x4, x6
               	ldr	x16, [sp, #0x2a8]
               	lsl	x0, x16, x0
               	orr	x0, x0, x4, lsr #1
               	and	x6, x5, x3
               	and	x0, x0, x3
               	and	x2, x5, x2
               	orr	x5, x0, x2
               	mov	x2, #0x1                // =1
               	and	x3, x25, #0x7f
               	and	x0, x25, #0x3f
               	sub	x8, x1, x0
               	lsr	x1, x3, #6
               	neg	x1, x1
               	mvn	x3, x1
               	lsl	x4, x2, x0
               	lsr	x2, x2, x8
               	lsl	x0, x7, x0
               	orr	x2, x0, x2, lsr #1
               	and	x0, x4, x3
               	and	x2, x2, x3
               	and	x1, x4, x1
               	orr	x1, x2, x1
               	cmp	x0, #0x1
               	cset	x2, lo
               	sub	x0, x0, #0x1
               	sub	x1, x1, x2
               	ldr	x16, [sp, #0x2a0]
               	and	x0, x16, x0
               	ldr	x16, [sp, #0x298]
               	and	x1, x16, x1
               	orr	x0, x6, x0
               	orr	x1, x5, x1
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	and	x2, x25, #0x7f
               	and	x0, x25, #0x3f
               	mov	x1, #0x3f               // =63
               	sub	x6, x1, x0
               	lsr	x2, x2, #6
               	mov	x7, #0x0                // =0
               	neg	x2, x2
               	mvn	x4, x2
               	ldr	x3, [sp, #0x2a8]
               	asr	x5, x3, x0
               	lsl	x6, x3, x6
               	ldr	x16, [sp, #0x2b0]
               	lsr	x0, x16, x0
               	orr	x0, x0, x6, lsl #1
               	and	x0, x0, x4
               	and	x6, x5, x2
               	orr	x6, x0, x6
               	and	x0, x5, x4
               	and	x2, x2, x3, asr #63
               	orr	x8, x0, x2
               	mov	x2, #0x1                // =1
               	and	x3, x20, #0x7f
               	and	x0, x20, #0x3f
               	sub	x9, x1, x0
               	lsr	x3, x3, #6
               	neg	x3, x3
               	mvn	x4, x3
               	lsl	x5, x2, x0
               	lsr	x2, x2, x9
               	lsl	x0, x7, x0
               	orr	x2, x0, x2, lsr #1
               	and	x0, x5, x4
               	and	x2, x2, x4
               	and	x3, x5, x3
               	orr	x2, x2, x3
               	cmp	x0, #0x1
               	cset	x3, lo
               	sub	x5, x0, #0x1
               	sub	x0, x2, x3
               	and	x3, x25, #0x7f
               	and	x2, x25, #0x3f
               	sub	x7, x1, x2
               	lsr	x1, x3, #6
               	neg	x1, x1
               	mvn	x3, x1
               	asr	x4, x0, x2
               	lsl	x7, x0, x7
               	lsr	x2, x5, x2
               	orr	x2, x2, x7, lsl #1
               	and	x2, x2, x3
               	and	x5, x4, x1
               	orr	x2, x2, x5
               	and	x3, x4, x3
               	and	x0, x1, x0, asr #63
               	orr	x0, x3, x0
               	mvn	x1, x2
               	mvn	x0, x0
               	ldr	x16, [sp, #0x2a0]
               	and	x1, x16, x1
               	ldr	x16, [sp, #0x298]
               	and	x0, x16, x0
               	orr	x1, x6, x1
               	orr	x0, x8, x0
               	str	x1, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	sub	x0, x29, #0x270
               	sub	x1, x29, #0x280
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	add	x1, x20, x20, lsr #63
               	asr	x2, x1, #1
               	mov	x3, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x190]
               	sub	x0, x29, #0x160
               	str	x1, [sp, #0x198]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	sub	x21, x29, #0x270
               	sub	x0, x29, #0x280
               	add	x1, x20, x20, lsr #63
               	asr	x2, x1, #1
               	mov	x3, #0x0                // =0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	str	x0, [sp, #0x1a0]
               	sub	x0, x29, #0x150
               	str	x1, [sp, #0x1a8]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	b	<addr>
               	ldr	x5, [sp, #0x70]
               	ldr	x0, [sp, #0x78]
               	and	x2, x25, #0x7f
               	and	x1, x25, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x6, x3, x1
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	asr	x4, x0, x1
               	lsl	x6, x0, x6
               	lsr	x1, x5, x1
               	orr	x1, x1, x6, lsl #1
               	and	x1, x1, x3
               	and	x5, x4, x2
               	orr	x1, x1, x5
               	and	x3, x4, x3
               	and	x0, x2, x0, asr #63
               	orr	x0, x3, x0
               	str	x1, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	ldr	x1, [sp, #0x70]
               	ldr	x7, [sp, #0x78]
               	mov	x2, #0x1                // =1
               	mov	x8, #0x0                // =0
               	sub	x0, x25, #0x1
               	and	x4, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x9, x3, x0
               	lsr	x4, x4, #6
               	neg	x4, x4
               	mvn	x5, x4
               	lsl	x6, x2, x0
               	lsr	x2, x2, x9
               	lsl	x0, x8, x0
               	orr	x0, x0, x2, lsr #1
               	and	x2, x6, x5
               	and	x0, x0, x5
               	and	x4, x6, x4
               	orr	x0, x0, x4
               	add	x4, x1, x2
               	cmp	x4, x1
               	cset	x1, lo
               	add	x0, x7, x0
               	add	x0, x0, x1
               	and	x2, x25, #0x7f
               	and	x1, x25, #0x3f
               	sub	x6, x3, x1
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	asr	x5, x0, x1
               	lsl	x6, x0, x6
               	lsr	x1, x4, x1
               	orr	x1, x1, x6, lsl #1
               	and	x1, x1, x3
               	and	x4, x5, x2
               	orr	x1, x1, x4
               	and	x3, x5, x3
               	and	x0, x2, x0, asr #63
               	orr	x0, x3, x0
               	str	x1, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	add	x0, x28, x21
               	cmp	x0, x28
               	cset	x1, lo
               	ldr	x16, [sp, #0x2c8]
               	ldr	x17, [sp, #0x2d0]
               	add	x2, x16, x17
               	add	x1, x2, x1
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	cmp	x28, x21
               	cset	x0, lo
               	sub	x1, x28, x21
               	ldr	x16, [sp, #0x2c8]
               	ldr	x17, [sp, #0x2d0]
               	sub	x2, x16, x17
               	sub	x0, x2, x0
               	str	x1, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	mul	x0, x28, x21
               	umulh	x1, x28, x21
               	ldr	x16, [sp, #0x2d0]
               	madd	x1, x28, x16, x1
               	ldr	x16, [sp, #0x2c8]
               	madd	x1, x16, x21, x1
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	lsl	x2, x20, #1
               	mov	x1, x24
               	mov	x3, x23
               	ldr	x0, [sp, #0x290]
               	bl	<addr>
               	str	x0, [sp, #0x1b0]
               	str	x1, [sp, #0x1b8]
               	umulh	x2, x28, x21
               	ldr	x16, [sp, #0x2d0]
               	madd	x2, x28, x16, x2
               	ldr	x16, [sp, #0x2c8]
               	madd	x3, x16, x21, x2
               	madd	x2, x28, x21, x0
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x3
               	add	x0, x1, x0
               	str	x2, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	lsl	x2, x20, #1
               	mov	x1, x24
               	mov	x3, x23
               	ldr	x0, [sp, #0x290]
               	bl	<addr>
               	str	x0, [sp, #0x1c0]
               	str	x1, [sp, #0x1c8]
               	mul	x2, x28, x21
               	umulh	x3, x28, x21
               	ldr	x16, [sp, #0x2d0]
               	madd	x3, x28, x16, x3
               	ldr	x16, [sp, #0x2c8]
               	madd	x3, x16, x21, x3
               	cmp	x0, x2
               	cset	x4, lo
               	sub	x0, x0, x2
               	sub	x1, x1, x3
               	sub	x1, x1, x4
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	lsl	x2, x20, #1
               	mov	x0, x26
               	mov	x3, x23
               	mov	x1, x24
               	bl	<addr>
               	str	x0, [sp, #0x1d0]
               	str	x1, [sp, #0x1d8]
               	add	x2, x0, x21
               	cmp	x2, x0
               	cset	x0, lo
               	ldr	x17, [sp, #0x2d0]
               	add	x1, x1, x17
               	add	x0, x1, x0
               	str	x2, [sp, #0x80]
               	str	x0, [sp, #0x88]
               	b	<addr>
               	lsl	x2, x20, #1
               	mov	x0, x26
               	mov	x3, x23
               	mov	x1, x24
               	bl	<addr>
               	str	x0, [sp, #0x1e0]
               	str	x1, [sp, #0x1e8]
               	cmp	x0, x21
               	cset	x2, lo
               	sub	x0, x0, x21
               	ldr	x17, [sp, #0x2d0]
               	sub	x1, x1, x17
               	sub	x1, x1, x2
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	str	x28, [sp, #0x80]
               	ldr	x16, [sp, #0x2c8]
               	str	x16, [sp, #0x88]
               	b	<addr>
               	lsl	x1, x24, #1
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x28, x1
               	stur	x21, [x29, #-0x100]
               	stur	x28, [x29, #-0xf8]
               	lsl	x0, x24, #1
               	add	x1, x0, #0x1
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	bl	<addr>
               	stur	x0, [x29, #-0xf0]
               	stur	x1, [x29, #-0xe8]
               	add	x0, x21, x0
               	cmp	x0, x21
               	cset	x2, lo
               	add	x1, x28, x1
               	add	x1, x1, x2
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	b	<addr>
               	sub	x21, x29, #0x270
               	mov	x1, #0x0                // =0
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	bl	<addr>
               	stur	x0, [x29, #-0xe0]
               	sub	x0, x29, #0xe0
               	stur	x1, [x29, #-0xd8]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	mov	x21, #0x1               // =1
               	cmp	w21, w27
               	b.ge	<addr>
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0xd0]
               	sub	x0, x29, #0xd0
               	stur	x1, [x29, #-0xc8]
               	sub	x1, x29, #0x260
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x270
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x1e
               	b.ne	<addr>
               	ldr	x3, [sp, #0x90]
               	ldr	x0, [sp, #0x98]
               	ldr	x4, [sp, #0x80]
               	ldr	x1, [sp, #0x88]
               	cmp	x1, x0
               	cset	x5, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x5, x0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x260
               	b	<addr>
               	sub	x0, x29, #0x270
               	b	<addr>
               	ldrsw	x0, [x22, #0xc]
               	cmp	w0, #0x1f
               	b.ne	<addr>
               	ldr	x3, [sp, #0x90]
               	ldr	x0, [sp, #0x98]
               	ldr	x4, [sp, #0x80]
               	ldr	x1, [sp, #0x88]
               	cmp	x0, x1
               	cset	x5, lt
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x5, x0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x260
               	b	<addr>
               	sub	x0, x29, #0x270
               	b	<addr>
               	ldr	x0, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	ldr	x1, [sp, #0x90]
               	ldr	x4, [sp, #0x98]
               	add	x1, x0, x1
               	cmp	x1, x0
               	cset	x0, lo
               	add	x3, x3, x4
               	add	x3, x3, x0
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	add	x21, x21, #0x1
               	cmp	w21, w27
               	b.ge	<addr>
               	b	<addr>
               	add	x24, x24, #0x1
               	cmp	w24, w27
               	b.lt	<addr>
               	ldr	x16, [sp, #0x288]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0x288]
               	ldr	x0, [sp, #0x288]
               	cmp	w0, #0x6
               	b.lt	<addr>
               	ldr	x16, [sp, #0x280]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0x280]
               	ldr	x16, [sp, #0x280]
               	cmp	w16, #0x6
               	b.lt	<addr>
               	ldr	x16, [sp, #0x278]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0x278]
               	ldr	x16, [sp, #0x278]
               	cmp	w16, #0x287
               	b.lo	<addr>
               	ldr	x16, [sp, #0x2d8]
               	mov	x0, x16
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
