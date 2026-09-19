
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0xc                // =12
               	str	w3, [x2]
               	ldrsw	x0, [x0]
               	add	x0, x0, #0xc
               	cmp	w0, #0x17
               	b.eq	<addr>
               	mov	x0, x1
               	ret
               	mov	x0, #0x0                // =0
               	ret
