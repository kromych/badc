
indirect_struct_return_outptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x30
               	str	x8, [x16]
               	sxtw	x0, w0
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x28
               	str	x0, [x1]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x28
               	str	x1, [x2, #0x8]
               	add	x1, x0, #0x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x28
               	str	x1, [x2, #0x10]
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	sub	x2, x29, #0x28
               	str	x1, [x2, #0x18]
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	sub	x1, x29, #0x28
               	str	x0, [x1, #0x20]
               	sub	x0, x29, #0x28
               	mov	x16, x0
               	sub	x17, x29, #0x30
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	str	x0, [x1]
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	str	x0, [x1, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, #0xa                // =10
               	mov	x9, x20
               	sub	x8, x29, #0x78
               	blr	x9
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x22, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0xc
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0xe
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x9, x21
               	blr	x9
               	sub	x16, x29, #0x98
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x98
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xe
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x9, x20
               	sub	x8, x29, #0xc8
               	blr	x9
               	sub	x0, x29, #0xc8
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x5               // =5
               	mov	x9, x21
               	mov	x0, x20
               	blr	x9
               	sub	x16, x29, #0xd8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xd8
               	ldr	x22, [x0]
               	mov	x9, x21
               	mov	x0, x20
               	blr	x9
               	sub	x16, x29, #0xe8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xe8
               	ldr	x0, [x0, #0x8]
               	add	x0, x22, x0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
