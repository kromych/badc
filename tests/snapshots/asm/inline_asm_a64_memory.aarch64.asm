
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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x16, x29, #0x20
               	ldr	x0, [x16]
               	sub	x16, x29, #0x20
               	ldr	x1, [x16, #0x8]
               	add	x0, x0, x1
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	stur	xzr, [x29, #-0x28]
               	sub	x16, x29, #0x28
               	stlr	x0, [x16]
               	sub	x16, x29, #0x28
               	str	x16, [sp]
               	ldr	x1, [sp]
               	ldar	x0, [x1]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldur	x0, [x16, #0x10]
               	sub	x16, x29, #0x20
               	ldtr	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	ldtrsb	w2, [x16, #0x18]
               	cmp	x0, #0x100
               	b.ne	<addr>
               	cmp	x1, #0x2
               	b.ne	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
