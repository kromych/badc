
typeof_abstract_array_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x40
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	add	x3, x2, #0x0
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x0
               	str	w2, [x3]
               	sub	x2, x29, #0x40
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x1
               	str	w2, [x3, #0x4]
               	sub	x2, x29, #0x40
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x2
               	str	w2, [x3, #0x8]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0xc
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
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
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
