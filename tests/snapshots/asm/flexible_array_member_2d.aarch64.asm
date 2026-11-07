
flexible_array_member_2d.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x7]
               	cmp	w1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrb	w1, [x0, #0xa]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xb]
               	cmp	w1, #0x16
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrb	w1, [x0, #0xc]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrb	w0, [x0, #0xf]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
