
array_of_struct_brace_elision.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldr	x1, [x0]
               	cmp	x1, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x4
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1e
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
