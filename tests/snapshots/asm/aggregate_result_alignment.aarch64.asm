
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

<make_m16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x30
               	and	x1, x0, #0xff
               	sturb	w1, [x29, #-0x30]
               	sturb	w1, [x29, #-0x2f]
               	sturb	w1, [x29, #-0x2e]
               	sturb	w1, [x29, #-0x2d]
               	sturb	w1, [x29, #-0x2c]
               	sturb	w1, [x29, #-0x2b]
               	sturb	w1, [x29, #-0x2a]
               	sturb	w1, [x29, #-0x29]
               	sturb	w1, [x29, #-0x28]
               	sturb	w1, [x29, #-0x27]
               	sturb	w1, [x29, #-0x26]
               	sturb	w1, [x29, #-0x25]
               	sturb	w1, [x29, #-0x24]
               	sturb	w1, [x29, #-0x23]
               	sturb	w1, [x29, #-0x22]
               	sturb	w1, [x29, #-0x21]
               	sturb	w1, [x29, #-0x20]
               	sturb	w1, [x29, #-0x1f]
               	sturb	w1, [x29, #-0x1e]
               	sturb	w1, [x29, #-0x1d]
               	sturb	w1, [x29, #-0x1c]
               	sturb	w1, [x29, #-0x1b]
               	sturb	w1, [x29, #-0x1a]
               	sturb	w1, [x29, #-0x19]
               	sturb	w1, [x29, #-0x18]
               	sturb	w1, [x29, #-0x17]
               	sturb	w1, [x29, #-0x16]
               	sturb	w1, [x29, #-0x15]
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x13]
               	sturb	w1, [x29, #-0x12]
               	sturb	w1, [x29, #-0x11]
               	mov	x16, x2
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
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
               	and	x0, x20, #0xff
               	add	x8, sp, #0x80
               	bl	<addr>
               	add	x0, sp, #0x80
               	and	x0, x0, #0xf
               	and	x1, x20, #0xff
               	add	x2, sp, #0xa0
               	strb	w1, [sp, #0xa0]
               	strb	w1, [sp, #0xa1]
               	strb	w1, [sp, #0xa2]
               	strb	w1, [sp, #0xa3]
               	strb	w1, [sp, #0xa4]
               	strb	w1, [sp, #0xa5]
               	strb	w1, [sp, #0xa6]
               	strb	w1, [sp, #0xa7]
               	strb	w1, [sp, #0xa8]
               	strb	w1, [sp, #0xa9]
               	strb	w1, [sp, #0xaa]
               	strb	w1, [sp, #0xab]
               	strb	w1, [sp, #0xac]
               	strb	w1, [sp, #0xad]
               	strb	w1, [sp, #0xae]
               	strb	w1, [sp, #0xaf]
               	and	x2, x2, #0xf
               	add	x21, x0, x2
               	mov	x0, sp
               	mov	x2, #0x40               // =64
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
               	and	x0, x20, #0xff
               	add	x8, sp, #0xb0
               	bl	<addr>
               	ldrb	w0, [sp, #0xcf]
               	and	x1, x20, #0xff
               	add	x21, x0, x1
               	add	x0, sp, #0x40
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	ldrb	w0, [sp, #0x7f]
               	add	x0, x21, x0
               	and	x1, x20, #0xff
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>

<probe_vla>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sxtw	x20, w0
               	mov	x21, x1
               	add	x17, x20, #0xf
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
               	and	x1, x21, #0xff
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	and	x0, x21, #0xff
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	and	x0, x0, #0xf
               	and	x1, x21, #0xff
               	sub	x2, x29, #0x20
               	sturb	w1, [x29, #-0x20]
               	sturb	w1, [x29, #-0x1f]
               	sturb	w1, [x29, #-0x1e]
               	sturb	w1, [x29, #-0x1d]
               	sturb	w1, [x29, #-0x1c]
               	sturb	w1, [x29, #-0x1b]
               	sturb	w1, [x29, #-0x1a]
               	sturb	w1, [x29, #-0x19]
               	sturb	w1, [x29, #-0x18]
               	sturb	w1, [x29, #-0x17]
               	sturb	w1, [x29, #-0x16]
               	sturb	w1, [x29, #-0x15]
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x13]
               	sturb	w1, [x29, #-0x12]
               	sturb	w1, [x29, #-0x11]
               	and	x2, x2, #0xf
               	add	x0, x0, x2
               	sub	x2, x20, #0x1
               	ldrb	w2, [x22, w2, sxtw]
               	add	x0, x0, x2
               	sub	x0, x0, x1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0x1a0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x30]
               	bl	<addr>
               	ldur	x1, [x29, #-0x30]
               	mov	x2, #0x2                // =2
               	sub	x1, x1, #0x2
               	add	x20, x0, x1
               	mov	x0, x2
               	add	x8, sp, #0x100
               	bl	<addr>
               	add	x0, sp, #0x100
               	and	x0, x0, #0xf
               	add	x1, x20, x0
               	add	x2, sp, #0x120
               	mov	x0, #0x2                // =2
               	strb	w0, [sp, #0x120]
               	strb	w0, [sp, #0x121]
               	strb	w0, [sp, #0x122]
               	strb	w0, [sp, #0x123]
               	strb	w0, [sp, #0x124]
               	strb	w0, [sp, #0x125]
               	strb	w0, [sp, #0x126]
               	strb	w0, [sp, #0x127]
               	strb	w0, [sp, #0x128]
               	strb	w0, [sp, #0x129]
               	strb	w0, [sp, #0x12a]
               	strb	w0, [sp, #0x12b]
               	strb	w0, [sp, #0x12c]
               	strb	w0, [sp, #0x12d]
               	strb	w0, [sp, #0x12e]
               	strb	w0, [sp, #0x12f]
               	and	x2, x2, #0xf
               	add	x1, x1, x2
               	cbz	w1, <addr>
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, sp
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, sp
               	and	x20, x0, #0x1f
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	ldur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #-0x20]
               	sub	x1, x1, x2
               	add	x21, x0, x1
               	mov	x0, #0x3                // =3
               	add	x8, sp, #0x130
               	bl	<addr>
               	add	x0, sp, #0x130
               	and	x0, x0, #0xf
               	add	x0, x21, x0
               	add	x2, sp, #0x150
               	mov	x1, #0x3                // =3
               	strb	w1, [sp, #0x150]
               	strb	w1, [sp, #0x151]
               	strb	w1, [sp, #0x152]
               	strb	w1, [sp, #0x153]
               	strb	w1, [sp, #0x154]
               	strb	w1, [sp, #0x155]
               	strb	w1, [sp, #0x156]
               	strb	w1, [sp, #0x157]
               	strb	w1, [sp, #0x158]
               	strb	w1, [sp, #0x159]
               	strb	w1, [sp, #0x15a]
               	strb	w1, [sp, #0x15b]
               	strb	w1, [sp, #0x15c]
               	strb	w1, [sp, #0x15d]
               	strb	w1, [sp, #0x15e]
               	strb	w1, [sp, #0x15f]
               	and	x2, x2, #0xf
               	add	x21, x0, x2
               	add	x0, sp, #0x40
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0x40
               	and	x0, x0, #0x1f
               	add	x0, x21, x0
               	mov	x17, #0x64              // =100
               	mul	x1, x20, x17
               	add	x20, x0, x1
               	add	x0, sp, #0x80
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	ldrb	w0, [sp, #0x85]
               	add	x0, x20, x0
               	sub	x0, x0, #0x3
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x18]
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x18]
               	ldur	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	ldur	x2, [x29, #-0x8]
               	sub	x20, x1, x2, lsl #1
               	add	x8, sp, #0x160
               	bl	<addr>
               	add	x0, sp, #0x160
               	and	x0, x0, #0xf
               	add	x0, x20, x0
               	add	x2, sp, #0x180
               	mov	x1, #0x4                // =4
               	strb	w1, [sp, #0x180]
               	strb	w1, [sp, #0x181]
               	strb	w1, [sp, #0x182]
               	strb	w1, [sp, #0x183]
               	strb	w1, [sp, #0x184]
               	strb	w1, [sp, #0x185]
               	strb	w1, [sp, #0x186]
               	strb	w1, [sp, #0x187]
               	strb	w1, [sp, #0x188]
               	strb	w1, [sp, #0x189]
               	strb	w1, [sp, #0x18a]
               	strb	w1, [sp, #0x18b]
               	strb	w1, [sp, #0x18c]
               	strb	w1, [sp, #0x18d]
               	strb	w1, [sp, #0x18e]
               	strb	w1, [sp, #0x18f]
               	and	x2, x2, #0xf
               	add	x20, x0, x2
               	add	x0, sp, #0xc0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xc0
               	and	x0, x0, #0x1f
               	add	x0, x20, x0
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x40
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
