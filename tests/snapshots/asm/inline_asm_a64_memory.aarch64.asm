
inline_asm_a64_memory.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x58
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
               	mov	x1, x0
               	sub	x1, x29, #0x38
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldr	x0, [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldr	x0, [x1, #0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldur	x1, [x29, #-0x38]
               	ldur	x2, [x29, #-0x30]
               	add	x1, x1, x2
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	str	x1, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	stlr	x1, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	sub	x1, x29, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldar	x0, [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldur	x1, [x29, #-0x20]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldur	x0, [x1, #0x10]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	sub	x1, x29, #0x10
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldtr	x0, [x1, #0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	sub	x1, x29, #0x8
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldtrsb	w0, [x1, #0x18]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x100
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldr	x0, [x0]
               	sxtw	x0, w0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
