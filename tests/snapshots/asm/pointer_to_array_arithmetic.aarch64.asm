
pointer_to_array_arithmetic.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x0, #0x10
               	sub	x3, x1, x0
               	cmp	x3, #0x10
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x2, x0, #0x8
               	sub	x4, x2, x0
               	cmp	x4, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w3, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x3, [x1]
               	cmp	w3, #0x4
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	lsr	x1, x4, #3
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x1, [x0, #0x4]
               	ldrsw	x2, [x2, #0x4]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	add	x1, x0, #0x20
               	sub	x1, x1, #0x8
               	sub	x0, x1, x0
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
