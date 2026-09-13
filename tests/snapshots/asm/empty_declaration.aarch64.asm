
empty_declaration.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xb                // =11
               	str	w2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0xc                // =12
               	str	w4, [x3]
               	ldrsw	x1, [x1]
               	add	x1, x1, #0xc
               	cmp	w1, #0x17
               	b.eq	<addr>
               	mov	x0, x2
               	ret
               	ret
