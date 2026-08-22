
typeof_abstract_array_type.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0x18
               	mov	x17, #0xc               // =12
               	mul	x5, x1, x17
               	add	x3, x4, x5
               	add	x7, x3, #0x0
               	mov	x17, #0xa               // =10
               	mul	x0, x1, x17
               	add	x6, x0, #0x0
               	str	w6, [x7]
               	add	x6, x0, #0x1
               	str	w6, [x3, #0x4]
               	add	x0, x0, #0x2
               	str	w0, [x3, #0x8]
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1]
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrsw	x2, [x1, #0x14]
               	cmp	x2, #0xc
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	str	x1, [x0, #0x10]
               	cmp	x1, #0x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
