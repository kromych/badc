
brace_elided_struct_array_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x1, [x0]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, #0xd0
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x20]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x28]
               	cmp	x1, #0x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, #0xe8
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x48]
               	cmp	x1, #0x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x50]
               	adrp	x2, <page>
               	add	x2, x2, #0xe0
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x68]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x0, [x0, #0x70]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
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
               	b	<addr>
               	b	<addr>
