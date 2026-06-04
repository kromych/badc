
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
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0xb
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x8
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x1, x0, #0xc
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1e
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1f
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
