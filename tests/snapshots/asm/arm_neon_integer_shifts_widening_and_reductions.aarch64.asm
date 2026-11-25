
arm_neon_integer_shifts_widening_and_reductions.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_s8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_s8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_s8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_s8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x7
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_s8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x7
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_s8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_s8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_u8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_u8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_u8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_u8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x7
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_u8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.16b, v0.16b, #0x7
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_u8_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u8_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u8_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8b, v0.8b, #0x8
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_u8_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u8_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u8_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.16b, v0.16b, #0x8
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_s16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_s16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_s16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_s16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0xf
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_s16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0xf
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_s16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_s16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_u16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_u16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_u16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_u16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4h, v0.4h, #0xf
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_u16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8h, v0.8h, #0xf
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_u16_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u16_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u16_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4h, v0.4h, #0x10
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_u16_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u16_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u16_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_s32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_s32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_s32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_s32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x1f
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_s32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x1f
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_s32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_s32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_u32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_u32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_u32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_u32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2s, v0.2s, #0x1f
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_u32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.4s, v0.4s, #0x1f
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_u32_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u32_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u32_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2s, v0.2s, #0x20
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_u32_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u32_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u32_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.4s, v0.4s, #0x20
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_s64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_s64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_s64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ssra	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_s64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_s64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_s64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_s64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	srsra	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_s64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_s64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x3f
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_s64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_s64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x3f
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_s64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_s64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_s64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_s64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsra_n_u64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	usra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsraq_n_u64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsraq_n_u64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	usra	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsra_n_u64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsra_n_u64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vrsraq_n_u64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vrsraq_n_u64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	ursra	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_u64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x0
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsli_n_u64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	d16, d0, #0x3f
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsliq_n_u64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x0
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_u64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x3f
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsri_n_u64_lo>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u64_mid>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsri_n_u64_hi>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sri	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_u64_lo>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x1
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u64_mid>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x5
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsriq_n_u64_hi>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.2d, v0.2d, #0x40
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsli_n_p8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.8b, v0.8b, #0x3
               	mov	v0.16b, v16.16b
               	str	d0, [x0]
               	ret

<w_vsriq_n_p16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sri	v16.8h, v0.8h, #0x10
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vsliq_n_p64>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	mov	v16.16b, v1.16b
               	sli	v16.2d, v0.2d, #0x3f
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal	v16.8h, v0.8b, v1.8b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal2	v16.8h, v0.16b, v1.16b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal	v16.8h, v0.8b, v1.8b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal2	v16.8h, v0.16b, v1.16b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal	v16.4s, v0.4h, v1.4h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal2	v16.4s, v0.8h, v1.8h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal	v16.4s, v0.4h, v1.4h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal2	v16.4s, v0.8h, v1.8h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal	v16.2d, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlal2	v16.2d, v0.4s, v1.4s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal	v16.2d, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlal_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlal2	v16.2d, v0.4s, v1.4s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_s8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl	v16.8h, v0.8b, v1.8b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_s8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl2	v16.8h, v0.16b, v1.16b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_u8>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl	v16.8h, v0.8b, v1.8b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_u8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl2	v16.8h, v0.16b, v1.16b
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_s16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl	v16.4s, v0.4h, v1.4h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_s16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl2	v16.4s, v0.8h, v1.8h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_u16>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl	v16.4s, v0.4h, v1.4h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_u16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl2	v16.4s, v0.8h, v1.8h
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_s32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl	v16.2d, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_s32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	smlsl2	v16.2d, v0.4s, v1.4s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_u32>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl	v16.2d, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
               	ret

<w_vmlsl_high_u32>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	mov	v16.16b, v2.16b
               	umlsl2	v16.2d, v0.4s, v1.4s
               	mov	v0.16b, v16.16b
               	str	q0, [x0]
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
               	ldr	d0, [x1]
               	addv	b0, v0.8b
               	str	b0, [x0]
               	ret

<w_vaddvq_s8>:
               	ldr	q0, [x1]
               	addv	b0, v0.16b
               	str	b0, [x0]
               	ret

