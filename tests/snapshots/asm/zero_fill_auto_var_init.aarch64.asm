
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
               	mov	x2, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	mov	x17, #0x7               // =7
               	and	x1, x2, x17
               	str	x2, [x0, x1, lsl #3]
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
               	mov	x2, x0
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	str	x1, [x0, #0x50]
               	str	x1, [x0, #0x58]
               	str	x1, [x0, #0x60]
               	str	x1, [x0, #0x68]
               	str	x1, [x0, #0x70]
               	str	x1, [x0, #0x78]
               	str	x1, [x0, #0x80]
               	str	x1, [x0, #0x88]
               	str	x1, [x0, #0x90]
               	str	x1, [x0, #0x98]
               	str	x1, [x0, #0xa0]
               	str	x1, [x0, #0xa8]
               	str	x1, [x0, #0xb0]
               	str	x1, [x0, #0xb8]
               	str	x1, [x0, #0xc0]
               	str	x1, [x0, #0xc8]
               	str	x1, [x0, #0xd0]
               	str	x1, [x0, #0xd8]
               	str	x1, [x0, #0xe0]
               	str	x1, [x0, #0xe8]
               	str	x1, [x0, #0xf0]
               	str	x1, [x0, #0xf8]
               	mov	x17, #0x1f              // =31
               	and	x1, x2, x17
               	str	x2, [x0, x1, lsl #3]
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
               	mov	x3, x0
               	sub	x0, x29, #0x108
               	add	x1, x0, #0x108
               	b	<addr>
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x1
               	b.lo	<addr>
               	sub	x0, x29, #0x108
               	mov	x1, #0x83e1             // =33761
               	movk	x1, #0x3e0f, lsl #16
               	movk	x1, #0xe0f8, lsl #32
               	movk	x1, #0xf83, lsl #48
               	umulh	x1, x3, x1
               	lsr	x1, x1, #1
               	mov	x17, #0x21              // =33
               	mul	x1, x1, x17
               	sub	x1, x3, x1
               	str	x3, [x0, x1, lsl #3]
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
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x17, #0x1000            // =4096
               	add	x1, x0, x17
               	b	<addr>
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x1
               	b.lo	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x17, #0x1ff             // =511
               	and	x1, x3, x17
               	str	x3, [x0, x1, lsl #3]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0xff8]
               	add	x0, x1, x0
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x10
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
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	sub	x0, x29, #0x10, lsl #12 // =0x10000
               	mov	x17, #0x10000           // =65536
               	add	x1, x0, x17
               	b	<addr>
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x1
               	b.lo	<addr>
               	sub	x0, x29, #0x10, lsl #12 // =0x10000
               	mov	x17, #0x1fff            // =8191
               	and	x1, x3, x17
               	str	x3, [x0, x1, lsl #3]
               	ldr	x1, [x0]
               	mov	x17, #0xfff8            // =65528
               	add	x0, x0, x17
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	add	sp, sp, #0x10, lsl #12  // =0x10000
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<uninit_vla>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
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
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	add	x2, x1, x0
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	str	x3, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x2
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x20]
               	udiv	x17, x0, x4
               	msub	x2, x17, x4, x0
               	str	x0, [x1, x2, lsl #3]
               	ldr	x2, [x1]
               	sub	x0, x4, #0x1
               	ldr	x0, [x1, x0, lsl #3]
               	add	x0, x2, x0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x130]!
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	<addr>
               	add	x3, x0, #0x0
               	sub	x0, x29, #0x108
               	add	x1, x0, #0x108
               	b	<addr>
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x1
               	b.lo	<addr>
               	sub	x0, x29, #0x108
               	str	x20, [x0, #0x18]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x100]
               	add	x0, x1, x0
               	add	x21, x3, x0
               	mov	x0, x20
               	bl	<addr>
               	add	x21, x21, x0
               	mov	x0, x20
               	bl	<addr>
               	add	x21, x21, x0
               	mov	x0, #0x64               // =100
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x21, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x20, x21, [sp], #0x130
               	ret
