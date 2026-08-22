
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
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x2
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf10
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	x0, x29, #0xed0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xec0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xeb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xea0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xe00
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xdf0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xde0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xee0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xed8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xdd0
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
               	sub	x0, x29, #0xdb0
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
               	sub	x0, x29, #0xd80
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	mov	x3, #0x3                // =3
               	strb	w3, [x0, #0x1]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0, #0x2]
               	mov	x3, #0x7                // =7
               	strb	w3, [x0, #0x3]
               	mov	x3, #0x12c              // =300
               	strb	w3, [x0, #0x4]
               	mov	x3, #0x100              // =256
               	strb	w3, [x0, #0x5]
               	mov	x3, #0x100              // =256
               	strb	w3, [x0, #0x6]
               	mov	x3, #0x12c              // =300
               	strb	w3, [x0, #0x7]
               	mov	x3, #0x100              // =256
               	strb	w3, [x0, #0x8]
               	mov	x3, #0x8                // =8
               	strb	w3, [x0, #0x9]
               	mov	x3, #0xd                // =13
               	strb	w3, [x0, #0xa]
               	mov	x3, #0x10               // =16
               	strb	w3, [x0, #0xb]
               	mov	x3, #0x13               // =19
               	strb	w3, [x0, #0xc]
               	mov	x3, #0x16               // =22
               	strb	w3, [x0, #0xd]
               	mov	x3, #0x1b               // =27
               	strb	w3, [x0, #0xe]
               	mov	x1, #0x1e               // =30
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xd70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	sub	x4, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd60
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd70
               	sub	x1, x29, #0xd60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xd50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	sub	x4, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd40
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	sub	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd50
               	sub	x1, x29, #0xd40
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xd30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	sub	x4, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd20
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	mul	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd30
               	sub	x1, x29, #0xd20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xd10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xd00
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	sdiv	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd10
               	sub	x1, x29, #0xd00
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xcf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xce0
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	sdiv	x17, x5, x6
               	msub	x5, x17, x6, x5
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xcf0
               	sub	x1, x29, #0xce0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xcd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xcc0
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	and	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xcd0
               	sub	x1, x29, #0xcc0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xcb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xca0
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	orr	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xcb0
               	sub	x1, x29, #0xca0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xc90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc80
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	eor	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc90
               	sub	x1, x29, #0xc80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	add	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xc70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	sub	x5, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc60
               	add	x6, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	add	x3, x5, x1
               	ldrsb	x3, [x3]
               	add	x2, x2, x3
               	sxtw	x3, w2
               	strb	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc70
               	sub	x1, x29, #0xc60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xc50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	sub	x5, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc40
               	add	x6, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	add	x3, x5, x1
               	ldrsb	x3, [x3]
               	sub	x2, x2, x3
               	sxtw	x3, w2
               	strb	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc50
               	sub	x1, x29, #0xc40
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xc30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	sub	x5, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc20
               	add	x6, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	add	x3, x5, x1
               	ldrsb	x3, [x3]
               	mul	x2, x2, x3
               	sxtw	x3, w2
               	strb	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc30
               	sub	x1, x29, #0xc20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	sdiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xc10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xeb0
               	sub	x4, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc00
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	add	x6, x4, x1
               	ldrsb	x6, [x6]
               	sdiv	x2, x2, x6
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc10
               	sub	x1, x29, #0xc00
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xbf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xeb0
               	sub	x4, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xbe0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	add	x6, x4, x1
               	ldrsb	x6, [x6]
               	sdiv	x17, x2, x6
               	msub	x2, x17, x6, x2
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xbf0
               	sub	x1, x29, #0xbe0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0xea0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xbd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xeb0
               	sub	x4, x29, #0xea0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xbc0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	add	x6, x4, x1
               	ldrsb	x6, [x6]
               	and	x2, x2, x6
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xbd0
               	sub	x1, x29, #0xbc0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0xe80
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	ldrh	w4, [x2]
               	add	x3, x3, x4
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	ldrh	w4, [x2, #0x2]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	ldrh	w4, [x2, #0x4]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	ldrh	w4, [x2, #0x6]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	ldrh	w4, [x2, #0x8]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	ldrh	w4, [x2, #0xa]
               	add	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	ldrh	w4, [x2, #0xc]
               	add	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	ldrh	w2, [x2, #0xe]
               	add	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xbb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	sub	x4, x29, #0xe80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xba0
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrh	w6, [x6]
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	add	x2, x6, x2
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xbb0
               	sub	x1, x29, #0xba0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0xe80
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	ldrh	w4, [x2]
               	sub	x3, x3, x4
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	ldrh	w4, [x2, #0x2]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	ldrh	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	ldrh	w4, [x2, #0x6]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	ldrh	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	ldrh	w4, [x2, #0xa]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	ldrh	w4, [x2, #0xc]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	ldrh	w2, [x2, #0xe]
               	sub	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xb90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	sub	x4, x29, #0xe80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb80
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrh	w6, [x6]
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	sub	x2, x6, x2
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xb90
               	sub	x1, x29, #0xb80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0xe80
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	ldrh	w4, [x2]
               	mul	x3, x3, x4
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	ldrh	w4, [x2, #0x2]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	ldrh	w4, [x2, #0x4]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	ldrh	w4, [x2, #0x6]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	ldrh	w4, [x2, #0x8]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	ldrh	w4, [x2, #0xa]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	ldrh	w4, [x2, #0xc]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	ldrh	w2, [x2, #0xe]
               	mul	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xb70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	sub	x4, x29, #0xe80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb60
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrh	w6, [x6]
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	mul	x2, x6, x2
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xb70
               	sub	x1, x29, #0xb60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0xe80
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	ldrh	w4, [x2]
               	udiv	x3, x3, x4
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	ldrh	w4, [x2, #0x2]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	ldrh	w4, [x2, #0x4]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	ldrh	w4, [x2, #0x6]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	ldrh	w4, [x2, #0x8]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	ldrh	w4, [x2, #0xa]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	ldrh	w4, [x2, #0xc]
               	udiv	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	ldrh	w2, [x2, #0xe]
               	udiv	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xb50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	sub	x4, x29, #0xe80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb40
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrh	w6, [x6]
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	sdiv	x2, x6, x2
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xb50
               	sub	x1, x29, #0xb40
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0xe80
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	ldrh	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	ldrh	w4, [x2, #0x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	ldrh	w4, [x2, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	ldrh	w4, [x2, #0x6]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	ldrh	w4, [x2, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	ldrh	w4, [x2, #0xa]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	ldrh	w4, [x2, #0xc]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	ldrh	w2, [x2, #0xe]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xb30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	sub	x4, x29, #0xe80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xb20
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrh	w6, [x6]
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	sdiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xb30
               	sub	x1, x29, #0xb20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	add	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	add	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	add	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	add	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	add	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xb10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xe70
               	sub	x5, x29, #0xe60
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xb00
               	lsl	x2, x1, #1
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsh	x3, [x3]
               	add	x2, x5, x2
               	ldrsh	x2, [x2]
               	add	x2, x3, x2
               	sxtw	x3, w2
               	strh	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xb10
               	sub	x1, x29, #0xb00
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	sub	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	sub	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	sub	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xaf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xe70
               	sub	x5, x29, #0xe60
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xae0
               	lsl	x2, x1, #1
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsh	x3, [x3]
               	add	x2, x5, x2
               	ldrsh	x2, [x2]
               	sub	x2, x3, x2
               	sxtw	x3, w2
               	strh	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xaf0
               	sub	x1, x29, #0xae0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	mul	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	mul	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	mul	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xad0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xe70
               	sub	x5, x29, #0xe60
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xac0
               	lsl	x2, x1, #1
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsh	x3, [x3]
               	add	x2, x5, x2
               	ldrsh	x2, [x2]
               	mul	x2, x3, x2
               	sxtw	x3, w2
               	strh	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xad0
               	sub	x1, x29, #0xac0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	sdiv	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	sdiv	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xab0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe70
               	sub	x4, x29, #0xe60
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xaa0
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsh	x6, [x6]
               	add	x2, x4, x2
               	ldrsh	x2, [x2]
               	sdiv	x2, x6, x2
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xab0
               	sub	x1, x29, #0xaa0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0xa90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe70
               	sub	x4, x29, #0xe60
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa80
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsh	x6, [x6]
               	add	x2, x4, x2
               	ldrsh	x2, [x2]
               	sdiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xa90
               	sub	x1, x29, #0xa80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xe40
               	sub	x0, x29, #0xd80
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	add	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	add	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	add	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	ldr	w2, [x2, #0xc]
               	add	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0xa70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	sub	x4, x29, #0xe40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa60
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	add	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa70
               	sub	x1, x29, #0xa60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xe40
               	sub	x0, x29, #0xd80
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	sub	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	ldr	w2, [x2, #0xc]
               	sub	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0xa50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	sub	x4, x29, #0xe40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa40
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	sub	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa50
               	sub	x1, x29, #0xa40
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xe40
               	sub	x0, x29, #0xd80
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	mul	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	mul	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	mul	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	ldr	w2, [x2, #0xc]
               	mul	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0xa30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	sub	x4, x29, #0xe40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa20
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	mul	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa30
               	sub	x1, x29, #0xa20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xe40
               	sub	x0, x29, #0xd80
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	udiv	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	udiv	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	udiv	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	ldr	w2, [x2, #0xc]
               	udiv	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0xa10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	sub	x4, x29, #0xe40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xa00
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	udiv	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa00
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xe40
               	sub	x0, x29, #0xd80
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	ldr	w2, [x2, #0xc]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x9f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	sub	x4, x29, #0xe40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9e0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	udiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x9f0
               	sub	x1, x29, #0x9e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	add	x3, x3, x4
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	add	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	add	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x2, [x2, #0xc]
               	add	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x9d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	sub	x4, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9c0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsw	x6, [x6]
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	add	x2, x6, x2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x9d0
               	sub	x1, x29, #0x9c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	sub	x3, x3, x4
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x2, [x2, #0xc]
               	sub	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x9b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	sub	x4, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x9a0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsw	x6, [x6]
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	sub	x2, x6, x2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x9b0
               	sub	x1, x29, #0x9a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	mul	x3, x3, x4
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	mul	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	mul	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x2, [x2, #0xc]
               	mul	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x990
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	sub	x4, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x980
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsw	x6, [x6]
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	mul	x2, x6, x2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x990
               	sub	x1, x29, #0x980
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	sdiv	x3, x3, x4
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x2, [x2, #0xc]
               	sdiv	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x970
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	sub	x4, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x960
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsw	x6, [x6]
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	sdiv	x2, x6, x2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x970
               	sub	x1, x29, #0x960
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x2, [x2, #0xc]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x950
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	sub	x4, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x940
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsw	x6, [x6]
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	sdiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x950
               	sub	x1, x29, #0x940
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0xe00
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	add	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x930
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe10
               	sub	x4, x29, #0xe00
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x920
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	add	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x930
               	sub	x1, x29, #0x920
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0xe00
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sub	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x910
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe10
               	sub	x4, x29, #0xe00
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x900
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	sub	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x910
               	sub	x1, x29, #0x900
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0xe00
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x8f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe10
               	sub	x4, x29, #0xe00
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x8e0
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	mul	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x8f0
               	sub	x1, x29, #0x8e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x25               // =37
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0xe00
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	udiv	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	udiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x8d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe10
               	sub	x4, x29, #0xe00
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x8c0
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	udiv	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x8d0
               	sub	x1, x29, #0x8c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x26               // =38
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0xe00
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x8b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe10
               	sub	x4, x29, #0xe00
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x8a0
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	udiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x8b0
               	sub	x1, x29, #0x8a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	add	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x890
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	sub	x4, x29, #0xde0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x880
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	add	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x890
               	sub	x1, x29, #0x880
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sub	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x870
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	sub	x4, x29, #0xde0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x860
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	sub	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x870
               	sub	x1, x29, #0x860
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x850
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	sub	x4, x29, #0xde0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x840
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	mul	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x850
               	sub	x1, x29, #0x840
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sdiv	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sdiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x830
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	sub	x4, x29, #0xde0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x820
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	sdiv	x2, x6, x2
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x830
               	sub	x1, x29, #0x820
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x810
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	sub	x4, x29, #0xde0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x800
               	lsl	x2, x1, #3
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	x6, [x6]
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	sdiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	str	x2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x810
               	sub	x1, x29, #0x800
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xee0
               	sub	x2, x29, #0xed8
               	sub	x0, x29, #0xd78
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
               	ldrb	w1, [x1, #0x7]
               	ldrb	w2, [x2, #0x7]
               	add	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x7f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xee0
               	sub	x4, x29, #0xed8
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x7e8
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x7f0
               	sub	x1, x29, #0x7e8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xee0
               	sub	x2, x29, #0xed8
               	sub	x0, x29, #0xd78
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
               	ldrb	w1, [x1, #0x7]
               	ldrb	w2, [x2, #0x7]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x7e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xee0
               	sub	x4, x29, #0xed8
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x7d8
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	mul	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x7e0
               	sub	x1, x29, #0x7d8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdd0
               	sub	x2, x29, #0xdb0
               	sub	x0, x29, #0xd90
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	add	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	add	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	add	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w3, [x1, #0xc]
               	ldr	w4, [x2, #0xc]
               	add	x3, x3, x4
               	str	w3, [x0, #0xc]
               	ldr	w3, [x1, #0x10]
               	ldr	w4, [x2, #0x10]
               	add	x3, x3, x4
               	str	w3, [x0, #0x10]
               	ldr	w3, [x1, #0x14]
               	ldr	w4, [x2, #0x14]
               	add	x3, x3, x4
               	str	w3, [x0, #0x14]
               	ldr	w3, [x1, #0x18]
               	ldr	w4, [x2, #0x18]
               	add	x3, x3, x4
               	str	w3, [x0, #0x18]
               	ldr	w1, [x1, #0x1c]
               	ldr	w2, [x2, #0x1c]
               	add	x1, x1, x2
               	str	w1, [x0, #0x1c]
               	sub	x1, x29, #0x7d0
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
               	sub	x3, x29, #0xdd0
               	sub	x4, x29, #0xdb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x7b0
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	add	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x7d0
               	sub	x1, x29, #0x7b0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2f               // =47
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdd0
               	sub	x2, x29, #0xdb0
               	sub	x0, x29, #0xd90
               	ldr	w3, [x1]
               	ldr	w4, [x2]
               	sub	x3, x3, x4
               	str	w3, [x0]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w3, [x1, #0x8]
               	ldr	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x8]
               	ldr	w3, [x1, #0xc]
               	ldr	w4, [x2, #0xc]
               	sub	x3, x3, x4
               	str	w3, [x0, #0xc]
               	ldr	w3, [x1, #0x10]
               	ldr	w4, [x2, #0x10]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x10]
               	ldr	w3, [x1, #0x14]
               	ldr	w4, [x2, #0x14]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x14]
               	ldr	w3, [x1, #0x18]
               	ldr	w4, [x2, #0x18]
               	sub	x3, x3, x4
               	str	w3, [x0, #0x18]
               	ldr	w1, [x1, #0x1c]
               	ldr	w2, [x2, #0x1c]
               	sub	x1, x1, x2
               	str	w1, [x0, #0x1c]
               	sub	x1, x29, #0x790
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
               	sub	x3, x29, #0xdd0
               	sub	x4, x29, #0xdb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x770
               	lsl	x2, x1, #2
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldr	w6, [x6]
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	sub	x2, x6, x2
               	mov	w2, w2
               	str	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x790
               	sub	x1, x29, #0x770
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x30               // =48
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xdc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xda0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	lsl	x1, x1, #7
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x750
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	sub	x4, x29, #0xdc0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x740
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	lsl	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x750
               	sub	x1, x29, #0x740
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x31               // =49
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xdc0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	lsr	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x730
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	sub	x3, x29, #0xdc0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x720
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	lsr	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x730
               	sub	x1, x29, #0x720
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x32               // =50
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xda0
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	asr	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	asr	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	asr	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x710
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe70
               	sub	x4, x29, #0xda0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x700
               	lsl	x2, x1, #1
               	add	x5, x5, x2
               	add	x6, x3, x2
               	ldrsh	x6, [x6]
               	add	x2, x4, x2
               	ldrsh	x2, [x2]
               	asr	x2, x6, x2
               	strh	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x710
               	sub	x1, x29, #0x700
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x33               // =51
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xda0
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	lsl	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	lsl	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	lsl	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x6f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xe70
               	sub	x5, x29, #0xda0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x6e0
               	lsl	x2, x1, #1
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsh	x3, [x3]
               	add	x2, x5, x2
               	ldrsh	x2, [x2]
               	lsl	x2, x3, x2
               	sxtw	x3, w2
               	strh	w3, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x6f0
               	sub	x1, x29, #0x6e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x34               // =52
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	sub	x0, x29, #0xd80
               	ldrsw	x2, [x1]
               	asr	x2, x2, #3
               	str	w2, [x0]
               	ldrsw	x2, [x1, #0x4]
               	asr	x2, x2, #3
               	str	w2, [x0, #0x4]
               	ldrsw	x2, [x1, #0x8]
               	asr	x2, x2, #3
               	str	w2, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	asr	x1, x1, #3
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x6d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x6c0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	asr	x2, x2, #3
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x1, x29, #0x6c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x35               // =53
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe50
               	sub	x0, x29, #0xd80
               	ldr	w2, [x1]
               	lsr	x2, x2, #3
               	str	w2, [x0]
               	ldr	w2, [x1, #0x4]
               	lsr	x2, x2, #3
               	str	w2, [x0, #0x4]
               	ldr	w2, [x1, #0x8]
               	lsr	x2, x2, #3
               	str	w2, [x0, #0x8]
               	ldr	w1, [x1, #0xc]
               	lsr	x1, x1, #3
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x6b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe50
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x6a0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	w2, [x2]
               	lsr	x2, x2, #3
               	mov	w2, w2
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x6b0
               	sub	x1, x29, #0x6a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x36               // =54
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	lsl	x1, x1, #2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x690
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x680
               	add	x5, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	lsl	x2, x2, #2
               	sxtw	x3, w2
               	strb	w3, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x690
               	sub	x1, x29, #0x680
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x37               // =55
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x670
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x660
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	sub	x2, x2, #0x40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x670
               	sub	x1, x29, #0x660
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x38               // =56
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	add	x1, x1, #0x64
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x650
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x640
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x2, x2, #0x64
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x650
               	sub	x1, x29, #0x640
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x39               // =57
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x630
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x620
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x630
               	sub	x1, x29, #0x620
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3a               // =58
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	udiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x610
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x600
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #34
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x610
               	sub	x1, x29, #0x600
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3b               // =59
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x5f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x5e0
               	add	x5, x2, x1
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x5f0
               	sub	x1, x29, #0x5e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0xf                // =15
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	and	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x5d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x5c0
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x5d0
               	sub	x1, x29, #0x5c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3d               // =61
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0xf0               // =240
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	orr	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x5b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x5a0
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x17, #0xf0              // =240
               	orr	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x5b0
               	sub	x1, x29, #0x5a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3e               // =62
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0x55               // =85
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x590
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x580
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x17, #0x55              // =85
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x590
               	sub	x1, x29, #0x580
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3f               // =63
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	sub	x1, x1, #0x64
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x570
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x560
               	add	x5, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	sub	x2, x2, #0x64
               	sxtw	x3, w2
               	strb	w3, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x570
               	sub	x1, x29, #0x560
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x40               // =64
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	sdiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x550
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x540
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x550
               	sub	x1, x29, #0x540
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x41               // =65
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xeb0
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x520
               	add	x5, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x530
               	sub	x1, x29, #0x520
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x42               // =66
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe90
               	mov	x2, #0x3e8              // =1000
               	sub	x0, x29, #0xd80
               	ldrh	w3, [x1]
               	mul	x3, x3, x2
               	strh	w3, [x0]
               	ldrh	w3, [x1, #0x2]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0x2]
               	ldrh	w3, [x1, #0x4]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0x4]
               	ldrh	w3, [x1, #0x6]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0x6]
               	ldrh	w3, [x1, #0x8]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0x8]
               	ldrh	w3, [x1, #0xa]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0xa]
               	ldrh	w3, [x1, #0xc]
               	mul	x3, x3, x2
               	strh	w3, [x0, #0xc]
               	ldrh	w1, [x1, #0xe]
               	mul	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x510
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe90
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x500
               	lsl	x2, x1, #1
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrh	w2, [x2]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	strh	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x510
               	sub	x1, x29, #0x500
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x43               // =67
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	mul	x3, x3, x2
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x4f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x4e0
               	lsl	x2, x1, #3
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	str	x2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4f0
               	sub	x1, x29, #0x4e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x44               // =68
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x40               // =64
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x4d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x4c0
               	add	x4, x2, x1
               	mov	x2, #0x40               // =64
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	sub	x2, x2, x5
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4d0
               	sub	x1, x29, #0x4c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x45               // =69
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x64               // =100
               	sub	x1, x29, #0xeb0
               	sub	x0, x29, #0xd80
               	ldrsb	x3, [x1]
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x1, [x1, #0xf]
               	sub	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x4b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x4a0
               	add	x5, x2, x1
               	mov	x2, #0x64               // =100
               	add	x3, x4, x1
               	ldrsb	x3, [x3]
               	sub	x2, x2, x3
               	sxtw	x3, w2
               	strb	w3, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x4a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x46               // =70
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	udiv	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	udiv	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x490
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x480
               	add	x3, x3, x1
               	mov	x4, #0xfa               // =250
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	sdiv	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x490
               	sub	x1, x29, #0x480
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x47               // =71
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x470
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x460
               	add	x3, x3, x1
               	mov	x4, #0xfa               // =250
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x470
               	sub	x1, x29, #0x460
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x61               // =97
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	sub	x1, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	and	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x450
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x440
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x450
               	sub	x1, x29, #0x440
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x62               // =98
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	sub	x1, x29, #0xdc0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	lsl	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	lsl	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdc0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x420
               	add	x4, x2, x1
               	mov	x2, #0x3                // =3
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	lsl	x2, x2, x5
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x430
               	sub	x1, x29, #0x420
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x63               // =99
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x80               // =128
               	sub	x1, x29, #0xdc0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	lsr	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	lsr	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xdc0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x400
               	add	x3, x3, x1
               	mov	x4, #0x80               // =128
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	lsr	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x410
               	sub	x1, x29, #0x400
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x64               // =100
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x1, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	sdiv	x3, x2, x3
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	sdiv	x3, x2, x3
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	sdiv	x3, x2, x3
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	sdiv	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x3f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x3e0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	mov	x5, #0xfff9             // =65529
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	sdiv	x2, x5, x2
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x3f0
               	sub	x1, x29, #0x3e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x65               // =101
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x1, x29, #0xe20
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x3c0
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	mov	x5, #0xfff9             // =65529
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	sdiv	x17, x5, x2
               	msub	x2, x17, x2, x5
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x3d0
               	sub	x1, x29, #0x3c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x66               // =102
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	udiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x3b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x3a0
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x3b0
               	sub	x1, x29, #0x3a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x48               // =72
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe30
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0xd80
               	ldrsw	x3, [x1]
               	sdiv	x3, x3, x2
               	str	w3, [x0]
               	ldrsw	x3, [x1, #0x4]
               	sdiv	x3, x3, x2
               	str	w3, [x0, #0x4]
               	ldrsw	x3, [x1, #0x8]
               	sdiv	x3, x3, x2
               	str	w3, [x0, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	sdiv	x1, x1, x2
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xe30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x380
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #34
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x390
               	sub	x1, x29, #0x380
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x60               // =96
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xed0
               	sub	x1, x29, #0xd80
               	ldrb	w3, [x2]
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w2, [x2, #0xf]
               	sub	x2, x0, x2
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0xed0
               	b	<addr>
               	sub	x2, x29, #0x360
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x370
               	sub	x1, x29, #0x360
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x49               // =73
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xeb0
               	sub	x1, x29, #0xd80
               	ldrsb	x3, [x2]
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrsb	x3, [x2, #0x1]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrsb	x3, [x2, #0x2]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrsb	x3, [x2, #0x3]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrsb	x3, [x2, #0x4]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrsb	x3, [x2, #0x5]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrsb	x3, [x2, #0x6]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrsb	x3, [x2, #0x7]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrsb	x3, [x2, #0x8]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrsb	x3, [x2, #0x9]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrsb	x3, [x2, #0xa]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrsb	x3, [x2, #0xb]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrsb	x3, [x2, #0xc]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrsb	x3, [x2, #0xd]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrsb	x3, [x2, #0xe]
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrsb	x2, [x2, #0xf]
               	sub	x2, x0, x2
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x350
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x4, x29, #0xeb0
               	b	<addr>
               	sub	x2, x29, #0x340
               	add	x5, x2, x1
               	add	x2, x4, x1
               	ldrsb	x2, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	sxtw	x3, w2
               	strb	w3, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x350
               	sub	x1, x29, #0x340
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4a               // =74
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xe30
               	sub	x1, x29, #0xd80
               	ldrsw	x3, [x2]
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	str	w3, [x1]
               	ldrsw	x3, [x2, #0x4]
               	sub	x3, x0, x3
               	str	w3, [x1, #0x4]
               	ldrsw	x3, [x2, #0x8]
               	sub	x3, x0, x3
               	str	w3, [x1, #0x8]
               	ldrsw	x2, [x2, #0xc]
               	sub	x2, x0, x2
               	str	w2, [x1, #0xc]
               	sub	x2, x29, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0xe30
               	b	<addr>
               	sub	x4, x29, #0x320
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x330
               	sub	x1, x29, #0x320
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4b               // =75
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	mvn	x1, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x300
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mvn	x4, x4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x310
               	sub	x1, x29, #0x300
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4c               // =76
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x0, x29, #0xd80
               	ldr	x2, [x1]
               	mvn	x2, x2
               	str	x2, [x0]
               	ldr	x1, [x1, #0x8]
               	mvn	x1, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdf0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x2e0
               	lsl	x2, x1, #3
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mvn	x2, x2
               	str	x2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x2f0
               	sub	x1, x29, #0x2e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4d               // =77
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	add	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x2c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x2c0
               	sub	x1, x29, #0x2c0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	add	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	add	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x2d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4e               // =78
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x2a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x2a0
               	sub	x1, x29, #0x2a0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	sub	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x2b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4f               // =79
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x290
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x280
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x280
               	sub	x1, x29, #0x280
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	mul	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	mul	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x280
               	sub	x1, x29, #0x290
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x50               // =80
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x270
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x260
               	sub	x1, x29, #0x260
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	udiv	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x260
               	sub	x1, x29, #0x270
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x51               // =81
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x250
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x240
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x240
               	sub	x1, x29, #0x240
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x240
               	sub	x1, x29, #0x250
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x52               // =82
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x230
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x220
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x220
               	sub	x1, x29, #0x220
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	and	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x220
               	sub	x1, x29, #0x230
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x53               // =83
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x200
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x200
               	sub	x1, x29, #0x200
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	orr	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x200
               	sub	x1, x29, #0x210
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x54               // =84
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1e0
               	sub	x1, x29, #0x1e0
               	sub	x2, x29, #0xec0
               	sub	x0, x29, #0xd80
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	eor	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x1e0
               	sub	x1, x29, #0x1f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x55               // =85
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xdc0
               	sub	x0, x29, #0xd80
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	lsl	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	lsl	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1c0
               	sub	x1, x29, #0x1c0
               	sub	x2, x29, #0xdc0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	lsl	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	lsl	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	lsl	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x1c0
               	sub	x1, x29, #0x1d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x56               // =86
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xdc0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	lsr	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1a0
               	sub	x1, x29, #0x1a0
               	sub	x2, x29, #0xdc0
               	sub	x0, x29, #0xd80
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	lsr	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	lsr	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x1b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x57               // =87
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x2]
               	sdiv	x3, x3, x4
               	strh	w3, [x0]
               	ldrsh	x3, [x1, #0x2]
               	ldrsh	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x2]
               	ldrsh	x3, [x1, #0x4]
               	ldrsh	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x4]
               	ldrsh	x3, [x1, #0x6]
               	ldrsh	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x6]
               	ldrsh	x3, [x1, #0x8]
               	ldrsh	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0x8]
               	ldrsh	x3, [x1, #0xa]
               	ldrsh	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0xa]
               	ldrsh	x3, [x1, #0xc]
               	ldrsh	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strh	w3, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	sdiv	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x190
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xe70
               	sub	x1, x29, #0x180
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x180
               	sub	x1, x29, #0x180
               	sub	x2, x29, #0xe60
               	sub	x0, x29, #0xd80
               	ldrsh	x4, [x1]
               	ldrsh	x5, [x2]
               	sdiv	x4, x4, x5
               	strh	w4, [x0]
               	ldrsh	x4, [x1, #0x2]
               	ldrsh	x5, [x2, #0x2]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0x2]
               	ldrsh	x4, [x1, #0x4]
               	ldrsh	x5, [x2, #0x4]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0x4]
               	ldrsh	x4, [x1, #0x6]
               	ldrsh	x5, [x2, #0x6]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0x6]
               	ldrsh	x4, [x1, #0x8]
               	ldrsh	x5, [x2, #0x8]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0x8]
               	ldrsh	x4, [x1, #0xa]
               	ldrsh	x5, [x2, #0xa]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0xa]
               	ldrsh	x4, [x1, #0xc]
               	ldrsh	x5, [x2, #0xc]
               	sdiv	x4, x4, x5
               	strh	w4, [x0, #0xc]
               	ldrsh	x1, [x1, #0xe]
               	ldrsh	x2, [x2, #0xe]
               	sdiv	x1, x1, x2
               	strh	w1, [x0, #0xe]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x180
               	sub	x1, x29, #0x190
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x58               // =88
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x170
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xdf0
               	sub	x1, x29, #0x160
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x160
               	sub	x1, x29, #0x160
               	sub	x2, x29, #0xde0
               	sub	x0, x29, #0xd80
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	mul	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x160
               	sub	x1, x29, #0x170
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x59               // =89
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x150
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x140
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5a               // =90
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0x130
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x130
               	sub	x1, x29, #0x130
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x2, x29, #0x130
               	sub	x1, x29, #0x130
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x2, x29, #0x130
               	sub	x1, x29, #0x130
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x1, #0x40
               	strb	w1, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x120
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	sub	x2, x2, #0xc0
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x130
               	sub	x1, x29, #0x120
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5b               // =91
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0xec0
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
               	ldrb	w0, [x0, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x22, x0, x1
               	mov	x0, #0x3                // =3
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	mul	x2, x2, x0
               	mov	x17, #0xff              // =255
               	and	x3, x4, x17
               	mul	x3, x3, x0
               	mov	x17, #0xff              // =255
               	and	x4, x5, x17
               	mul	x4, x4, x0
               	mov	x17, #0xff              // =255
               	and	x5, x6, x17
               	mul	x5, x5, x0
               	mov	x17, #0xff              // =255
               	and	x6, x7, x17
               	mul	x6, x6, x0
               	mov	x17, #0xff              // =255
               	and	x7, x8, x17
               	mul	x7, x7, x0
               	mov	x17, #0xff              // =255
               	and	x8, x9, x17
               	mul	x8, x8, x0
               	mov	x17, #0xff              // =255
               	and	x9, x10, x17
               	mul	x9, x9, x0
               	mov	x17, #0xff              // =255
               	and	x10, x11, x17
               	mul	x10, x10, x0
               	mov	x17, #0xff              // =255
               	and	x11, x12, x17
               	mul	x11, x11, x0
               	mov	x17, #0xff              // =255
               	and	x12, x13, x17
               	mul	x12, x12, x0
               	mov	x17, #0xff              // =255
               	and	x13, x14, x17
               	mul	x13, x13, x0
               	mov	x17, #0xff              // =255
               	and	x14, x15, x17
               	mul	x14, x14, x0
               	mov	x17, #0xff              // =255
               	and	x15, x20, x17
               	mul	x15, x15, x0
               	mov	x17, #0xff              // =255
               	and	x20, x21, x17
               	mul	x20, x20, x0
               	mov	x17, #0xff              // =255
               	and	x21, x22, x17
               	mul	x21, x21, x0
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xd80
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x1]
               	sub	x2, x2, x22
               	strb	w2, [x0]
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	ldrb	w3, [x1, #0x1]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x1]
               	mov	x17, #0xff              // =255
               	and	x2, x4, x17
               	ldrb	w3, [x1, #0x2]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x5, x17
               	ldrb	w3, [x1, #0x3]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x2, x6, x17
               	ldrb	w3, [x1, #0x4]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x2, x7, x17
               	ldrb	w3, [x1, #0x5]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x5]
               	mov	x17, #0xff              // =255
               	and	x2, x8, x17
               	ldrb	w3, [x1, #0x6]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x6]
               	mov	x17, #0xff              // =255
               	and	x2, x9, x17
               	ldrb	w3, [x1, #0x7]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x7]
               	mov	x17, #0xff              // =255
               	and	x2, x10, x17
               	ldrb	w3, [x1, #0x8]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x11, x17
               	ldrb	w3, [x1, #0x9]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x9]
               	mov	x17, #0xff              // =255
               	and	x2, x12, x17
               	ldrb	w3, [x1, #0xa]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xa]
               	mov	x17, #0xff              // =255
               	and	x2, x13, x17
               	ldrb	w3, [x1, #0xb]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xb]
               	mov	x17, #0xff              // =255
               	and	x2, x14, x17
               	ldrb	w3, [x1, #0xc]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xc]
               	mov	x17, #0xff              // =255
               	and	x2, x15, x17
               	ldrb	w3, [x1, #0xd]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xd]
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	ldrb	w3, [x1, #0xe]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xe]
               	mov	x17, #0xff              // =255
               	and	x2, x21, x17
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x110
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x5, x29, #0xed0
               	sub	x6, x29, #0xec0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x100
               	add	x7, x2, x1
               	add	x3, x5, x1
               	ldrb	w4, [x3]
               	add	x2, x6, x1
               	ldrb	w2, [x2]
               	add	x2, x4, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sub	x2, x2, x4
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x7]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0x100
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5c               // =92
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe30
               	mov	x1, #0x3                // =3
               	ldrsw	x3, [x0]
               	sdiv	x3, x3, x1
               	ldrsw	x4, [x0, #0x4]
               	sdiv	x4, x4, x1
               	ldrsw	x5, [x0, #0x8]
               	sdiv	x5, x5, x1
               	ldrsw	x0, [x0, #0xc]
               	sdiv	x6, x0, x1
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	sub	x4, x0, x4
               	sub	x5, x0, x5
               	sub	x6, x0, x6
               	sub	x2, x29, #0xe20
               	sub	x1, x29, #0xd80
               	ldrsw	x7, [x2]
               	add	x3, x3, x7
               	str	w3, [x1]
               	ldrsw	x3, [x2, #0x4]
               	add	x3, x4, x3
               	str	w3, [x1, #0x4]
               	ldrsw	x3, [x2, #0x8]
               	add	x3, x5, x3
               	str	w3, [x1, #0x8]
               	ldrsw	x2, [x2, #0xc]
               	add	x2, x6, x2
               	str	w2, [x1, #0xc]
               	sub	x2, x29, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x4, x29, #0xe30
               	sub	x5, x29, #0xe20
               	b	<addr>
               	sub	x3, x29, #0xe0
               	lsl	x2, x1, #2
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsw	x3, [x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	add	x2, x5, x2
               	ldrsw	x2, [x2]
               	add	x2, x3, x2
               	str	w2, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0xe0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5d               // =93
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xed0
               	sub	x1, x29, #0xd80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xd80
               	sub	x1, x29, #0xdc0
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
               	ldrb	w0, [x0, #0xf]
               	lsl	x0, x0, #1
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0xd80
               	ldrsb	x4, [x0]
               	asr	x4, x4, #7
               	ldrsb	x5, [x0, #0x1]
               	asr	x5, x5, #7
               	ldrsb	x6, [x0, #0x2]
               	asr	x6, x6, #7
               	ldrsb	x7, [x0, #0x3]
               	asr	x7, x7, #7
               	ldrsb	x8, [x0, #0x4]
               	asr	x8, x8, #7
               	ldrsb	x9, [x0, #0x5]
               	asr	x9, x9, #7
               	ldrsb	x10, [x0, #0x6]
               	asr	x10, x10, #7
               	ldrsb	x11, [x0, #0x7]
               	asr	x11, x11, #7
               	ldrsb	x12, [x0, #0x8]
               	asr	x12, x12, #7
               	ldrsb	x13, [x0, #0x9]
               	asr	x13, x13, #7
               	ldrsb	x14, [x0, #0xa]
               	asr	x14, x14, #7
               	ldrsb	x15, [x0, #0xb]
               	asr	x15, x15, #7
               	ldrsb	x20, [x0, #0xc]
               	asr	x20, x20, #7
               	ldrsb	x21, [x0, #0xd]
               	asr	x21, x21, #7
               	ldrsb	x22, [x0, #0xe]
               	asr	x22, x22, #7
               	ldrsb	x0, [x0, #0xf]
               	asr	x23, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0xda0
               	sxtb	x4, w4
               	and	x4, x4, x2
               	strb	w4, [x0]
               	sxtb	x4, w5
               	and	x4, x4, x2
               	strb	w4, [x0, #0x1]
               	sxtb	x4, w6
               	and	x4, x4, x2
               	strb	w4, [x0, #0x2]
               	sxtb	x4, w7
               	and	x4, x4, x2
               	strb	w4, [x0, #0x3]
               	sxtb	x4, w8
               	and	x4, x4, x2
               	strb	w4, [x0, #0x4]
               	sxtb	x4, w9
               	and	x4, x4, x2
               	strb	w4, [x0, #0x5]
               	sxtb	x4, w10
               	and	x4, x4, x2
               	strb	w4, [x0, #0x6]
               	sxtb	x4, w11
               	and	x4, x4, x2
               	strb	w4, [x0, #0x7]
               	sxtb	x4, w12
               	and	x5, x4, x2
               	add	x4, x0, #0x8
               	strb	w5, [x4]
               	sxtb	x5, w13
               	and	x5, x5, x2
               	strb	w5, [x0, #0x9]
               	sxtb	x5, w14
               	and	x5, x5, x2
               	strb	w5, [x0, #0xa]
               	sxtb	x5, w15
               	and	x5, x5, x2
               	strb	w5, [x0, #0xb]
               	sxtb	x5, w20
               	and	x5, x5, x2
               	strb	w5, [x0, #0xc]
               	sxtb	x5, w21
               	and	x5, x5, x2
               	strb	w5, [x0, #0xd]
               	sxtb	x5, w22
               	and	x5, x5, x2
               	strb	w5, [x0, #0xe]
               	sxtb	x5, w23
               	and	x2, x5, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xd80
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x0, x1, x0
               	str	x0, [x2]
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	eor	x0, x0, x1
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0xed0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	sxtb	x2, w2
               	asr	x2, x2, #7
               	mov	x17, #0x1b              // =27
               	and	x4, x2, x17
               	sub	x2, x29, #0xc0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	lsl	x2, x2, #1
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x2, x2, x4
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0xc0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5e               // =94
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0xeb0
               	sub	x0, x29, #0xd80
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
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	add	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xed0
               	sub	x4, x29, #0xeb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xa0
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x2, x2, x6
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0xa0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5f               // =95
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xdc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xda0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xd80
               	mov	x3, #0x42               // =66
               	strb	w3, [x0]
               	mov	x3, #0x0                // =0
               	strb	w3, [x0, #0x1]
               	mov	x3, #0x28               // =40
               	strb	w3, [x0, #0x2]
               	mov	x3, #0x0                // =0
               	strb	w3, [x0, #0x3]
               	mov	x3, #0x1d               // =29
               	strb	w3, [x0, #0x4]
               	mov	x3, #0x0                // =0
               	strb	w3, [x0, #0x5]
               	mov	x3, #0x16               // =22
               	strb	w3, [x0, #0x6]
               	mov	x3, #0x0                // =0
               	strb	w3, [x0, #0x7]
               	mov	x3, #0x1                // =1
               	strb	w3, [x0, #0x8]
               	mov	x3, #0x2                // =2
               	strb	w3, [x0, #0x9]
               	mov	x3, #0x3                // =3
               	strb	w3, [x0, #0xa]
               	mov	x3, #0x4                // =4
               	strb	w3, [x0, #0xb]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0, #0xc]
               	mov	x3, #0x6                // =6
               	strb	w3, [x0, #0xd]
               	mov	x3, #0x7                // =7
               	strb	w3, [x0, #0xe]
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xdc0
               	sub	x3, x29, #0xda0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x80
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	sdiv	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x67               // =103
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xdc0
               	sub	x2, x29, #0xda0
               	sub	x0, x29, #0xd80
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
               	ldrsb	x1, [x1, #0xf]
               	ldrsb	x2, [x2, #0xf]
               	sdiv	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xdc0
               	sub	x4, x29, #0xda0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x60
               	add	x5, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	add	x6, x4, x1
               	ldrsb	x6, [x6]
               	sdiv	x2, x2, x6
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x68               // =104
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xf10
               	ldp	x29, x30, [sp], #0x10
               	ret
