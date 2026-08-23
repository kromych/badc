
inline_asm_a64_ldr_sub.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldrh	w0, [x1, #0x4]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	sub	x1, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ldrsw	x0, [x1, #0xc]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldur	x1, [x29, #-0x10]
               	cmp	x1, #0x21
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
