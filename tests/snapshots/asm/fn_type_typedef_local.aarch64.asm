
fn_type_typedef_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x10
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	lsl	x0, x1, #1
               	sxtw	x1, w0
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x90]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x7                // =7
               	mov	x9, x20
               	blr	x9
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xe
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x3                // =3
               	mov	x9, x20
               	blr	x9
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x90
               	ret
               	stur	x20, [x29, #-0x58]
               	mov	x0, #0x4                // =4
               	mov	x9, x20
               	blr	x9
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x90
               	ret
               	sub	x0, x29, #0x58
               	ldr	x0, [x0]
               	mov	x1, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x90
               	ret
               	b	<addr>
