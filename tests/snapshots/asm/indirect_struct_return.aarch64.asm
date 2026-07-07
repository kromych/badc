
indirect_struct_return.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x8
               	str	w0, [x1]
               	lsl	x0, x0, #1
               	sub	x1, x29, #0x8
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x7                // =7
               	mov	x9, x20
               	blr	x9
               	sub	x16, x29, #0x48
               	str	x0, [x16]
               	sub	x0, x29, #0x48
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xe
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x18
               	str	x20, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	mov	x1, #0xa                // =10
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x3               // =3
               	mov	x9, x20
               	mov	x0, x21
               	blr	x9
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	ldrsw	x20, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x20, x0
               	sxtw	x0, w0
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	b	<addr>
               	b	<addr>
