
gcc_vector_arith_ops.aarch64:	file format elf64-littleaarch64

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

<same>:
               	mov	x3, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x860
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x820
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x810
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x800
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7e0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x790
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x780
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x770
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x760
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x750
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x740
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xf38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xf28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x730
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x710
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xf10
               	mov	x5, #0x1                // =1
               	strb	w5, [x0]
               	mov	x5, #0x3                // =3
               	strb	w5, [x0, #0x1]
               	mov	x5, #0x5                // =5
               	strb	w5, [x0, #0x2]
               	mov	x5, #0x7                // =7
               	strb	w5, [x0, #0x3]
               	mov	x6, #0x12c              // =300
               	strb	w6, [x0, #0x4]
               	mov	x5, #0x100              // =256
               	strb	w5, [x0, #0x5]
               	strb	w5, [x0, #0x6]
               	strb	w6, [x0, #0x7]
               	strb	w5, [x0, #0x8]
               	mov	x5, #0x8                // =8
               	strb	w5, [x0, #0x9]
               	mov	x5, #0xd                // =13
               	strb	w5, [x0, #0xa]
               	mov	x5, #0x10               // =16
               	strb	w5, [x0, #0xb]
               	mov	x5, #0x13               // =19
               	strb	w5, [x0, #0xc]
               	mov	x5, #0x16               // =22
               	strb	w5, [x0, #0xd]
               	mov	x5, #0x1b               // =27
               	strb	w5, [x0, #0xe]
               	mov	x1, #0x1e               // =30
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0xdb0
               	sxtw	x1, w0
               	add	x6, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x4, x1
               	ldrb	w7, [x7]
               	add	x2, x2, x7
               	and	x2, x2, x5
               	strb	w2, [x6]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6f0
               	sub	x1, x29, #0xdb0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x6e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0xd90
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	add	x7, x2, x3
               	ldrb	w7, [x7]
               	sub	x4, x4, x7
               	and	x4, x4, x5
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6e0
               	sub	x1, x29, #0xd90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	mul	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x6d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0xd70
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	add	x7, x2, x3
               	ldrb	w7, [x7]
               	mul	x4, x4, x7
               	and	x4, x4, x5
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6d0
               	sub	x1, x29, #0xd70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	udiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x6c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0xd50
               	sxtw	x3, w0
               	add	x5, x5, x3
               	add	x6, x1, x3
               	ldrb	w6, [x6]
               	add	x7, x2, x3
               	ldrb	w7, [x7]
               	sdiv	x6, x6, x7
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6c0
               	sub	x1, x29, #0xd50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w4, [x1]
               	ldrb	w3, [x2]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w3, [x2, #0x1]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w3, [x2, #0x2]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w3, [x2, #0x3]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w3, [x2, #0x4]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w3, [x2, #0x5]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w3, [x2, #0x6]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w3, [x2, #0x7]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w3, [x2, #0x8]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w3, [x2, #0x9]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w3, [x2, #0xa]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w3, [x2, #0xb]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w3, [x2, #0xc]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w3, [x2, #0xd]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w3, [x2, #0xe]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w3, [x2, #0xf]
               	udiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x6b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x6, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0xd30
               	sxtw	x3, w0
               	add	x7, x4, x3
               	add	x4, x1, x3
               	ldrb	w5, [x4]
               	add	x4, x2, x3
               	ldrb	w4, [x4]
               	sdiv	x17, x5, x4
               	msub	x4, x17, x4, x5
               	and	x4, x4, x6
               	strb	w4, [x7]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6b0
               	sub	x1, x29, #0xd30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x830
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x1, [x2]
               	ldr	x4, [x3]
               	and	x1, x1, x4
               	str	x1, [x0]
               	ldr	x1, [x2, #0x8]
               	ldr	x4, [x3, #0x8]
               	and	x1, x1, x4
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0xd10
               	sxtw	x1, w0
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldrb	w6, [x6]
               	add	x7, x3, x1
               	ldrb	w7, [x7]
               	and	x6, x6, x7
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6a0
               	sub	x1, x29, #0xd10
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x830
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x1, [x2]
               	ldr	x4, [x3]
               	orr	x1, x1, x4
               	str	x1, [x0]
               	ldr	x1, [x2, #0x8]
               	ldr	x4, [x3, #0x8]
               	orr	x1, x1, x4
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x690
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0xcf0
               	sxtw	x1, w0
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldrb	w6, [x6]
               	add	x7, x3, x1
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x690
               	sub	x1, x29, #0xcf0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x830
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x1, [x2]
               	ldr	x4, [x3]
               	eor	x1, x1, x4
               	str	x1, [x0]
               	ldr	x1, [x2, #0x8]
               	ldr	x4, [x3, #0x8]
               	eor	x1, x1, x4
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x680
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0xcd0
               	sxtw	x1, w0
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldrb	w6, [x6]
               	add	x7, x3, x1
               	ldrb	w7, [x7]
               	eor	x6, x6, x7
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x680
               	sub	x1, x29, #0xcd0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	add	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x670
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xcb0
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	add	x5, x2, x3
               	ldrsb	x5, [x5]
               	add	x4, x4, x5
               	mov	x5, x4
               	strb	w5, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x670
               	sub	x1, x29, #0xcb0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x660
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc90
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	add	x5, x2, x3
               	ldrsb	x5, [x5]
               	sub	x4, x4, x5
               	mov	x5, x4
               	strb	w5, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x660
               	sub	x1, x29, #0xc90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	mul	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x650
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc70
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	add	x5, x2, x3
               	ldrsb	x5, [x5]
               	mul	x4, x4, x5
               	mov	x5, x4
               	strb	w5, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x650
               	sub	x1, x29, #0xc70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x640
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc50
               	sxtw	x3, w0
               	add	x5, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	add	x6, x2, x3
               	ldrsb	x6, [x6]
               	sdiv	x4, x4, x6
               	strb	w4, [x5]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x640
               	sub	x1, x29, #0xc50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0xf10
               	ldrsb	x4, [x1]
               	ldrsb	x3, [x2]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x3, [x2, #0x1]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x3, [x2, #0x2]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x3, [x2, #0x3]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x3, [x2, #0x4]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x3, [x2, #0x5]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x3, [x2, #0x6]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x3, [x2, #0x7]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x3, [x2, #0x8]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x3, [x2, #0x9]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x3, [x2, #0xa]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x3, [x2, #0xb]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x3, [x2, #0xc]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x3, [x2, #0xd]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x3, [x2, #0xe]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x3, [x2, #0xf]
               	sdiv	x17, x4, x3
               	msub	x3, x17, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc30
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrsb	x5, [x4]
               	add	x4, x2, x3
               	ldrsb	x4, [x4]
               	sdiv	x17, x5, x4
               	msub	x4, x17, x4, x5
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x630
               	sub	x1, x29, #0xc30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x810
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x800
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	and	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x620
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc10
               	sxtw	x1, w0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	add	x6, x4, x1
               	ldrsb	x6, [x6]
               	and	x2, x2, x6
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x620
               	sub	x1, x29, #0xc10
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7e0
               	sub	x0, x29, #0xf10
               	ldrh	w1, [x2]
               	ldrh	w4, [x3]
               	add	x1, x1, x4
               	strh	w1, [x0]
               	ldrh	w1, [x2, #0x2]
               	ldrh	w4, [x3, #0x2]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x2, #0x4]
               	ldrh	w4, [x3, #0x4]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x2, #0x6]
               	ldrh	w4, [x3, #0x6]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x2, #0x8]
               	ldrh	w4, [x3, #0x8]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x2, #0xa]
               	ldrh	w4, [x3, #0xa]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x2, #0xc]
               	ldrh	w4, [x3, #0xc]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x2, #0xe]
               	ldrh	w4, [x3, #0xe]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xffff             // =65535
               	b	<addr>
               	sub	x6, x29, #0xbf0
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x6, x1
               	add	x7, x2, x1
               	ldrh	w7, [x7]
               	add	x1, x3, x1
               	ldrh	w1, [x1]
               	add	x1, x7, x1
               	and	x1, x1, x5
               	strh	w1, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x610
               	sub	x1, x29, #0xbf0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7e0
               	sub	x0, x29, #0xf10
               	ldrh	w1, [x2]
               	ldrh	w4, [x3]
               	sub	x1, x1, x4
               	strh	w1, [x0]
               	ldrh	w1, [x2, #0x2]
               	ldrh	w4, [x3, #0x2]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x2, #0x4]
               	ldrh	w4, [x3, #0x4]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x2, #0x6]
               	ldrh	w4, [x3, #0x6]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x2, #0x8]
               	ldrh	w4, [x3, #0x8]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x2, #0xa]
               	ldrh	w4, [x3, #0xa]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x2, #0xc]
               	ldrh	w4, [x3, #0xc]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x2, #0xe]
               	ldrh	w4, [x3, #0xe]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x600
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xffff             // =65535
               	b	<addr>
               	sub	x6, x29, #0xbd0
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x6, x1
               	add	x7, x2, x1
               	ldrh	w7, [x7]
               	add	x1, x3, x1
               	ldrh	w1, [x1]
               	sub	x1, x7, x1
               	and	x1, x1, x5
               	strh	w1, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x600
               	sub	x1, x29, #0xbd0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7e0
               	sub	x0, x29, #0xf10
               	ldrh	w1, [x2]
               	ldrh	w4, [x3]
               	mul	x1, x1, x4
               	strh	w1, [x0]
               	ldrh	w1, [x2, #0x2]
               	ldrh	w4, [x3, #0x2]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x2, #0x4]
               	ldrh	w4, [x3, #0x4]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x2, #0x6]
               	ldrh	w4, [x3, #0x6]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x2, #0x8]
               	ldrh	w4, [x3, #0x8]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x2, #0xa]
               	ldrh	w4, [x3, #0xa]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x2, #0xc]
               	ldrh	w4, [x3, #0xc]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x2, #0xe]
               	ldrh	w4, [x3, #0xe]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xffff             // =65535
               	b	<addr>
               	sub	x6, x29, #0xbb0
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x6, x1
               	add	x7, x2, x1
               	ldrh	w7, [x7]
               	add	x1, x3, x1
               	ldrh	w1, [x1]
               	mul	x1, x7, x1
               	and	x1, x1, x5
               	strh	w1, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5f0
               	sub	x1, x29, #0xbb0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7e0
               	sub	x0, x29, #0xf10
               	ldrh	w1, [x2]
               	ldrh	w4, [x3]
               	udiv	x1, x1, x4
               	strh	w1, [x0]
               	ldrh	w1, [x2, #0x2]
               	ldrh	w4, [x3, #0x2]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x2, #0x4]
               	ldrh	w4, [x3, #0x4]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x2, #0x6]
               	ldrh	w4, [x3, #0x6]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x2, #0x8]
               	ldrh	w4, [x3, #0x8]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x2, #0xa]
               	ldrh	w4, [x3, #0xa]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x2, #0xc]
               	ldrh	w4, [x3, #0xc]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x2, #0xe]
               	ldrh	w4, [x3, #0xe]
               	udiv	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xffff             // =65535
               	b	<addr>
               	sub	x6, x29, #0xb90
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x6, x1
               	add	x7, x2, x1
               	ldrh	w7, [x7]
               	add	x1, x3, x1
               	ldrh	w1, [x1]
               	sdiv	x1, x7, x1
               	and	x1, x1, x5
               	strh	w1, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5e0
               	sub	x1, x29, #0xb90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7e0
               	sub	x0, x29, #0xf10
               	ldrh	w4, [x2]
               	ldrh	w1, [x3]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0]
               	ldrh	w4, [x2, #0x2]
               	ldrh	w1, [x3, #0x2]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrh	w4, [x2, #0x4]
               	ldrh	w1, [x3, #0x4]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrh	w4, [x2, #0x6]
               	ldrh	w1, [x3, #0x6]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrh	w4, [x2, #0x8]
               	ldrh	w1, [x3, #0x8]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrh	w4, [x2, #0xa]
               	ldrh	w1, [x3, #0xa]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrh	w4, [x2, #0xc]
               	ldrh	w1, [x3, #0xc]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrh	w4, [x2, #0xe]
               	ldrh	w1, [x3, #0xe]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x6, #0xffff             // =65535
               	b	<addr>
               	sub	x5, x29, #0xb70
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x7, x5, x1
               	add	x5, x2, x1
               	ldrh	w5, [x5]
               	add	x1, x3, x1
               	ldrh	w1, [x1]
               	sdiv	x17, x5, x1
               	msub	x1, x17, x1, x5
               	and	x1, x1, x6
               	strh	w1, [x7]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5d0
               	sub	x1, x29, #0xb70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	add	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	add	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	add	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb50
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x5, x1
               	add	x5, x2, x1
               	ldrsh	x5, [x5]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	add	x1, x5, x1
               	mov	x5, x1
               	strh	w5, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5c0
               	sub	x1, x29, #0xb50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	sub	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	sub	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb30
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x5, x1
               	add	x5, x2, x1
               	ldrsh	x5, [x5]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	sub	x1, x5, x1
               	mov	x5, x1
               	strh	w5, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5b0
               	sub	x1, x29, #0xb30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	mul	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	mul	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb10
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x5, x1
               	add	x5, x2, x1
               	ldrsh	x5, [x5]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	mul	x1, x5, x1
               	mov	x5, x1
               	strh	w5, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5a0
               	sub	x1, x29, #0xb10
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	sdiv	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	sdiv	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xaf0
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldrsh	x6, [x6]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	sdiv	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x590
               	sub	x1, x29, #0xaf0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x4, [x2]
               	ldrsh	x1, [x3]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0]
               	ldrsh	x4, [x2, #0x2]
               	ldrsh	x1, [x3, #0x2]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x4, [x2, #0x4]
               	ldrsh	x1, [x3, #0x4]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x4, [x2, #0x6]
               	ldrsh	x1, [x3, #0x6]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x4, [x2, #0x8]
               	ldrsh	x1, [x3, #0x8]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x4, [x2, #0xa]
               	ldrsh	x1, [x3, #0xa]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x4, [x2, #0xc]
               	ldrsh	x1, [x3, #0xc]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x4, [x2, #0xe]
               	ldrsh	x1, [x3, #0xe]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x580
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xad0
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x5, x1
               	add	x5, x2, x1
               	ldrsh	x5, [x5]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	sdiv	x17, x5, x1
               	msub	x1, x17, x1, x5
               	strh	w1, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x580
               	sub	x1, x29, #0xad0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x7a0
               	sub	x0, x29, #0xf10
               	ldr	w1, [x3]
               	ldr	w2, [x4]
               	add	x1, x1, x2
               	str	w1, [x0]
               	ldr	w1, [x3, #0x4]
               	ldr	w2, [x4, #0x4]
               	add	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldr	w1, [x3, #0x8]
               	ldr	w2, [x4, #0x8]
               	add	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x3, #0xc]
               	ldr	w2, [x4, #0xc]
               	add	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xab0
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	add	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x570
               	sub	x1, x29, #0xab0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x7a0
               	sub	x0, x29, #0xf10
               	ldr	w1, [x3]
               	ldr	w2, [x4]
               	sub	x1, x1, x2
               	str	w1, [x0]
               	ldr	w1, [x3, #0x4]
               	ldr	w2, [x4, #0x4]
               	sub	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldr	w1, [x3, #0x8]
               	ldr	w2, [x4, #0x8]
               	sub	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x3, #0xc]
               	ldr	w2, [x4, #0xc]
               	sub	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa90
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	sub	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x560
               	sub	x1, x29, #0xa90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x7a0
               	sub	x0, x29, #0xf10
               	ldr	w1, [x3]
               	ldr	w2, [x4]
               	mul	x1, x1, x2
               	str	w1, [x0]
               	ldr	w1, [x3, #0x4]
               	ldr	w2, [x4, #0x4]
               	mul	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldr	w1, [x3, #0x8]
               	ldr	w2, [x4, #0x8]
               	mul	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x3, #0xc]
               	ldr	w2, [x4, #0xc]
               	mul	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa70
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	mul	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0xa70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x7a0
               	sub	x0, x29, #0xf10
               	ldr	w1, [x3]
               	ldr	w2, [x4]
               	udiv	x1, x1, x2
               	str	w1, [x0]
               	ldr	w1, [x3, #0x4]
               	ldr	w2, [x4, #0x4]
               	udiv	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldr	w1, [x3, #0x8]
               	ldr	w2, [x4, #0x8]
               	udiv	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x3, #0xc]
               	ldr	w2, [x4, #0xc]
               	udiv	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x540
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa50
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	udiv	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x540
               	sub	x1, x29, #0xa50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x7b0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x7a0
               	sub	x0, x29, #0xf10
               	ldr	w2, [x4]
               	ldr	w1, [x5]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0]
               	ldr	w2, [x4, #0x4]
               	ldr	w1, [x5, #0x4]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x4]
               	ldr	w2, [x4, #0x8]
               	ldr	w1, [x5, #0x8]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w2, [x4, #0xc]
               	ldr	w1, [x5, #0xc]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xa30
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x6, x3, x1
               	add	x3, x4, x1
               	ldr	w3, [x3]
               	add	x1, x5, x1
               	ldr	w1, [x1]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	mov	w1, w1
               	str	w1, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x530
               	sub	x1, x29, #0xa30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	ldrsw	x2, [x4]
               	add	x1, x1, x2
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x2, [x4, #0x4]
               	add	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x2, [x4, #0x8]
               	add	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x2, [x4, #0xc]
               	add	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x520
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa10
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	add	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x520
               	sub	x1, x29, #0xa10
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	ldrsw	x2, [x4]
               	sub	x1, x1, x2
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x2, [x4, #0x4]
               	sub	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x2, [x4, #0x8]
               	sub	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x2, [x4, #0xc]
               	sub	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x510
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9f0
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sub	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x510
               	sub	x1, x29, #0x9f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	ldrsw	x2, [x4]
               	mul	x1, x1, x2
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x2, [x4, #0x4]
               	mul	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x2, [x4, #0x8]
               	mul	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x2, [x4, #0xc]
               	mul	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x500
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9d0
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	mul	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x500
               	sub	x1, x29, #0x9d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	ldrsw	x2, [x4]
               	sdiv	x1, x1, x2
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x2, [x4, #0x4]
               	sdiv	x1, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x2, [x4, #0x8]
               	sdiv	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x2, [x4, #0xc]
               	sdiv	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9b0
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sdiv	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4f0
               	sub	x1, x29, #0x9b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x790
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x2, [x4]
               	ldrsw	x1, [x5]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0]
               	ldrsw	x2, [x4, #0x4]
               	ldrsw	x1, [x5, #0x4]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x2, [x4, #0x8]
               	ldrsw	x1, [x5, #0x8]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x2, [x4, #0xc]
               	ldrsw	x1, [x5, #0xc]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x990
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x6, x3, x1
               	add	x3, x4, x1
               	ldrsw	x3, [x3]
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	sdiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	str	w1, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4e0
               	sub	x1, x29, #0x990
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x770
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x760
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	add	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x970
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	add	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4d0
               	sub	x1, x29, #0x970
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x770
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x760
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	sub	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x950
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sub	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4c0
               	sub	x1, x29, #0x950
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x770
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x760
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	mul	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x930
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	mul	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4b0
               	sub	x1, x29, #0x930
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x25               // =37
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x770
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x760
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	udiv	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	udiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x910
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	udiv	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4a0
               	sub	x1, x29, #0x910
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x26               // =38
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x770
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x760
               	sub	x0, x29, #0xf10
               	ldr	x2, [x4]
               	ldr	x1, [x5]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	x1, [x0]
               	ldr	x2, [x4, #0x8]
               	ldr	x1, [x5, #0x8]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x490
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x8f0
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x6, x3, x1
               	add	x3, x4, x1
               	ldr	x3, [x3]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	str	x1, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x490
               	sub	x1, x29, #0x8f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	add	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x480
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x8d0
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	add	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x480
               	sub	x1, x29, #0x8d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	sub	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x470
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x8b0
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sub	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x470
               	sub	x1, x29, #0x8b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	mul	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x460
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x890
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	mul	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x460
               	sub	x1, x29, #0x890
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	ldr	x2, [x4]
               	sdiv	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x4, #0x8]
               	sdiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x450
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x870
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sdiv	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x450
               	sub	x1, x29, #0x870
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x750
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x2, [x4]
               	ldr	x1, [x5]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	x1, [x0]
               	ldr	x2, [x4, #0x8]
               	ldr	x1, [x5, #0x8]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x440
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x850
               	sxtw	x2, w0
               	lsl	x1, x2, #3
               	add	x6, x3, x1
               	add	x3, x4, x1
               	ldr	x3, [x3]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	sdiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	str	x1, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x440
               	sub	x1, x29, #0x850
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xf38
               	sub	x4, x29, #0xf28
               	sub	x0, x29, #0xf08
               	ldrb	w1, [x3]
               	ldrb	w2, [x4]
               	add	x1, x1, x2
               	strb	w1, [x0]
               	ldrb	w1, [x3, #0x1]
               	ldrb	w2, [x4, #0x1]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x3, #0x2]
               	ldrb	w2, [x4, #0x2]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x3, #0x3]
               	ldrb	w2, [x4, #0x3]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x3, #0x4]
               	ldrb	w2, [x4, #0x4]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x3, #0x5]
               	ldrb	w2, [x4, #0x5]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x3, #0x6]
               	ldrb	w2, [x4, #0x6]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x3, #0x7]
               	ldrb	w2, [x4, #0x7]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x840
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x838
               	sxtw	x1, w0
               	add	x6, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x4, x1
               	ldrb	w7, [x7]
               	add	x2, x2, x7
               	and	x2, x2, x5
               	strb	w2, [x6]
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x840
               	sub	x1, x29, #0x838
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xf38
               	sub	x4, x29, #0xf28
               	sub	x0, x29, #0xf08
               	ldrb	w1, [x3]
               	ldrb	w2, [x4]
               	mul	x1, x1, x2
               	strb	w1, [x0]
               	ldrb	w1, [x3, #0x1]
               	ldrb	w2, [x4, #0x1]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x3, #0x2]
               	ldrb	w2, [x4, #0x2]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x3, #0x3]
               	ldrb	w2, [x4, #0x3]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x3, #0x4]
               	ldrb	w2, [x4, #0x4]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x3, #0x5]
               	ldrb	w2, [x4, #0x5]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x3, #0x6]
               	ldrb	w2, [x4, #0x6]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x3, #0x7]
               	ldrb	w2, [x4, #0x7]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x830
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x828
               	sxtw	x1, w0
               	add	x6, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x4, x1
               	ldrb	w7, [x7]
               	mul	x2, x2, x7
               	and	x2, x2, x5
               	strb	w2, [x6]
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x830
               	sub	x1, x29, #0x828
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x730
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x710
               	sub	x0, x29, #0xf20
               	ldr	w1, [x2]
               	ldr	w4, [x3]
               	add	x1, x1, x4
               	str	w1, [x0]
               	ldr	w1, [x2, #0x4]
               	ldr	w4, [x3, #0x4]
               	add	x1, x1, x4
               	str	w1, [x0, #0x4]
               	ldr	w1, [x2, #0x8]
               	ldr	w4, [x3, #0x8]
               	add	x1, x1, x4
               	str	w1, [x0, #0x8]
               	ldr	w1, [x2, #0xc]
               	ldr	w4, [x3, #0xc]
               	add	x1, x1, x4
               	str	w1, [x0, #0xc]
               	ldr	w1, [x2, #0x10]
               	ldr	w4, [x3, #0x10]
               	add	x1, x1, x4
               	str	w1, [x0, #0x10]
               	ldr	w1, [x2, #0x14]
               	ldr	w4, [x3, #0x14]
               	add	x1, x1, x4
               	str	w1, [x0, #0x14]
               	ldr	w1, [x2, #0x18]
               	ldr	w4, [x3, #0x18]
               	add	x1, x1, x4
               	str	w1, [x0, #0x18]
               	ldr	w1, [x2, #0x1c]
               	ldr	w4, [x3, #0x1c]
               	add	x1, x1, x4
               	str	w1, [x0, #0x1c]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x800
               	sxtw	x4, w0
               	lsl	x1, x4, #2
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldr	w6, [x6]
               	add	x1, x3, x1
               	ldr	w1, [x1]
               	add	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x430
               	sub	x1, x29, #0x800
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2f               // =47
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x730
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x710
               	sub	x0, x29, #0xf20
               	ldr	w1, [x2]
               	ldr	w4, [x3]
               	sub	x1, x1, x4
               	str	w1, [x0]
               	ldr	w1, [x2, #0x4]
               	ldr	w4, [x3, #0x4]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x4]
               	ldr	w1, [x2, #0x8]
               	ldr	w4, [x3, #0x8]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x8]
               	ldr	w1, [x2, #0xc]
               	ldr	w4, [x3, #0xc]
               	sub	x1, x1, x4
               	str	w1, [x0, #0xc]
               	ldr	w1, [x2, #0x10]
               	ldr	w4, [x3, #0x10]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x10]
               	ldr	w1, [x2, #0x14]
               	ldr	w4, [x3, #0x14]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x14]
               	ldr	w1, [x2, #0x18]
               	ldr	w4, [x3, #0x18]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x18]
               	ldr	w1, [x2, #0x1c]
               	ldr	w4, [x3, #0x1c]
               	sub	x1, x1, x4
               	str	w1, [x0, #0x1c]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x7c0
               	sxtw	x4, w0
               	lsl	x1, x4, #2
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldr	w6, [x6]
               	add	x1, x3, x1
               	ldr	w1, [x1]
               	sub	x1, x6, x1
               	mov	w1, w1
               	str	w1, [x5]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x410
               	sub	x1, x29, #0x7c0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x30               // =48
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x3f0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3e0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	lsr	x3, x3, #0
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsl	x3, x3, #1
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsl	x3, x3, #3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsl	x3, x3, #4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsl	x3, x3, #5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsl	x3, x3, #6
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsl	x3, x3, #7
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	lsr	x3, x3, #0
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsl	x3, x3, #1
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsl	x3, x3, #3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsl	x3, x3, #4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsl	x3, x3, #5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsl	x3, x3, #6
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	lsl	x2, x3, #7
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x770
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	add	x7, x4, x2
               	ldrb	w7, [x7]
               	lsl	x3, x3, x7
               	and	x3, x3, x5
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3d0
               	sub	x1, x29, #0x770
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x31               // =49
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3f0
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	lsr	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x3c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x750
               	sxtw	x3, w0
               	add	x5, x5, x3
               	add	x6, x1, x3
               	ldrb	w6, [x6]
               	add	x7, x2, x3
               	ldrb	w7, [x7]
               	lsr	x6, x6, x7
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3c0
               	sub	x1, x29, #0x750
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x32               // =50
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x3e0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	asr	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	asr	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x730
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x5, x5, x1
               	add	x6, x2, x1
               	ldrsh	x6, [x6]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	asr	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3b0
               	sub	x1, x29, #0x730
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x33               // =51
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x3e0
               	sub	x0, x29, #0xf10
               	ldrsh	x1, [x2]
               	ldrsh	x4, [x3]
               	lsl	x1, x1, x4
               	strh	w1, [x0]
               	ldrsh	x1, [x2, #0x2]
               	ldrsh	x4, [x3, #0x2]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x2, #0x4]
               	ldrsh	x4, [x3, #0x4]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x2, #0x6]
               	ldrsh	x4, [x3, #0x6]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x2, #0x8]
               	ldrsh	x4, [x3, #0x8]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x2, #0xa]
               	ldrsh	x4, [x3, #0xa]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x2, #0xc]
               	ldrsh	x4, [x3, #0xc]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x2, #0xe]
               	ldrsh	x4, [x3, #0xe]
               	lsl	x1, x1, x4
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x710
               	sxtw	x4, w0
               	lsl	x1, x4, #1
               	add	x6, x5, x1
               	add	x5, x2, x1
               	ldrsh	x5, [x5]
               	add	x1, x3, x1
               	ldrsh	x1, [x1]
               	lsl	x1, x5, x1
               	mov	x5, x1
               	strh	w5, [x6]
               	add	x0, x4, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3a0
               	sub	x1, x29, #0x710
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x34               // =52
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	asr	x1, x1, #3
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	asr	x1, x1, #3
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	asr	x1, x1, #3
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	asr	x1, x1, #3
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x6f0
               	sxtw	x1, w0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	asr	x2, x2, #3
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x390
               	sub	x1, x29, #0x6f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x35               // =53
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x0, x29, #0xf10
               	ldr	w1, [x3]
               	lsr	x1, x1, #3
               	str	w1, [x0]
               	ldr	w1, [x3, #0x4]
               	lsr	x1, x1, #3
               	str	w1, [x0, #0x4]
               	ldr	w1, [x3, #0x8]
               	lsr	x1, x1, #3
               	str	w1, [x0, #0x8]
               	ldr	w1, [x3, #0xc]
               	lsr	x1, x1, #3
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x6d0
               	sxtw	x1, w0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	w2, [x2]
               	lsr	x2, x2, #3
               	mov	w2, w2
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x380
               	sub	x1, x29, #0x6d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x36               // =54
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x0, x29, #0xf10
               	ldrsb	x2, [x1]
               	lsl	x2, x2, #2
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x6b0
               	sxtw	x2, w0
               	add	x5, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	lsl	x3, x3, #2
               	mov	x4, x3
               	strb	w4, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x370
               	sub	x1, x29, #0x6b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x37               // =55
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x360
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x690
               	sxtw	x2, w0
               	add	x5, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	sub	x3, x3, #0x40
               	and	x3, x3, x4
               	strb	w3, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x360
               	sub	x1, x29, #0x690
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x38               // =56
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	add	x2, x2, #0x64
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x350
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x670
               	sxtw	x2, w0
               	add	x5, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	add	x3, x3, #0x64
               	and	x3, x3, x4
               	strb	w3, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x350
               	sub	x1, x29, #0x670
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x39               // =57
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	mul	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mul	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x650
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	mul	x3, x3, x4
               	and	x3, x3, x5
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x340
               	sub	x1, x29, #0x650
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3a               // =58
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	udiv	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x630
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	mul	x3, x3, x5
               	asr	x3, x3, #34
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	and	x3, x3, x4
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x330
               	sub	x1, x29, #0x630
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3b               // =59
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	udiv	x17, x3, x2
               	msub	x2, x17, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x320
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	mov	x6, #0xff               // =255
               	mov	x7, #0x2493             // =9363
               	movk	x7, #0x9249, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x610
               	sxtw	x2, w0
               	add	x8, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	mul	x4, x3, x7
               	asr	x4, x4, #34
               	lsr	x9, x4, #63
               	add	x4, x4, x9
               	mul	x4, x4, x5
               	sub	x3, x3, x4
               	and	x3, x3, x6
               	strb	w3, [x8]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x320
               	sub	x1, x29, #0x610
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0xf                // =15
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	and	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	and	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0xf                // =15
               	b	<addr>
               	sub	x4, x29, #0x5f0
               	sxtw	x2, w0
               	add	x4, x4, x2
               	add	x5, x1, x2
               	ldrb	w5, [x5]
               	and	x5, x5, x3
               	strb	w5, [x4]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x310
               	sub	x1, x29, #0x5f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3d               // =61
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0xf0               // =240
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	orr	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	orr	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0xf0               // =240
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x5d0
               	sxtw	x2, w0
               	add	x5, x5, x2
               	add	x6, x1, x2
               	ldrb	w6, [x6]
               	orr	x6, x6, x3
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x300
               	sub	x1, x29, #0x5d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3e               // =62
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0x55               // =85
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	eor	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	eor	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0x55               // =85
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x5b0
               	sxtw	x2, w0
               	add	x5, x5, x2
               	add	x6, x1, x2
               	ldrb	w6, [x6]
               	eor	x6, x6, x3
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2f0
               	sub	x1, x29, #0x5b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3f               // =63
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x0, x29, #0xf10
               	ldrsb	x2, [x1]
               	sub	x2, x2, #0x64
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x590
               	sxtw	x2, w0
               	add	x5, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	sub	x3, x3, #0x64
               	mov	x4, x3
               	strb	w4, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2e0
               	sub	x1, x29, #0x590
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x40               // =64
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	sdiv	x3, x3, x2
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sdiv	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	sdiv	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x570
               	sxtw	x2, w0
               	add	x5, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	mul	x3, x3, x4
               	asr	x3, x3, #32
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	strb	w3, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2d0
               	sub	x1, x29, #0x570
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x41               // =65
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sdiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	sdiv	x17, x3, x2
               	msub	x2, x17, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x550
               	sxtw	x2, w0
               	add	x7, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	mul	x4, x3, x6
               	asr	x4, x4, #32
               	lsr	x8, x4, #63
               	add	x4, x4, x8
               	mul	x4, x4, x5
               	sub	x3, x3, x4
               	strb	w3, [x7]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2c0
               	sub	x1, x29, #0x550
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x42               // =66
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7f0
               	mov	x1, #0x3e8              // =1000
               	sub	x0, x29, #0xf10
               	ldrh	w3, [x2]
               	mul	x3, x3, x1
               	strh	w3, [x0]
               	ldrh	w3, [x2, #0x2]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x2, #0x4]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x2, #0x6]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x2, #0x8]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x2, #0xa]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x2, #0xc]
               	mul	x3, x3, x1
               	strh	w3, [x0, #0xc]
               	ldrh	w3, [x2, #0xe]
               	mul	x1, x3, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3e8              // =1000
               	mov	x5, #0xffff             // =65535
               	b	<addr>
               	sub	x6, x29, #0x530
               	sxtw	x3, w0
               	lsl	x1, x3, #1
               	add	x6, x6, x1
               	add	x1, x2, x1
               	ldrh	w1, [x1]
               	mul	x1, x1, x4
               	and	x1, x1, x5
               	strh	w1, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2b0
               	sub	x1, x29, #0x530
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x43               // =67
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0xf10
               	ldr	x2, [x3]
               	mul	x2, x2, x1
               	str	x2, [x0]
               	ldr	x2, [x3, #0x8]
               	mul	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	b	<addr>
               	sub	x5, x29, #0x510
               	sxtw	x1, w0
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mul	x2, x2, x4
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2a0
               	sub	x1, x29, #0x510
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x44               // =68
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x40               // =64
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x290
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x4f0
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	sub	x3, x4, x3
               	and	x3, x3, x5
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x290
               	sub	x1, x29, #0x4f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x45               // =69
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x64               // =100
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x0, x29, #0xf10
               	ldrsb	x2, [x1]
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x280
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x4d0
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	sub	x3, x4, x3
               	mov	x5, x3
               	strb	w5, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x280
               	sub	x1, x29, #0x4d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x46               // =70
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xfa               // =250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	udiv	x2, x3, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x270
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x4b0
               	sxtw	x2, w0
               	add	x5, x5, x2
               	add	x6, x1, x2
               	ldrb	w6, [x6]
               	sdiv	x6, x3, x6
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x270
               	sub	x1, x29, #0x4b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x47               // =71
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xfa               // =250
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x2]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	udiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0x490
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x2, x3
               	ldrb	w4, [x4]
               	sdiv	x17, x1, x4
               	msub	x4, x17, x4, x1
               	and	x4, x4, x5
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x260
               	sub	x1, x29, #0x490
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x61               // =97
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	and	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	and	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x250
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0xf                // =15
               	b	<addr>
               	sub	x4, x29, #0x470
               	sxtw	x2, w0
               	add	x4, x4, x2
               	add	x5, x1, x2
               	ldrb	w5, [x5]
               	and	x5, x5, x3
               	strb	w5, [x4]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x250
               	sub	x1, x29, #0x470
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x62               // =98
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x3                // =3
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	lsl	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	lsl	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x240
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x450
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	lsl	x3, x4, x3
               	and	x3, x3, x5
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x240
               	sub	x1, x29, #0x450
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x63               // =99
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x80               // =128
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	lsr	x2, x3, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	lsr	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x230
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x430
               	sxtw	x2, w0
               	add	x5, x5, x2
               	add	x6, x1, x2
               	ldrb	w6, [x6]
               	lsr	x6, x3, x6
               	and	x6, x6, x4
               	strb	w6, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x230
               	sub	x1, x29, #0x430
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x64               // =100
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xfff9             // =65529
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x3]
               	sdiv	x1, x4, x1
               	str	w1, [x0]
               	ldrsw	x1, [x3, #0x4]
               	sdiv	x1, x4, x1
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x3, #0x8]
               	sdiv	x1, x4, x1
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x3, #0xc]
               	sdiv	x1, x4, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x220
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x410
               	sxtw	x1, w0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	sdiv	x2, x4, x2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x220
               	sub	x1, x29, #0x410
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x65               // =101
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x780
               	sub	x0, x29, #0xf10
               	ldrsw	x1, [x4]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0]
               	ldrsw	x1, [x4, #0x4]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x4, #0x8]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x4, #0xc]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x3f0
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x5, x5, x1
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x5]
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x210
               	sub	x1, x29, #0x3f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x66               // =102
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	udiv	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	udiv	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x200
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x3d0
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	mul	x3, x3, x5
               	asr	x3, x3, #32
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	and	x3, x3, x4
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x200
               	sub	x1, x29, #0x3d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x48               // =72
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0xf10
               	ldrsw	x2, [x3]
               	sdiv	x2, x2, x1
               	str	w2, [x0]
               	ldrsw	x2, [x3, #0x4]
               	sdiv	x2, x2, x1
               	str	w2, [x0, #0x4]
               	ldrsw	x2, [x3, #0x8]
               	sdiv	x2, x2, x1
               	str	w2, [x0, #0x8]
               	ldrsw	x2, [x3, #0xc]
               	sdiv	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	b	<addr>
               	sub	x5, x29, #0x3b0
               	sxtw	x1, w0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	mul	x2, x2, x4
               	asr	x2, x2, #34
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1f0
               	sub	x1, x29, #0x3b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x60               // =96
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0xf10
               	ldrb	w3, [x1]
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x2]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xe]
               	ldrb	w3, [x1, #0xf]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x390
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrb	w3, [x3]
               	mul	x3, x3, x4
               	and	x3, x3, x5
               	strb	w3, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1e0
               	sub	x1, x29, #0x390
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x49               // =73
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x810
               	sub	x2, x29, #0xf10
               	ldrsb	x3, [x1]
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x2]
               	ldrsb	x3, [x1, #0x1]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	sub	x3, x0, x3
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	b	<addr>
               	sub	x3, x29, #0x370
               	sxtw	x2, w0
               	add	x6, x3, x2
               	add	x3, x1, x2
               	ldrsb	x3, [x3]
               	mul	x3, x3, x5
               	mov	x4, x3
               	strb	w4, [x6]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1d0
               	sub	x1, x29, #0x370
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4a               // =74
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x790
               	sub	x1, x29, #0xf10
               	ldrsw	x2, [x3]
               	mov	x0, #0x0                // =0
               	sub	x2, x0, x2
               	str	w2, [x1]
               	ldrsw	x2, [x3, #0x4]
               	sub	x2, x0, x2
               	str	w2, [x1, #0x4]
               	ldrsw	x2, [x3, #0x8]
               	sub	x2, x0, x2
               	str	w2, [x1, #0x8]
               	ldrsw	x2, [x3, #0xc]
               	sub	x2, x0, x2
               	str	w2, [x1, #0xc]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	b	<addr>
               	sub	x5, x29, #0x350
               	sxtw	x2, w0
               	lsl	x1, x2, #2
               	add	x5, x5, x1
               	add	x1, x3, x1
               	ldrsw	x1, [x1]
               	mul	x1, x1, x4
               	str	w1, [x5]
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1c0
               	sub	x1, x29, #0x350
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4b               // =75
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x1]
               	mvn	x2, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	mvn	x2, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	mvn	x2, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	mvn	x2, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	mvn	x2, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	mvn	x2, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	mvn	x2, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	mvn	x2, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	mvn	x2, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	mvn	x2, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	mvn	x2, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	mvn	x2, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	mvn	x2, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	mvn	x2, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	mvn	x2, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	mvn	x2, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0x330
               	sxtw	x2, w0
               	add	x4, x4, x2
               	add	x5, x1, x2
               	ldrb	w5, [x5]
               	mvn	x5, x5
               	and	x5, x5, x3
               	strb	w5, [x4]
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1b0
               	sub	x1, x29, #0x330
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4c               // =76
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x0, x29, #0xf10
               	ldr	x1, [x3]
               	mvn	x1, x1
               	str	x1, [x0]
               	ldr	x1, [x3, #0x8]
               	mvn	x1, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x310
               	sxtw	x1, w0
               	lsl	x2, x1, #3
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mvn	x2, x2
               	str	x2, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1a0
               	sub	x1, x29, #0x310
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4d               // =77
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	add	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x190
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x180
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	add	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4e               // =78
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	sub	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x170
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x160
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	sub	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4f               // =79
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	mul	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	mul	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	mul	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x50               // =80
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	udiv	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x130
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x120
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	udiv	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	udiv	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x51               // =81
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldrb	w4, [x3]
               	ldrb	w2, [x1]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0]
               	ldrb	w4, [x3, #0x1]
               	ldrb	w2, [x1, #0x1]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w4, [x3, #0x2]
               	ldrb	w2, [x1, #0x2]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w4, [x3, #0x3]
               	ldrb	w2, [x1, #0x3]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w4, [x3, #0x4]
               	ldrb	w2, [x1, #0x4]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w4, [x3, #0x5]
               	ldrb	w2, [x1, #0x5]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w4, [x3, #0x6]
               	ldrb	w2, [x1, #0x6]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w4, [x3, #0x7]
               	ldrb	w2, [x1, #0x7]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w4, [x3, #0x8]
               	ldrb	w2, [x1, #0x8]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w4, [x3, #0x9]
               	ldrb	w2, [x1, #0x9]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w4, [x3, #0xa]
               	ldrb	w2, [x1, #0xa]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w4, [x3, #0xb]
               	ldrb	w2, [x1, #0xb]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w4, [x3, #0xc]
               	ldrb	w2, [x1, #0xc]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w4, [x3, #0xd]
               	ldrb	w2, [x1, #0xd]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w4, [x3, #0xe]
               	ldrb	w2, [x1, #0xe]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w4, [x3, #0xf]
               	ldrb	w2, [x1, #0xf]
               	udiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x110
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w5, [x2]
               	ldrb	w3, [x1]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w3, [x1, #0x1]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w3, [x1, #0x2]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w5, [x2, #0x3]
               	ldrb	w3, [x1, #0x3]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w5, [x2, #0x4]
               	ldrb	w3, [x1, #0x4]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w5, [x2, #0x5]
               	ldrb	w3, [x1, #0x5]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w5, [x2, #0x6]
               	ldrb	w3, [x1, #0x6]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w5, [x2, #0x7]
               	ldrb	w3, [x1, #0x7]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w5, [x2, #0x8]
               	ldrb	w3, [x1, #0x8]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w5, [x2, #0x9]
               	ldrb	w3, [x1, #0x9]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w5, [x2, #0xa]
               	ldrb	w3, [x1, #0xa]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w5, [x2, #0xb]
               	ldrb	w3, [x1, #0xb]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w5, [x2, #0xc]
               	ldrb	w3, [x1, #0xc]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w5, [x2, #0xd]
               	ldrb	w3, [x1, #0xd]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w5, [x2, #0xe]
               	ldrb	w3, [x1, #0xe]
               	udiv	x17, x5, x3
               	msub	x3, x17, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x52               // =82
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x2, [x3]
               	ldr	x4, [x1]
               	and	x2, x2, x4
               	str	x2, [x0]
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x1, #0x8]
               	and	x2, x2, x4
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldr	x3, [x2]
               	ldr	x5, [x1]
               	and	x3, x3, x5
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	and	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x53               // =83
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x2, [x3]
               	ldr	x4, [x1]
               	orr	x2, x2, x4
               	str	x2, [x0]
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x1, #0x8]
               	orr	x2, x2, x4
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldr	x3, [x2]
               	ldr	x5, [x1]
               	orr	x3, x3, x5
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	orr	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x54               // =84
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	sub	x0, x29, #0xf10
               	ldr	x2, [x3]
               	ldr	x4, [x1]
               	eor	x2, x2, x4
               	str	x2, [x0]
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x1, #0x8]
               	eor	x2, x2, x4
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldr	x3, [x2]
               	ldr	x5, [x1]
               	eor	x3, x3, x5
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x55               // =85
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	lsl	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	lsl	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	lsl	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x56               // =86
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	sub	x0, x29, #0xf10
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	lsr	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	lsr	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	lsr	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x57               // =87
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x7c0
               	sub	x0, x29, #0xf10
               	ldrsh	x2, [x3]
               	ldrsh	x4, [x1]
               	sdiv	x2, x2, x4
               	strh	w2, [x0]
               	ldrsh	x2, [x3, #0x2]
               	ldrsh	x4, [x1, #0x2]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0x2]
               	ldrsh	x2, [x3, #0x4]
               	ldrsh	x4, [x1, #0x4]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0x4]
               	ldrsh	x2, [x3, #0x6]
               	ldrsh	x4, [x1, #0x6]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0x6]
               	ldrsh	x2, [x3, #0x8]
               	ldrsh	x4, [x1, #0x8]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0x8]
               	ldrsh	x2, [x3, #0xa]
               	ldrsh	x4, [x1, #0xa]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0xa]
               	ldrsh	x2, [x3, #0xc]
               	ldrsh	x4, [x1, #0xc]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0xc]
               	ldrsh	x2, [x3, #0xe]
               	ldrsh	x4, [x1, #0xe]
               	sdiv	x2, x2, x4
               	strh	w2, [x0, #0xe]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldrsh	x3, [x2]
               	ldrsh	x5, [x1]
               	sdiv	x3, x3, x5
               	strh	w3, [x0]
               	ldrsh	x3, [x2, #0x2]
               	ldrsh	x5, [x1, #0x2]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x2, #0x4]
               	ldrsh	x5, [x1, #0x4]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x2, #0x6]
               	ldrsh	x5, [x1, #0x6]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x2, #0x8]
               	ldrsh	x5, [x1, #0x8]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x2, #0xa]
               	ldrsh	x5, [x1, #0xa]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x2, #0xc]
               	ldrsh	x5, [x1, #0xc]
               	sdiv	x3, x3, x5
               	strh	w3, [x0, #0xc]
               	ldrsh	x3, [x2, #0xe]
               	ldrsh	x1, [x1, #0xe]
               	sdiv	x1, x3, x1
               	strh	w1, [x0, #0xe]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x58               // =88
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x740
               	sub	x0, x29, #0xf10
               	ldr	x2, [x3]
               	ldr	x4, [x1]
               	mul	x2, x2, x4
               	str	x2, [x0]
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x1, #0x8]
               	mul	x2, x2, x4
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldr	x3, [x2]
               	ldr	x5, [x1]
               	mul	x3, x3, x5
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	mul	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x1, x4
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x59               // =89
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x1
               	ldrb	w3, [x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xe]
               	ldrb	w2, [x2, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x10               // =16
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5a               // =90
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x830
               	sub	x0, x29, #0xff0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xf10
               	ldrb	w2, [x0]
               	sub	x2, x2, #0x40
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x8]
               	ldrb	w2, [x0, #0x9]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldrb	w2, [x0]
               	sub	x2, x2, #0x40
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x8]
               	ldrb	w2, [x0, #0x9]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldrb	w2, [x0]
               	sub	x2, x2, #0x40
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x8]
               	ldrb	w2, [x0, #0x9]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x1, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x150
               	sxtw	x1, w0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	sub	x2, x2, #0xc0
               	and	x2, x2, x4
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xff0
               	sub	x1, x29, #0x150
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5b               // =91
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x830
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x820
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x1]
               	ldrb	w5, [x1, #0x1]
               	add	x4, x4, x5
               	ldrb	w5, [x0, #0x2]
               	ldrb	w6, [x1, #0x2]
               	add	x5, x5, x6
               	ldrb	w6, [x0, #0x3]
               	ldrb	w7, [x1, #0x3]
               	add	x6, x6, x7
               	ldrb	w7, [x0, #0x4]
               	ldrb	w8, [x1, #0x4]
               	add	x7, x7, x8
               	ldrb	w8, [x0, #0x5]
               	ldrb	w9, [x1, #0x5]
               	add	x8, x8, x9
               	ldrb	w9, [x0, #0x6]
               	ldrb	w10, [x1, #0x6]
               	add	x9, x9, x10
               	ldrb	w10, [x0, #0x7]
               	ldrb	w11, [x1, #0x7]
               	add	x10, x10, x11
               	ldrb	w11, [x0, #0x8]
               	ldrb	w12, [x1, #0x8]
               	add	x11, x11, x12
               	ldrb	w12, [x0, #0x9]
               	ldrb	w13, [x1, #0x9]
               	add	x12, x12, x13
               	ldrb	w13, [x0, #0xa]
               	ldrb	w14, [x1, #0xa]
               	add	x13, x13, x14
               	ldrb	w14, [x0, #0xb]
               	ldrb	w15, [x1, #0xb]
               	add	x14, x14, x15
               	ldrb	w15, [x0, #0xc]
               	ldrb	w20, [x1, #0xc]
               	add	x15, x15, x20
               	ldrb	w20, [x0, #0xd]
               	ldrb	w21, [x1, #0xd]
               	add	x20, x20, x21
               	ldrb	w21, [x0, #0xe]
               	ldrb	w22, [x1, #0xe]
               	add	x21, x21, x22
               	ldrb	w22, [x0, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x22, x22, x1
               	mov	x1, #0x3                // =3
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	mul	x3, x3, x1
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	mul	x4, x4, x1
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	mul	x5, x5, x1
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	mul	x6, x6, x1
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	mul	x7, x7, x1
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	mul	x8, x8, x1
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	mul	x9, x9, x1
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	mul	x10, x10, x1
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	mul	x11, x11, x1
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	mul	x12, x12, x1
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	mul	x13, x13, x1
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	mul	x14, x14, x1
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	mul	x15, x15, x1
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	mul	x20, x20, x1
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	mul	x21, x21, x1
               	mov	x17, #0xff              // =255
               	and	x22, x22, x17
               	mul	x22, x22, x1
               	sub	x1, x29, #0xf10
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	ldrb	w3, [x0]
               	sub	x2, x2, x3
               	strb	w2, [x1]
               	mov	x17, #0xff              // =255
               	and	x2, x4, x17
               	ldrb	w3, [x0, #0x1]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x1]
               	mov	x17, #0xff              // =255
               	and	x2, x5, x17
               	ldrb	w3, [x0, #0x2]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x6, x17
               	ldrb	w3, [x0, #0x3]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x3]
               	mov	x17, #0xff              // =255
               	and	x2, x7, x17
               	ldrb	w3, [x0, #0x4]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x4]
               	mov	x17, #0xff              // =255
               	and	x2, x8, x17
               	ldrb	w3, [x0, #0x5]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x5]
               	mov	x17, #0xff              // =255
               	and	x2, x9, x17
               	ldrb	w3, [x0, #0x6]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x6]
               	mov	x17, #0xff              // =255
               	and	x2, x10, x17
               	ldrb	w3, [x0, #0x7]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x7]
               	mov	x17, #0xff              // =255
               	and	x2, x11, x17
               	ldrb	w3, [x0, #0x8]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x12, x17
               	ldrb	w3, [x0, #0x9]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x9]
               	mov	x17, #0xff              // =255
               	and	x2, x13, x17
               	ldrb	w3, [x0, #0xa]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xa]
               	mov	x17, #0xff              // =255
               	and	x2, x14, x17
               	ldrb	w3, [x0, #0xb]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xb]
               	mov	x17, #0xff              // =255
               	and	x2, x15, x17
               	ldrb	w3, [x0, #0xc]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xc]
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	ldrb	w3, [x0, #0xd]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xd]
               	mov	x17, #0xff              // =255
               	and	x2, x21, x17
               	ldrb	w3, [x0, #0xe]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xe]
               	mov	x17, #0xff              // =255
               	and	x2, x22, x17
               	ldrb	w0, [x0, #0xf]
               	sub	x0, x2, x0
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0xfe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x6, x29, #0x1, lsl #12  // =0x1000
               	sub	x6, x6, #0x830
               	sub	x7, x29, #0x1, lsl #12  // =0x1000
               	sub	x7, x7, #0x820
               	mov	x0, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x130
               	sxtw	x1, w0
               	add	x9, x3, x1
               	add	x4, x6, x1
               	ldrb	w5, [x4]
               	add	x3, x7, x1
               	ldrb	w3, [x3]
               	add	x3, x5, x3
               	and	x3, x3, x2
               	mul	x3, x3, x8
               	and	x3, x3, x2
               	sub	x3, x3, x5
               	and	x3, x3, x2
               	strb	w3, [x9]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xfe0
               	sub	x1, x29, #0x130
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5c               // =92
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x790
               	mov	x0, #0x3                // =3
               	ldrsw	x2, [x4]
               	sdiv	x2, x2, x0
               	ldrsw	x3, [x4, #0x4]
               	sdiv	x3, x3, x0
               	ldrsw	x5, [x4, #0x8]
               	sdiv	x5, x5, x0
               	ldrsw	x6, [x4, #0xc]
               	sdiv	x6, x6, x0
               	mov	x0, #0x0                // =0
               	sub	x2, x0, x2
               	sub	x3, x0, x3
               	sub	x7, x0, x5
               	sub	x6, x0, x6
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x780
               	sub	x1, x29, #0xf10
               	ldrsw	x8, [x5]
               	add	x2, x2, x8
               	str	w2, [x1]
               	ldrsw	x2, [x5, #0x4]
               	add	x2, x3, x2
               	str	w2, [x1, #0x4]
               	ldrsw	x2, [x5, #0x8]
               	add	x2, x7, x2
               	str	w2, [x1, #0x8]
               	ldrsw	x2, [x5, #0xc]
               	add	x2, x6, x2
               	str	w2, [x1, #0xc]
               	sub	x2, x29, #0xfd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	b	<addr>
               	sub	x2, x29, #0x110
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x8, x2, x1
               	add	x2, x4, x1
               	ldrsw	x2, [x2]
               	mul	x2, x2, x7
               	asr	x2, x2, #32
               	lsr	x9, x2, #63
               	add	x2, x2, x9
               	mul	x2, x2, x6
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	add	x1, x2, x1
               	str	w1, [x8]
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xfd0
               	sub	x1, x29, #0x110
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5d               // =93
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x830
               	sub	x0, x29, #0xfc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xf40
               	ldrb	w2, [x0]
               	lsl	x2, x2, #1
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	lsl	x2, x2, #1
               	add	x3, x1, #0x8
               	strb	w2, [x3]
               	ldrb	w2, [x0, #0x9]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xf]
               	ldrsb	x5, [x0]
               	asr	x5, x5, #7
               	ldrsb	x6, [x0, #0x1]
               	asr	x6, x6, #7
               	ldrsb	x7, [x0, #0x2]
               	asr	x7, x7, #7
               	ldrsb	x8, [x0, #0x3]
               	asr	x8, x8, #7
               	ldrsb	x9, [x0, #0x4]
               	asr	x9, x9, #7
               	ldrsb	x10, [x0, #0x5]
               	asr	x10, x10, #7
               	ldrsb	x11, [x0, #0x6]
               	asr	x11, x11, #7
               	ldrsb	x12, [x0, #0x7]
               	asr	x12, x12, #7
               	ldrsb	x13, [x0, #0x8]
               	asr	x13, x13, #7
               	ldrsb	x14, [x0, #0x9]
               	asr	x14, x14, #7
               	ldrsb	x15, [x0, #0xa]
               	asr	x15, x15, #7
               	ldrsb	x20, [x0, #0xb]
               	asr	x20, x20, #7
               	ldrsb	x21, [x0, #0xc]
               	asr	x21, x21, #7
               	ldrsb	x22, [x0, #0xd]
               	asr	x22, x22, #7
               	ldrsb	x23, [x0, #0xe]
               	asr	x23, x23, #7
               	ldrsb	x0, [x0, #0xf]
               	asr	x24, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0xf30
               	sxtb	x5, w5
               	and	x5, x5, x2
               	strb	w5, [x0]
               	sxtb	x5, w6
               	and	x5, x5, x2
               	strb	w5, [x0, #0x1]
               	sxtb	x5, w7
               	and	x5, x5, x2
               	strb	w5, [x0, #0x2]
               	sxtb	x5, w8
               	and	x5, x5, x2
               	strb	w5, [x0, #0x3]
               	sxtb	x5, w9
               	and	x5, x5, x2
               	strb	w5, [x0, #0x4]
               	sxtb	x5, w10
               	and	x5, x5, x2
               	strb	w5, [x0, #0x5]
               	sxtb	x5, w11
               	and	x5, x5, x2
               	strb	w5, [x0, #0x6]
               	sxtb	x5, w12
               	and	x5, x5, x2
               	strb	w5, [x0, #0x7]
               	sxtb	x5, w13
               	and	x6, x5, x2
               	add	x5, x0, #0x8
               	strb	w6, [x5]
               	sxtb	x6, w14
               	and	x6, x6, x2
               	strb	w6, [x0, #0x9]
               	sxtb	x6, w15
               	and	x6, x6, x2
               	strb	w6, [x0, #0xa]
               	sxtb	x6, w20
               	and	x6, x6, x2
               	strb	w6, [x0, #0xb]
               	sxtb	x6, w21
               	and	x6, x6, x2
               	strb	w6, [x0, #0xc]
               	sxtb	x6, w22
               	and	x6, x6, x2
               	strb	w6, [x0, #0xd]
               	sxtb	x6, w23
               	and	x6, x6, x2
               	strb	w6, [x0, #0xe]
               	sxtb	x6, w24
               	and	x2, x6, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xf10
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x0, x1, x0
               	str	x0, [x2]
               	ldr	x0, [x3]
               	ldr	x1, [x5]
               	eor	x0, x0, x1
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0xfb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x7, #0x1b               // =27
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x4, x1
               	ldrb	w3, [x5]
               	sxtb	x6, w3
               	asr	x6, x6, #7
               	and	x6, x6, x7
               	sub	x8, x29, #0xe0
               	add	x8, x8, x1
               	lsl	x3, x3, #1
               	and	x3, x3, x2
               	and	x5, x6, x2
               	eor	x3, x3, x5
               	and	x3, x3, x2
               	strb	w3, [x8]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xfb0
               	sub	x1, x29, #0xe0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5e               // =94
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x830
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x810
               	sub	x0, x29, #0xf10
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	add	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xfa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0xc0
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	add	x7, x2, x3
               	ldrb	w7, [x7]
               	add	x4, x4, x7
               	and	x4, x4, x5
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xfa0
               	sub	x1, x29, #0xc0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5f               // =95
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0xf90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	sub	x5, x29, #0xf80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	sub	x1, x29, #0xf10
               	mov	x0, #0x42               // =66
               	strb	w0, [x1]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, #0x1]
               	mov	x6, #0x28               // =40
               	strb	w6, [x1, #0x2]
               	strb	w0, [x1, #0x3]
               	mov	x6, #0x1d               // =29
               	strb	w6, [x1, #0x4]
               	strb	w0, [x1, #0x5]
               	mov	x6, #0x16               // =22
               	strb	w6, [x1, #0x6]
               	strb	w0, [x1, #0x7]
               	mov	x6, #0x1                // =1
               	strb	w6, [x1, #0x8]
               	mov	x6, #0x2                // =2
               	strb	w6, [x1, #0x9]
               	mov	x6, #0x3                // =3
               	strb	w6, [x1, #0xa]
               	mov	x6, #0x4                // =4
               	strb	w6, [x1, #0xb]
               	mov	x6, #0x5                // =5
               	strb	w6, [x1, #0xc]
               	mov	x6, #0x6                // =6
               	strb	w6, [x1, #0xd]
               	mov	x6, #0x7                // =7
               	strb	w6, [x1, #0xe]
               	mov	x2, #0x8                // =8
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0xf70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x80
               	sxtw	x1, w0
               	add	x3, x3, x1
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x7, x5, x1
               	ldrb	w7, [x7]
               	sdiv	x6, x6, x7
               	and	x6, x6, x2
               	strb	w6, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xf70
               	sub	x1, x29, #0x80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x67               // =103
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xf90
               	sub	x2, x29, #0xf80
               	sub	x0, x29, #0xf10
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xf60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x60
               	sxtw	x3, w0
               	add	x5, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	add	x6, x2, x3
               	ldrsb	x6, [x6]
               	sdiv	x4, x4, x6
               	strb	w4, [x5]
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xf60
               	sub	x1, x29, #0x60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x68               // =104
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x860
               	ldp	x29, x30, [sp], #0x10
               	ret