<w_vaddlv_s8>:
               	ldr	d0, [x1]
               	saddlv	h0, v0.8b
               	str	h0, [x0]
               	ret

<w_vaddlvq_s8>:
               	ldr	q0, [x1]
               	saddlv	h0, v0.16b
               	str	h0, [x0]
               	ret

<w_vmaxv_s8>:
               	ldr	d0, [x1]
               	smaxv	b0, v0.8b
               	str	b0, [x0]
               	ret

<w_vmaxvq_s8>:
               	ldr	q0, [x1]
               	smaxv	b0, v0.16b
               	str	b0, [x0]
               	ret

<w_vminv_s8>:
               	ldr	d0, [x1]
               	sminv	b0, v0.8b
               	str	b0, [x0]
               	ret

<w_vminvq_s8>:
               	ldr	q0, [x1]
               	sminv	b0, v0.16b
               	str	b0, [x0]
               	ret

<w_vaddv_u8>:
               	ldr	d0, [x1]
               	addv	b0, v0.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vaddvq_u8>:
               	ldr	q0, [x1]
               	addv	b0, v0.16b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vaddlv_u8>:
               	ldr	d0, [x1]
               	uaddlv	h0, v0.8b
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vaddlvq_u8>:
               	ldr	q0, [x1]
               	uaddlv	h0, v0.16b
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vmaxv_u8>:
               	ldr	d0, [x1]
               	umaxv	b0, v0.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vmaxvq_u8>:
               	ldr	q0, [x1]
               	umaxv	b0, v0.16b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vminv_u8>:
               	ldr	d0, [x1]
               	uminv	b0, v0.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vminvq_u8>:
               	ldr	q0, [x1]
               	uminv	b0, v0.16b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<w_vaddv_s16>:
               	ldr	d0, [x1]
               	addv	h0, v0.4h
               	str	h0, [x0]
               	ret

<w_vaddvq_s16>:
               	ldr	q0, [x1]
               	addv	h0, v0.8h
               	str	h0, [x0]
               	ret

<w_vaddlv_s16>:
               	ldr	d0, [x1]
               	saddlv	s0, v0.4h
               	str	s0, [x0]
               	ret

<w_vaddlvq_s16>:
               	ldr	q0, [x1]
               	saddlv	s0, v0.8h
               	str	s0, [x0]
               	ret

<w_vmaxv_s16>:
               	ldr	d0, [x1]
               	smaxv	h0, v0.4h
               	str	h0, [x0]
               	ret

<w_vmaxvq_s16>:
               	ldr	q0, [x1]
               	smaxv	h0, v0.8h
               	str	h0, [x0]
               	ret

<w_vminv_s16>:
               	ldr	d0, [x1]
               	sminv	h0, v0.4h
               	str	h0, [x0]
               	ret

<w_vminvq_s16>:
               	ldr	q0, [x1]
               	sminv	h0, v0.8h
               	str	h0, [x0]
               	ret

<w_vaddv_u16>:
               	ldr	d0, [x1]
               	addv	h0, v0.4h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vaddvq_u16>:
               	ldr	q0, [x1]
               	addv	h0, v0.8h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vaddlv_u16>:
               	ldr	d0, [x1]
               	uaddlv	s0, v0.4h
               	str	s0, [x0]
               	ret

<w_vaddlvq_u16>:
               	ldr	q0, [x1]
               	uaddlv	s0, v0.8h
               	str	s0, [x0]
               	ret

<w_vmaxv_u16>:
               	ldr	d0, [x1]
               	umaxv	h0, v0.4h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vmaxvq_u16>:
               	ldr	q0, [x1]
               	umaxv	h0, v0.8h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vminv_u16>:
               	ldr	d0, [x1]
               	uminv	h0, v0.4h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vminvq_u16>:
               	ldr	q0, [x1]
               	uminv	h0, v0.8h
               	smov	x1, v0.h[0]
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	ret

<w_vaddv_s32>:
               	ldr	d0, [x1]
               	addp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vaddvq_s32>:
               	ldr	q0, [x1]
               	addv	s0, v0.4s
               	str	s0, [x0]
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
               	ldr	d0, [x1]
               	smaxp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vmaxvq_s32>:
               	ldr	q0, [x1]
               	smaxv	s0, v0.4s
               	str	s0, [x0]
               	ret

