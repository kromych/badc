
inline_asm_a64_ld1_postindex.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x28
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
               	stur	x0, [x29, #-0x40]
               	sub	x16, x29, #0x30
               	str	x16, [sp]
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x8]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x10]
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
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x38]
               	add	x0, x0, x1
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
