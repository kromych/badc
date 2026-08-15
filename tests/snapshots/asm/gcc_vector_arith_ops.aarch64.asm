
gcc_vector_arith_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
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
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x700
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x560
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x570
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x580
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x590
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5e0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x600
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x610
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x620
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x630
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x640
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x648
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x650
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x670
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
               	sub	x0, x0, #0x690
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
               	sub	x0, x29, #0x18
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6b0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6a0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x28
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x540
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x530
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x540
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x38
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x510
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x520
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x510
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x520
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x48
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x500
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x500
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x58
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x4e0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x68
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x4c0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x78
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x4a0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x490
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x88
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x480
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x470
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x480
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0x98
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x450
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x460
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x450
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x460
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0xa8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x440
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x430
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x440
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0xb8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x420
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x410
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x420
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0xc8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x570
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x400
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x400
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0xd8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x570
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3e0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x580
               	sub	x0, x29, #0xe8
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x570
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x580
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3c0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	sub	x0, x29, #0xf8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5a0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x3a0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x390
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	sub	x0, x29, #0x108
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5a0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x380
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x370
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x380
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	sub	x0, x29, #0x118
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x350
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5a0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x360
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x350
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x360
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	sub	x0, x29, #0x128
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5a0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x340
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x330
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x340
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	sub	x0, x29, #0x138
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5a0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x320
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x310
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x320
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x148
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5b0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x5c0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x300
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x300
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x158
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5b0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x5c0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x2e0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x168
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5b0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x5c0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x2c0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x178
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x290
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5c0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x2a0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x188
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x270
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5c0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x280
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x270
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x280
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	sub	x0, x29, #0x198
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x250
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5e0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x260
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x260
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	sub	x0, x29, #0x1a8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x230
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5e0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x240
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x230
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x240
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	sub	x0, x29, #0x1b8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5e0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x220
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x210
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x220
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1b               // =27
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	sub	x0, x29, #0x1c8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5e0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x200
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x200
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1c               // =28
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	sub	x0, x29, #0x1d8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5e0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x1e0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1d               // =29
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x0, x29, #0x1e8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x1c0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1e               // =30
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x0, x29, #0x1f8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x190
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x1a0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x190
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x0, x29, #0x208
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x170
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x180
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x170
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x180
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x0, x29, #0x218
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x160
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x150
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x160
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x0, x29, #0x228
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x130
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x140
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x130
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x140
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	sub	x0, x29, #0x238
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	add	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x110
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x610
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x620
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x120
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x110
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x120
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x23               // =35
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	sub	x0, x29, #0x248
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sub	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x610
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x620
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x100
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xf0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x100
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x24               // =36
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	sub	x0, x29, #0x258
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x610
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x620
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0xe0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xd0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xe0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x25               // =37
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	sub	x0, x29, #0x268
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	udiv	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	udiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x610
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x620
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0xc0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xb0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xc0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x26               // =38
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	sub	x0, x29, #0x278
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x610
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x620
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0xa0
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x90
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xa0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x27               // =39
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x288
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	add	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	add	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x640
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x80
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x70
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x28               // =40
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x298
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sub	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sub	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x640
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x60
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x50
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x2a8
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x640
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x40
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x30
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x40
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x2b8
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	sdiv	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	sdiv	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x640
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x20
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2b               // =43
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x2c8
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
               	sub	x1, x29, #0xff0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x640
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
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
               	sub	x0, x29, #0xff0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2c               // =44
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x648
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x650
               	sub	x0, x29, #0x2d0
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x648
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x650
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6c8
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6c8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2d               // =45
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x648
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x650
               	sub	x0, x29, #0x2d8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x648
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x650
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6b8
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
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6c0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6b8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2e               // =46
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x670
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x690
               	sub	x0, x29, #0x2f8
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
               	sub	x1, x29, #0xfc0
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
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x670
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x690
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xfe0
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
               	sub	x0, x29, #0xfc0
               	sub	x1, x29, #0xfe0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2f               // =47
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x670
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x690
               	sub	x0, x29, #0x318
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
               	sub	x1, x29, #0xf80
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
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x670
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x690
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xfa0
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
               	sub	x0, x29, #0xf80
               	sub	x1, x29, #0xfa0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x30               // =48
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xf30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xf40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x328
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
               	sub	x1, x29, #0xf50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	sub	x4, x29, #0xf30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xf60
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
               	sub	x0, x29, #0xf50
               	sub	x1, x29, #0xf60
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x31               // =49
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0xf30
               	sub	x0, x29, #0x338
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
               	sub	x1, x29, #0xf08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x3, x29, #0xf30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xf18
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
               	sub	x0, x29, #0xf08
               	sub	x1, x29, #0xf18
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x32               // =50
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0xf40
               	sub	x0, x29, #0x348
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
               	sub	x1, x29, #0xee8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5b0
               	sub	x4, x29, #0xf40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x5, x29, #0xef8
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
               	sub	x0, x29, #0xee8
               	sub	x1, x29, #0xef8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x33               // =51
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0xf40
               	sub	x0, x29, #0x358
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
               	sub	x1, x29, #0xec8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5b0
               	sub	x5, x29, #0xf40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xed8
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
               	sub	x0, x29, #0xec8
               	sub	x1, x29, #0xed8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x34               // =52
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	sub	x0, x29, #0x368
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
               	sub	x1, x29, #0xea8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xeb8
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
               	sub	x0, x29, #0xea8
               	sub	x1, x29, #0xeb8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x0, x29, #0x378
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
               	sub	x1, x29, #0xe88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5d0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xe98
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
               	sub	x0, x29, #0xe88
               	sub	x1, x29, #0xe98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x36               // =54
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x0, x29, #0x388
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
               	sub	x1, x29, #0xe68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xe78
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
               	sub	x0, x29, #0xe68
               	sub	x1, x29, #0xe78
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x37               // =55
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x398
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
               	sub	x1, x29, #0xe48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xe58
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
               	sub	x0, x29, #0xe48
               	sub	x1, x29, #0xe58
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x38               // =56
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x3a8
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
               	sub	x1, x29, #0xe28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xe38
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
               	sub	x0, x29, #0xe28
               	sub	x1, x29, #0xe38
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x39               // =57
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x3b8
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
               	sub	x1, x29, #0xe08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xe18
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
               	sub	x0, x29, #0xe08
               	sub	x1, x29, #0xe18
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3a               // =58
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x3c8
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
               	sub	x1, x29, #0xde8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xdf8
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x5, #0x7                // =7
               	sdiv	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xde8
               	sub	x1, x29, #0xdf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3b               // =59
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x3d8
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
               	sub	x1, x29, #0xdc8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xdd8
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x5, #0x7                // =7
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xdc8
               	sub	x1, x29, #0xdd8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3c               // =60
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0xf                // =15
               	sub	x0, x29, #0x3e8
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
               	sub	x1, x29, #0xda8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xdb8
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
               	sub	x0, x29, #0xda8
               	sub	x1, x29, #0xdb8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3d               // =61
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0xf0               // =240
               	sub	x0, x29, #0x3f8
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
               	sub	x1, x29, #0xd88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xd98
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
               	sub	x0, x29, #0xd88
               	sub	x1, x29, #0xd98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3e               // =62
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0x55               // =85
               	sub	x0, x29, #0x408
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
               	sub	x1, x29, #0xd68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xd78
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
               	sub	x0, x29, #0xd68
               	sub	x1, x29, #0xd78
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3f               // =63
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x0, x29, #0x418
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
               	sub	x1, x29, #0xd48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd58
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
               	sub	x0, x29, #0xd48
               	sub	x1, x29, #0xd58
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x40               // =64
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0x428
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
               	sub	x1, x29, #0xd28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd38
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	mov	x5, #0x3                // =3
               	sdiv	x2, x2, x5
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd28
               	sub	x1, x29, #0xd38
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x41               // =65
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0x438
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
               	sub	x1, x29, #0xd08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xd18
               	add	x4, x2, x1
               	add	x2, x3, x1
               	ldrsb	x2, [x2]
               	mov	x5, #0x3                // =3
               	sdiv	x17, x2, x5
               	msub	x2, x17, x5, x2
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd08
               	sub	x1, x29, #0xd18
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x42               // =66
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	mov	x2, #0x3e8              // =1000
               	sub	x0, x29, #0x448
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
               	sub	x1, x29, #0xce8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x590
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xcf8
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
               	sub	x0, x29, #0xce8
               	sub	x1, x29, #0xcf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x43               // =67
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x458
               	ldr	x3, [x1]
               	mul	x3, x3, x2
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xcc8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xcd8
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
               	sub	x0, x29, #0xcc8
               	sub	x1, x29, #0xcd8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x44               // =68
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x40               // =64
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x468
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
               	sub	x1, x29, #0xca8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xcb8
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
               	sub	x0, x29, #0xca8
               	sub	x1, x29, #0xcb8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x45               // =69
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x64               // =100
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x570
               	sub	x0, x29, #0x478
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
               	sub	x1, x29, #0xc88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc98
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
               	sub	x0, x29, #0xc88
               	sub	x1, x29, #0xc98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x46               // =70
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
               	sub	x0, x29, #0x488
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
               	sub	x1, x29, #0xc68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xc78
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
               	sub	x0, x29, #0xc68
               	sub	x1, x29, #0xc78
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x47               // =71
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
               	sub	x0, x29, #0x498
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
               	sub	x1, x29, #0xc48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xc58
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
               	sub	x0, x29, #0xc48
               	sub	x1, x29, #0xc58
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x61               // =97
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
               	sub	x0, x29, #0x4a8
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
               	sub	x1, x29, #0xc28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xc38
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
               	sub	x0, x29, #0xc28
               	sub	x1, x29, #0xc38
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x62               // =98
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	sub	x1, x29, #0xf30
               	sub	x0, x29, #0x4b8
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
               	sub	x1, x29, #0xc08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xf30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc18
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
               	sub	x0, x29, #0xc08
               	sub	x1, x29, #0xc18
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x63               // =99
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x80               // =128
               	sub	x1, x29, #0xf30
               	sub	x0, x29, #0x4c8
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
               	sub	x1, x29, #0xbe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xf30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xbf8
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
               	sub	x0, x29, #0xbe8
               	sub	x1, x29, #0xbf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x64               // =100
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x600
               	sub	x0, x29, #0x4d8
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
               	sub	x1, x29, #0xbc8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xbd8
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
               	sub	x0, x29, #0xbc8
               	sub	x1, x29, #0xbd8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x65               // =101
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x600
               	sub	x0, x29, #0x4e8
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
               	sub	x1, x29, #0xba8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x600
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xbb8
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
               	sub	x0, x29, #0xba8
               	sub	x1, x29, #0xbb8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x66               // =102
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0x4f8
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
               	sub	x1, x29, #0xb88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xb98
               	add	x3, x3, x1
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	mov	x5, #0x3                // =3
               	sdiv	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xb88
               	sub	x1, x29, #0xb98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x48               // =72
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5f0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x508
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
               	sub	x1, x29, #0xb68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xb78
               	lsl	x2, x1, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	mov	x5, #0x7                // =7
               	sdiv	x2, x2, x5
               	str	w2, [x4]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xb68
               	sub	x1, x29, #0xb78
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x60               // =96
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	sub	x1, x29, #0x518
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
               	sub	x2, x29, #0xb48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	b	<addr>
               	sub	x2, x29, #0xb58
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
               	sub	x0, x29, #0xb48
               	sub	x1, x29, #0xb58
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x49               // =73
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x570
               	sub	x1, x29, #0x528
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
               	sub	x2, x29, #0xb28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	b	<addr>
               	sub	x2, x29, #0xb38
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
               	sub	x0, x29, #0xb28
               	sub	x1, x29, #0xb38
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4a               // =74
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5f0
               	sub	x1, x29, #0x538
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
               	sub	x2, x29, #0xb08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x5f0
               	b	<addr>
               	sub	x4, x29, #0xb18
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
               	sub	x0, x29, #0xb08
               	sub	x1, x29, #0xb18
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4b               // =75
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x548
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
               	sub	x1, x29, #0xae8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xaf8
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
               	sub	x0, x29, #0xae8
               	sub	x1, x29, #0xaf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4c               // =76
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x0, x29, #0x558
               	ldr	x2, [x1]
               	mvn	x2, x2
               	str	x2, [x0]
               	ldr	x1, [x1, #0x8]
               	mvn	x1, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xac8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x630
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xad8
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
               	sub	x0, x29, #0xac8
               	sub	x1, x29, #0xad8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4d               // =77
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x568
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
               	sub	x1, x29, #0x908
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x918
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x918
               	sub	x1, x29, #0x918
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x578
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
               	sub	x0, x29, #0x918
               	sub	x1, x29, #0x908
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4e               // =78
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x588
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
               	sub	x1, x29, #0x928
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x938
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x938
               	sub	x1, x29, #0x938
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x598
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
               	sub	x0, x29, #0x938
               	sub	x1, x29, #0x928
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4f               // =79
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5a8
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
               	sub	x1, x29, #0x948
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x958
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x958
               	sub	x1, x29, #0x958
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5b8
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
               	sub	x0, x29, #0x958
               	sub	x1, x29, #0x948
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x50               // =80
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5c8
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
               	sub	x1, x29, #0x968
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x978
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x978
               	sub	x1, x29, #0x978
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5d8
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
               	sub	x0, x29, #0x978
               	sub	x1, x29, #0x968
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x51               // =81
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5e8
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
               	sub	x1, x29, #0x988
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x998
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x998
               	sub	x1, x29, #0x998
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x5f8
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
               	sub	x0, x29, #0x998
               	sub	x1, x29, #0x988
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x52               // =82
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x608
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x9a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x9b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x9b8
               	sub	x1, x29, #0x9b8
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x618
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
               	sub	x0, x29, #0x9b8
               	sub	x1, x29, #0x9a8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x53               // =83
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x628
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x9c8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x9d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x9d8
               	sub	x1, x29, #0x9d8
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x638
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
               	sub	x0, x29, #0x9d8
               	sub	x1, x29, #0x9c8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x54               // =84
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x648
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x9e8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x9f8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x9f8
               	sub	x1, x29, #0x9f8
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	sub	x0, x29, #0x658
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
               	sub	x0, x29, #0x9f8
               	sub	x1, x29, #0x9e8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x55               // =85
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0xf30
               	sub	x0, x29, #0x668
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
               	sub	x1, x29, #0xa08
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0xa18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xa18
               	sub	x1, x29, #0xa18
               	sub	x2, x29, #0xf30
               	sub	x0, x29, #0x678
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
               	sub	x0, x29, #0xa18
               	sub	x1, x29, #0xa08
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x56               // =86
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0xf30
               	sub	x0, x29, #0x688
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
               	sub	x1, x29, #0xa28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0xa38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xa38
               	sub	x1, x29, #0xa38
               	sub	x2, x29, #0xf30
               	sub	x0, x29, #0x698
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
               	sub	x0, x29, #0xa38
               	sub	x1, x29, #0xa28
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x57               // =87
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x6a8
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
               	sub	x1, x29, #0xa48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5b0
               	sub	x1, x29, #0xa58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xa58
               	sub	x1, x29, #0xa58
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x6b8
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
               	sub	x0, x29, #0xa58
               	sub	x1, x29, #0xa48
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x58               // =88
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x630
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x6c8
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	mul	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	mul	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xa68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x630
               	sub	x1, x29, #0xa78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0xa78
               	sub	x1, x29, #0xa78
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x640
               	sub	x0, x29, #0x6d8
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
               	sub	x0, x29, #0xa78
               	sub	x1, x29, #0xa68
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x59               // =89
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0xa88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xa88
               	sub	x1, x29, #0xa88
               	sub	x0, x29, #0x6e8
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x6f8
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
               	sub	x1, x29, #0xa98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa88
               	sub	x1, x29, #0xa98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5a               // =90
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0xaa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0xaa8
               	sub	x1, x29, #0xaa8
               	sub	x0, x29, #0x708
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
               	sub	x2, x29, #0xaa8
               	sub	x1, x29, #0xaa8
               	sub	x0, x29, #0x718
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
               	sub	x2, x29, #0xaa8
               	sub	x1, x29, #0xaa8
               	sub	x0, x29, #0x728
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
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xab8
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
               	sub	x0, x29, #0xaa8
               	sub	x1, x29, #0xab8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5b               // =91
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
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
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x0, x29, #0x758
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
               	sub	x1, x29, #0x8e8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x550
               	sub	x6, x29, #0x1, lsl #12  // =0x1000
               	sub	x6, x6, #0x560
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x8f8
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
               	sub	x0, x29, #0x8e8
               	sub	x1, x29, #0x8f8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5c               // =92
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5f0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x600
               	sub	x1, x29, #0x788
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
               	sub	x2, x29, #0x8c8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x5f0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x600
               	b	<addr>
               	sub	x3, x29, #0x8d8
               	lsl	x2, x1, #2
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldrsw	x3, [x3]
               	mov	x7, #0x3                // =3
               	sdiv	x3, x3, x7
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
               	sub	x0, x29, #0x8c8
               	sub	x1, x29, #0x8d8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5d               // =93
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x550
               	sub	x1, x29, #0x898
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x898
               	sub	x1, x29, #0x798
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
               	sub	x0, x29, #0x898
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
               	sub	x0, x29, #0x7b8
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
               	sub	x2, x29, #0x7c8
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x0, x1, x0
               	str	x0, [x2]
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	eor	x0, x0, x1
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x8a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	sxtb	x2, w2
               	asr	x2, x2, #7
               	mov	x17, #0x1b              // =27
               	and	x4, x2, x17
               	sub	x2, x29, #0x8b8
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
               	sub	x0, x29, #0x8a8
               	sub	x1, x29, #0x8b8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5e               // =94
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x570
               	sub	x0, x29, #0x7d8
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
               	sub	x1, x29, #0x870
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x550
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x570
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x880
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
               	sub	x0, x29, #0x870
               	sub	x1, x29, #0x880
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5f               // =95
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x830
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x840
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x7e8
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
               	sub	x1, x29, #0x850
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x830
               	sub	x3, x29, #0x840
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x860
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
               	sub	x0, x29, #0x850
               	sub	x1, x29, #0x860
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x67               // =103
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x830
               	sub	x2, x29, #0x840
               	sub	x0, x29, #0x7f8
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
               	sub	x1, x29, #0x808
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x830
               	sub	x4, x29, #0x840
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x818
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
               	sub	x0, x29, #0x808
               	sub	x1, x29, #0x818
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x68               // =104
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x700
               	ldp	x29, x30, [sp], #0x10
               	ret
