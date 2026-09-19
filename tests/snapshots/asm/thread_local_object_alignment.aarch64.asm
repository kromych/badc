
thread_local_object_alignment.aarch64:	file format elf64-littleaarch64

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

<file_scope_boundaries>:
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	and	x0, x1, #0x7
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	and	x0, x0, #0xf
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	and	x0, x0, #0xf
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	add	x0, x0, #0x10
               	and	x0, x0, #0xf
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x2
               	str	d16, [x1]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	mov	x3, #0x1                // =1
               	str	x3, [x0]
               	mov	x4, #0x2                // =2
               	str	x4, [x0, #0x8]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	mov	x5, #0x3                // =3
               	str	x5, [x0, #0x10]
               	mov	x6, #0x4                // =4
               	str	x6, [x0, #0x18]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	strb	w3, [x0]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	strb	w4, [x0]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x40
               	strb	w5, [x0]
               	ldr	d0, [x1]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	add	x0, x1, x0
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrb	w0, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret

<block_scope_boundaries>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x78
               	and	x1, x0, #0x7
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x50
               	and	x1, x1, #0xf
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0xa8
               	and	x1, x1, #0x7
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0xc0
               	and	x1, x1, #0xf
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x2
               	str	d16, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x50
               	mov	x3, #0x3                // =3
               	str	x3, [x1]
               	mov	x4, #0x4                // =4
               	str	x4, [x1, #0x8]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0xa8
               	mov	x5, #0x5                // =5
               	str	x5, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0xc0
               	mov	x6, #0x6                // =6
               	str	x6, [x1]
               	mov	x7, #0x7                // =7
               	str	x7, [x1, #0x8]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	mov	x8, #0x1                // =1
               	strb	w8, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	mov	x8, #0x2                // =2
               	strb	w8, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	strb	w3, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	strb	w4, [x1]
               	ldr	d0, [x0]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xa8
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, x5
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xc0
               	ldr	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrb	w0, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, x7
               	ret
               	mov	x0, #0x0                // =0
               	ret

<wide_array_boundary>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xe0
               	and	x1, x0, #0xf
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x1, x0, #0x10
               	and	x1, x1, #0xf
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x1, #0x8                // =8
               	str	x1, [x0, #0x20]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0xd0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	ldr	x0, [x0, #0x20]
               	add	x0, x0, #0x1
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
