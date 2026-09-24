
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
               	sub	sp, sp, #0x10
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp]
               	ldr	x1, [sp]
               	ldrh	w0, [x1, #0x4]
               	mov	x2, x0
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp]
               	ldr	x1, [sp]
               	ldrsw	x0, [x1, #0xc]
               	cmp	x2, #0x21
               	b.ne	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
