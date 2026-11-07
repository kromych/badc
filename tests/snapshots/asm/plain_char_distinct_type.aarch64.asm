
plain_char_distinct_type.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0xff               // =255
               	strb	w1, [x0, #0x30]
               	ldrb	w0, [x0, #0x30]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0xa                // =10
               	ret
