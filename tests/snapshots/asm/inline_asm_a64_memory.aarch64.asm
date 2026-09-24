
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
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x16, x29, #0x38
               	str	x16, [sp]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldr	x0, [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	sub	x16, x29, #0x30
               	str	x16, [sp]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldr	x0, [x1, #0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x30]
               	add	x2, x0, x1
               	sub	x16, x29, #0x58
               	str	x16, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	str	x1, [x0]
               	stur	xzr, [x29, #-0x28]
               	sub	x16, x29, #0x28
               	str	x16, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	stlr	x1, [x0]
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldar	x0, [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x20]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	str	x16, [sp]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldur	x0, [x1, #0x10]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldtr	x0, [x1, #0x8]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldtrsb	w0, [x1, #0x18]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x100
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x58]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
