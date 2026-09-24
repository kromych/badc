
inline_asm_a64_ldst_modes.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x8               // =8
               	add	x16, x16, x17
               	str	x16, [sp]
               	ldr	x1, [sp]
               	ldur	x0, [x1, #-0x8]
               	mov	x3, x0
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	x1, [x16]
               	ldr	x0, [x1, #0x8]!
               	ldr	x16, [sp]
               	str	x1, [x16]
               	mov	x4, x0
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	x1, [x16]
               	ldr	x0, [x1], #0x8
               	ldr	x16, [sp]
               	str	x1, [x16]
               	mov	x5, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	str	x0, [sp]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	strb	w1, [x0, #0x1]!
               	stur	x0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	x1, [x16]
               	ldrb	w0, [x1], #0x1
               	ldr	x16, [sp]
               	str	x1, [x16]
               	mov	x6, x0
               	sub	x16, x29, #0x18
               	str	x16, [sp]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x10              // =16
               	add	x16, x16, x17
               	str	x16, [sp, #0x8]
               	ldr	x2, [sp, #0x8]
               	ldp	x0, x1, [x2, #-0x10]
               	ldr	x16, [sp]
               	str	x1, [x16]
               	mov	x7, x0
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x0, [x1, w2, sxtw #3]
               	mov	x1, x0
               	cmp	x6, #0x6
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x2
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x3, x4
               	add	x0, x0, x5
               	add	x2, x0, x7
               	ldur	x3, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0, #0x18]
               	sub	x3, x3, x4
               	add	x2, x2, x3
               	add	x1, x2, x1
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
