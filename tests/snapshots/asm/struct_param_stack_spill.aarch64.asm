
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
               	add	x0, x0, x7
               	ldur	x1, [x29, #-0x10]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
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
               	add	x0, x0, x7
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0xc]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	ldur	x0, [x29, #-0x10]
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x8, <page>
               	ldr	x9, [x8, #0x10]
               	sub	x8, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x3, [x29, #-0x18]
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	blr	x9
               	cmp	x0, #0xbe0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x8, [x29, #-0x8]
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x9, <page>
               	ldr	x9, [x9, <lo12>]
               	sub	x10, x29, #0x20
               	stur	w8, [x29, #-0x20]
               	stur	w2, [x29, #-0x1c]
               	stur	w3, [x29, #-0x18]
               	mov	x16, x10
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
               	cmp	x0, #0x10e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
