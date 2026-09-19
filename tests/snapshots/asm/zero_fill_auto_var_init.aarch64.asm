
zero_fill_auto_var_init.aarch64:	file format elf64-littleaarch64

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

<uninit_64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x1, x0
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	and	x2, x1, #0x7
               	str	x1, [x0, x2, lsl #3]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x38]
               	add	x0, x1, x0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_256>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	mov	x1, x0
               	sub	x0, x29, #0x100
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
               	and	x2, x1, #0x1f
               	str	x1, [x0, x2, lsl #3]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0xf8]
               	add	x0, x1, x0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_264>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	mov	x1, x0
               	sub	x0, x29, #0x108
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
               	mov	x2, #0x83e1             // =33761
               	movk	x2, #0x3e0f, lsl #16
               	movk	x2, #0xe0f8, lsl #32
               	movk	x2, #0xf83, lsl #48
               	umulh	x2, x1, x2
               	lsr	x2, x2, #1
               	mov	x17, #0x21              // =33
               	mul	x2, x2, x17
               	sub	x2, x1, x2
               	str	x1, [x0, x2, lsl #3]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x100]
               	add	x0, x1, x0
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_4k>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	mov	x1, x0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x16, x0
               	mov	x17, #0x1000            // =4096
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	and	x2, x1, #0x1ff
               	str	x1, [x0, x2, lsl #3]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0xff8]
               	add	x0, x1, x0
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_64k>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x10              // =16
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x10, lsl #12 // =0x10000
               	mov	x16, x0
               	mov	x17, #0x10000           // =65536
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	and	x2, x1, #0x1fff
               	str	x1, [x0, x2, lsl #3]
               	ldr	x1, [x0]
               	mov	x17, #0xfff8            // =65528
               	add	x0, x0, x17
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	add	sp, sp, #0x10, lsl #12  // =0x10000
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x4, x0
               	stur	x1, [x29, #-0x20]
               	lsl	x0, x4, #3
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x2, x1, x0
               	mov	x0, x1
               	cmp	x0, x2
               	b.hs	<addr>
               	mov	x3, #0x0                // =0
               	str	x3, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x2
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x20]
               	udiv	x17, x0, x4
               	msub	x2, x17, x4, x0
               	str	x0, [x1, x2, lsl #3]
               	ldr	x0, [x1]
               	sub	x2, x4, #0x1
               	ldr	x1, [x1, x2, lsl #3]
               	add	x0, x0, x1
               	sub	sp, x29, #0x30
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x20, x20, x0
               	mov	x0, #0x64               // =100
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
