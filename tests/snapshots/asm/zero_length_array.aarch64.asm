
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
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x14               // =20
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x1e               // =30
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	add	x2, x0, #0x4
               	cmp	x2, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x2, #0xab               // =171
               	strb	w2, [x0, #0x4]
               	mov	x2, #0xcd               // =205
               	strb	w2, [x0, #0x5]
               	mov	x2, x1
               	ldrh	w0, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	w0, #0xab
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, x1
               	ret
