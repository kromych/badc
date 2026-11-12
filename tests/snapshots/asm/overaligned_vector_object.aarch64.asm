
overaligned_vector_object.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
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
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x9                // =9
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0x1f
               	cbz	w2, <addr>
               	mov	x0, #0xa                // =10
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x13               // =19
               	str	w2, [x0, #0x8]
               	mov	x2, #0x17               // =23
               	str	w2, [x1]
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x0, #0x17
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x41]
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x50]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x58]
               	add	x0, x0, x1
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x48]
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x10
               	and	x0, x0, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	and	x0, x0, #0x1f
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0xb                // =11
               	str	w0, [sp, #0x10]
               	mov	x0, #0xd                // =13
               	str	w0, [sp, #0x1c]
               	mov	x0, #0x11               // =17
               	str	w0, [sp, #0x4]
               	ldrsw	x0, [sp, #0x1c]
               	add	x0, x0, #0xb
               	add	x0, x0, #0x11
               	cmp	w0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0x3f
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x60]
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x70]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x78]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x68]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
