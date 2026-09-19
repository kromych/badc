
struct_param_stack_spill.aarch64:	file format elf64-littleaarch64

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

<f16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x1, x0, x7
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<f12>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	w17, [x29, #0x18]
               	str	w17, [x16, #0x8]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x1, x0, x7
               	sub	x0, x29, #0x10
               	ldrsw	x2, [x0]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x4]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	sub	x8, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x8]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x8, #0x8]
               	ldr	x10, [sp], #0x10
               	ldur	x0, [x29, #-0x10]
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	x9, [x9]
               	sub	sp, sp, #0x10
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	blr	x9
               	add	sp, sp, #0x10
               	cmp	x0, #0xbe0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x8, x29, #0x20
               	str	xzr, [x8]
               	str	wzr, [x8, #0x8]
               	ldursw	x0, [x29, #-0x8]
               	str	w0, [x8]
               	mov	x2, #0x3                // =3
               	str	w2, [x8, #0x4]
               	mov	x3, #0x4                // =4
               	str	w3, [x8, #0x8]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	x9, [x9]
               	sub	sp, sp, #0x10
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldrb	w17, [x16, #0x8]
               	strb	w17, [sp, #0x8]
               	ldrb	w17, [x16, #0x9]
               	strb	w17, [sp, #0x9]
               	ldrb	w17, [x16, #0xa]
               	strb	w17, [sp, #0xa]
               	ldrb	w17, [x16, #0xb]
               	strb	w17, [sp, #0xb]
               	blr	x9
               	add	sp, sp, #0x10
               	cmp	x0, #0x10e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
