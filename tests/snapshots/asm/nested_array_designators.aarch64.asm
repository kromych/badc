
nested_array_designators.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x28
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x29
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldrb	w1, [x0, #0xb]
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xa]
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