<w_vminv_s32>:
               	ldr	d0, [x1]
               	sminp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vminvq_s32>:
               	ldr	q0, [x1]
               	sminv	s0, v0.4s
               	str	s0, [x0]
               	ret

<w_vaddv_u32>:
               	ldr	d0, [x1]
               	addp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vaddvq_u32>:
               	ldr	q0, [x1]
               	addv	s0, v0.4s
               	str	s0, [x0]
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
               	ldr	d0, [x1]
               	umaxp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vmaxvq_u32>:
               	ldr	q0, [x1]
               	umaxv	s0, v0.4s
               	str	s0, [x0]
               	ret

<w_vminv_u32>:
               	ldr	d0, [x1]
               	uminp	v0.2s, v0.2s, v0.2s
               	str	s0, [x0]
               	ret

<w_vminvq_u32>:
               	ldr	q0, [x1]
               	uminv	s0, v0.4s
               	str	s0, [x0]
               	ret

<w_vaddvq_s64>:
               	ldr	q0, [x1]
               	addp	v0.2d, v0.2d, v0.2d
               	str	d0, [x0]
               	ret

<w_vaddvq_u64>:
               	ldr	q0, [x1]
               	addp	v0.2d, v0.2d, v0.2d
               	str	d0, [x0]
               	ret

