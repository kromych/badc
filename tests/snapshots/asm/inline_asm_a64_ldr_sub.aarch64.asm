
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
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	ldrh	w0, [x16, #0x4]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	ldrsw	x1, [x16, #0xc]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
