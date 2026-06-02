
struct_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrsw	x14, [x15]
               	cmp	x14, #0xa
               	cset	x14, ne
               	stur	x14, [x29, #-0x8]
               	cbnz	x14, <addr>
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	cmp	x13, #0xb
               	cset	x13, ne
               	stur	x13, [x29, #-0x8]
               	b	<addr>
               	ldur	x13, [x29, #-0x8]
               	cbz	x13, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x15, #0x8
               	ldrsw	x13, [x13]
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0x10]
               	cbnz	x13, <addr>
               	add	x0, x15, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x15, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	cset	x0, ne
               	stur	x0, [x29, #-0x18]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x14
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1f
               	cset	x15, ne
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
