
zero_length_array.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x1, #0x140a             // =5130
               	strh	w1, [x0, #0x4]
               	mov	x1, #0x1e               // =30
               	strb	w1, [x0, #0x6]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0xcdab             // =52651
               	strh	w1, [x0, #0x4]
               	ldrh	w0, [x0, #0x4]
               	and	x0, x0, #0xff
               	cmp	w0, #0xab
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
