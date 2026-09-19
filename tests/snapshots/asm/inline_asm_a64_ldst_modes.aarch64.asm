
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
               	sub	sp, sp, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	sub	x16, x29, #0x48
               	str	x16, [sp]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x8               // =8
               	add	x16, x16, x17
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldur	x0, [x1, #-0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	sub	x16, x29, #0x40
               	str	x16, [sp]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldr	x0, [x1, #0x8]!
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	sub	x16, x29, #0x38
               	str	x16, [sp]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldr	x0, [x1], #0x8
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x1, [sp, #0x8]
               	strb	w1, [x0, #0x1]!
               	ldr	x16, [sp]
               	str	x0, [x16]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldrb	w0, [x1], #0x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	sub	x16, x29, #0x30
               	str	x16, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [sp, #0x8]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x10              // =16
               	add	x16, x16, x17
               	str	x16, [sp, #0x10]
               	ldr	x2, [sp, #0x10]
               	ldp	x0, x1, [x2, #-0x10]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x8]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x0, [x1, w2, sxtw #3]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x38]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x30]
               	add	x1, x0, x1
               	ldur	x2, [x29, #-0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0, #0x18]
               	sub	x2, x2, x3
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x20]
               	add	x1, x1, x2
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
