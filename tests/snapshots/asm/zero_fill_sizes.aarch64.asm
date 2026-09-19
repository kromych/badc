
zero_fill_sizes.aarch64:	file format elf64-littleaarch64

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

<local_64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	and	x2, x0, #0x7
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x38]
               	add	x0, x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_256>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x1, x29, #0x100
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	stp	xzr, xzr, [x1, #0x90]
               	stp	xzr, xzr, [x1, #0xa0]
               	stp	xzr, xzr, [x1, #0xb0]
               	stp	xzr, xzr, [x1, #0xc0]
               	stp	xzr, xzr, [x1, #0xd0]
               	stp	xzr, xzr, [x1, #0xe0]
               	stp	xzr, xzr, [x1, #0xf0]
               	and	x2, x0, #0x1f
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0xf8]
               	add	x0, x0, x1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_264>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	sub	x1, x29, #0x108
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	stp	xzr, xzr, [x1, #0x90]
               	stp	xzr, xzr, [x1, #0xa0]
               	stp	xzr, xzr, [x1, #0xb0]
               	stp	xzr, xzr, [x1, #0xc0]
               	stp	xzr, xzr, [x1, #0xd0]
               	stp	xzr, xzr, [x1, #0xe0]
               	stp	xzr, xzr, [x1, #0xf0]
               	str	xzr, [x1, #0x100]
               	mov	x2, #0x83e1             // =33761
               	movk	x2, #0x3e0f, lsl #16
               	movk	x2, #0xe0f8, lsl #32
               	movk	x2, #0xf83, lsl #48
               	umulh	x2, x0, x2
               	lsr	x2, x2, #1
               	mov	x17, #0x21              // =33
               	mul	x2, x2, x17
               	sub	x2, x0, x2
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x100]
               	add	x0, x0, x1
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_4k>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	mov	x16, x1
               	mov	x17, #0x1000            // =4096
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	and	x2, x0, #0x1ff
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0xff8]
               	add	x0, x0, x1
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_64k>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x10              // =16
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x10, lsl #12 // =0x10000
               	mov	x16, x1
               	mov	x17, #0x10000           // =65536
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	and	x2, x0, #0x1fff
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	mov	x17, #0xfff8            // =65528
               	add	x1, x1, x17
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	add	sp, sp, #0x10, lsl #12  // =0x10000
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	x1, x29, #0xff8
               	mov	x16, x1
               	add	x17, x16, #0xfe0
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	stp	xzr, xzr, [x16]
               	str	wzr, [x16, #0x10]
               	mov	x2, #0xedb3             // =60851
               	movk	x2, #0x513c, lsl #16
               	movk	x2, #0x906c, lsl #32
               	movk	x2, #0xc0, lsl #48
               	umulh	x2, x0, x2
               	sub	x3, x0, x2
               	lsr	x3, x3, #1
               	add	x2, x3, x2
               	lsr	x2, x2, #9
               	mov	x17, #0x3fd             // =1021
               	mul	x2, x2, x17
               	sub	x2, x0, x2
               	str	w0, [x1, x2, lsl #2]
               	ldrsw	x0, [x1]
               	ldrsw	x1, [x1, #0xff0]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	ldp	x29, x30, [sp], #0x10
               	ret

<zero_264>:
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	stp	xzr, xzr, [x0, #0x60]
               	stp	xzr, xzr, [x0, #0x70]
               	stp	xzr, xzr, [x0, #0x80]
               	stp	xzr, xzr, [x0, #0x90]
               	stp	xzr, xzr, [x0, #0xa0]
               	stp	xzr, xzr, [x0, #0xb0]
               	stp	xzr, xzr, [x0, #0xc0]
               	stp	xzr, xzr, [x0, #0xd0]
               	stp	xzr, xzr, [x0, #0xe0]
               	stp	xzr, xzr, [x0, #0xf0]
               	str	xzr, [x0, #0x100]
               	ret

<zero_4k>:
               	mov	x16, x0
               	mov	x17, #0x1000            // =4096
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	ret

<zero_odd>:
               	mov	x16, x0
               	add	x17, x16, #0xfe0
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	stp	xzr, xzr, [x16]
               	str	wzr, [x16, #0x10]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	x0, [x1, #0x100]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2, #0xff8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w0, [x3, #0xff0]
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	stp	xzr, xzr, [x1, #0x90]
               	stp	xzr, xzr, [x1, #0xa0]
               	stp	xzr, xzr, [x1, #0xb0]
               	stp	xzr, xzr, [x1, #0xc0]
               	stp	xzr, xzr, [x1, #0xd0]
               	stp	xzr, xzr, [x1, #0xe0]
               	stp	xzr, xzr, [x1, #0xf0]
               	str	xzr, [x1, #0x100]
               	mov	x16, x2
               	mov	x17, #0x1000            // =4096
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	mov	x16, x3
               	add	x17, x16, #0xfe0
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	stp	xzr, xzr, [x16]
               	str	wzr, [x16, #0x10]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x100]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0xff8]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xff0]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
