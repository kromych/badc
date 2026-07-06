
pointer_to_array_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x1, x0, #0x8
               	sub	x2, x1, x0
               	cmp	x2, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x2, x0, #0x10
               	sub	x3, x2, x0
               	cmp	x3, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x3, [x2]
               	cmp	x3, #0x4
               	cset	x4, ne
               	cbnz	x4, <addr>
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x5
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	sub	x1, x1, x0
               	asr	x2, x1, #63
               	lsr	x2, x2, #61
               	add	x1, x1, x2
               	asr	x1, x1, #3
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	add	x1, x0, #0x8
               	ldrsw	x2, [x0, #0x4]
               	ldrsw	x1, [x1, #0x4]
               	cmp	x2, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x1, #0x3
               	cset	x3, ne
               	cbz	x3, <addr>
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
               	b	<addr>
               	b	<addr>
