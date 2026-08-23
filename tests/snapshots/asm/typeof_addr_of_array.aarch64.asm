
typeof_addr_of_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x4, #0xa                // =10
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x5, [x1, x2, lsl #2]
               	mul	x3, x2, x4
               	add	x3, x3, #0xa
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0xa                // =10
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x1, x2, lsl #2]
               	mul	x3, x2, x5
               	add	x3, x3, #0xa
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x3                // =3
               	ret