<lane>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w2
               	mov	x21, x3
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	mul	x1, x1, x20
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	add	x1, x0, x1, asr #3
               	add	x0, x20, x20, lsr #61
               	asr	x2, x0, #3
               	sub	x0, x29, #0x10
               	bl	<addr>
               	cbz	w21, <addr>
               	ldur	x4, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	sub	x0, x20, #0x1
               	and	x2, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x5, x3, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x6, x2
               	lsr	x7, x1, x0
               	lsl	x1, x1, x5
               	lsr	x0, x4, x0
               	orr	x0, x0, x1, lsl #1
               	and	x0, x0, x6
               	and	x1, x7, x2
               	orr	x0, x0, x1
               	tbz	w0, #0x0, <addr>
               	ldur	x4, [x29, #-0x10]
               	ldur	x5, [x29, #-0x8]
               	mov	x1, #-0x1               // =-1
               	and	x2, x20, #0x7f
               	and	x0, x20, #0x3f
               	sub	x6, x3, x0
               	lsr	x2, x2, #6
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
               	sub	x8, x29, #0x70
               	stur	x1, [x29, #-0x68]
               	cbz	w3, <addr>
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
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
               	lsl	x0, x7, x0
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
               	sub	x7, x4, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsl	x5, x3, x0
               	lsr	x3, x3, x7
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
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldur	x5, [x29, #-0x70]
               	ldur	x2, [x29, #-0x68]
               	ldur	x6, [x29, #-0x60]
               	ldur	x3, [x29, #-0x58]
               	cmp	x2, x3
               	cset	x7, lt
               	cmp	x2, x3
               	cset	x3, eq
               	cmp	x5, x6
               	cset	x6, lo
               	and	x3, x3, x6
               	orr	x3, x7, x3
               	cbz	x3, <addr>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x3, lt
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x1, x5
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	csel	x1, x4, x8, ne
               	b	<addr>
               	mov	x3, #0x1                // =1
               	mov	x6, #0x0                // =0
               	and	x4, x2, #0x7f
               	and	x0, x2, #0x3f
               	mov	x2, #0x3f               // =63
               	sub	x7, x2, x0
               	lsr	x2, x4, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsl	x5, x3, x0
               	lsr	x3, x3, x7
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
               	sub	sp, sp, #0x30
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
               	sub	x3, x29, #0x20
               	stur	x4, [x29, #-0x20]
               	stur	x5, [x29, #-0x18]
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	b	<addr>
               	cbz	w6, <addr>
               	orr	x5, x0, x1
               	cbnz	x5, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x30
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
               	neg	x0, x0
               	neg	x1, x1
               	sub	x1, x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	bl	<addr>
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
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
               	orr	x1, x0, x1, lsr #1
               	and	x0, x6, x5
               	and	x1, x1, x5
               	and	x2, x6, x2
               	orr	x1, x1, x2
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
               	orr	x6, x5, x6
               	mul	x5, x0, x2
               	umulh	x7, x0, x2
               	madd	x0, x0, x6, x7
               	madd	x1, x1, x2, x0
               	mov	x0, x5
               	mov	x2, x3
               	mov	x3, x4
               	bl	<addr>
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	b	<addr>
               	cmp	w2, w3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	add	sp, sp, #0x30
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
               	orr	x0, x0, x2
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
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
               	str	x16, [sp, #0xb0]
               	ldr	x28, [sp, #0xb0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [sp, #0xb0]
               	mov	x17, #0x28              // =40
               	mul	x1, x16, x17
               	add	x24, x0, x1
               	ldrsw	x21, [x24, #0x10]
               	ldrsw	x22, [x24, #0x14]
               	ldrsw	x26, [x24, #0x18]
               	ldrsw	x0, [x24, #0x1c]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xb8]
               	and	x1, x0, #0x7f
               	lsr	x1, x1, #6
               	neg	x16, x1
               	str	x16, [sp, #0x108]
               	and	x1, x21, #0x7f
               	lsr	x16, x1, #6
               	str	x16, [sp, #0xc0]
               	str	x0, [sp, #0x118]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xc8]
               	b	<addr>
               	ldr	x16, [sp, #0xc8]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0xc8]
               	ldr	x0, [sp, #0xc8]
               	cmp	w0, #0x6
               	b.ge	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [sp, #0xb8]
               	add	x25, x1, x2, lsl #4
               	add	x2, x2, x0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x6               // =6
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	add	x16, x1, x2, lsl #4
               	str	x16, [sp, #0x100]
               	sub	x2, x29, #0xe0
               	add	x0, x1, x0, lsl #4
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldrsw	x0, [x24, #0xc]
               	cmp	w0, #0x2
               	b.gt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x16, [sp, #0xc8]
               	mov	x17, #0x7               // =7
               	mul	x3, x16, x17
               	cmp	w0, w26
               	b.ge	<addr>
               	mul	x1, x0, x21
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #61
               	asr	x1, x1, #3
               	add	x4, x0, x0, lsl #2
               	add	x4, x3, x4
               	lsl	x5, x21, #1
               	add	x5, x5, #0x5
               	sdiv	w17, w4, w5
               	msub	w4, w17, w5, w4
               	add	x5, x21, #0x2
               	sub	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x2, x1]
               	add	x0, x0, #0x1
               	cmp	w0, w26
               	b.lt	<addr>
               	ldr	x4, [x24]
               	mov	x1, x25
               	sub	x0, x29, #0xd0
               	sub	x2, x29, #0xe0
               	ldr	x3, [sp, #0x100]
               	blr	x4
               	mov	x23, #0x0               // =0
               	b	<addr>
               	add	x23, x23, #0x1
               	cmp	w23, w26
               	b.ge	<addr>
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x27, x0
               	mov	x20, x1
               	mov	x1, x23
               	mov	x3, x22
               	mov	x2, x21
               	sub	x0, x29, #0xe0
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0xf8]
               	mov	x16, x1
               	str	x16, [sp, #0xf0]
               	mov	x3, #0x0                // =0
               	stur	x3, [x29, #-0xc0]
               	stur	x3, [x29, #-0xb8]
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0xe8]
               	mov	x16, x1
               	str	x16, [sp, #0xe0]
               	mov	x1, x23
               	mov	x2, x21
               	sub	x0, x29, #0xe0
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0xd8]
               	mov	x16, x1
               	str	x16, [sp, #0xd0]
               	ldrsw	x2, [x24, #0x20]
               	madd	x1, x2, x26, x23
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	mov	x4, x0
               	mov	x16, x1
               	str	x16, [sp, #0x110]
               	ldrsw	x2, [x24, #0x20]
               	madd	x1, x2, x26, x23
               	str	x4, [sp, #0xa8]
               	mov	x2, x21
               	mov	x3, x22
               	sub	x0, x29, #0xe0
               	bl	<addr>
               	ldr	x4, [sp, #0xa8]
               	mov	x3, x0
               	mov	x5, x1
               	ldrsw	x2, [x24, #0xc]
               	cmp	x2, #0x1c
               	b.hs	<addr>
               	adrp	x17, <addr>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	sub	x1, x29, #0xe0
               	mul	x0, x23, x21
               	sxtw	x0, w0
               	add	x0, x0, x0, lsr #61
               	asr	x0, x0, #3
               	ldrb	w0, [x1, x0]
               	sxtb	x2, w0
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x0                // =0
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	ldrsw	x0, [x24, #0xc]
               	cmp	w0, #0xb
               	b.lt	<addr>
               	cmp	w0, #0x12
               	b.gt	<addr>
               	add	x1, x21, x21, lsr #63
               	asr	x27, x1, #1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x0, x26, x26, lsr #63
               	asr	x20, x0, #1
               	sub	x0, x26, x20
               	cmp	w23, w0
               	b.ge	<addr>
               	cbz	x20, <addr>
               	mov	x1, x23
               	mov	x2, x27
               	sub	x0, x29, #0xd0
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x110]
               	mov	x16, x1
               	str	x16, [sp, #0xf8]
               	mov	x1, x23
               	mov	x2, x27
               	sub	x0, x29, #0xe0
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	ldr	x16, [sp, #0x110]
               	eor	x0, x16, x0
               	ldr	x16, [sp, #0xf8]
               	eor	x1, x16, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	ldrsw	x0, [x24, #0x8]
               	orr	x28, x28, x0
               	ldur	x17, [x29, #-0xc0]
               	str	x17, [sp, #0x110]
               	ldur	x17, [x29, #-0xb8]
               	str	x17, [sp, #0xf8]
               	add	x1, x20, x23
               	mov	x2, x27
               	sub	x0, x29, #0xd0
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	ldr	x16, [sp, #0x110]
               	eor	x5, x16, x0
               	ldr	x16, [sp, #0xf8]
               	eor	x6, x16, x1
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x27, #0x7f
               	and	x0, x27, #0x3f
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
               	ldrsw	x0, [x24, #0x8]
               	orr	x28, x28, x0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	ldrsw	x0, [x24, #0xc]
               	cmp	w0, #0x13
               	b.lt	<addr>
               	cmp	w0, #0x1b
               	b.gt	<addr>
               	lsl	x20, x21, #1
               	ldrsw	x0, [x24, #0xc]
               	cmp	w0, #0x1c
               	b.lt	<addr>
               	lsl	x1, x21, #1
               	cmp	w0, #0x1d
               	csel	x20, x1, x21, eq
               	cbnz	x23, <addr>
               	ldur	x27, [x29, #-0xc0]
               	ldur	x17, [x29, #-0xb8]
               	str	x17, [sp, #0x110]
               	mov	x1, x23
               	mov	x2, x20
               	sub	x0, x29, #0xd0
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	eor	x5, x27, x0
               	ldr	x16, [sp, #0x110]
               	eor	x6, x16, x1
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	and	x2, x20, #0x7f
               	and	x0, x20, #0x3f
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
               	ldrsw	x0, [x24, #0x8]
               	orr	x28, x28, x0
               	b	<addr>
               	mov	x20, x21
               	b	<addr>
               	mov	x20, x21
               	b	<addr>
               	sub	x1, x29, #0xe0
               	mul	x0, x23, x21
               	sxtw	x0, w0
               	add	x0, x0, x0, lsr #61
               	asr	x0, x0, #3
               	ldrb	w0, [x1, x0]
               	sxtb	x2, w0
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	sub	x1, x29, #0xe0
               	mul	x0, x23, x21
               	sxtw	x0, w0
               	add	x0, x0, x0, lsr #61
               	asr	x0, x0, #3
               	ldrb	w0, [x1, x0]
               	sxtb	x2, w0
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x0                // =0
               	mov	x6, #0x1                // =1
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [sp, #0x118]
               	mov	x5, #0x0                // =0
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [sp, #0x118]
               	mov	x5, #0x0                // =0
               	mov	x6, #0x1                // =1
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0x118]
               	neg	x2, x16
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x0                // =0
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0x118]
               	neg	x2, x16
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0x118]
               	neg	x2, x16
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x0                // =0
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	ldr	x2, [sp, #0xf8]
               	add	x0, x2, x0
               	cmp	x0, x2
               	cset	x2, lo
               	ldr	x16, [sp, #0xf0]
               	add	x1, x16, x1
               	add	x1, x1, x2
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0x118]
               	neg	x2, x16
               	mov	x0, x27
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	mov	x5, #0x1                // =1
               	mov	x6, #0x0                // =0
               	bl	<addr>
               	ldr	x2, [sp, #0xf8]
               	add	x0, x2, x0
               	cmp	x0, x2
               	cset	x2, lo
               	ldr	x16, [sp, #0xf0]
               	add	x1, x16, x1
               	add	x1, x1, x2
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x0, [sp, #0x118]
               	and	x3, x0, #0x3f
               	mov	x1, #0x3f               // =63
               	sub	x7, x1, x3
               	mov	x8, #0x0                // =0
               	ldr	x2, [sp, #0x108]
               	mvn	x4, x2
               	ldr	x5, [sp, #0xe8]
               	lsl	x6, x5, x3
               	lsr	x5, x5, x7
               	ldr	x16, [sp, #0xe0]
               	lsl	x3, x16, x3
               	orr	x3, x3, x5, lsr #1
               	and	x5, x6, x4
               	and	x3, x3, x4
               	and	x4, x6, x2
               	orr	x6, x3, x4
               	mov	x4, #0x1                // =1
               	and	x3, x0, #0x3f
               	sub	x7, x1, x3
               	mvn	x0, x2
               	lsl	x1, x4, x3
               	lsr	x4, x4, x7
               	lsl	x3, x8, x3
               	orr	x4, x3, x4, lsr #1
               	and	x3, x1, x0
               	and	x0, x4, x0
               	and	x1, x1, x2
               	orr	x0, x0, x1
               	cmp	x3, #0x1
               	cset	x1, lo
               	sub	x2, x3, #0x1
               	sub	x0, x0, x1
               	ldr	x16, [sp, #0xd8]
               	and	x1, x16, x2
               	ldr	x16, [sp, #0xd0]
               	and	x0, x16, x0
               	orr	x1, x5, x1
               	orr	x0, x6, x0
               	stur	x1, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldr	x0, [sp, #0x118]
               	and	x3, x0, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x7, x4, x3
               	mov	x8, #0x0                // =0
               	ldr	x2, [sp, #0x108]
               	mvn	x1, x2
               	ldr	x5, [sp, #0xe0]
               	asr	x6, x5, x3
               	lsl	x7, x5, x7
               	ldr	x16, [sp, #0xe8]
               	lsr	x3, x16, x3
               	orr	x3, x3, x7, lsl #1
               	and	x3, x3, x1
               	and	x7, x6, x2
               	orr	x9, x3, x7
               	and	x1, x6, x1
               	and	x3, x2, x5, asr #63
               	orr	x10, x1, x3
               	mov	x1, #0x1                // =1
               	and	x3, x21, #0x3f
               	sub	x11, x4, x3
               	ldr	x16, [sp, #0xc0]
               	neg	x5, x16
               	mvn	x6, x5
               	lsl	x7, x1, x3
               	lsr	x1, x1, x11
               	lsl	x3, x8, x3
               	orr	x3, x3, x1, lsr #1
               	and	x1, x7, x6
               	and	x3, x3, x6
               	and	x5, x7, x5
               	orr	x3, x3, x5
               	cmp	x1, #0x1
               	cset	x5, lo
               	sub	x6, x1, #0x1
               	sub	x3, x3, x5
               	and	x5, x0, #0x3f
               	sub	x4, x4, x5
               	mvn	x0, x2
               	asr	x1, x3, x5
               	lsl	x4, x3, x4
               	lsr	x5, x6, x5
               	orr	x4, x5, x4, lsl #1
               	and	x4, x4, x0
               	and	x5, x1, x2
               	orr	x4, x4, x5
               	and	x0, x1, x0
               	and	x1, x2, x3, asr #63
               	orr	x0, x0, x1
               	mvn	x1, x4
               	mvn	x0, x0
               	ldr	x16, [sp, #0xd8]
               	and	x1, x16, x1
               	ldr	x16, [sp, #0xd0]
               	and	x0, x16, x0
               	orr	x1, x9, x1
               	orr	x0, x10, x0
               	stur	x1, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	stur	x27, [x29, #-0xc0]
               	stur	x20, [x29, #-0xb8]
               	b	<addr>
               	add	x0, x21, x21, lsr #63
               	asr	x2, x0, #1
               	mov	x0, x27
               	mov	x3, x22
               	mov	x1, x20
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	add	x0, x21, x21, lsr #63
               	asr	x2, x0, #1
               	mov	x0, x27
               	mov	x1, x20
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0x118]
               	and	x0, x16, #0x3f
               	mov	x1, #0x3f               // =63
               	sub	x4, x1, x0
               	ldr	x1, [sp, #0x108]
               	mvn	x2, x1
               	asr	x3, x20, x0
               	lsl	x4, x20, x4
               	lsr	x0, x27, x0
               	orr	x0, x0, x4, lsl #1
               	and	x0, x0, x2
               	and	x4, x3, x1
               	orr	x0, x0, x4
               	and	x2, x3, x2
               	and	x1, x1, x20, asr #63
               	orr	x1, x2, x1
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x7, #0x0                // =0
               	ldr	x2, [sp, #0x118]
               	sub	x0, x2, #0x1
               	and	x4, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x8, x3, x0
               	lsr	x4, x4, #6
               	neg	x4, x4
               	mvn	x5, x4
               	lsl	x6, x1, x0
               	lsr	x1, x1, x8
               	lsl	x0, x7, x0
               	orr	x0, x0, x1, lsr #1
               	and	x1, x6, x5
               	and	x0, x0, x5
               	and	x4, x6, x4
               	orr	x0, x0, x4
               	add	x4, x27, x1
               	cmp	x4, x27
               	cset	x1, lo
               	add	x0, x20, x0
               	add	x0, x0, x1
               	and	x1, x2, #0x3f
               	sub	x6, x3, x1
               	ldr	x2, [sp, #0x108]
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
               	stur	x1, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	add	x0, x4, x3
               	cmp	x0, x4
               	cset	x1, lo
               	ldr	x16, [sp, #0x110]
               	add	x2, x16, x5
               	add	x1, x2, x1
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	cmp	x4, x3
               	cset	x0, lo
               	sub	x1, x4, x3
               	ldr	x16, [sp, #0x110]
               	sub	x2, x16, x5
               	sub	x0, x2, x0
               	stur	x1, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	mul	x0, x4, x3
               	umulh	x1, x4, x3
               	madd	x1, x4, x5, x1
               	ldr	x16, [sp, #0x110]
               	madd	x1, x16, x3, x1
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	lsl	x2, x21, #1
               	str	x4, [sp, #0xa8]
               	str	x3, [sp, #0xa0]
               	str	x5, [sp, #0x98]
               	mov	x1, x23
               	mov	x3, x22
               	ldr	x0, [sp, #0x100]
               	bl	<addr>
               	ldr	x4, [sp, #0xa8]
               	ldr	x3, [sp, #0xa0]
               	ldr	x5, [sp, #0x98]
               	umulh	x2, x4, x3
               	madd	x2, x4, x5, x2
               	ldr	x16, [sp, #0x110]
               	madd	x5, x16, x3, x2
               	madd	x2, x4, x3, x0
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x5
               	add	x0, x1, x0
               	stur	x2, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	lsl	x2, x21, #1
               	str	x4, [sp, #0xa8]
               	str	x3, [sp, #0xa0]
               	str	x5, [sp, #0x98]
               	mov	x1, x23
               	mov	x3, x22
               	ldr	x0, [sp, #0x100]
               	bl	<addr>
               	ldr	x4, [sp, #0xa8]
               	ldr	x3, [sp, #0xa0]
               	ldr	x5, [sp, #0x98]
               	mul	x2, x4, x3
               	umulh	x6, x4, x3
               	madd	x4, x4, x5, x6
               	ldr	x16, [sp, #0x110]
               	madd	x3, x16, x3, x4
               	cmp	x0, x2
               	cset	x4, lo
               	sub	x0, x0, x2
               	sub	x1, x1, x3
               	sub	x1, x1, x4
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	lsl	x2, x21, #1
               	str	x3, [sp, #0xa0]
               	str	x5, [sp, #0x98]
               	mov	x0, x25
               	mov	x3, x22
               	mov	x1, x23
               	bl	<addr>
               	ldr	x3, [sp, #0xa0]
               	ldr	x5, [sp, #0x98]
               	add	x2, x0, x3
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x5
               	add	x0, x1, x0
               	stur	x2, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	lsl	x2, x21, #1
               	str	x3, [sp, #0xa0]
               	str	x5, [sp, #0x98]
               	mov	x0, x25
               	mov	x3, x22
               	mov	x1, x23
               	bl	<addr>
               	ldr	x3, [sp, #0xa0]
               	ldr	x5, [sp, #0x98]
               	cmp	x0, x3
               	cset	x2, lo
               	sub	x0, x0, x3
               	sub	x1, x1, x5
               	sub	x1, x1, x2
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	stur	x4, [x29, #-0xc0]
               	ldr	x16, [sp, #0x110]
               	stur	x16, [x29, #-0xb8]
               	b	<addr>
               	lsl	x1, x23, #1
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	mov	x20, x0
               	mov	x27, x1
               	lsl	x0, x23, #1
               	add	x1, x0, #0x1
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	x0, x20
               	cset	x2, lo
               	add	x1, x27, x1
               	add	x1, x1, x2
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	b	<addr>
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	mov	x20, #0x1               // =1
               	b	<addr>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	add	x20, x20, #0x1
               	cmp	w20, w26
               	b.ge	<addr>
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	sub	x3, x29, #0xc0
               	ldrsw	x2, [x24, #0xc]
               	cmp	w2, #0x1e
               	b.ne	<addr>
               	ldur	x4, [x29, #-0xc0]
               	ldur	x2, [x29, #-0xb8]
               	cmp	x2, x1
               	cset	x5, lt
               	cmp	x2, x1
               	cset	x1, eq
               	cmp	x4, x0
               	cset	x0, lo
               	and	x0, x1, x0
               	orr	x0, x5, x0
               	cbz	x0, <addr>
               	sub	x0, x29, #0xb0
               	b	<addr>
               	sub	x0, x29, #0xc0
               	b	<addr>
               	cmp	w2, #0x1f
               	b.ne	<addr>
               	ldur	x4, [x29, #-0xc0]
               	ldur	x2, [x29, #-0xb8]
               	cmp	x1, x2
               	cset	x5, lt
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x0, x4
               	cset	x0, lo
               	and	x0, x1, x0
               	orr	x0, x5, x0
               	cbz	x0, <addr>
               	sub	x0, x29, #0xb0
               	b	<addr>
               	sub	x0, x29, #0xc0
               	b	<addr>
               	ldur	x2, [x29, #-0xc0]
               	ldur	x5, [x29, #-0xb8]
               	add	x4, x2, x0
               	cmp	x4, x2
               	cset	x0, lo
               	add	x1, x5, x1
               	add	x1, x1, x0
               	sub	x0, x29, #0x10
               	stur	x4, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	b	<addr>
               	ldr	x16, [sp, #0xb8]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0xb8]
               	ldr	x16, [sp, #0xb8]
               	cmp	w16, #0x6
               	b.lt	<addr>
               	ldr	x16, [sp, #0xb0]
               	add	x16, x16, #0x1
               	str	x16, [sp, #0xb0]
               	ldr	x16, [sp, #0xb0]
               	cmp	w16, #0x287
               	b.lo	<addr>
               	mov	x0, x28
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
