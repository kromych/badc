
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
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	b	<addr>
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	b	<addr>
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	x1, #0x1e
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x1f
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	b	<addr>
               	cbz	x3, <addr>
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
