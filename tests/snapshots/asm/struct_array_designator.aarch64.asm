
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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrsw	x15, [x15]
               	cmp	x15, #0xa
               	cset	x15, ne
               	stur	x15, [x29, #-0x8]
               	cbnz	x15, <addr>
               	adrp	x14, <page>
               	add	x14, x14, #0xd0
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0xb
               	cset	x14, ne
               	stur	x14, [x29, #-0x8]
               	b	<addr>
               	ldur	x14, [x29, #-0x8]
               	cbz	x14, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0xd0
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	cbnz	x14, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	cset	x0, ne
               	stur	x0, [x29, #-0x18]
               	cbnz	x0, <addr>
               	adrp	x14, <page>
               	add	x14, x14, #0xd0
               	add	x14, x14, #0x14
               	ldrsw	x14, [x14]
               	cmp	x14, #0x1f
               	cset	x14, ne
               	stur	x14, [x29, #-0x18]
               	b	<addr>
               	ldur	x14, [x29, #-0x18]
               	cbz	x14, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
