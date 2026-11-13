
range_unproved_comparisons_stay.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	adrp	x1, <page>
               	mov	x3, #0x100              // =256
               	str	x3, [x1, #0x20]
               	adrp	x2, <page>
               	str	x3, [x2, #0x28]
               	adrp	x4, <page>
               	mov	x0, #0x0                // =0
               	str	x0, [x4, #0x30]
               	ldr	x1, [x1, #0x20]
               	and	x5, x1, #0xff
               	cbnz	w5, <addr>
               	mov	x5, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x1, x0, x5, ne
               	cbz	x1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x2, #0x28]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	cmp	x1, #0x2
               	b.hi	<addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x8]
               	sub	x5, x29, #0x8
               	str	x5, [x4, #0x30]
               	ldur	x4, [x29, #-0x8]
               	cmp	x4, #0x64
               	b.ge	<addr>
               	str	x3, [x5]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, #0x64
               	b.ge	<addr>
               	mov	x3, #0x3                // =3
               	cbz	w3, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2, #0x28]
               	cmp	x3, #0x0
               	b.ls	<addr>
               	sub	x3, x3, #0x11
               	cmn	x3, #0x11
               	b.ls	<addr>
               	mov	x0, #0x4                // =4
               	cbz	w0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2, #0x28]
               	cbz	x0, <addr>
               	lsl	x0, x0, #55
               	cmp	x0, #0x0
               	b.lt	<addr>
               	cbz	w1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
