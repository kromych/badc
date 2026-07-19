
inline_asm_a64_ld1_postindex.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
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
               	sub	x0, x29, #0x20
               	stur	x0, [x29, #-0x38]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x38
               	sub	sp, sp, #0x40
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x16, [sp, #0x10]
               	ldr	x2, [x16]
               	ld1	{ v0.4s }, [x2], #16
               	mov	w0, v0.s[0]
               	ld1	{ v1.4s }, [x2], #16
               	mov	w1, v1.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	w1, [x16]
               	ldr	x16, [sp, #0x10]
               	str	x2, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	add	sp, sp, #0x40
               	ldursw	x0, [x29, #-0x28]
               	ldursw	x1, [x29, #-0x30]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
