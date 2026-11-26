
designator_completes_a_union.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d1, [x0]
               	fmov	d0, #2.50000000
               	fcmp	d1, d0
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x10]
               	fcmp	d1, d0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	mov	x16, #0x1               // =1
               	csel	x0, x16, xzr, ne
               	mov	x17, #0x14              // =20
               	mul	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x4]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x4, #0x4]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x4, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldr	x0, [x2]
               	cmp	x0, #0x6
               	b.ne	<addr>
               	ldr	x0, [x2, #0x8]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x2, #0x10]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldr	x0, [x2, #0x18]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldrsw	x0, [x2, #0x20]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
