
inline_asm_a64_ldst_modes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x8
               	stur	x0, [x29, #-0x40]
               	mov	x3, #0x3                // =3
               	sub	x2, x29, #0x8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldur	x0, [x1, #-0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x40
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldr	x0, [x1, #0x8]!
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x40
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldr	x0, [x1], #0x8
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	stur	x2, [x29, #-0x50]
               	mov	x1, #0x6                // =6
               	sub	x4, x29, #0x50
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x4, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x1, [sp, #0x8]
               	strb	w1, [x0, #0x1]!
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x60
               	sub	x4, x29, #0x50
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x4, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldrb	w0, [x1], #0x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x20
               	sub	x4, x29, #0x28
               	add	x5, x0, #0x10
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x1, [sp]
               	str	x4, [sp, #0x8]
               	str	x5, [sp, #0x10]
               	ldr	x2, [sp, #0x10]
               	ldp	x0, x1, [x2, #-0x10]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x30
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	str	x3, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x0, [x1, w2, sxtw #3]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldur	x1, [x29, #-0x60]
               	cmp	x1, #0x6
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x50]
               	add	x2, x2, #0x2
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x20]
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x28]
               	ldr	x3, [x0, #0x18]
               	sub	x2, x2, x3
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x30]
               	add	x1, x1, x2
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
