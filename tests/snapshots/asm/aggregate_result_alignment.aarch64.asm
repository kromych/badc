
aggregate_result_alignment.aarch64:	file format elf64-littleaarch64

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

<make_m32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x8, [x29, #-0x8]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x3, sp
               	and	x1, x0, #0xff
               	mov	x2, #0x40               // =64
               	mov	x0, x3
               	bl	<addr>
               	mov	x0, sp
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldp	x0, x1, [x16, #0x30]
               	stp	x0, x1, [x17, #0x30]
               	mov	x0, x17
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_m32_args>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x8, [x29, #-0x8]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, sp
               	ldr	x1, [x29, #0x10]
               	add	x1, x1, #0x1f
               	sub	x1, x1, #0x24
               	and	x1, x1, #0xff
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, sp
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldp	x0, x1, [x16, #0x30]
               	stp	x0, x1, [x17, #0x30]
               	mov	x0, x17
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<results>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0xe0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x20, x0
               	and	x1, x20, #0xff
               	add	x0, sp, #0x80
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0x80
               	and	x21, x0, #0xf
               	and	x1, x20, #0xff
               	add	x0, sp, #0xa0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	add	x0, sp, #0xa0
               	and	x0, x0, #0xf
               	add	x21, x21, x0
               	and	x0, x20, #0xff
               	mov	x8, sp
               	bl	<addr>
               	mov	x0, sp
               	and	x0, x0, #0x1f
               	add	x0, x21, x0
               	cbz	x0, <addr>
               	add	x0, x0, #0x3e8
               	sub	sp, x29, #0x10
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x20, #0xff
               	add	x0, sp, #0xb0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	ldrb	w21, [sp, #0xcf]
               	and	x1, x20, #0xff
               	add	x0, sp, #0xd0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldrb	w0, [sp, #0xdf]
               	add	x21, x21, x0
               	and	x0, x20, #0xff
               	add	x8, sp, #0x40
               	bl	<addr>
               	ldrb	w0, [sp, #0x7f]
               	add	x0, x21, x0
               	and	x1, x20, #0xff
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>

<probe2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0x100
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x3, #0x8                // =8
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	mov	x3, x0
               	add	x8, sp, #0x10
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, sp
               	and	x20, x0, #0x1f
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	sub	x1, x1, x2
               	add	x21, x0, x1
               	add	x0, sp, #0xc0
               	mov	x1, #0x3                // =3
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xc0
               	and	x0, x0, #0xf
               	add	x21, x21, x0
               	add	x0, sp, #0xe0
               	mov	x1, #0x3                // =3
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	add	x0, sp, #0xe0
               	and	x0, x0, #0xf
               	add	x21, x21, x0
               	mov	x0, #0x3                // =3
               	add	x8, sp, #0x40
               	bl	<addr>
               	add	x0, sp, #0x40
               	and	x0, x0, #0x1f
               	add	x0, x21, x0
               	mov	x17, #0x64              // =100
               	mul	x1, x20, x17
               	add	x20, x0, x1
               	mov	x0, #0x3                // =3
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x3, #0x8                // =8
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	mov	x3, x0
               	add	x8, sp, #0x90
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldrb	w0, [sp, #0x85]
               	add	x0, x20, x0
               	sub	x0, x0, #0x3
               	sub	sp, x29, #0x20
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x18]
               	ldur	x2, [x29, #-0x10]
               	add	x0, x0, x2
               	ldur	x2, [x29, #-0x8]
               	sub	x20, x0, x2, lsl #1
               	add	x0, sp, #0x40
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0x40
               	and	x0, x0, #0xf
               	add	x20, x20, x0
               	add	x0, sp, #0x60
               	mov	x1, #0x4                // =4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	add	x0, sp, #0x60
               	and	x0, x0, #0xf
               	add	x20, x20, x0
               	mov	x0, #0x4                // =4
               	mov	x8, sp
               	bl	<addr>
               	mov	x0, sp
               	and	x0, x0, #0x1f
               	add	x0, x20, x0
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe_vla>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sxtw	x21, w0
               	mov	x20, x1
               	add	x17, x21, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x22, sp
               	sub	x22, x22, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x22
               	and	x1, x20, #0xff
               	mov	x0, x22
               	mov	x2, x21
               	bl	<addr>
               	and	x1, x20, #0xff
               	sub	x0, x29, #0x40
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x40
               	and	x23, x0, #0xf
               	and	x1, x20, #0xff
               	sub	x0, x29, #0x20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x20
               	and	x0, x0, #0xf
               	add	x0, x23, x0
               	sub	x1, x21, #0x1
               	ldrb	w1, [x22, w1, sxtw]
               	add	x0, x0, x1
               	and	x1, x20, #0xff
               	sub	x0, x0, x1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x8]
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x2
               	add	x20, x0, x1
               	sub	x0, x29, #0x40
               	mov	x1, #0x2                // =2
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x40
               	and	x0, x0, #0xf
               	add	x20, x20, x0
               	sub	x0, x29, #0x20
               	mov	x1, #0x2                // =2
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x20
               	and	x0, x0, #0xf
               	add	x0, x20, x0
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
